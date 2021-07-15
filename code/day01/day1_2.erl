-module(day1_2).
-export([run/0]).

run()->
    process_list(load_file("day1input.txt")).

load_file(Filename)->
    {ok, Binary} = file:read_file(Filename),
    StringContent = unicode:characters_to_list(Binary),
    [ element(1, string:to_integer(Substr)) || Substr <- string:tokens(StringContent, "\n")]. 

process_list([H | T])->
    case process_sublist(H, T) of
        notfound -> process_list(T);
        X -> X
    end;
process_list([])->
    notfound.

process_sublist(Elem, [H1 | T]) ->
    case process_subsublist(Elem, H1, T) of
        notfound -> process_sublist(Elem, T);
        X -> X
    end;
process_sublist(_, []) ->
    notfound.

process_subsublist(Elem1, Elem2, [H | T])->
    case is_solution(Elem1, Elem2, H) of
        true -> {found, Elem1, Elem2, H, H*Elem1*Elem2};
        false -> process_subsublist(Elem1, Elem2, T)
    end;
process_subsublist(_,_, []) ->
    notfound.

is_solution(X, Y, Z) ->
    X + Y + Z =:= 2020.
