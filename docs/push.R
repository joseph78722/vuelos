
setwd("/Users/jose/Vuelos2")
library(git2r)

repo <-  repository()
add(repo, "*")

commit(repo, message = "nuevo")
cred <- cred_token(token = "GITHUB_PAT")
push(repo, credentials = cred)
cred