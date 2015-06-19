defmodule Melnitz do
  use Application.Behaviour

  def start(_type, _args) do
    ## assumes that ecto has been started
    Melnitz.Supervisor.start_link
  end
  
  def start do
    Ecto.Pool.start_link
    Melnitz.Supervisor.start_link
  end
end
