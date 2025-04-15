import os
import pipeline

proc walk(path: string, callback: proc(path: string, isDir: bool)) =
  for kind, file in walkDir(path):
    case kind
    of pcFile, pcLinkToFile:
      callback(file, false)
    of pcDir:
      callback(file, true)
      walk(file, callback)
    of pcLinkToDir:
      discard

proc parseDir*(pathDir : string): Pipeline =
    var 
        pipe : Pipeline
    walk(pathDir) do (path: string, isDir: bool):
        if isDir:
            pipe.dirs.add(path)
        else:
            var file : FileDesc
            try:
              let data = readFile(path)
              file.path = path 
              file.data = data
            except OSError:
              echo "os error readfile"
            except:
              echo "unknown error readfile"

            
