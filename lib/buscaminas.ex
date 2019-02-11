defmodule Buscaminas do
  @bomb "*"

  def obtiene() do
    case File.read("lib/minas.txt") do
      {:ok, contents} -> transform(contents) |> busca() |> imprime()
      {:error, reason} -> IO.puts(reason)
    end
  end

  def transform(text) do
    [dimensions | lines] = text |> String.split("\n", trim: true)
    [rows, cols] = dimensions |> String.split() |> Enum.map(fn(a) -> String.to_integer(a) end)
    {rows, cols, lines}
  end

  def busca({_dim1, dim2, lines}) do
    array = to_onedim_array(lines)

    mines = mines_indexes(array)

    a_length = length(array)
    solution =
      for n <- Enum.map(mines, fn(a) -> llena(a_length, a, dim2) end) |> Enum.zip , do: Tuple.to_list(n)
      |> List.foldl(0, fn x, acc -> sum(x, acc) end)

    to_matrix(solution, dim2)
  end

  def to_onedim_array(lines) do
    lines
    |> Enum.map(fn(l) -> String.graphemes(l) end)
    |> List.flatten
  end

  def mines_indexes(array) do
    array
    |> Enum.with_index()
    |> Enum.filter(fn {e, _idx} -> e == @bomb end)
    |> Enum.map(fn {_e, idx} -> idx end)
  end

  def to_matrix(array, cols) do
    array
    |> Enum.map(fn s -> if is_integer(s) do to_string(s) else s end end)
    |> Enum.chunk_every(cols)
    |> Enum.map(fn a -> List.to_string(a) end)
  end

  defp sum(x, y) when is_integer(x) and is_integer(y), do: x + y
  defp sum(_, _), do: @bomb

  def llena(array_length, position, ancho) do
    array =
      0
      |> List.duplicate(array_length)
      |> List.replace_at(position, @bomb) #poniendo mina en posición

    my_positions =
      case rem(position + 1, ancho) do
        0 ->
          [
            position - (ancho + 1),
            position - ancho,
            position - 1,
            position + (ancho - 1),
            position + ancho
          ] #extremo derecho
        1 ->
          [
            position - ancho,
            position - (ancho - 1),
            position + 1, position + ancho,
            position + ancho + 1
          ] #extremo izquierdo
        _ ->
          [
            position - ancho + 1,
            position - ancho,
            position - ancho - 1,
            position - 1,
            position + 1,
            position + ancho - 1,
            position + ancho,
            position + ancho + 1
          ]
      end

    my_positions = Enum.filter(my_positions, fn a -> a > 0 end) #filtrando negativos.

    for n <- Enum.map(my_positions, fn(a) ->
      List.update_at(array, a, &(&1 + 1))
    end) |> Enum.zip, do: Tuple.to_list(n)
    |> List.foldl(0, fn (x),  acc -> if is_integer(x) do x + acc else @bomb end end)
  end

  def imprime(results) do
    case File.open "lib/result.txt", [:write] do
      {:ok, file} -> Enum.each(results,fn(a)-> IO.write(file, a <> "\n") end)
      {:error, reason} -> IO.puts(reason)
    end
  end
end
