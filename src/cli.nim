import file_operations

proc run_app(args : seq[string]) =
    if len(args) < 1:
        echo "number of argc so small"
    case args[0]
    of "generate":
        createDefault(args[1])
    of "install":
        moveTempl(args[1])
            
