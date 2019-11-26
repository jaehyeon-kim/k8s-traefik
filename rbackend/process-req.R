#### PROCESS REQUEST
process_request <- function(url, query, body, headers) {   
  #### building request object
  ## not strictly necessary as in FastRWeb, 
  ## just to make clear of request related variables
  request <- list(uri = url, method = 'POST', 
                  query = query, body = body)
  
  ## parse headers
  request$headers <- parse_headers(headers)
  if ("request-method" %in% names(request$headers)) 
    request$method <- c(request$headers["request-method"])
  
  ## parse parameters (function arguments)
  ## POST accept only 2 content types
  ## - application/x-www-form-urlencoded by built-in server
  ## - application/json
  ## used below as do.call(function_name, request$pars)
  request$pars <- list()
  if (request$method == 'POST') {
    if (!is.null(body)) {
      if (is.raw(body)) 
        body <- rawToChar(body)
      body <- jsonlite::fromJSON(body)
      request$pars <- body
    }
  } else {
    if (!is.null(query)) {
      request$pars <- as.list(query)
    }
  }
  
  #### building output object
  ## list(payload, content-type, headers, status_code)
  ## https://github.com/s-u/Rserve/blob/master/src/http.c#L358
  payload <- NULL
  content_type <- 'application/json; charset=utf-8'
  headers <- character(0)
  status_code <- 200
  
  ## generate payload (function output)
  ## function name must match to resource path for now
  matched_fun <- gsub('^/', '', request$uri)
  
  ## no resource path means no matching function
  if (matched_fun == '') {
    payload <- jsonlite::toJSON(whoami(), auto_unbox = TRUE)
    return (list(payload, content_type, headers)) # default status 200
  }
  
  ## check if all defined arguments are supplied
  params <- request$pars
  futile.logger::flog.info(params)
  defined_args <- filter_formals(matched_fun)
  if (!is.null(defined_args) && !all(defined_args %in% names(params))) {
    missing_args <- defined_args[!defined_args %in% names(params)]
    payload <- list(detail = paste('Missing argument -', 
                                    paste(missing_args, collapse = ', ')))
    return (list(jsonlite::toJSON(payload, auto_unbox = TRUE), content_type, headers, 400)) 
  }
  
  tryCatch({
    payload <- jsonlite::toJSON(do.call(matched_fun, params), auto_unbox = TRUE)
    return (list(payload, content_type, headers))
  }, error = function(err) {
    futile.logger::flog.error(err)
    payload <- jsonlite::toJSON(list(detail = err), auto_unbox = TRUE)
    return (list(payload, content_type, headers, 500))
  })
}

# parse headers in process_request()
# https://github.com/s-u/FastRWeb/blob/master/R/run.R#L65
parse_headers <- function(headers) {
  ## process headers to pull out request method (if supplied) and cookies
  if (is.raw(headers)) headers <- rawToChar(headers)
  if (is.character(headers)) {
    ## parse the headers into key/value pairs, collapsing multi-line values
    h.lines <- unlist(strsplit(gsub("[\r\n]+[ \t]+"," ", headers), "[\r\n]+"))
    h.keys <- tolower(gsub(":.*", "", h.lines))
    h.vals <- gsub("^[^:]*:[[:space:]]*", "", h.lines)
    names(h.vals) <- h.keys
    h.vals <- h.vals[grep("^[^:]+:", h.lines)]
    return (h.vals)
  } else {
    return (NULL)
  }
}

filter_formals <- function(matched_fun) {
  frmls <- formals(matched_fun)
  to_exclude <- do.call(c, lapply(names(frmls), function(n) {
    grepl('...', n) || is.null(frmls[[n]]) || frmls[[n]] != ''
  }))
  defined_args <- names(frmls)[!to_exclude]
  if (length(defined_args) == 0) {
    NULL
  } else {
    defined_args
  }
}