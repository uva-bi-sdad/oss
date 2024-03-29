library(httr)

#' Pulls repositories from the code.gov api
get_repos <- function(base_url = 'http://code-api.app.cloud.gov/api/repos',
                      size_per_request = 2,
                      from = 0,
                      key = Sys.getenv('CODE_GOV_API_KEY')) {
  res <- httr::GET(base_url,
                   query = list(
                     'size' = size_per_request,
                     'from' = from
                   ),
                   add_headers(
                     'accept' = 'application/json',
                     'X-Api-Key' = key
                   ))
  return(res)
}


i <- 1
next_page <- TRUE
from <- 0
size_per_request <- 500


# repos <- get_repos(size_per_request = size_per_request)
# con <- content(repos)
#
# l <- lapply(con$repos, data.frame, stringsAsFactors = FALSE)
#
# dt <- data.table::rbindlist(l, fill = TRUE)

all_data_list <- list()

while (next_page) {
  print(i)
  repos <- get_repos(size_per_request = size_per_request,
                     from = from)
  con <- content(repos)
  #print(repos$status_code)

  if (repos$status_code != 200) {
    next_page <- FALSE
  } else {
    l <- lapply(con$repos, data.frame, stringsAsFactors = FALSE)
    dt <- data.table::rbindlist(l, fill = TRUE)
    #print(head(dt))
    all_data_list[[i]] <- dt

    i <- i + 1
    from <- from + size_per_request
    Sys.sleep(1)
  }
}

dt <- data.table::rbindlist(all_data_list, fill = TRUE)

saveRDS(dt, sprintf('./data/oss/original/code_gov/api_pull/%s-repo_contents.RDS', Sys.Date()))
