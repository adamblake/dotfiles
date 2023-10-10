# prevent "Registered S3 method overwritten" warnings
Sys.setenv(`_R_S3_METHOD_REGISTRATION_NOTE_OVERWRITES_` = "false")

options(
  warnPartialMatchArgs = TRUE,
  warnPartialMatchDollar = TRUE,
  warnPartialMatchAttr = TRUE,
  error = rlang::entrace,
  repos = c(CRAN = "https://packagemanager.posit.co/cran/latest"),
  coursekata.quiet = TRUE
)

.load_dev <- function() {
  library(usethis)
  library(devtools)
  devtools::load_all()
}
