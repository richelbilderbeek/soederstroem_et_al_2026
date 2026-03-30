#!/bin/env Rscript

create_test_line <- function() {
  "{\"id\": \"720389270335135745\", \"name\": \"The Web Conference\", \"screen_name\": \"TheWebConf\", \"description\": \"The Web Conference Series (formerly WWW) ||  #TheWebConf 2019\", \"lang\": \"en\", \"img_path\": \"./test/pic/9h1m2705_400x400.jpg\"}"
}

#' Create a line
create_line <- function(
  id, # string
  name,
  screen_name,
  description,
  lang,
  img_path
) {
  testthat::expect_equal(1, length(id))
  testthat::expect_true(is.character(id))
  paste0(
    "{\"id\": \"", id, "\", \"name\": \"", name, "\", \"screen_name\": \"", screen_name, "\", \"description\": \"", description, "\", \"lang\": \"", lang, "\", \"img_path\": \"", img_path, "\"}"
  )
}

testthat::expect_equal(
  create_test_line()[1],
  create_line(
    id = "720389270335135745",
    name = "The Web Conference",
    screen_name = "TheWebConf",
    description = "The Web Conference Series (formerly WWW) ||  #TheWebConf 2019",
    lang = "en",
    img_path = "./test/pic/9h1m2705_400x400.jpg"
  )
)


# Create the same text as the example
create_test_text <- function() {
  c(
    "{\"id\": \"720389270335135745\", \"name\": \"The Web Conference\", \"screen_name\": \"TheWebConf\", \"description\": \"The Web Conference Series (formerly WWW) ||  #TheWebConf 2019\", \"lang\": \"en\", \"img_path\": \"./test/pic/9h1m2705_400x400.jpg\"}",
    "{\"id\": \"21447363\", \"name\": \"KATY PERRY\", \"screen_name\": \"katyperry\", \"description\": \"Love. Light.\", \"lang\": \"en\", \"img_path\": \"./test/pic/Wb77WUdv_400x400.jpg\"}",
    "{\"id\": \"25073877\", \"name\": \"Donald J. Trump\", \"screen_name\": \"realDonaldTrump\", \"description\": \"45th President of the United States of America\ud83c\uddfa\ud83c\uddf8\", \"lang\": \"en\", \"img_path\": \"./test/pic/kUuht00m_400x400.jpg\"}",
    "{\"id\": \"159978305\", \"name\": \"Real Madrid C.F.\u26bd\", \"screen_name\": \"realmadrid_yuc\", \"description\": \"Actualidad, noticias, informaci\u00f3n diaria y relatos en directo de partidos del Real Madrid! Para 100% madridistas! Desde M\u00e9rida Yucat\u00e1n \u00a1Hala Madrid!\", \"lang\": \"es\", \"img_path\": \"./test/pic/UTo8hzGe_400x400.jpg\"}",
    "{\"id\": \"1976143068\", \"name\": \"Emmanuel Macron\", \"screen_name\": \"EmmanuelMacron\", \"description\": \"Pr\u00e9sident de la R\u00e9publique fran\u00e7aise.\", \"lang\": \"fr\", \"img_path\": \"./test/pic/7-1gAjdP_400x400.jpg\"}",
    "{\"id\": \"2631881902\", \"name\": \"Angela Merkel\", \"screen_name\": \"AngelaMerkeICDU\", \"description\": \"Bundeskanzlerin\", \"lang\": \"de\", \"img_path\": \"./test/pic/TigSM93l_400x400.jpg\"}",
    "{\"id\": \"230845588\", \"name\": \"Robin van Persie\", \"screen_name\": \"Persie_Official\", \"description\": \"\", \"lang\": \"nl\", \"img_path\": \"./test/pic/6-AWM5dS_400x400.jpg\"}"
  )
}

#' Get the paths to the data files
get_data_files <- function() {
  csv_file_names <- list.files(path = "data", pattern = "*.csv", full.names = TRUE)
  testthat::expect_equal(3, length(csv_file_names))
  # rev(csv_file_names)
  csv_file_names
}

testthat::expect_true(all(file.exists(get_data_files())))


#' Convert the file path of a comma-separated file in 'data',
#' to a path of a JSONL file in 'intermediate'
to_intermediate_file_name <- function(data_file_name, must_have_picture = TRUE) {
  jsonl_filename <- stringr::str_replace(
    stringr::str_replace(data_file_name, ".csv", ".jsonl"),
    "data/",
    "intermediate/")
  if (!must_have_picture) {
    jsonl_filename <- stringr::str_replace(jsonl_filename, ".jsonl", "_text_based.jsonl")
  }
  jsonl_filename
}

testthat::expect_equal(
  to_intermediate_file_name(data_file_name = "data/yttrandefrihet.csv"),
  "intermediate/yttrandefrihet.jsonl"
)
testthat::expect_equal(
  to_intermediate_file_name(data_file_name = "data/stop_the_steal.csv"),
  "intermediate/stop_the_steal.jsonl"
)
testthat::expect_equal(
  to_intermediate_file_name(data_file_name = "data/swexit.csv"),
  "intermediate/swexit.jsonl"
)
testthat::expect_equal(
  to_intermediate_file_name(data_file_name = "data/swexit.csv", must_have_picture = FALSE),
  "intermediate/swexit_text_based.jsonl"
)

