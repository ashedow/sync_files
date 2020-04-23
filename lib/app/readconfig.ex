defmodule App.ReadConfig do

  def read_config({:system, environment_variable_name}) do
    System.get_env(environment_variable_name)
  end

  def read_config(value) do
    value
  end
end
