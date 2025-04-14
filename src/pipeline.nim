import os, file_operations

type
  FileDesc* = object
    path*: string
    data*: string

  PipeLine* = object 
    project_name*: string
    commands*: seq[string]
    dirs*: seq[string]
    files*: seq[FileDesc]

proc runPipeline*(pipe: PipeLine) =
  for dir in pipe.dirs:
    try:
      createDir(dir)
    except OSError:
      echo "error create dir: ", dir
  
  for cmd in pipe.commands:
    discard execShellCmd(cmd)
  
  for file in pipe.files:
    createWith(file.path, file.data) 
