% -module(mylists).

% -export([main/0]).

% main() ->
%     list_stuff().

% list_stuff() ->
%     List1 = [1, 2, 3],
%     List2 = [4, 5, 6],

%     List3 = List1 ++ List2,
%     List3,

%     List4 = List3 -- List1,
%     List4,

%     hd(List4),
%     tl(List4),

%     List5 = [3 | List4],
%     List5,

%     [Head | Tail] = List5,
%     Head.

-module(mylists).

-compile(export_all).
%% Some definitions copied from lists.erl
%% for pedagogic purposes

%% (1)
map(_, []) -> [];
%% (2)
map(F, [H | T]) -> [F(H) | map(F, T)].

member(H, [H | _]) -> true;
member(H, [_ | T]) -> member(H, T);
member(_, []) -> false.

%% (3)
sum([H | T]) -> H + sum(T);
%% (4)
sum([]) -> 0.

partition(Pred, L) -> partition(Pred, L, [], []).

partition(Pred, [H | T], Ts, Fs) ->
    case Pred(H) of
        true -> partition(Pred, T, [H | Ts], Fs);
        false -> partition(Pred, T, Ts, [H | Fs])
    end;
partition(_, [], Ts, Fs) ->
    {reverse(Ts), reverse(Fs)}.
%END:partition

reverse(L) -> reverse(L, []).

reverse([H | T], L) -> reverse(T, [H | L]);
reverse([], L) -> L.
