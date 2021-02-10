#' Basic API call
#'
#' This function is the base GET call to the [Open LIbrary API](https://openlibrary.org/dev/docs/api/books).
#'
#' @param path the API method to call
#' @param query call parameters in the form of a list()
#'
#' @return API object
#'
#' @import httr
#'
#' @export
#'
ol_get <- function(path, query = NULL) {

  url <- httr::modify_url(url = 'https://openlibrary.org/', path = path, query = query)

  response <- httr::GET(url)

  if (httr::http_type(response) != "application/json") {
    stop("API did not return json", call. = FALSE)
  } else if(response$status_code != 200) {
    stop(paste0("API returned status ", response$headers$status), call. = FALSE)
  }

  response

}


