-module(my_records).

-export([main/0]).

main() ->
    %record_stuff().

    %-record(customer, {name = "", bal = 0.00}).

    %record_stuff() ->
    %   Sally = #customer{name = "Sally Smith", bal = 100.00},

    %  Sally2 = Sally#customer{bal = 50},

    % io:fwrite("~p owes $ ~p\n", [Sally2#customer.name, Sally2#customer.bal]).
    % ---------------------------------------------------
    %do_math2(),
    %fun_stuff("Ivan").

    %double(X) -> X * 2.

    %triple(X) -> X * 3.

    %do_math2() ->
    %lists:map(fun double/1, [1, 2, 3]),
    %lists:map(fun triple/1, [1, 2, 3]).

    %fun_stuff(N) ->
    %Fun_Stuff = fun() -> io:fwrite("Hello ~p\n", [N]) end,
    %Fun_Stuff().

    fun_stuff2().

fun_stuff2() ->
    X = 3,
    Y = 4,
    Z = fun() ->
        io:fwrite("Sum : ~p\n", [X + Y])
    end,
    Z().
