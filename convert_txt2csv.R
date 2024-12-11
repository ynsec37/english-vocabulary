list.files(path = "./", pattern = "\\.txt$", full.names = TRUE) |>
  purrr::walk(
    \(file){

      input_file <- file
      if (!dir.exists("./csv")) {
        dir.create("./csv")
      }
      output_file <- paste0("./csv", tools::file_path_sans_ext(input_file), ".csv")


      lines <- readr::read_lines(input_file)

      # Split each line into two parts
      split_lines <- stringr::str_split(lines, "\\s+", n = 2, simplify = TRUE)

      # Create a data frame
      df <- data.frame(
        word = split_lines[, 1],
        meaning = split_lines[, 2],
        stringsAsFactors = FALSE
      )

      # Write the data frame to a CSV file
      readr::write_excel_csv(df, output_file)
    }
  )
