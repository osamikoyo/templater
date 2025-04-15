import os, file_operations
import parsetoml, tables
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

proc pipelineToToml*(pipe : PipeLine): string =
  var 
    data = newTTable()
    files = newTArray()
    dirs = newTArray()

  for dir in pipe.dirs:
    dirs.add(newTString(dir))
  
  data["dirs"] = dirs

  for file in pipe.files:
    var fileData = newTTable()

    fileData["path"] = newTString(file.path)
    fileData["data"] = newTString(file.data)

    files.add(fileData)
  
  data["files"] = files

  result = data.toTomlString()
