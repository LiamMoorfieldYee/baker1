#' Gather Data
#' 
#' gather_data() brings together all the daily return data we need from the ws.data package.
#'
#' @return A data frame on stock-by-date information.
#' @export

gather_data <- function(){
  
  ## Function for gathering data. First, data() the required inputs.
  
  data(daily.1998)
  data(daily.1999)
  data(daily.2000)
  data(daily.2001)
  data(daily.2002)
  data(daily.2003)
  data(daily.2004)
  data(daily.2005)
  data(daily.2006)
  data(daily.2007)
  data(yearly)
  data(secref)
  
  ## Merge in a couple of steps for clarity.
  
  daily <- tbl_df(daily.1998)
  daily <- mutate(daily, year = year(v.date))
  
  x <- left_join(daily, select(yearly, -symbol), 
                 by = c("year", "id"))
  
  x <- left_join(x, select(secref, -symbol), by = "id")  
  
  return(x)
}