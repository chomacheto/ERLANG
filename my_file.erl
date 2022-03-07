-module(my_file).

-export([main/0]).

main() ->
    write_txt("Write to the file"),
    write_txt2(" More text to the file"),
    read_txt().

write_txt(N) ->
    {ok, Fh} = file:open("MyFile.txt", [write]),
    file:write(Fh, N).

write_txt2(N) ->
    {ok, Fh} = file:open("MyFile.txt", [append]),
    file:write(Fh, N).

read_txt() ->
    {ok, File} = file:open("MyFile.txt", [read]),
    Words = file:read(File, 1024 * 1024),
    io:fwrite("~p\n", [Words]).
