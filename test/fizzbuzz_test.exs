defmodule FizzBuzzTest do
  use ExUnit.Case
  doctest FizzBuzz

  [3, 6, 9, 12, 18, 21, 33, 36, 99]
  |> Enum.each(fn n ->
    @n n
    test "three multiples: #{@n}" do
      assert FizzBuzz.validate(@n) == "Fizz"
    end
  end)

  [5, 10, 20, 25, 35, 40, 50, 55, 65, 80, 95]
  |> Enum.each(fn n ->
    @n n
    test "five multiples: #{@n}" do
      assert FizzBuzz.validate(@n) == "Buzz"
    end
  end)


  [15, 30, 45, 60, 75, 90]
  |> Enum.each(fn n ->
    @n n
    test "both: #{@n}" do
      assert FizzBuzz.validate(@n) == "FizzBuzz"
    end
  end)

  [1, 2, 4, 7, 8, 11, 13, 14, 16, 17, 19, 22]
  |> Enum.each(fn n ->
    @n n
    test "number #{@n}" do
      assert is_integer(FizzBuzz.validate(@n))
    end
  end)
end
