defmodule FizzBuzzTest do
  use ExUnit.Case
  doctest FizzBuzz

  [3, 6, 9, 12, 18, 21, 33, 36, 99]
  |> Enum.each(fn n ->
    @n n
    test "multiples of three: #{@n}" do
      assert FizzBuzz.fizzbuzz(@n) == "Fizz"
    end
  end)

  [5, 10, 20, 25, 35, 40, 50, 55, 65, 80, 95]
  |> Enum.each(fn n ->
    @n n
    test "multiples of five: #{@n}" do
      assert FizzBuzz.fizzbuzz(@n) == "Buzz"
    end
  end)


  [15, 30, 45, 60, 75, 90]
  |> Enum.each(fn n ->
    @n n
    test "multiples of three and five: #{@n}" do
      assert FizzBuzz.fizzbuzz(@n) == "FizzBuzz"
    end
  end)

  [1, 2, 4, 7, 8, 11, 13, 14, 16, 17, 19, 22]
  |> Enum.each(fn n ->
    @n n
    test "number #{@n}" do
      assert is_integer(FizzBuzz.fizzbuzz(@n))
    end
  end)
end
