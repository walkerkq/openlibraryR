# converts JSON response into a tidy tibble

fromJSONtoTibble <- function(response) {

  df <- jsonlite::fromJSON(
    gsub(':null', ':\"\"',
         httr::content(response, as = 'text', encoding = 'utf-8')
    ),
    flatten = TRUE)

    response_tibble <- tibble::tibble(.rows=length(df))

  for(l in 1:length(df)) {

    # fix LCCN and OCLC mult values later (ex ISBN 0345337662)
    # workaround to fix multilevels
    identifier_length <- df[[l]]$identifiers %>% lapply(length) %>% as.data.frame()

    min_identifier_length <- min(identifier_length)

    df[[l]]$identifiers <- df[[l]]$identifiers %>% lapply(function(x) x[1:min_identifier_length])

    tibble_row <- df[[l]] %>%
      purrr::map_if(purrr::is_list, tibble::as_tibble, .name_repair = 'unique') %>%
      purrr::map_if(tibble::is_tibble, list) %>%
      tibble::as_tibble(.name_repair = 'unique')

    if(l == 1){

      response_tibble <- rbind(response_tibble, tibble_row)

    } else {

      # handle responses missing columns with an full outer merge
      response_tibble <- merge(response_tibble, tibble_row, all = TRUE)

    }

  }

  response_tibble

}
