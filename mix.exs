defmodule Ethereum.Wallet.Mixfile do
  use Mix.Project

  def project do
    [
      app: :ethereum_wallet,
      version: "0.0.1",
      elixir: "~> 1.0",
      elixirc_paths: elixirc_paths(Mix.env),
      description: description(),
      package: package(),
      deps: deps()
    ]
  end

  def application do
    [applications: applications(Mix.env)]
  end

  #
  # Private
  #

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["test/support"] ++ elixirc_paths(:prod)
  defp elixirc_paths(_),     do: ["lib"]

  defp applications(_) do
    []
  end

  defp deps do
    [{:ksha3, "~> 1.0.0", git: "https://github.com/onyxrev/ksha3.git", branch: "master"}]
  end

  defp package do
    [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Dan Connor Consulting"],
      licenses: ["Apache 2.0"],
      links: %{"GitHub" => "https://github.com/onyxrev/ethereum_wallet_elixir"}
    ]
  end

  defp description do
    """
    Generate Ethereum wallets with Elixir
    """
  end
end
