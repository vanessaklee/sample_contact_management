defmodule Project do
  use Application.Behaviour

  def start(_type, _args) do
    ## assumes that ecto has been started
    Project.Supervisor.start_link
  end
  
  def start do
    Ecto.Pool.start_link
    Project.Supervisor.start_link
  end
end
