defmodule Project.Mixfile do
  use Mix.Project

  def project do
    [ app: :project,
      version: "0.1.7",
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ applications: [:lager, :hackney, :ecto],
      mod: { Project, [] } ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, "0.1", git: "https://github.com/elixir-lang/foobar.git" }
  defp deps do
    [ { :hackney, github: "benoitc/hackney" },
      { :exlager, github: "khia/exlager" , ref: "2a4b002dfe34abf1b03c9d26a3ebe2e101437f51"},
      { :jsonex, github: "devinus/jsonex" },
      { :eredis, github: "wooga/eredis" },
      { :ecto, github: "interline/ecto" } ]
  end
end
