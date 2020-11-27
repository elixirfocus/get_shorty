defmodule GetShorty.ShortLinkFactory do
  defmacro __using__(_opts) do
    quote do
      def short_link_factory do
        %GetShorty.ShortLinks.ShortLink{
          long_link: "https://phoenixframework.org/",
          token: sequence(:email, &"token#{&1}")
        }
      end
    end
  end
end
