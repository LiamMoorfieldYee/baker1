#' Gather Data
#' 
#' gather_data() brings together all the daily return data we need from the ws.data package.
#'
#' @return A data frame on stock-by-date information.
#' 
#' @import dplyr ws.data
#' 
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
  
  x <- bind_rows(daily.1998, daily.1999, daily.2000, daily.2001,
                 daily.2002, daily.2003, daily.2004, daily.2005,
                 daily.2006, daily.2007)
  

  x <- rename(x, date = v.date) 
  
  ## Need year for the merge with yearly data frame and month (like Jan-2005) to
  ## calculate monthly returns.
  
  x <- mutate(x, year = lubridate::year(date),
                 month = paste(lubridate::month(date, TRUE, TRUE), year, sep = "-"))
  
  x <- left_join(x, select(yearly, -symbol), 
                 by = c("year", "id"))
  
  x <- left_join(x, select(secref, -symbol), by = "id")
  
  x <- select(x, symbol, name, date, tret, top.1500, month) %>% arrange(date, symbol)

  return(x)
}