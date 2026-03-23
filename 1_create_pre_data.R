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

# readr::write_lines(create_test_text(), "data.jsonl")

t <- readr::read_csv(file = "data/yttrandefrihet.csv", show_col_types = FALSE)
t$id <- as.character(t$id)

n_lines <- nrow(t)

jsonl_text <- rep(x = "", times = n_lines)

create_image_path <- function(screen_name) {

  paste0("intermediate/", stringr::str_to_lower(screen_name), ".jpg")
}

do_list_missing_images <- FALSE
if (do_list_missing_images) {

  n <- 0
  for (i in seq_len(n_lines)) {
    screen_name <- t$screen_name[i]
    image_path <- create_image_path(screen_name)
    if (!file.exists(image_path)) {
      message(screen_name)
      n <- n + 1
    }
    #if (n == 50) return (42)
  }

}


for (i in seq_len(n_lines)) {
  img_path <- create_image_path(t$screen_name[i])
  message(img_path)
  if (!file.exists(img_path)) break
  jsonl_text[i] <- create_line(
    id = t$id[i], # string
    name = t$name[i],
    screen_name = t$screen_name[i],
    description = t$description[i],
    lang = t$lang[i],
    img_path = img_path
  )
}

readr::write_lines(jsonl_text, "intermediate/data.jsonl")

