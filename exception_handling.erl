-module(exception_handling).

-export([main/0]).

main() ->
    error_stuff(0),
    read_txt2().

error_stuff(N) ->
    try
        Ans = 2 / N,
        Ans
    catch
        error:badarith ->
            "Can't divide by zero"
    end.

read_txt2() ->
    try
        {ok, File} = file:open("MyFile1.txt", [read]),
        Words = file:read(File, 1024 * 1024),
        io:fwrite("~p\n", [Words])
    catch
        _:_ ->
            "File Doesn't Exist"
    end.
