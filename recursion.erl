-module(recursion).

-export([main/0]).

main() ->
    find_factorial(3).

factorial(N) when N == 0 -> 1;
factorial(N) when N > 0 -> N * factorial(N - 1).

find_factorial(X) ->
    Y = factorial(X),
    io:fwrite("Factorial : ~p\n", [Y]),

    sum([1, 2, 3]).

sum([]) -> 0;
sum([H | T]) -> H + sum(T).
