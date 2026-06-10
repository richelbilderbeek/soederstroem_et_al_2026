#!/bin/env Rscript

#' Read the tables produced by the inference and put these in one table
read_inference_tables <- function() {
  # Only use results based on text only, as there are too
  # profiles with an image
  csv_filenames <- list.files(pattern = "results_.*_text_based.csv")

  list_of_tables <- list()
  for (i in seq_along(csv_filenames)) {
    csv_filename <- csv_filenames[i]
    t <- readr::read_csv(csv_filename, show_col_types = FALSE)
    t$data_set <- stringr::str_match(string = csv_filename, "results_(.*)_text_based.csv")[1, 2]
    list_of_tables[[i]] <- t
  }
  dplyr::bind_rows(list_of_tables)
}

#' Create the raw version of table A5,
#' with some extra columns for testing
create_table_a5_raw <- function() {

  t <- read_inference_tables()

  # No ties in the gender estimates
  testthat::expect_true(all(t$est_p_gender_male != t$est_p_gender_female))
  # The highest probability for a certain age class is unique
  t$max_p_age <- t |> dplyr::rowwise() |> dplyr::mutate(max_p_age = max(est_p_age_le_18, est_p_age_19_29, est_p_age_30_39, est_p_age_ge_40)) |> dplyr::select(max_p_age) |> dplyr::pull()
  t$is_le_18 <- t |> dplyr::rowwise() |> dplyr::mutate(is_le_18 = est_p_age_le_18 == max_p_age) |> dplyr::select(is_le_18) |> dplyr::pull()
  t$is_19_29 <- t |> dplyr::rowwise() |> dplyr::mutate(is_19_29 = est_p_age_19_29 == max_p_age) |> dplyr::select(is_19_29) |> dplyr::pull()
  t$is_30_39 <- t |> dplyr::rowwise() |> dplyr::mutate(is_30_39 = est_p_age_30_39 == max_p_age) |> dplyr::select(is_30_39) |> dplyr::pull()
  t$is_ge_40 <- t |> dplyr::rowwise() |> dplyr::mutate(is_ge_40 = est_p_age_ge_40 == max_p_age) |> dplyr::select(is_ge_40) |> dplyr::pull()
  t$n_is_age <- t |> dplyr::rowwise() |> dplyr::mutate(is_age = is_le_18 + is_19_29 + is_30_39 + is_ge_40) |> dplyr::select(is_age) |> dplyr::pull()
  testthat::expect_true(all(t$n_is_age == 1))
  # Done testing
  t$max_p_age <- NULL
  t$n_is_age <- NULL


  t$is_male <- t$est_p_gender_male > t$est_p_gender_female
  t$is_female <- t$est_p_gender_male < t$est_p_gender_female

  n <- t |> dplyr::group_by(data_set) |> dplyr::count()

  approach <- "pick_best"

  if (approach == "pick_best") {
    t_n_male <- t |> dplyr::group_by(data_set) |> dplyr::filter(is_male) |> dplyr::count(name = "n_male")
    t_n_female <- t |> dplyr::group_by(data_set) |> dplyr::filter(is_female) |> dplyr::count(name = "n_female")
    t_n_age_le_18 <- t |> dplyr::group_by(data_set) |> dplyr::filter(is_le_18) |> dplyr::count(name = "n_age_le_18")
    t_n_age_19_29 <- t |> dplyr::group_by(data_set) |> dplyr::filter(is_19_29) |> dplyr::count(name = "n_age_19_29")
    t_n_age_30_39 <- t |> dplyr::group_by(data_set) |> dplyr::filter(is_30_39) |> dplyr::count(name = "n_age_30_39")
    t_n_age_ge_40 <- t |> dplyr::group_by(data_set) |> dplyr::filter(is_ge_40) |> dplyr::count(name = "n_age_ge_40")

    t_f_male <- merge(n, t_n_male) |> dplyr::rowwise() |> dplyr::mutate(f_male = n_male / n) |> dplyr::select(data_set, f_male)
    t_f_female <- merge(n, t_n_female) |> dplyr::rowwise() |> dplyr::mutate(f_female = n_female / n) |> dplyr::select(data_set, f_female)

    t_f_age_le_18 <- merge(n, t_n_age_le_18) |> dplyr::rowwise() |> dplyr::mutate(f_age_le_18 = n_age_le_18 / n) |> dplyr::select(data_set, f_age_le_18)
    t_f_age_19_29 <- merge(n, t_n_age_19_29) |> dplyr::rowwise() |> dplyr::mutate(f_age_19_29 = n_age_19_29 / n) |> dplyr::select(data_set, f_age_19_29)
    t_f_age_30_39 <- merge(n, t_n_age_30_39) |> dplyr::rowwise() |> dplyr::mutate(f_age_30_39 = n_age_30_39 / n) |> dplyr::select(data_set, f_age_30_39)
    t_f_age_ge_40 <- merge(n, t_n_age_ge_40) |> dplyr::rowwise() |> dplyr::mutate(f_age_ge_40 = n_age_ge_40 / n) |> dplyr::select(data_set, f_age_ge_40)

    results <- merge(n, t_f_male)
    results <- merge(results, t_n_male)
    results <- merge(results, t_f_female)
    results <- merge(results, t_n_female)
    results <- merge(results, t_f_age_le_18)
    results <- merge(results, t_n_age_le_18)
    results <- merge(results, t_f_age_19_29)
    results <- merge(results, t_n_age_19_29)
    results <- merge(results, t_f_age_30_39)
    results <- merge(results, t_n_age_30_39)
    results <- merge(results, t_f_age_ge_40)
    results <- merge(results, t_n_age_ge_40)

  } else {
    # Sum the probabilities
    t_f_male <- t |> dplyr::group_by(data_set) |> dplyr::summarise(f_male = mean(est_p_gender_male))
    t_f_female <- t |> dplyr::group_by(data_set) |> dplyr::summarise(f_female = mean(est_p_gender_female))

    t_f_age_le_18 <- t |> dplyr::group_by(data_set) |> dplyr::summarise(f_age_le_18 = mean(est_p_age_le_18))
    t_f_age_19_29 <- t |> dplyr::group_by(data_set) |> dplyr::summarise(f_age_19_29 = mean(est_p_age_19_29))
    t_f_age_30_39 <- t |> dplyr::group_by(data_set) |> dplyr::summarise(f_age_30_39 = mean(est_p_age_30_39))
    t_f_age_ge_40 <- t |> dplyr::group_by(data_set) |> dplyr::summarise(f_age_ge_40 = mean(est_p_age_ge_40))

    results <- merge(n, t_f_male)
    results$n_male <- results$n * results$f_male
    results <- merge(results, t_f_female)
    results$n_female <- results$n * results$f_female
    results <- merge(results, t_f_age_le_18)
    results$n_age_le_18 <- results$n * results$f_age_le_18
    results <- merge(results, t_f_age_19_29)
    results$n_age_19_29 <- results$n * results$f_age_19_29
    results <- merge(results, t_f_age_30_39)
    results$n_age_30_39 <- results$n * results$f_age_30_39
    results <- merge(results, t_f_age_ge_40)
    results$n_age_ge_40 <- results$n * results$f_age_ge_40
  }
  results$total <- results$n
  results$n <- NULL
  results
}

