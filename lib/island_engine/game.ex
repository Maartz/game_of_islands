defmodule IslandEngine.Game do
  use GenServer

  def handle_info(:first, state) do
    IO.puts "This message has been handled by handle_info/2, matching on :first"
    {:noreply, state}
  end

  # Server API
  def handle_call(:demo_call, _from, state) do
    {:reply, state, state}
  end

  # Server API
  def handle_cast({:demo_cast, new_value}, state) do
    {:noreply, Map.put(state, :test, new_value)}
  end

  ###############

  @doc """
    Starts a new genserver for Game module
  """
  def start_link(name) when is_binary(name) do
    GenServer.start_link(__MODULE__, name, [])
  end

  # Client API
  def demo_call(game) do
    GenServer.call(game, :demo_call)
  end

  # Client API
  def demo_cast(pid, new_value) do
    GenServer.cast(:demo_cast, new_value)
  end

end
