-module(tree).
-export([start/1, loop/1]).

start(D) ->
    Server = spawn(server, loop, [{D, self(), [], []}]),
    Server ! create_layerL,
    Server ! create_layerR,
io:format("test1").

loop({0, _Root, _ChildL, _ChildR}) -> io:format("test2");

loop({D, Root, ChildL, ChildR}) ->
    State = {D, Root, ChildL, ChildR},
    receive
        create_layerL -> ChildL = spawn(server, loop, [{D-1, Root, self(), []}]),
        NewState = {D, Root, ChildL},
        io:format("D:~p, Root:~p, ChildL:~p~n", [D, Root, self()]),
        ChildL ! create_layerL;


        create_layerR -> ChildR = spawn(server, loop, [{D, Root, [], self()}]),
        NewState = {D, Root, ChildL, ChildR},

        io:format("D:~p, Root:~p, ChildR:~p~n", [D, Root, self()]),
                        ChildR ! create_layerR;

        Any -> Any,
            NewState = State
    end,
loop(NewState).