import file_operations
import pipeline
import parser


const HOME_DIR = ".larny-templates"

proc run_app*(args : seq[string]) =
    if len(args) < 2:
        echo "number of argc so small"
        return
    case args[0]
    of "generate":
        createDefault(args[1])
    of "install":
        moveTempl(args[1])
    of "project":
        let path = HOME_DIR & "/" & args[1] &  ".toml"
        let pipe : Pipeline = parseTempl(path)
        pipe.runPipeline()
proc hello(goida : string) =
    
