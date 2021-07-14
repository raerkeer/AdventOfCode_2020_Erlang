-module(day1_1).
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
        {found, X, Y, Result} -> {X, Y, Result}
    end;
process_list([])->
    notfound.

process_sublist(Elem, [H | T]) ->
    case is_solution(Elem, H) of
        true -> {found, Elem, H, H*Elem};
        false -> process_sublist(Elem, T)
    end;
process_sublist(_, []) ->
    notfound.

is_solution(X, Y) ->
    X + Y =:= 2020.
