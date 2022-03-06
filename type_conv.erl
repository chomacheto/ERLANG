-module(type_conv).

-export([main/0]).

main() ->
    type_stuff().

type_stuff() ->
    is_atom(name),
    is_float(3.14),
    is_integer(10),
    is_boolean(false),
    is_list([1, 2, 3]),
    is_tuple({height, 6.24}),

    % type_to_type
    % atom_to_binary, atom_to_list, binary_to_atom,
    % binary_to_list, bitstring_to_list, binary_to_term,
    % float_to_list, fun_to_list, integer_to_list,
    % iolist_to_binary, iolist_to_atom, list_to_atom,
    % list_to_binary, list_to_bitstring, list_to_float,
    % list_to_integer, list_to_pid, list_to_tuple,
    % pid_to_list, port_to_list, ref_to_list,
    % term_to_binary, tuple_to_list

    List1 = integer_to_list(21),
    List1.
