defmodule FizzBuzzTest do
  use ExUnit.Case
  doctest FizzBuzz

  [3, 6, 9, 12, 18]
  |> Enum.each(fn n ->
    @n n
    test "three multiples: #{@n}" do
      assert FizzBuzz.validate(@n) == "Fizz"
    end
  end)

  test "five multiples" do
    assert FizzBuzz.validate(5) == "Buzz"
  end

  test "both multiples" do
    assert FizzBuzz.validate(30) == "FizzBuzz"
  end

  test "one_number" do
    assert is_integer(FizzBuzz.validate(1)) 
  end
end