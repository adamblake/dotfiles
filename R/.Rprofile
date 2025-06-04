# prevent "Registered S3 method overwritten" warnings
Sys.setenv(`_R_S3_METHOD_REGISTRATION_NOTE_OVERWRITES_` = "false")

options(
  warnPartialMatchArgs = TRUE,
  warnPartialMatchDollar = TRUE,
  warnPartialMatchAttr = TRUE,
  show.signif.stars = FALSE,
  useFancyQuotes = FALSE,
  coursekata.quiet = TRUE,
  error = rlang::entrace,
  repos = c(
    PPM = "https://packagemanager.posit.co/cran/latest",
    CRAN = "https://cran.r-project.org"
  )
)

# enable autocompletions for package names in `require()`, `library()`
utils::rc.settings(ipck = TRUE)

.load_dev <- function() {
  pak::pkg_install(c("usethis", "devtools"), ask = FALSE, upgrade = FALSE)
  library(usethis)
  library(devtools)
  devtools::load_all()
}
