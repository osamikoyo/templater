import parsetoml
import pipeline

proc parseTempl*(path: string): PipeLine =
    var 
        cmds : seq[string]
        dirs : seq[string]
        files : seq[FileDesc]
        pipe : PipeLine
        file : FileDesc

    let data = parseFile(path)

    pipe.project_name = data["project"].getStr()

    let filesPipe = data["files"].getTable()
    for key, filedata in filesPipe.pairs():
        file.path = filedata["path"].getStr()
        file.data = filedata["data"].getStr()

        files.add(file)
    
    let commands = data["commands"].getElems()
    for cmd in commands:
        cmds.add(cmd.getStr())

    let dirsPipe = data["dirs"].getElems()
    for dir in dirsPipe:
        dirs.add(dir.getStr())

    pipe.files = files
    pipe.commands = cmds
    pipe.dirs = dirs
    return pipe
        
