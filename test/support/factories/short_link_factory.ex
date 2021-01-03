defmodule GetShorty.ShortLinkFactory do
  @moduledoc """
  Defines `ExMachina` fixtures for the `GetShorty.ShortLinks` context that are used in testing.
  """

  defmacro __using__(_opts) do
    quote do
      def short_link_factory do
        %GetShorty.ShortLinks.ShortLink{
          long_link: "https://phoenixframework.org",
          token: sequence(:token, &"token#{&1}")
        }
      end
    end
  end
end
