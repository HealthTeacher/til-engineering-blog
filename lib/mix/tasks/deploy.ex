defmodule Mix.Tasks.Deploy do
  use Mix.Task

  @shortdoc "Deploy to Heroku."
  @moduledoc """
    Deploys our environments.
  """

  def run(_) do
    System.cmd("git", ["fetch", "--tags"])
    System.cmd("git", ["tag", "-d", "production"])
    System.cmd("git", ["push", "origin", ":refs/tags/production"])
    System.cmd("git", ["tag", "production"])
    System.cmd("git", ["push", "origin", "--tags"])

    System.cmd("git", ["push", "heroku", "master"])
    System.cmd("heroku", ["run", "POOL_SIZE=2 mix ecto.migrate"])
    System.cmd("heroku", ["restart"])
  end
end
