-module(day10).
-export([run/0]).

run()->
    Input = lists:sort(load_file("day10input.txt")),
    {part1(Input), part2(Input)}.

part1(Input)-> 
    calc1([0|Input], 0, 0).

calc1([X,Y|T], Ones, Threes) ->
    case Y - X of
        1 -> calc1([Y|T], Ones + 1, Threes);
        3 -> calc1([Y|T], Ones, Threes + 1);
        _ -> calc1([Y|T], Ones, Threes)
    end;
calc1(_, Ones, Threes)->
    Ones * (Threes + 1).

% Idea for part 2 stolen from camilleryr (https://github.com/camilleryr/advent20/blob/main/lib/day_10.ex) and translated to Erlang
part2(Input)-> 
    {Consecutives,_} = lists:foldl(fun(X, Acc) -> calc_consecutive(X, Acc) end, {[1],0}, Input),
    Permutations = lists:map(fun(X)-> calc_tribonacci(X) end, Consecutives),
    lists:foldl(fun(X, Acc) -> X * Acc end, 1, Permutations).

calc_consecutive(Elem, {[H | T] = L, Prev})->
    case Elem - Prev of
        1 -> {[H + 1 | T], Elem};
        _ -> {[1 | L], Elem}
    end.

calc_tribonacci(0) -> 0;
calc_tribonacci(X) when (X =:= 1) or (X =:= 2) -> 1;
calc_tribonacci(X) -> calc_tribonacci(X - 1) + calc_tribonacci(X - 2) + calc_tribonacci(X - 3).

load_file(Filename)->
    {ok, Binary} = file:read_file(Filename),
    StringContent = unicode:characters_to_list(Binary),
    [ element(1, string:to_integer(Line)) || Line <- string:split(StringContent, "\n", all)].
