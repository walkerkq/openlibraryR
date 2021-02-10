#' Get book details
#'
#' This function retrieves a variety of details about books using ISBN from
#' the [Open Library API](https://openlibrary.org/dev/docs/api/books).
#'
#' @param book_id a single ISBN, or several passed as a list, max 200
#' @param jscmd defaults to 'data', pass 'details' for more detailed response
#'
#' @return tibble containing book details, nested
#'
#' @import dplyr
#'
#' @export
#'
get_books <- function(book_id, jscmd = 'data'){

  if(length(book_id) > 200) stop('The maximum number of IDs that you can pass to the API in one call is 200.')

  book_ids <- paste0('ISBN:', book_id, collapse = ',')

  response <- ol_get(path = 'api/books',
                     query = list(bibkeys = book_ids,
                                  jscmd = jscmd,
                                  format = 'json'))

  fromJSONtoTibble(response)

}

