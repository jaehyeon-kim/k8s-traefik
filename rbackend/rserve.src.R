library(jsonlite)
library(futile.logger)

source("./process-req.R")

whoami <- function() {
    return list(title=sprintf("%s API", Sys.getenv("APP_PREFIX")))
}

admission <- function()

.http.request <- process_request

flog.info("API is ready to serve requests...")
