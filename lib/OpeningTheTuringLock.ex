defmodule OpeningTheTuringLock do
 def read_instructions do
  {status, text} = File.read("lib/input.txt") 
  case status do
    :ok -> 
      text 
      |> String.split("\n", trim: true)
      |> execute_instructions(%{"a" => 0, "b" => 0}, 0)
    _ -> IO.puts(status)
    end
  end

  def execute_instructions(instruction_list, registers, pos) when pos >= length(instruction_list) or pos < 0 do
    registers
  end

  def execute_instructions(instruction_list, registers, pos) do  
    case List.to_tuple(String.split(Enum.at(instruction_list, pos),[" ", ","],trim: true)) do
      {"inc", register} -> execute_instructions(instruction_list, Map.update!(registers, register, &(&1 + 1)), pos + 1 )
      {"hlf", register} -> execute_instructions(instruction_list, Map.update!(registers, register, &(Integer.floor_div(&1,2))), pos + 1 )
      {"tpl", register} -> execute_instructions(instruction_list, Map.update!(registers, register, &(&1 * 3)), pos + 1 )
      {"jmp", offset} -> execute_instructions(instruction_list, registers, new_position(pos, offset)) 
      {"jie", register,offset} -> execute_instructions(instruction_list ,registers, if rem(Map.get(registers, register), 2) == 0 do new_position(pos, offset) else pos + 1 end) 
      {"jio", register,offset} -> execute_instructions(instruction_list ,registers, if Map.get(registers, register) == 1 do new_position(pos, offset) else pos + 1 end) 
    end
  end

  def new_position(pos,offset) do
    <<operator :: binary-size(1)>> <> num = offset
    case operator do
      "+" -> pos + String.to_integer(num)
      "-" -> pos - String.to_integer(num)
      _ -> :error
    end
  end
end
