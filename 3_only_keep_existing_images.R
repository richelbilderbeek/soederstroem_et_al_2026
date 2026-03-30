#!/bin/env Rscript
#
# The 'resized.jsonl' files contain lines that refer to resized
# images that do not exist.
#
# Remove the lines that refer to files that do not exist
#
jsonl_files <- list.files(path = "intermediate", pattern = "resized.jsonl", full.names = TRUE)

for (jsonl_file in jsonl_files) {
  message("jsonl_file: ", jsonl_file)
  text <- readr::read_lines(jsonl_file)

  base_filenames <- stringr::str_match(text, "intermediate/(.*).jpeg")[, 2]
  full_filenames <- paste0("intermediate/", base_filenames, ".jpeg")

  message("Keeping: ", sum(file.exists(full_filenames)))
  message("Dropping: ", sum(!file.exists(full_filenames)))

  text <- text[file.exists(full_filenames)]
  readr::write_lines(x = text, file = jsonl_file)

}


