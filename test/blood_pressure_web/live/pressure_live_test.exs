defmodule BloodPressureWeb.PressureLiveTest do
  use BloodPressureWeb.ConnCase

  import Phoenix.LiveViewTest
  import BloodPressure.MetricsFixtures

  @create_attrs %{high: 42, low: 42, timestamp: "2023-04-06T13:06:00"}
  @update_attrs %{high: 43, low: 43, timestamp: "2023-04-07T13:06:00"}
  @invalid_attrs %{high: nil, low: nil, timestamp: nil}

  defp create_pressure(_) do
    pressure = pressure_fixture()
    %{pressure: pressure}
  end

  describe "Index" do
    setup [:create_pressure]

    test "lists all pressures", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/pressures")

      assert html =~ "Listing Pressures"
    end

    test "saves new pressure", %{conn: conn} do
      {:ok, index_live, _html} = live(conn, ~p"/pressures")

      assert index_live |> element("a", "New Pressure") |> render_click() =~
               "New Pressure"

      assert_patch(index_live, ~p"/pressures/new")

      assert index_live
             |> form("#pressure-form", pressure: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#pressure-form", pressure: @create_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/pressures")

      html = render(index_live)
      assert html =~ "Pressure created successfully"
    end

    test "updates pressure in listing", %{conn: conn, pressure: pressure} do
      {:ok, index_live, _html} = live(conn, ~p"/pressures")

      assert index_live |> element("#pressures-#{pressure.id} a", "Edit") |> render_click() =~
               "Edit Pressure"

      assert_patch(index_live, ~p"/pressures/#{pressure}/edit")

      assert index_live
             |> form("#pressure-form", pressure: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert index_live
             |> form("#pressure-form", pressure: @update_attrs)
             |> render_submit()

      assert_patch(index_live, ~p"/pressures")

      html = render(index_live)
      assert html =~ "Pressure updated successfully"
    end

    test "deletes pressure in listing", %{conn: conn, pressure: pressure} do
      {:ok, index_live, _html} = live(conn, ~p"/pressures")

      assert index_live |> element("#pressures-#{pressure.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#pressures-#{pressure.id}")
    end
  end

  describe "Show" do
    setup [:create_pressure]

    test "displays pressure", %{conn: conn, pressure: pressure} do
      {:ok, _show_live, html} = live(conn, ~p"/pressures/#{pressure}")

      assert html =~ "Show Pressure"
    end

    test "updates pressure within modal", %{conn: conn, pressure: pressure} do
      {:ok, show_live, _html} = live(conn, ~p"/pressures/#{pressure}")

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Pressure"

      assert_patch(show_live, ~p"/pressures/#{pressure}/show/edit")

      assert show_live
             |> form("#pressure-form", pressure: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      assert show_live
             |> form("#pressure-form", pressure: @update_attrs)
             |> render_submit()

      assert_patch(show_live, ~p"/pressures/#{pressure}")

      html = render(show_live)
      assert html =~ "Pressure updated successfully"
    end
  end
end
