defmodule GetShorty.Factory do
  @moduledoc """
  Defines a collection of `ExMachina` fixtures that are used in testing.
  """

  use ExMachina.Ecto, repo: GetShorty.Repo
  use GetShorty.ShortLinkFactory
end
