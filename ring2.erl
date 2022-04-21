-module(ring2).
-export([loop/1, start/2]).

start(N, {calculate, Z}) ->
    P0 = spawn(ring2, loop, [{N, self(), []}]),
    P0 ! create_child,
    P0 ! {do, Z},
    receive
        {final_result, Result} -> Result
    end.

%P0 -> P1(P0)......PN(PN-1)
%    |              |
%    P              P

%P(P1) -> P1(P2) -> .........PN().
%State = {N, Root, Child}

%binary tree
%State = {N, Root, [ChildL, ChildR]}.

loop({0, Root, _Child}) ->
    receive
        {do, M} -> Root ! {final_result, M}
    end;

loop({N, Root,  Child}) ->
    State = {N, Root, Child},
    receive
        create_child -> NewChild = spawn(ring2, loop, [{N-1, Root, []}]),
                        NewState = {N, Root, NewChild},
                        io:format("N: ~p, Me:~p, NewChild: ~p~n", [N, self(), NewChild]),
                        NewChild ! create_child;

                    {do, X} -> M = X*X,

                    io:format("N: ~p, Me:~p, M: ~p~n", [N, self(), M]),
                    Child ! {do, M},
                    NewState = State;
        Any -> Any,
               NewState = State
    end,
    loop(NewState).