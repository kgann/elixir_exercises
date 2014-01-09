defmodule Stack.Server do
  use GenServer.Behaviour

  def start_link(initial_state // []) do
    :gen_server.start_link({ :local, :stack }, __MODULE__, initial_state, [])
  end

  def push(ele) do
    :gen_server.cast(:stack, { :push, ele })
  end

  def pop do
    :gen_server.call(:stack, :pop)
  end

  def inspect do
    :gen_server.call(:stack, :inspect)
  end

  def shutdown(reason) do
    :gen_server.call(:stack, { :terminate, reason })
  end

  def init(current_stack) when is_list(current_stack) do
    { :ok, current_stack }
  end

  # pop
  def handle_call(:pop, _from, [head | tail]) do
    { :reply, head, tail }
  end

  def handle_call(:pop, _from, []) do
    { :reply, nil, [] }
  end

  # push
  def handle_cast({ :push, ele }, current_stack) do
    { :noreply, [ele | current_stack] }
  end

  # inspect
  def handle_call(:inspect, _from, current_stack) do
    { :reply, current_stack, current_stack }
  end

  # terminate
  def handle_call({ :terminate, reason }, _from, current_stack) do
    { :stop, reason, current_stack }
  end

  def terminate(reason, _state) do
    IO.puts(reason)
  end
end
