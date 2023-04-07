defmodule BloodPressure.Metrics do
  @moduledoc """
  The Metrics context.
  """

  import Ecto.Query, warn: false
  alias BloodPressure.Repo

  alias BloodPressure.Metrics.Pressure

  @doc """
  Returns the list of pressures.

  ## Examples

      iex> list_pressures()
      [%Pressure{}, ...]

  """
  def list_pressures do
    Repo.all(Pressure)
  end

  @doc """
  Gets a single pressure.

  Raises `Ecto.NoResultsError` if the Pressure does not exist.

  ## Examples

      iex> get_pressure!(123)
      %Pressure{}

      iex> get_pressure!(456)
      ** (Ecto.NoResultsError)

  """
  def get_pressure!(id), do: Repo.get!(Pressure, id)

  @doc """
  Creates a pressure.

  ## Examples

      iex> create_pressure(%{field: value})
      {:ok, %Pressure{}}

      iex> create_pressure(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_pressure(attrs \\ %{}) do
    %Pressure{}
    |> Pressure.changeset(attrs)
    |> Repo.insert()
  end

  def prefilled_pressure() do
    Pressure.new()
  end


  @doc """
  Updates a pressure.

  ## Examples

      iex> update_pressure(pressure, %{field: new_value})
      {:ok, %Pressure{}}

      iex> update_pressure(pressure, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_pressure(%Pressure{} = pressure, attrs) do
    pressure
    |> Pressure.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a pressure.

  ## Examples

      iex> delete_pressure(pressure)
      {:ok, %Pressure{}}

      iex> delete_pressure(pressure)
      {:error, %Ecto.Changeset{}}

  """
  def delete_pressure(%Pressure{} = pressure) do
    Repo.delete(pressure)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking pressure changes.

  ## Examples

      iex> change_pressure(pressure)
      %Ecto.Changeset{data: %Pressure{}}

  """
  def change_pressure(%Pressure{} = pressure, attrs \\ %{}) do
    Pressure.changeset(pressure, attrs)
  end
end
