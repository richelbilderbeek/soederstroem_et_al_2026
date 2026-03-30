#!/bin/env Rscript

jsonl_filenames <- list.files(pattern = "results_.*.jsonl")

for (jsonl_filename in jsonl_filenames) {
  lines <- readr::read_lines(jsonl_filename)

  ids <- stringr::str_match(lines, "\\('([0-9]+)',")[, 2]
  ids <- ids[!is.na(ids)]

  ages_19_29 <- stringr::str_match(lines, "age.*19-29.: ([01].[0-9]+)")[, 2]
  ages_19_29 <- ages_19_29[!is.na(ages_19_29)]
  if (length(ids) < length(ages_19_29)) {
    n_missing <- length(ages_19_29) - length(ids)
    ids <- c(ids, rep(x = 1234567890, times = n_missing))
  }
  testthat::expect_equal(length(ids), length(ages_19_29))

  ages_30_39 <- stringr::str_match(lines, "30-39.: ([01].[0-9]+)")[, 2]
  ages_30_39 <- ages_30_39[!is.na(ages_30_39)]
  testthat::expect_equal(length(ids), length(ages_30_39))

  ages_le_18 <- stringr::str_match(lines, "<=18.: ([01].[0-9]+)")[, 2]
  ages_le_18 <- ages_le_18[!is.na(ages_le_18)]
  testthat::expect_equal(length(ids), length(ages_le_18))

  ages_ge_40 <- stringr::str_match(lines, ">=40.: ([01].[0-9]+)")[, 2]
  ages_ge_40 <- ages_ge_40[!is.na(ages_ge_40)]
  testthat::expect_equal(length(ids), length(ages_le_18))

  gender_male <- stringr::str_match(lines, "female.*male.: ([01].[0-9]+)")[, 2]
  gender_male <- gender_male[!is.na(gender_male)]
  testthat::expect_equal(length(ids), length(gender_male))

  gender_female <- stringr::str_match(lines, "female.: ([01].[0-9]+).*male")[, 2]
  gender_female <- gender_female[!is.na(gender_female)]
  testthat::expect_equal(length(ids), length(gender_female))

  is_org <- stringr::str_match(lines, "is-org.: ([01].[0-9]+).*non-org")[, 2]
  is_org <- is_org[!is.na(is_org)]
  testthat::expect_equal(length(ids), length(is_org))

  is_non_org <- stringr::str_match(lines, "non-org.: ([01].[0-9]+)")[, 2]
  is_non_org <- is_non_org[!is.na(is_non_org)]
  testthat::expect_equal(length(ids), length(is_non_org))

  t <- tibble::tibble(
    id = as.numeric(ids),
    est_p_age_le_18 = as.numeric(ages_le_18),
    est_p_age_19_29 = as.numeric(ages_19_29),
    est_p_age_30_39 = as.numeric(ages_30_39),
    est_p_age_ge_40 = as.numeric(ages_ge_40),
    est_p_gender_male = as.numeric(gender_male),
    est_p_gender_female = as.numeric(gender_female),
    est_p_is_org = as.numeric(is_org),
    est_p_is_non_org = as.numeric(is_non_org)
  )
  csv_filename <- stringr::str_replace(jsonl_filename, "jsonl", "csv")
  readr::write_csv(x = t, file = csv_filename)
}
