-module(concurrency).

-export([main/0]).

main() ->
    spawner2(50, 1),
    spawner2(100, 51).

% get_id(M) ->
%     io:fwrite("ID : ~p\n", [M]).

% spawner() ->
%     spawn(
%         fun() ->
%             get_id(
%                 [self()]
%             )
%         end
%     ).
%-----------------------------------------------------

for2(0, _) ->
    ok;
for2(Max, Min) when Max > 0 ->
    io:fwrite("Num : ~p\n", [Max]),
    for2(Max - 1, Min).

spawner2(Max, Min) ->
    spawn(fun() -> for2(Max, Min) end).
