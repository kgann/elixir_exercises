defmodule Functions9 do
  @supported_ops %W{+ - * /}

  def calculate(chars) do
    to_string(chars) |> String.split(" ", trim: true) |> _calculate
  end

  # Private
  defp _calculate([str]), do: binary_to_integer(str)
  defp _calculate([a, op, b | tail]) when op in @supported_ops do
    [do_op(op, [a, b]) |> to_string | tail] |> _calculate
  end

  defp do_op(op, args) do
    apply(Kernel, binary_to_atom(op), Enum.map(args, &binary_to_integer/1))
  end
end
