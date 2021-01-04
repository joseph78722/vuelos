
setwd("~/Vuelos2/docs")
library(git2r)

repo <-  repository()
add(repo, "*")

commit(repo, message = "nuevo")
cred <- cred_token()
push(repo, credentials = cred)
