-module(flower).
-export([loop/1, start/2]).

start(N, {calculate, Z}) ->
    P0 = spawn(flower, loop, [{N, self(), []}]),
    P0 ! create_child,
    P0 ! {do, Z},
    receive
        {final_result, Result} -> Result
    end.


loop({0, Root, _Child}) ->
    receive
        {do, M} -> Root ! {final_result, M}
    end;

loop({N, Root, Child}) ->
    State = {N, Root, Child},
    receive
        create_child -> NewChild = spawn(flower, loop, [{N-1, Root, []}]),
                        %NewChild2 = spawn(flower, loop, [{N, Root, Child, []}]),
                        NewState = {N, Root, NewChild},
                        io:format("N: ~p, Me:~p, NewChild: ~p~n", [N, self(), NewChild]),
                        NewChild ! create_child,
                        NewChild ! create_child2;
                        %NewChild2 ! create_child,

                        {do, X} -> M = X*X,

                        io:format("Number N: ~p, Me:~p, M: ~p~n", [N, self(), M]),
                        Child ! {do, M},
                        NewState = State;
        create_child2 ->NewChild2 = spawn(flower, loop, [{N, Root, []}]),
                    io:format("Child2 N: ~p, Me:~p, NewChild: ~p~n", [N, self(), NewChild2]),
                    NewState = State;


        Any -> Any,
            NewState = State
    end,
loop(NewState).