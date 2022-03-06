-module(lists).

-export([main/0]).

main() ->
    list_stuff().

list_stuff() ->
    List1 = [1, 2, 3],
    List2 = [4, 5, 6],

    List3 = List1 ++ List2,
    List3.
