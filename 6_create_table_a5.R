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

#' Create the raw version of table A5
create_table_a5_raw <- function() {

  t <- read_inference_tables()
  n <- t |> dplyr::group_by(data_set) |> dplyr::count()

  t_f_male <- t |> dplyr::group_by(data_set) |> dplyr::summarise(f_male = mean(est_p_gender_male))
  t_f_female <- t |> dplyr::group_by(data_set) |> dplyr::summarise(f_female = mean(est_p_gender_female))

  t_f_age_le_18 <- t |> dplyr::group_by(data_set) |> dplyr::summarise(f_age_le_18 = mean(est_p_age_le_18))
  t_f_age_19_29 <- t |> dplyr::group_by(data_set) |> dplyr::summarise(f_age_19_29 = mean(est_p_age_19_29))
  t_f_age_30_39 <- t |> dplyr::group_by(data_set) |> dplyr::summarise(f_age_30_39 = mean(est_p_age_30_39))
  t_f_age_ge_40 <- t |> dplyr::group_by(data_set) |> dplyr::summarise(f_age_ge_40 = mean(est_p_age_ge_40))

  results <- merge(n, t_f_female)
  #results$n_male <- results$n * results$f_male
  #results <- merge(results, t_f_female)
  results$n_female <- results$n * results$f_female

  results <- merge(results, t_f_age_le_18)
  results$n_age_le_18 <- results$n * results$f_age_le_18

  results <- merge(results, t_f_age_19_29)
  results$n_age_19_29 <- results$n * results$f_age_19_29

  results <- merge(results, t_f_age_30_39)
  results$n_age_30_39 <- results$n * results$f_age_30_39

  results <- merge(results, t_f_age_ge_40)
  results$n_age_ge_40 <- results$n * results$f_age_ge_40
  results$n <- NULL
  results
}

#' Create the polished version of table A5
create_table_a5 <- function() {

  t <- create_table_a5_raw()
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

