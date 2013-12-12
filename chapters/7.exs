defmodule Functions7 do
  def sum(list), do: _sum(list)
  def max(list), do: _max(list, nil)
  def mapsum(list, fun), do: map_then(list, fun, &sum/1)
  def map_then(list, map_fun, then_fun), do: _map_then([], list, map_fun, then_fun)
  def caesar(list, n), do: map_then(list, &(&1 + n), &_wrap([], &1))
  def span(from, to), do: _span(from, to)
  def all?(list, fun // &(&1)), do: _all?(list, fun)
  def each(list, fun), do: _each(list, fun)
  def filter(list, fun), do: _filter([], list, fun)

  # Private
  defp _sum([]), do: 0
  defp _sum([head | []]), do: head
  defp _sum([head, second | tail]), do: head + second + sum(tail)

  # map_then
  #  - map over a list with map_fn
  #  - apply then_fun to the new list (mapped)
  defp _map_then(mapped, [], _map_fun, then_fun), do: then_fun.(mapped)
  defp _map_then(mapped, [head | tail], map_fun, then_fun) do
    mapped ++ [map_fun.(head)] |> _map_then(tail, map_fun, then_fun)
  end

  defp _max([], maximuum), do: maximuum
  defp _max([head | tail], maximum) when maximum in [head, nil], do: _max(tail, head)
  defp _max([head | tail], maximum) when maximum > head, do: _max(tail, maximum)
  defp _max([head | tail], maximum) when maximum < head, do: _max(tail, head)

  @chars 26
  defp _wrap([], []), do: ""
  defp _wrap(out, []), do: out
  defp _wrap(out, [head | tail]), do: out ++ [?a + rem(head - ?a, @chars)] |> _wrap(tail)

  defp _span(from, from), do: [from]
  defp _span(from, to), do: [from | _span(from + 1, to)]

  defp _all?([], _fun), do: true
  defp _all?([head | tail], fun), do: !!fun.(head) && _all?(tail, fun)

  defp _each([], _fun), do: :ok
  defp _each([head | tail], fun) do fun.(head); _each(tail, fun) end

  defp _filter(filtered, [], _fun), do: filtered
  defp _filter(filtered, [head | tail], fun) do
    if fun.(head) do
      filtered ++ [head] |> _filter(tail, fun)
    else
      filtered |> _filter(tail, fun)
    end
  end
end