# Test the validity
t <- create_table_a5_raw()
# Sum of probabilities must be 1
testthat::expect_true(all(abs(t$f_male + t$f_female - 1.0) < 0.001))
# Numbers of males and females must match total
testthat::expect_true(all(abs(t$n_male + t$n_female - t$total) < 0.001))
# Sum of probabilities must be 1
testthat::expect_true(all(abs(t$f_age_le_18 + t$f_age_19_29 + t$f_age_30_39 + t$f_age_ge_40 - 1.0) < 0.001))
# Numbers of age classes must match total
testthat::expect_true(all(abs(t$n_age_le_18 + t$n_age_19_29 + t$n_age_30_39 + t$n_age_ge_40 - t$total) < 0.01))


#' Create the polished version of table A5
create_table_a5 <- function() {

  t <- create_table_a5_raw()
  t$f_male <- NULL
  t$n_male <- NULL
  t$f_female <- round(t$f_female * 100) # %
  t$n_female <- round(t$n_female)
  t$f_age_le_18 <- round(t$f_age_le_18 * 100) # %
  t$n_age_le_18 <- round(t$n_age_le_18)
  t$f_age_19_29 <- round(t$f_age_19_29 * 100) # %
  t$n_age_19_29 <- round(t$n_age_19_29)
  t$f_age_30_39 <- round(t$f_age_30_39 * 100) # %
  t$n_age_30_39 <- round(t$n_age_30_39)
  t$f_age_ge_40 <- round(t$f_age_ge_40 * 100) # %
  t$n_age_ge_40 <- round(t$n_age_ge_40)
  t

}

readr::write_csv(create_table_a5(), "table_a5.csv")

