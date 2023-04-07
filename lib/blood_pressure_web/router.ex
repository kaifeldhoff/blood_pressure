defmodule BloodPressureWeb.Router do
  use BloodPressureWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {BloodPressureWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BloodPressureWeb do
    pipe_through :browser

    live "/", PressureLive.Index, :index
    live "/pressures", PressureLive.Index, :index
    live "/pressures/new", PressureLive.Index, :new
    live "/pressures/:id", PressureLive.Show, :show
    live "/pressures/:id/show/edit", PressureLive.Show, :edit
    live "/pressures/:id/edit", PressureLive.Index, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", BloodPressureWeb do
  #   pipe_through :api
  # end
end
