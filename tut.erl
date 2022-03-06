-module(tut).
-import(string, [len/1, concat/2, chr/2, substr/3, str/2, to_lower/1, to_upper/1]).

-export([main/0]).

main() ->
    string_stuff().

string_stuff() ->
    Str1 = "Random string",
    Str2 = "Another string",

    io:fwrite("String : ~p ~p\n", [Str1, Str2]),

    Str3 = io_lib:format("It's a ~s and ~s\n", [Str1, Str2]),
    io:fwrite(Str3),

    len(Str3),

    Str4 = concat(Str1, Str2),
    Str4,

    CharIndex = chr(Str4, $r),
    CharIndex,

    Str5 = substr(Str4, 8, 6),
    Str5,

    StrIndex = str(Str4, Str2),
    StrIndex,

    to_upper(Str1),
    to_lower(Str2).
