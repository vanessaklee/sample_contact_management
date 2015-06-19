defmodule Project.Supervisor do
  use Supervisor.Behaviour

  alias Project.RedisWorkers, as: RW

  def start_link do
    :supervisor.start_link { :local, __MODULE__ }, __MODULE__, []
  end

  def init(_) do
    tree = [ worker(Project.EventManager, []),
             supervisor(Project.Index.Supervisor, []),
             worker(RW.Update, []),
             worker(RW.Legacy, []),
             worker(RW.Delete, []) ]
             
    supervise(tree, strategy: :one_for_one)
  end
end
