-module(day5).
-export([run/0]).

run()->
    SeatCodes = load_file("day5input.txt"),
    SeatIds = lists:map(fun(SeatCode) -> calc_seatid(SeatCode) end, SeatCodes),
    {part1(SeatIds), part2(SeatIds)}.

part1(SeatIds)->
    lists:max(SeatIds).

part2(SeatIds)->
    SortedIds = lists:sort(SeatIds),
    my_seat(SortedIds).

my_seat([X, Y | T])->
    case Y-X of
        1 -> my_seat([Y|T]);
        _ -> X+1
    end.

calc_seatid(SeatCode)->
    Bits = lists:map(fun(X) -> get_bit(X) end, SeatCode),
    list_to_integer(Bits, 2).
    %Row = list_to_integer(string:slice(Bits, 0, 7), 2),
    %Col = list_to_integer(string:slice(Bits, 7, 3), 2),
    %Row * 8 + Col.

get_bit($F) -> $0;
get_bit($B) -> $1;
get_bit($L) -> $0;
get_bit($R) -> $1.

load_file(Filename)->
    {ok, Binary} = file:read_file(Filename),
    StringContent = unicode:characters_to_list(Binary),
    [ Line || Line <- string:tokens(StringContent, "\n")]. 