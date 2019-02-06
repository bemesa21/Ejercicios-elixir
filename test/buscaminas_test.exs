defmodule BuscaminasTest do
  use ExUnit.Case
  doctest Buscaminas

  test "Caso ejemplo" do
    assert Buscaminas.busca(
      {4, 4, [
        "*...",
        "....",
        ".*..",
        "....",
      ]}) == [
        "*100",
        "2210",
        "1*10",
        "1110"
      ]
  end

  test "Probando esquinas" do
    assert Buscaminas.busca(
      {4, 5,[
        "*...*",
        ".....",
        ".....",
        "*...*"
      ]}) == [
        "*101*",
        "11011",
        "11011",
        "*101*"
      ]
  end

  test "Probando extremos" do
    assert Buscaminas.busca(
      {6, 3,[
        "...",
        "..*",
        "*..",
        "...",
        "...",
        ".*."
      ]}) ==[
        "011",
        "12*",
        "*21",
        "110",
        "111",
        "1*1"
        ]
  end
end
