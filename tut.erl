-module(tut).
-import(string, [len/1, concat/2, chr/2, substr/3, str/2, to_lower/1, to_upper/1]).

-export([main/0]).

main() ->
    do_math(5, 4).

do_math(A, B) ->
    math:sqrt(64).

% sin, cos, tan, asin, acos, atan, sinh, cosh, tanh, asinh,
	% acosh, atanh
