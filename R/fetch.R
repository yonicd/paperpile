#' @title Fetch an object(s) from paperpile shared folder
#' @description Fetch an object using a [dribble][googledrive::dribble] object
#' returned from [query][paperpile::query]
#' @param obj [dribble][googledrive::dribble] object
#' returned from [query][paperpile::query]
#' @param path character, path to save the output, Default: tempdir()
#' @param \dots arguments to pass to [drive_download][googledrive::drive_download]
#' @return NULL
#' @details dribble can be multiple rows, in this case all files will be downloaded to path.
#' @examples
#' \dontrun{
#' f <- query('Holford and Sheiner 1981')
#' fetch(f[1,])
#' fetch(f[1,],path = '~/Desktop')
#' fetch(f[1,],path = '~/Desktop',overwrite = TRUE)
#' }
#' @seealso
#'  [drive_download][googledrive::drive_download]
#' @rdname fetch
#' @export
#' @importFrom purrr walk2
#' @importFrom googledrive drive_download as_id
fetch <- function(obj,path = tempdir(),...){

  if(!dir.exists(path)){
    dir.create(path)
  }

  purrr::walk2(obj$id,obj$name,
               .f=function(id,name,path){
                 googledrive::drive_download(
                   googledrive::as_id(id),
                   path = file.path(path,name),...)
               },path = path)
}
