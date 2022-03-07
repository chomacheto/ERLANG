-module(my_maps).

-export([main/0]).

main() ->
    map_stuff().

map_stuff() ->
    Bob = #{f_name => 'Bob', l_name => 'Smith'},

    io:fwrite("1st Name : ~p\n", [maps:get(f_name, Bob)]),

    io:fwrite("~p\n", [maps:remove(l_name, Bob)]),

    maps:put(address, "123 main", Bob).
