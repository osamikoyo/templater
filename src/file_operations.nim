import os, osproc

const EXAMPLE_TEMPLATE_DATA = """
project = "coni"
commands = ["go mod init", "echo hello"]
dirs = ["internal", "internal/server"]

[files]

[files.main]
path = "cmd/main.go"
data = "package main\n\nfunc main(){\n\n}"

[files.server]
path = "internal/server/server.go"
data = "package server\n\ntype Server struct{\nserver *http.Server\n}"
"""

const HOME_DIR = ".templates"

proc createWith*(path, data: string) =
  let filepath = path & ".toml"

  try:
    createDir(parentDir(filepath)) 
    writeFile(filepath, data)
    echo "created file: ", filepath
  except OSError as e:
    echo "errror to create file: ", e.msg

proc createHomeDir*(): string =
  let path = getHomeDir() / HOME_DIR
  try:
    createDir(path)
    result = path
  except OSError as e:
    echo "error create dir: ", e.msg
    result = ""

proc createDefault*(name : string) =
  try:
    createWith(name, EXAMPLE_TEMPLATE_DATA)
  except OSError:
    echo "os error create file"
  except:
    echo "unknowm error create file"

proc moveTempl*(path : string) =
  try:
    let homeDir = getHomeDir()
    let destDir = homeDir / HOME_DIR 

    createDir(destDir)
    
    let filename = extractFilename(path)
    
    let destPath = destDir / filename
    
    if not fileExists(path):
      raise newException(IOError, "Source file does not exist: " & path)
    
    if fileExists(destPath):
      raise newException(IOError, "Destination file already exists: " & destPath)
    
    moveFile(path, destPath)
    echo "File moved successfully to: ", destPath
    
  except OSError as e:
    echo "OS error while moving file: ", e.msg
  except IOError as e:
    echo "File operation error: ", e.msg
  except:
    echo "Unknown error: ", getCurrentExceptionMsg()
