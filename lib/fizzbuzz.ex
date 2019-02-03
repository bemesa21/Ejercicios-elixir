defmodule FizzBuzz do
	def start() do
		1 .. 100 
		|> Enum.map(fn(n)->validate(n) end)
		|> Enum.each(fn(a)-> IO.puts(a) end)
	end
 
	def validate(num) do 
		cond do
			rem(num,3) == 0 && rem(num,5) == 0 -> "FizzBuzz" 
			rem(num,3) == 0 -> "Fizz"
			rem(num,5) == 0 -> "Buzz"
			true -> num
		end
	end
end
