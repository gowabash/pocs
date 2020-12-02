defmodule Aoc do
  def year_check(a, b, c) do
    z = a + b + c
    val = case z do
      x when x == 2020 -> true
      x when x < 2020  -> false
      _ -> false
    end
    if val do
      IO.puts "#{a} * #{b} * #{c} = #{a * b  * c}"
    end
  end

  def test_it(array, item) do
    Enum.each(array, fn y -> test_3(array -- [item,y], item, y) end)
  end
  
  def test_3(array, a, b) do
    Enum.each(array, fn y -> year_check(a,b, y) end)
  end

  def process(body) do
    sorted_amts = body
    |> String.split
    |> Enum.map(&String.to_integer/1)
    |> Enum.sort
    largest_amts = Enum.reverse(sorted_amts)
    Enum.each(sorted_amts, fn x -> test_it(largest_amts, x) end )
  end
end


case File.read("day1.input") do
  {:ok, body}       -> Aoc.process(body)
  {:error, _reason} -> IO.puts("no")
end

