-module(for_loops).

-export([main/0]).

main() ->
    for(3, 1).

for(0, _) ->
    ok;
for(Max, Min) when Max > 0 ->
    io:fwrite("Num : ~p\n", [Max]),
    for(Max - 1, Min).
