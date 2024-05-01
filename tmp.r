tryCatch(
    {
        shell('cls')
    },
    error = function(e){
        system(print0('clear'))
        print("Running on linux!")
    },
    finally = {
        print("cleared session")
    }
)