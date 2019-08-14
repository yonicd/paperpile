get_key <- function(x) gsub('^(.*?)\\{|[,]','',x[1])

get_field <- function(x,field = 'title'){
  x <- gsub('^\\s+','',x)
  xid <- grep(sprintf('^%s',field),x)
  Xid <- grep('=',x)

  x_find <- pmin(match(xid,Xid) + 1,length(Xid))
  if(length(Xid[x_find])==0)
    return(NA_character_)

  ret <- paste0(x[xid:(Xid[x_find] - 1)],collapse = '')
  gsub('^\\s+','',gsub('\\s+',' ',gsub('^(.*?)=|[\\",]','',ret)))
}

#' @importFrom readr read_lines
#' @importFrom purrr map2
#' @export
parse_bib <- function(path = system.file('mrg.bib',package = 'paperpile')){

  x <- readr::read_lines(path)
  x1 <- x[nzchar(x)]
  x2 <- grep('^@',x1)
  purrr::map2(x2[-length(x2)],x2[-1],.f=function(x,y) x1[x:(y-1)])

}

#' @importFrom purrr map_chr
#' @importFrom tibble rowid_to_column
#' @export
bibble <- function(bib){

  tibble::tibble(
    key = purrr::map_chr(bib,get_key),
    title = purrr::map_chr(bib,get_field,field = 'title'),
    author = purrr::map_chr(bib,get_field,field = 'author'))%>%
    tibble::rowid_to_column()

}

#' @export
write_bib <- function(bib, subset=NULL, file = ''){

  cat(unlist(bib[subset]),sep='\n',file = file)

}

#' @title re-export magrittr pipe operators
#'
#' @importFrom magrittr %>%
#' @name %>%
#' @rdname pipe
#' @export
NULL
