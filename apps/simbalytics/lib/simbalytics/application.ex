defmodule Simbalytics.Application do
  @moduledoc """
  The Simbalytics Application Service.

  The simbalytics system business domain lives in this application.

  Exposes API to clients such as the `Simbalytics.Web` application
  for use in channels, controllers, and elsewhere.
  """
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    Supervisor.start_link([
      supervisor(Simbalytics.Repo, []),
    ], strategy: :one_for_one, name: Simbalytics.Supervisor)
  end
end
