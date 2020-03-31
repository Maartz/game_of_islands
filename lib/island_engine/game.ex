defmodule IslandEngine.Game do
  use GenServer

  alias IslandEngine.{Board, Guesses, Rules}

  def init(name) do
    player1 = %{name: name, board: Board.new(), guesses: Guesses.new()}
    player2 = %{name: nil, board: Board.new(), guesses: Guesses.new()}
    {:ok, %{player1: player1, player2: player2, rules: %Rules{}}}
  end

  def handle_info(:first, state) do
    IO.puts("This message has been handled by handle_info/2, matching on :first")
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

  def handle_call({:add_player, name}, _from, state_data) do
    with {:ok, rules} <- Rules.check state_data.rules, :add_player
    do
      state_data
      |> update_player2_name(name)
      |> update_rules(rules)
      |> reply_success(:ok)
    else
      :error -> {:repyl, :error, state_data}
    end
  end

  ###############

  @doc """
  Starts a new genserver for Game module
  """
  def start_link(name) when is_binary(name) do
    GenServer.start_link(__MODULE__, name, [])
  end

  def add_player(game, name) when is_binary(name) do
    GenServer.call(game, {:add_player, name})
  end

  # Client API
  def demo_call(game) do
    GenServer.call(game, :demo_call)
  end

  # Client API
  def demo_cast(pid, new_value) do
    GenServer.cast(:demo_cast, new_value)
  end

  #### Private

  defp update_player2_name(state, name) do
    put_in(state.player2.name, name)
  end

  defp update_rules(state, rules) do
    %{state | rules: rules}
  end

  defp reply_success(state, reply) do
    {:reply, reply, state}
  end
end
