options(repos = c(CRAN = "https://packagemanager.posit.co/cran/latest"))

if (!requireNamespace("pak", quietly = TRUE)) {
  install.packages("pak")
}

pak::pkg_install(upgrade = FALSE, c(
  "jsonlite",
  "remotes",
  "rlang",
  "tidyverse",
  "devtools",
  "roxygen2",
  "testthat",
  "usethis",
  "languageserver"
))
