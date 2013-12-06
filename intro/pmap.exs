defmodule Parallel do
  def pmap(collection, fun) do
    me = self

    my_spawn = fn (elem) ->
      spawn_link fn -> (me <- { self, fun.(elem) }) end
    end

    my_receive = fn (pid) ->
      receive do { ^pid, result } -> result end
    end

    collection |> Enum.map(my_spawn) |> Enum.map(my_receive)
  end
end
