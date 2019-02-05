defmodule BuscaminasTest do
  use ExUnit.Case
  doctest Buscaminas

  test "Caso ejemplo" do
    assert Buscaminas.busca({4, 4, ["*",".",".",".",".",".",".",".",".","*",".",".",".",".",".","."]}) ==
    [["*", 1, 0, 0], [2, 2, 1, 0], [1, "*", 1, 0], [1, 1, 1, 0]]
  end

  test "Probando esquinas y valores intermedios" do
    assert Buscaminas.busca({5, 4, ["*",".",".",".","*",".",".","*",".",".",".",".",".",".",".",".",".",".","*","."]}) ==
    [["*", 2, 1, 2, "*"], [1, 2, "*", 2, 1], [0, 1, 2, 2, 1], [0, 0, 1, "*", 1]]
  end

  test "Probando extremos" do
    assert Buscaminas.busca({4, 4, ["*",".",".",".","*",".",".",".","*",".",".","*",".",".",".","*"]}) ==
    [["*", 2, 0, 0], ["*", 3 ,1 , 1], ["*" ,2 ,2 ,"*" ], [1, 1, 2, "*"]]
  end

  #test "Probando archivo" do
   # assert Buscaminas.obtiene('lib/minas.txt') ==
    #[["*", 2, 0, 0], ["*", 3 ,1 , 1], ["*" ,2 ,2 ,"*" ], [1, 1, 2, "*"]]
  #end
end
