#' @title Query paperpile google drive
#' @description Using googledrive api query the paperpile shared folder
#' @param pattern text to search for in title or in body of document
#' @param field character, what field to query, usually name of fullText, Default: 'name'
#' @param operator character, what operator to apply in query, usually '=' or 'contains', Default: 'contains'
#' @param type character, mime type to search for, Default: 'application/pdf'
#' @param \dots arguments passed to [drive_find][googledrive::drive_find]
#' @return OUTPUT_DESCRIPTION
#' @details DETAILS
#' @examples
#' \dontrun{
#' query('understanding the dose-effect')
#' }
#' @seealso
#'  [drive_find][googledrive::drive_find]
#' @rdname query
#' @export
#' @importFrom googledrive drive_find
#' @importFrom glue glue
query <- function(pattern, field = 'name', operator = 'contains', type = "application/pdf",...){

  this <- glue::glue("{field} {operator} '{pattern}'")

  googledrive::drive_find(q = this, type = type,...)

}
