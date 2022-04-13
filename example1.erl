-module(example1).
-export([test/1, test/2, factoriel/1, loop/0]).

test(_X, _Y) ->
    alabala.

test(5) -> 0;
test(ok) -> ok;
test(X) -> io:format("X: ~p ~n", [X]).

%Factoriel(N) = N*Factoriel(N-1) ....

%Factoriel(0) = 1

factoriel(0) ->
    1;
factoriel(N) ->
    io:format("N: ~p~n", [N]),
    N * factoriel(N - 1).

loop() ->
    receive
        {X, 1} -> io:format("X= ~p ~n", [X])
    end,

    loop().

what is the actor model?
