# INPUT:
#        "~/oss/data/oss/working/pypi/04_prod_mature_w_licenses.csv"
#        "~/oss/data/oss/final/PyPI/osi_approved_licenses.csv"
# OUTPUT:
#        "~/oss/data/oss/working/pypi/05_prod_mature_names_w_osi_approved_status.csv"

library(ggplot2)

prod_mature_pkgs <- read.csv("./data/oss/working/pypi/04_prod_mature_w_licenses.csv")
osi_licences <- read.csv("./data/oss/final/PyPI/osi_approved_licenses.csv")

prod_mature_pkgs$osi_approved <- NA

for (i in 1:length(prod_mature_pkgs$name))
{
  if ((prod_mature_pkgs$license[i] %in% osi_licences$abbreviation) || (prod_mature_pkgs$license[i] %in% osi_licences$full_name))
  {
    prod_mature_pkgs$osi_approved[i] <- TRUE
  } else {
    prod_mature_pkgs$osi_approved[i] <- FALSE
  }
}
prod_mature_pkgs$X.1 <- NULL
prod_mature_pkgs$X <- NULL

write.csv(prod_mature_pkgs, "~/oss/data/oss/working/pypi/05_prod_mature_names_w_osi_approved_status.csv")

# EXPLORATORY ANALYSIS WORK
num_osi_approved <- sum(which(prod_mature_pkgs$osi_approved == TRUE))

osi_app = prod_mature_pkgs[grep(TRUE, prod_mature_pkgs$osi_approved), ]

percent_osi_app <- nrow(osi_app)/nrow(prod_mature_pkgs) * 100

licenses_dist <- ggplot(data = prod_mature_pkgs, mapping = aes(x = osi_approved, color = development_status)) + geom_bar()

licenses_dist <- ggplot(data = prod_mature_pkgs) +
  geom_bar(mapping = aes(fill = osi_approved, x = development_status), position = 'dodge')
