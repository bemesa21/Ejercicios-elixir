defmodule OpeningTheTuringLock do
 def read_instructions do
  {status, text} = File.read("lib/input.txt") 
  case status do
    :ok -> 
      text 
      |> String.split("\n", trim: true)
      |> execute_instructions(0 ,0 ,0)

    _ -> IO.puts(status)
    end
  end

  def execute_instructions(instruction_list, a, b, pos) when pos >= length(instruction_list) or pos < 0 do
    %{"a" => a ,"b" => b}
  end

  def execute_instructions(instruction_list, a, b, pos) do  
    case List.to_tuple(String.split(Enum.at(instruction_list, pos),[" ", ","],trim: true)) do
      {"hlf", register} -> 
        case register do
          "a" -> execute_instructions(instruction_list ,Integer.floor_div(a,2) ,b, pos + 1 ) 
          "b" -> execute_instructions(instruction_list ,a ,Integer.floor_div(b,2), pos + 1 ) 
          _ -> IO.puts(:error) 
        end
        
      {"tpl", register} -> 
        case register do 
          "a" -> execute_instructions(instruction_list ,a * 3 ,b, pos + 1 ) 
          "b" -> execute_instructions(instruction_list ,a ,b * 3, pos + 1 ) 
          _ -> IO.puts(:error)
        end

      {"inc", register} -> 
        case register do 
          "a" -> execute_instructions(instruction_list ,a + 1 ,b, pos + 1 ) 
          "b" -> execute_instructions(instruction_list ,a ,b + 1, pos + 1 ) 
          _ -> IO.puts(:error)
        end

      {"jmp", offset} -> 
        <<operator :: binary-size(1)>> <> num = offset
        case operator do
          "+" -> execute_instructions(instruction_list ,a ,b, pos + String.to_integer(num)) 
          "-" -> execute_instructions(instruction_list ,a ,b, pos - String.to_integer(num)) 
          _ -> :error
        end

      {"jie", register,offset} -> 
        eval_result = 
          case register do
            "a" -> rem(a, 2) == 0
            "b" -> rem(b, 2) == 0
          end 

        case eval_result do
          true -> 
            <<operator :: binary-size(1)>> <> num = offset
            case operator do
              "+" -> execute_instructions(instruction_list ,a ,b, pos + String.to_integer(num)) 
              "-" -> execute_instructions(instruction_list ,a ,b, pos - String.to_integer(num)) 
              _ -> :error
            end
          false -> execute_instructions(instruction_list ,a ,b, pos + 1) 
        end

      {"jio", register,offset} -> 
        eval_result = 
          case register do
            "a" -> a == 1
            "b" -> b == 1
          end 

        case eval_result do
          true -> 
            <<operator :: binary-size(1)>> <> num = offset
            case operator do
              "+" -> execute_instructions(instruction_list ,a ,b, pos + String.to_integer(num)) 
              "-" -> execute_instructions(instruction_list ,a ,b, pos - String.to_integer(num)) 
              _ -> :error
            end
          false -> execute_instructions(instruction_list ,a ,b, pos + 1) 
        end

      _ -> %{"a" => a ,"b" => b}   #instruction not found
    end
  end
end
