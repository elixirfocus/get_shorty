defmodule GetShorty.Factory do
  use ExMachina.Ecto, repo: GetShorty.Repo
  use GetShorty.ShortLinkFactory
end
