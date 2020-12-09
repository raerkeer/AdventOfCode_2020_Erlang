-module(day9).
-export([run/0]).

run()->
    Input = load_file("day9input.txt"),
    InvalidNumber = part1(Input),
    {InvalidNumber, part2(Input, InvalidNumber)}.

part1(Input)->
    find_invalid_number(Input, 1).

find_invalid_number(Input, Offset)->
    Preamble = lists:sublist(Input, Offset, 25),
    NumberToCheck = lists:nth(Offset + 25, Input),
    case is_valid(Preamble, NumberToCheck) of
        true -> find_invalid_number(Input, Offset + 1);
        false -> NumberToCheck
    end.

is_valid(Preamble, Number)->
    Sums = [X + Y || X <- Preamble, Y <- Preamble, X=/=Y],
    lists:member(Number, Sums).

part2(Input, InvalidNumber)->
    find_weakness(Input, 1, 1, InvalidNumber).

find_weakness(Input, Offset, Length, InvalidNumber)->
    Sublist = lists:sublist(Input, Offset, Length),
    SublistSum = lists:sum(Sublist),
    case SublistSum =:= InvalidNumber of
        true -> lists:nth(1, Sublist) + lists:last(Sublist);
        false -> 
            case (SublistSum > InvalidNumber) or (Offset + Length =:= length(Input)) of
                true -> find_weakness(Input, Offset + 1, 1, InvalidNumber);
                false -> find_weakness(Input, Offset, Length+1, InvalidNumber)
            end
        end.

load_file(Filename)->
    {ok, Binary} = file:read_file(Filename),
    StringContent = unicode:characters_to_list(Binary),
    [ element(1, string:to_integer(Line)) || Line <- string:split(StringContent, "\n", all)].