create_image_path <- function(screen_name) {
  testthat::expect_equal(1, length(screen_name))
  testthat::expect_true(is.character(screen_name))
  testthat::expect_true(nchar(screen_name) > 0)
  # paste0("data/", stringr::str_to_lower(screen_name), ".jpg")
  paste0("data/", screen_name, ".jpg")
}

testthat::expect_equal("data/test.jpg", create_image_path("test"))

#' Read the complete csv that contains the accounts of interest
#' @return a cleaned-up table
read_csv <- function(csv_file_name) {
  testthat::expect_equal(1, length(csv_file_name))
  testthat::expect_true(file.exists(csv_file_name))

  t <- readr::read_csv(file = csv_file_name, show_col_types = FALSE)

  # Transforming data
  t$id <- as.character(t$id)

  # Simplify, so that tool can work with it
  # Pipeline will not work without it
  t$name <- stringr::str_remove_all(stringi::stri_enc_toascii(t$name), "\032")
  t$name <- stringr::str_remove_all(t$name, "\"")
  t$name <- stringr::str_remove_all(t$name, "\\")
  t$description <- stringr::str_remove_all(stringr::str_remove_all(stringi::stri_enc_toascii(t$description), "\032"), "\n")

  # Remove quotes, as JSONL parser gets confused
  t$description <- stringr::str_remove_all(t$description, "\"")
  t$description <- stringr::str_remove_all(t$description, "\\")

  t <- t[which(t$id != ""), ]
  testthat::expect_equal(0, sum(t$id == ""))

  t$name[which(t$name == "")] <- "Unknown"
  testthat::expect_equal(0, sum(t$name == ""))
  testthat::expect_equal(0, sum(t$screen_name == ""))
  t$description[which(is.na(t$description))] <- "None"
  t$description[which(t$description == "")] <- "None"
  t$description[which(is.na(t$description))] <- "None"
  testthat::expect_equal(0, sum(t$description == ""))
  t[which(is.na(t$lang)), ]$lang <- "un"
  t <- t[which(t$lang != ""), ]
  testthat::expect_equal(0, sum(t$lang == ""))
  t
}

testthat::expect_true(nrow(read_csv(csv_file_name = get_data_files()[1])) > 1)

remove_empty_lines <- function(text) {
  text[nchar(text) != 0]
}
text <- c("A", "", "B")
testthat::expect_equal(2, length(remove_empty_lines(text)))


convert_to_jsonl <- function(
  csv_file_name,
  jsonl_file_name,
  must_have_picture
) {

  testthat::expect_equal(1, length(csv_file_name))
  testthat::expect_true(file.exists(csv_file_name))
  t <- read_csv(csv_file_name)

  n_lines <- nrow(t)

  jsonl_text <- rep(x = "", times = n_lines)

  for (i in seq_len(n_lines)) {
    img_path <- create_image_path(t$screen_name[i])
    # Accounts without a profile picture are skipped
    if (must_have_picture && !file.exists(img_path)) {
      next
    }
    jsonl_text[i] <- create_line(
      id = t$id[i], # string
      name = t$name[i],
      screen_name = t$screen_name[i],
      description = t$description[i],
      lang = t$lang[i],
      img_path = img_path
    )
  }
  jsonl_text <- remove_empty_lines(jsonl_text)
  readr::write_lines(jsonl_text, jsonl_file_name)
}

#' Display the missing images using \link{message}
show_missing_images <- function(csv_file_name) {
  testthat::expect_equal(1, length(csv_file_name))
  testthat::expect_true(file.exists(csv_file_name))
  t <- read_csv(csv_file_name)

  n_lines <- nrow(t)

  n <- 0
  for (i in seq_len(n_lines)) {
    screen_name <- t$screen_name[i]
    image_path <- create_image_path(screen_name)
    if (!file.exists(image_path)) {
      message(screen_name)
      n <- n + 1
    }
  }
}

csv_file_names <- get_data_files()

for (csv_file_name in csv_file_names) {
  for (must_have_picture in c(FALSE, TRUE)) {
    message("csv_file_name: ", csv_file_name, " (", length(readr::read_lines(csv_file_name)), " lines)")
    jsonl_file_name <- to_intermediate_file_name(csv_file_name, must_have_picture = must_have_picture)
    dir.create(dirname(jsonl_file_name), showWarnings = FALSE)
    convert_to_jsonl(csv_file_name = csv_file_name, jsonl_file_name = jsonl_file_name, must_have_picture = must_have_picture)
    testthat::expect_true(file.exists(jsonl_file_name))
    message("jsonl_file_name: ", jsonl_file_name, " (", length(readr::read_lines(jsonl_file_name)), " lines)")
  }
}


