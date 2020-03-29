defmodule IslandEngine.Guesses do
  @moduledoc """
    Provides API for create a Guess, add a guess to hit or miss MapSet
  """

  alias __MODULE__

  alias IslandEngine.Coordinate

  @enforce_keys [:hits, :misses]
  defstruct [:hits, :misses]

  def new, do: %Guesses{hits: MapSet.new(), misses: MapSet.new()}

  def add(%Guesses{} = guesses, :hit, %Coordinate{} = coordinate) do
    update_in(guesses.hits, &MapSet.put(&1, coordinate))
  end

  def add(%Guesses{} = guesses, :miss, %Coordinate{} = coordinate) do
    update_in(guesses.misses, &MapSet.put(&1, coordinate))
  end
end
