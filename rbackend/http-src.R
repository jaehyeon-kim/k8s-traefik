# https://stats.idre.ucla.edu/r/dae/logit-regression/
DAT <- read.csv('./binary.csv')
DAT$rank <- factor(DAT$rank)

value_if_null <- function(v, DAT) {
  if (class(DAT[[v]]) == 'factor') {
    tt <- table(DAT[[v]])
    names(tt[tt==max(tt)])
  } else {
    mean(DAT[[v]])
  }
}

set_newdata <- function(args_called) {
  args_init <- list(gre=NULL, gpa=NULL, rank=NULL)
  newdata <- lapply(names(args_init), function(n) {
    if (is.null(args_called[[n]])) {
      args_init[[n]] <- value_if_null(n, DAT)
    } else {
      args_init[[n]] <- args_called[[n]]
    }
  })
  names(newdata) <- names(args_init)
  lapply(names(newdata), function(n) {
    flog.info(sprintf("%s - %s", n, newdata[[n]]))
  })
  newdata <- as.data.frame(newdata)
  newdata$rank <- factor(newdata$rank, levels = levels(DAT$rank))
  newdata
}

admission <- function(gre=NULL, gpa=NULL, rank=NULL, ...) {
  newdata <- set_newdata(args_called = as.list(sys.call()))
  logit <- glm(admit ~ gre + gpa + rank, data = DAT, family = "binomial")
  resp <- predict(logit, newdata=newdata, type="response")
  flog.info(sprintf("resp - %s", resp))
  list(result = resp > 0.5)
}

whoami <- function() {
    list(title=sprintf("%s API", Sys.getenv("APP_PREFIX", "RSERVE")))
}
