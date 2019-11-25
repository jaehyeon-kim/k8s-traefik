mydata <- read.csv('./binary.csv')
mydata$rank <- factor(mydata$rank)

min(mydata$gre)
min(mydata$gpa)
unique(mydata$rank)

value_if_null <- function(v, mydata) {
  if (class(mydata[[v]]) == 'factor') {
    tt <- table(mydata[[v]])
    names(tt[tt==max(tt)])
  } else {
    mean(mydata[[v]])
  }
}


ad <- function(gre=NULL, gpa=NULL, rank=NULL) {
  args_value <- list(gre=NULL, gpa=NULL, rank=NULL)
  args_called <- as.list(sys.call())
  args_called <- args_called[names(args_called) %in% names(args_value)]
  args_called
}
