-module(day8).
-export([run/0]).

run()->
    Instructions = load_file("day8input.txt"),
    {part1(Instructions, [], 0, 1), part2(Instructions, 1)}.

part1(Instructions, PositionsVisited, Acc, Pos)->
    case lists:member(Pos, PositionsVisited) of
        true -> {infiniteloop, Acc};
        false ->
            {Instr, Val} = lists:nth(Pos, Instructions),
            case Instr of
                "nop" -> part1(Instructions, [Pos | PositionsVisited], Acc, Pos + 1);
                "acc" -> part1(Instructions, [Pos | PositionsVisited], Acc + Val, Pos + 1);
                "jmp" -> part1(Instructions, [Pos | PositionsVisited], Acc, Pos + Val);
                endofcode -> {finished, Acc}
            end
        end.

part2(Instructions, ModifyAt)-> 
    NewInstructions = modify_code(Instructions, ModifyAt),
    case part1(NewInstructions, [], 0, 1) of
        {finished, Acc} -> {finished, Acc};
        {infiniteloop,_} -> part2(Instructions, ModifyAt+1)
    end.

modify_code(Instructions, ModifyAt)->
    case lists:nth(ModifyAt, Instructions) of
        {"nop", Val} -> lists:sublist(Instructions,ModifyAt-1) ++ [{"jmp", Val}] ++ lists:nthtail(ModifyAt,Instructions);
        {"jmp", Val} -> lists:sublist(Instructions,ModifyAt-1) ++ [{"nop", Val}] ++ lists:nthtail(ModifyAt,Instructions);
        {"acc",_} -> modify_code(Instructions, ModifyAt+1)
    end.

load_file(Filename)->
    {ok, Binary} = file:read_file(Filename),
    StringContent = unicode:characters_to_list(Binary),
    Lines = [ string:split(Line, " ") || Line <- string:split(StringContent, "\n", all)],
    lists:map(fun(L) -> parse_line(L) end, Lines).

parse_line(Line)->
    case Line of
        [[]]->{endofcode, nil};
        [Instruction, Value] ->
            {IntVal, _} = string:to_integer(Value),
            {Instruction, IntVal}
    end.
