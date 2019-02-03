defmodule EjerciciosTest do
  use ExUnit.Case
  doctest Ejercicios

  test "greets the world" do
    assert Ejercicios.hello() == :world
  end
end
