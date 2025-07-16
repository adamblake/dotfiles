options(repos = c(
  CRAN = "https://packagemanager.posit.co/cran/latest",
  "https://community.r-multiverse.org"
))

if (!requireNamespace("pak", quietly = TRUE)) {
  install.packages("pak")
}

pak::pkg_install(upgrade = FALSE, c(
  # common tools
  "jsonlite",
  "remotes",
  "rlang",
  "tidyverse",
  "coursekata",
  # package development
  "devtools",
  "rhub",
  "roxygen2",
  "spelling",
  "testthat",
  "usethis",
  # vscode
  "languageserver",
  "httpgd"
))
