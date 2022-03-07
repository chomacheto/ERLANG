-module(my_macros).

-export([main/0]).

main() ->
    macro_stuff(5, 6).

-define(add(X, Y), {X + Y}).

macro_stuff(X, Y) ->
    io:fwrite("~p\n", [?add(X, Y)]).
