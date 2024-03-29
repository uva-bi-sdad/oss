library(readr)
library(dplyr)
library(MASS)
depsy_net_nodes <- read_csv("~/git/oss/src/gkorkmaz/depsy_dependency_network_nodes.csv")
load(file = "~/git/oss/data/oss/working/depsy/updated_neighb_mat.Rdata")
load(file = "~/git/oss/data/oss/working/depsy/node_mat.Rdata")
node_mat$num_commits <- as.numeric(node_mat$num_commits)
node_mat$num_stars <- as.numeric(node_mat$num_stars)
node_mat$num_committers <- as.numeric(node_mat$num_committers)
node_mat$num_authors <- as.numeric(node_mat$num_authors)
node_mat$num_citations <- as.numeric(node_mat$num_citations)
node_mat$num_downloads <- as.numeric(node_mat$num_downloads)
node_mat$num_contribs <- as.numeric(node_mat$num_contribs)

#node_mat <- node_mat[-which(node_mat$deg == 0),]
full_data <- left_join(depsy_net_nodes[,c(1,4:18)], node_mat[,c(1,13:18,20)], by = c(id = "name"))
full_data <- full_data[,-1]

full_data[is.na(full_data)] <- 0
full_data <- full_data[,-c(3,6)]

full_data <- full_data[,-c(1,11,14,16)]
full_data <- full_data[,-c(9,11)]
full_data <- full_data[,-c(6)]


fit1=glm(num_citations ~ ., data = full_data,family="quasipoisson", control = list(maxit = 50))
summary(fit1)
test <- vcov(fit1)

glm.fit <- glm(num_citations ~ ., family="poisson", data=full_data, control = list(maxit = 1000))
summary(glm.fit)


plot(full_data[,1:9])


# Possible Overdispersion;
# Check of Overdispersion
#check of dispersion parameter: 132
sum(residuals(glm.fit, type="pearson")^2)/glm.fit$df.residual

glm.fit.quasi <- glm( num_citations ~ ., data=full_data, family="quasipoisson", control = list(maxit = 50))
summary(glm.fit.quasi)

library(pscl)
full_data <- full_data[,-c(2)]
full_data <- full_data[,-c(2)]
zero.inf <- zeroinfl(num_citations ~ ., data=full_data, dist="negbin", control = zeroinfl.control(maxit = 1000))
summary(zero.inf)

### Model Diagnostics
fitted.mean <- (predict.glm(glm.fit, type='link'))
fitted.resp <- (predict.glm(glm.fit, type='response'))
fitted.var <- (full_data$num_citations - fitted.mean)^2

fit.data <- data.frame(fitted.resp, fitted.var, fitted.mean)

#if slope=1 (Poisson) if not 1 (quassipoison) if not line (not poisson)
ggplot(fit.data, aes(x=log(fit.data[,1])) )+
  geom_point(aes(y=log(fit.data[,2]), colour ="red"), size=3)+
  geom_abline(slope = 1, intercept = 0, color="blue") +
  theme( legend.position= "none", axis.text=element_text(size=20), axis.title=element_text(size=24),
         text=element_text(size=24) ) +
  xlab(expression( 'Standardized '(hat(mu)) ) ) +
  scale_y_continuous(expression( 'Standardized '(y-hat(mu))^2 ) ) +
  scale_colour_identity() +
  ggtitle(expression('Fitted Mean vs Fitted Variance') )
