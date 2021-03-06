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
#' @importFrom purrr map2 set_names
#' @export
parse_bib <- function(path = system.file('mrg.bib',package = 'paperpile')){

  x <- readr::read_lines(path)
  x1 <- x[nzchar(x)]
  x2 <- grep('^@',x1)
  ret <- purrr::map2(x2[-length(x2)],x2[-1],.f=function(x,y) x1[x:(y-1)])

  purrr::set_names(ret,purrr::map_chr(ret,get_key))

}

#' @importFrom purrr map_chr
#' @export
bibble <- function(bib){

  ret <- tibble::tibble(
    key = purrr::map_chr(bib,get_key),
    title = purrr::map_chr(bib,get_field,field = 'title'),
    author = purrr::map_chr(bib,get_field,field = 'author'))

  class(ret) <- c(class(ret),'bibble')

  ret
}

#' @export
write_bib <- function(keys, file = '', bib = parse_bib(),...){

  cat(unlist(bib[keys]),sep='\n',file = file,...)

}

#' @export
#' @importFrom checkmate testClass
write_bibble <- function(obj, file = '', bib = parse_bib(),...){

  checkmate::testClass(obj,'bibble')

  cat(unlist(bib[obj$key]),sep='\n',file = file,...)

}

#' @title re-export magrittr pipe operators
#'
#' @importFrom magrittr %>%
#' @name %>%
#' @rdname pipe
#' @export
NULL

#' @export
#' @importFrom readr read_lines
find_cite <- function(file) {

  x <- readr::read_lines(file); x1 <- x[grepl('\\cite',x)]
  ret <- unlist(regmatches(x1,gregexpr('\\cite\\{(.*?)\\}',x1)))
  ret <- gsub('^cite\\{|\\}$','',ret)
  ret <- gsub('^\\s+|\\s+$','',ret)
  sort(unique(strsplit(paste0(ret,collapse = ','),',')[[1]]))

}

#' @export
#' @importFrom purrr map keep flatten_chr
map_find_cite <- function(path){

  ret <- purrr::map(list.files(path,pattern = '.tex$',full.names = TRUE),find_cite)

  ret <- purrr::keep(ret,.p = function(x) length(x)>0)

  ret <- unique(purrr::flatten_chr(ret))

  ret <- gsub('^\\s+|\\s+$','',ret)

  sort(ret)
}
