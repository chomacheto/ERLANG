-module(tut).
-import(string, [len/1, concat/2, chr/2, substr/3, str/2, to_lower/1, to_upper/1]).

-export([main/0]).

main() ->
    what_grade(10).

preschool() ->
    'Go to preschool'.

kindergarten() ->
    'Go to kindergarten'.

grade_school() ->
    'Go to grade grade school'.

what_grade(X) ->
    if
        X < 5 -> preschool();
        X == 5 -> kindergarten();
        X > 5 -> grade_school()
    end.

% sin, cos, tan, asin, acos, atan, sinh, cosh, tanh, asinh,
	% acosh, atanh
