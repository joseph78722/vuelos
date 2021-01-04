library(git2r)

repo <-  repository()
add(repo, "*")

commit(repo, message = "actualización 15 minutos")
cred <- cred_token()
push(repo, credentials = cred)
