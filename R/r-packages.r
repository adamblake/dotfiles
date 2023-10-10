options(repos = c(CRAN = "https://packagemanager.posit.co/cran/latest"))

install.packages("pak")
pak::pkg_install(c(
  "rlang",
  "tidyverse",
  "devtools",
  "roxygen2",
  "testthat",
  "usethis",
  "remotes"
))
