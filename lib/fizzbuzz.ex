defmodule FizzBuzz do
  def start() do
    1..100
    |> Enum.map(fn(n)-> fizzbuzz(n) end)
    |> Enum.each(fn(a)-> IO.puts(a) end)
  end

  def fizzbuzz(num) do
    case {rem(num, 3), rem(num, 5)} do
      {0, 0} -> "FizzBuzz"
      {0, _} -> "Fizz"
      {_, 0} -> "Buzz"
      {_, _} -> num
    end
  end
end
