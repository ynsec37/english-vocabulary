list.files(path = "./", pattern = "\\.txt$", full.names = TRUE) |>
  setNames(list.files(path = "./", pattern = "\\.txt$")) |>
  purrr::map(
    \(file){
      input_file <- file
      if (!dir.exists("./csv")) {
        dir.create("./csv")
      }
      output_file <- paste0("./csv", tools::file_path_sans_ext(input_file), ".csv")
      lines <- readr::read_lines(input_file)
      split_lines <- stringr::str_split(lines, "\\s+", n = 2, simplify = TRUE)
      df <- data.frame(
        word = split_lines[, 1],
        meaning = split_lines[, 2],
        stringsAsFactors = FALSE
      )
    }
  ) |>
  openxlsx::write.xlsx(
    file = "english_word.xlsx",
    firstRow = TRUE,
    withFilter = TRUE,
    colWidths = list(list(20, 40))
  )
