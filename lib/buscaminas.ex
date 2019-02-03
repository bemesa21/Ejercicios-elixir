defmodule Buscaminas do
  def obtiene() do
    {response, contents} = File.read("lib/minas.txt")
    case response do
      :ok -> transform(contents) |> busca() |> imprime()
      _->IO.puts(response)
    end
  end

  def transform(text) do 
    trimed_text = text |> String.split("\n", trim: true)
    [dimensions|lines] = trimed_text 
    [_dim1,dim2] = dimensions |> String.split() |> Enum.map(fn(a)->String.to_integer(a) end)
    array = Enum.map(lines, fn(l) -> String.graphemes(l) end) |> List.flatten
    result = {_dim1,dim2,array}
  end

  def busca({dim1,dim2,array}) do
    mtx2 =  List.duplicate(0, length(array))
    minas = Enum.with_index(array) 
            |> Enum.map(fn {e, idx} -> if e == "*" do idx end end) 
            |> Enum.filter(fn a -> a != nil end)
    solution = for n <- Enum.map(minas,fn(a) -> llena(mtx2,a,dim1) end) 
               |> Enum.zip, do: Tuple.to_list(n) 
               |> Enum.sum
    Enum.chunk_every(solution,dim1) 
  end

  def llena(array,position,ancho) do
    my_positions = cond do
      rem(position + 1,ancho) == 1 ->
      [position - ancho, position - (ancho - 1),position + 1,position + ancho ,position + ancho + 1]
      rem(position + 1,ancho) == 0 ->
      [position - (ancho + 1),position - ancho,position - 1,position + (ancho - 1) ,position + ancho]
      true ->  [position - ancho + 1,position - ancho, position - ancho - 1, position - 1, position + 1, position + ancho - 1 ,position + ancho ,position + ancho + 1]
    end
    my_positions = Enum.filter(my_positions,fn a -> a > 0 end)
    for n <- Enum.map(my_positions, fn(a) -> if a != "*" do List.update_at(array,a,&(&1 + 1)) end end) 
              |> Enum.zip , do: Tuple.to_list(n) 
              |> Enum.sum
  end

  def imprime(results) do 
     {:ok, file} = File.open "lib/result.txt", [:write]
     Enum.each(results,fn(a)->aux(a,file)end)  
  end

  def aux(line,file) do
    Enum.each(line,fn(l)->IO.write(file,l) end)
    IO.write(file,"\n")
  end
end