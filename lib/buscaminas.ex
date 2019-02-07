defmodule Buscaminas do
  def obtiene() do
    {response, contents} = File.read("lib/minas.txt")
    case response do
      :ok -> transform(contents) |> busca() |> imprime()
      _->IO.puts(response)
    end
  end

  def transform(text) do
    [dimensions | lines] = text |> String.split("\n", trim: true)
    [rows, cols] = dimensions |> String.split() |> Enum.map(fn(a) -> String.to_integer(a) end)
    {rows, cols, lines}
  end

  def busca({dim1, dim2, lines}) do
    array =
      lines
      |> Enum.map(fn(l) -> String.graphemes(l) end)
      |> List.flatten

    mtx2 =  List.duplicate(0, length(array))

    minas =
      array
      |> Enum.with_index()
      |> Enum.filter(fn {e, _idx} -> e == "*" end)
      |> Enum.map(fn {_e, idx} -> idx end)

    solution =
      for n <- Enum.map(minas, fn(a) -> llena(mtx2, a, dim2) end) |> Enum.zip , do: Tuple.to_list(n)
      |> List.foldl(0, fn (x),  acc -> if is_integer(x) and is_integer(acc) do x + acc else "*" end end)

    solution
    |> Enum.map(fn s -> if is_integer(s) do to_string(s) else s end end)
    |> Enum.chunk_every(dim2)
    |> Enum.map(fn a -> List.to_string(a) end)
  end

  def llena(array,position,ancho) do
    array = List.replace_at(array,position,"*") #poniendo mina en posición
    
    my_positions =
      case rem(position + 1 , ancho) do
        0 -> [position - (ancho + 1),position - ancho,position - 1,position + (ancho - 1) ,position + ancho] #extremo derecho
        1 -> [position - ancho, position - (ancho - 1),position + 1,position + ancho ,position + ancho + 1] #extremo izquierdo
        _ -> [position - ancho + 1,position - ancho, position - ancho - 1, position - 1, position + 1, position + ancho - 1 ,position + ancho ,position + ancho + 1]
      end

    my_positions = Enum.filter(my_positions,fn a -> a > 0 end) #filtrando negativos.
    
    for n <- Enum.map(my_positions, fn(a) -> if a != "*" do List.update_at(array,a,&(&1 + 1)) end end)
      |> Enum.zip , do: Tuple.to_list(n)
      |> List.foldl(0, fn (x),  acc -> if is_integer(x) do x + acc else "*" end end)
  end

  def imprime(results) do
    {response, file} = File.open "lib/result.txt", [:write]
    case response do
      :ok -> Enum.each(results,fn(a)-> IO.write(file,a<>"\n")end)
      _->IO.puts(response)
    end
  end
end
