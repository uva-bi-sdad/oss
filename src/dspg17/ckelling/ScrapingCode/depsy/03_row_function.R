#this creates functions to scrape all information from Depsy


makenodeRow <- function(name){
  #i=3458
  #name <- depsy_packages[i,1]
  #link <- "http://depsy.org/api/package/cran/A3"
  url <- paste('http://depsy.org/api/package/cran/', name, sep='')
  document <- jsonlite::fromJSON(txt=url)
  df <- c('name','citations_harv','citations_pmc', 'git_owner','git_repo_name','host', 'impact', 'impact_percentile', 'indegree', 'is_academic', 'language','neighborhood_size', 'num_authors', 'num_commits', 'num_committers', 'num_contribs', 'num_stars', 'num_downloads','perc_downloads',  'num_citations','perc_citations',  'num_deprank', 'perc_deprank', 'summary')
  contribs <- document$all_contribs$github_login
  #contribs
  new_df <- as.data.frame(t(df), stringsAsFactors = FALSE)
  colnames(new_df) <- df
  new_df <- new_df[-1, ]
  new_df[1, 'num_contribs'] <- length(contribs)
  if(is.null(document$github_owner) != TRUE){
    new_df[1, 'git_owner'] <- document$github_owner
  }
  new_df[1, 'summary'] <- document$summary
  if(is.null(document$github_repo_name) != TRUE){
    new_df[1, 'git_repo_name'] <- document$github_repo_name
  }
  if(is.null(document$num_authors) != TRUE){
    new_df[1, 'num_authors'] <- document$num_authors
  }
  new_df[1, 'is_academic'] <- document$is_academic
  new_df[1, 'language'] <- document$language
  #new_df[1, 'citations_dict'] <- document$citations_dict
  if(is.null(document$indegree) != TRUE){
    new_df[1, 'indegree'] <- document$indegree
  }
  new_df[1, 'name'] <- document$name
  new_df[1, 'impact'] <- document$impact
  if(is.null(document$num_commits) != TRUE){
    new_df[1, 'num_commits'] <- document$num_commits
  }
  if(is.null(document$num_commits) != TRUE){
    new_df[1, 'num_commits'] <- document$num_commits
  }
  if(is.null(document$num_committers) != TRUE){
    new_df[1, 'num_committers'] <- document$num_committers
  }
  if(is.null(document$neighborhood_size) != TRUE){
    new_df[1, 'neighborhood_size'] <- document$neighborhood_size
  }
  if(is.null(document$num_stars) != TRUE){
    new_df[1, 'num_stars'] <- document$num_stars
  }
  new_df[1, 'impact_percentile'] <- document$impact_percentile
  new_df[1, 'citations_harv'] <- document$citations_dict$count[1]
  new_df[1, 'citations_pmc'] <- document$citations_dict$count[2]
  new_df[1, 'host'] <- document$host
  new_df[1, 'num_downloads'] <- document$subscores[1,6]
  new_df[1, 'perc_downloads'] <- document$subscores[1, 5]
  new_df[1, 'num_citations'] <- document$subscores[2,6]
  new_df[1, 'perc_citations'] <- document$subscores[2, 5]
  new_df[1, 'num_deprank'] <- document$subscores[3,6]
  new_df[1, 'perc_deprank'] <- document$subscores[3, 5]
  return(new_df)
}


makecontribRow <- function(name){
  #name <- depsy_packages[5,1]
  #link <- "http://depsy.org/api/package/cran/A3"
  url <- paste('http://depsy.org/api/package/cran/', name, sep='')
  document <- jsonlite::fromJSON(txt=url)
  df <- c('name','contrib')
  new_df <- c()

  oss_name <- document$name
  contribs <- document$all_contribs$name

  for(i in 1:length(document$all_contribs$name)){
    contrib_name <- contribs[i]
    new_row <- c(oss_name, contrib_name)
    new_df <- rbind(new_df, new_row)
  }

  colnames(new_df) <- df
  return(new_df)
}

makeneighRow <- function(name){
  #name <- depsy_packages[12,1]
  #link <- "http://depsy.org/api/package/cran/A3"
  url <- paste('http://depsy.org/api/package/cran/', name, sep='')
  document <- jsonlite::fromJSON(txt=url)
  df <- c('name','neighbor')
  new_df <- c()

  oss_name <- document$name
  neighbs <- document$all_neighbor_ids
  final_neighb <- c()
  if(length(neighbs) != 0){
    for(i in 1:length(neighbs)){
      if(substr(neighbs[i], 1, 5) == "cran:"){
        new_neighb <- neighbs[i]
        final_neighb <- rbind(final_neighb, new_neighb)
      }
    }
  }
  if(length(final_neighb) > 0){
    for(i in 1:length(final_neighb)){
      neighb_name <- final_neighb[i]
      new_row <- c(oss_name, neighb_name)
      new_df <- rbind(new_df, new_row)
      colnames(new_df) <- df
    }
  }
  return(new_df)
}


