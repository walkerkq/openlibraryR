
# openlibraryR <img src = "man/figures/openlibraryR_sm.png" width = "180px" align = "right" />

[![Build
Status](https://travis-ci.com/walkerkq/openlibraryR.svg?branch=main)](https://travis-ci.com/walkerkq/openlibraryR)

openlibraryR is an R package that provides a simple wrapper for the
[Open Library API](https://openlibrary.org/dev/docs/api/books).

[Open Library](https://openlibrary.org) is an initiative of the
[Internet Archive](https:://archive.org), a 501(c)(3) non-profit,
building a digital library of Internet sites and other cultural
artifacts in digital form.

Hex sticker icon by
[mangsaabguru](https://www.flaticon.com/authors/mangsaabguru).

## Installation

You can install the development version of openlibraryR from Github:

``` r
devtools::install_github("walkerkq/openlibraryR")
```

## Getting Started

You do not need an account or key to access the Open Library API. There
is only method provided which returns book details from an ISBN
(International Standard Book Number).

``` r
my_book <- openlibraryR::get_books(book_id = '0486282112')

str(my_book)
#> tibble [1 x 20] (S3: tbl_df/tbl/data.frame)
#>  $ url            : chr "https://openlibrary.org/books/OL1110841M/Frankenstein"
#>  $ key            : chr "/books/OL1110841M"
#>  $ title          : chr "Frankenstein"
#>  $ authors        :List of 1
#>   ..$ : tibble [1 x 2] (S3: tbl_df/tbl/data.frame)
#>   .. ..$ url : chr "https://openlibrary.org/authors/OL25342A/Mary_Shelley"
#>   .. ..$ name: chr "Mary Shelley"
#>  $ number_of_pages: int 166
#>  $ pagination     : chr "x, 166 p. ;"
#>  $ by_statement   : chr "Mary Shelley"
#>  $ identifiers    :List of 1
#>   ..$ : tibble [1 x 6] (S3: tbl_df/tbl/data.frame)
#>   .. ..$ goodreads   : chr "89476"
#>   .. ..$ librarything: chr "8294"
#>   .. ..$ isbn_10     : chr "0486282112"
#>   .. ..$ lccn        : chr "94036624"
#>   .. ..$ oclc        : chr "31166513"
#>   .. ..$ openlibrary : chr "OL1110841M"
#>  $ classifications:List of 1
#>   ..$ : tibble [1 x 2] (S3: tbl_df/tbl/data.frame)
#>   .. ..$ lc_classifications : chr "PR5397 .F7 1994b"
#>   .. ..$ dewey_decimal_class: chr "823/.7"
#>  $ publishers     :List of 1
#>   ..$ : tibble [1 x 1] (S3: tbl_df/tbl/data.frame)
#>   .. ..$ name: chr "Dover Publications"
#>  $ publish_places :List of 1
#>   ..$ : tibble [1 x 1] (S3: tbl_df/tbl/data.frame)
#>   .. ..$ name: chr "New York"
#>  $ publish_date   : chr "1994"
#>  $ subjects       :List of 1
#>   ..$ : tibble [70 x 2] (S3: tbl_df/tbl/data.frame)
#>   .. ..$ name: chr [1:70] "Mary Shelley" "Mary Wollstonecraft Shelley" "Women authors" "Rhetoric" ...
#>   .. ..$ url : chr [1:70] "https://openlibrary.org/subjects/mary_shelley" "https://openlibrary.org/subjects/mary_wollstonecraft_shelley" "https://openlibrary.org/subjects/women_authors" "https://openlibrary.org/subjects/rhetoric" ...
#>  $ subject_places :List of 1
#>   ..$ : tibble [2 x 2] (S3: tbl_df/tbl/data.frame)
#>   .. ..$ name: chr [1:2] "Geneva (Switzerland)" "England"
#>   .. ..$ url : chr [1:2] "https://openlibrary.org/subjects/place:geneva_(switzerland)" "https://openlibrary.org/subjects/place:england"
#>  $ subject_people :List of 1
#>   ..$ : tibble [3 x 2] (S3: tbl_df/tbl/data.frame)
#>   .. ..$ name: chr [1:3] "Frankenstein (Fictitious character)" "Frankenstein's monster (Fictitious character)" "Victor Frankenstein (Fictitious character)"
#>   .. ..$ url : chr [1:3] "https://openlibrary.org/subjects/person:frankenstein_(fictitious_character)" "https://openlibrary.org/subjects/person:frankenstein's_monster_(fictitious_character)" "https://openlibrary.org/subjects/person:victor_frankenstein_(fictitious_character)"
#>  $ subject_times  :List of 1
#>   ..$ : tibble [1 x 2] (S3: tbl_df/tbl/data.frame)
#>   .. ..$ name: chr "19th century"
#>   .. ..$ url : chr "https://openlibrary.org/subjects/time:19th_century"
#>  $ notes          : chr "Previously published: 3rd ed. London : Colburn and Bentley, 1831, in series: Standard novels."
#>  $ links          :List of 1
#>   ..$ : tibble [3 x 2] (S3: tbl_df/tbl/data.frame)
#>   .. ..$ title: chr [1:3] "Wikipedia" "Wikidata" "VIAF ID: 185508590"
#>   .. ..$ url  : chr [1:3] "https://en.wikipedia.org/wiki/Frankenstein" "https://www.wikidata.org/wiki/Q150827" "https://viaf.org/viaf/185508590"
#>  $ ebooks         :List of 1
#>   ..$ : tibble [1 x 4] (S3: tbl_df/tbl/data.frame)
#>   .. ..$ preview_url : chr "https://archive.org/details/frankenstein00shel"
#>   .. ..$ availability: chr "borrow"
#>   .. ..$ borrow_url  : chr "https://openlibrary.org/books/OL1110841M/Frankenstein/borrow"
#>   .. ..$ checkedout  : logi FALSE
#>  $ cover          :List of 1
#>   ..$ : tibble [1 x 3] (S3: tbl_df/tbl/data.frame)
#>   .. ..$ small : chr "https://covers.openlibrary.org/b/id/311591-S.jpg"
#>   .. ..$ medium: chr "https://covers.openlibrary.org/b/id/311591-M.jpg"
#>   .. ..$ large : chr "https://covers.openlibrary.org/b/id/311591-L.jpg"
```

Use `tidyr::unnest` to access the various nested data.

``` r
library(dplyr)

my_book %>% 
  select(authors) %>% 
  tidyr::unnest(authors, 
                names_sep = '_')
#> # A tibble: 1 x 2
#>   authors_url                                           authors_name
#>   <chr>                                                 <chr>       
#> 1 https://openlibrary.org/authors/OL25342A/Mary_Shelley Mary Shelley

my_book %>% 
  select(identifiers) %>% 
  tidyr::unnest(identifiers)
#> # A tibble: 1 x 6
#>   goodreads librarything isbn_10    lccn     oclc     openlibrary
#>   <chr>     <chr>        <chr>      <chr>    <chr>    <chr>      
#> 1 89476     8294         0486282112 94036624 31166513 OL1110841M

my_book %>% 
  select(subject_people) %>% 
  tidyr::unnest(subject_people, 
                names_sep = '_')
#> # A tibble: 3 x 2
#>   subject_people_name             subject_people_url                            
#>   <chr>                           <chr>                                         
#> 1 Frankenstein (Fictitious chara~ https://openlibrary.org/subjects/person:frank~
#> 2 Frankenstein's monster (Fictit~ https://openlibrary.org/subjects/person:frank~
#> 3 Victor Frankenstein (Fictitiou~ https://openlibrary.org/subjects/person:victo~
```
