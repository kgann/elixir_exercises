defmodule Functions1 do
  def list_concat(x, y), do: x ++ y

  def sum(a, b, c), do: a + b + c

  def pair_tuple_to_list({x, y}), do: [x, y]
end

defmodule Functions2 do
  def fizz(0, 0, _), do: 'FizzBuzz'
  def fizz(0, _, _), do: 'Fizz'
  def fizz(_, 0, _), do: 'Buzz'
  def fizz(_, _, a), do: a

  def fizz_buzz(n) do
    fizz(rem(n, 3), rem(n, 5), n)
  end

  def go do
    1..16
    |> Enum.map(&fizz_buzz/1)
    |> Enum.join(", ")
    |> IO.puts
  end
end

defmodule Functions4 do
  def prefix(a) do
    fn (b) -> "#{a} #{b}" end
  end
end

#   Use the &... notation to rewrite the following.
# – Enum.map [1,2,3,4], fn x -> x + 2 end
# – Enum.each [1,2,3,4], fn x -> IO.inspect x end
Enum.map [1,2,3,4], &(&1 + 2)
Enum.each [1,2,3,4], &IO.inspect/1
