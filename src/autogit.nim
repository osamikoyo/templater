import osproc

const 
  GIT_INIT_CMD = "git init"
  GIT_FIRST_COMMIT_CMD = "git add . && git commit -m base"

proc autogit(commitmsg : string) = 
  echo "work with git"

  let exit = execcmd(GIT_INIT_CMD)
  if exit != 0:
    echo "error create git repo"
    return

  let commit_exit = execcmd(GIT_FIRST_COMMIT_CMD)
  if commit_exit != 0:
    echo "error make a commit"
    return



