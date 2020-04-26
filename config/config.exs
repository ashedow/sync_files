# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# By default, the umbrella project as well as each child
# application will require this configuration file, as
# configuration and dependencies are shared in an umbrella
# project. While one could configure all applications here,
# we prefer to keep the configuration of each individual
# child application in their own app, but all other
# dependencies, regardless if they belong to one or multiple
# apps, should be configured in the umbrella to avoid confusion.
import_config "../apps/*/config/config.exs"

## Example of project config
# config :mymodule,
#   api_url: "http://api.seave.co"
#   namespace: "hello"
## Example of usage
# defmodule Client do
#   def log
#     IO.puts Application.get_env(:mymodule, :key)
#   end
# end

## Example of third party dependency
# config :logger,
  # verbose: true

# App params
ssh_keys_path = "~/.ssh/" # ssh dir path
ssh_secret_key = "#{:ssh_keys_path}id_rsa" # ssh secret key
ssh_pub_key = "#{:ssh_keys_path}id_rsa.pub" # ssh pub key

config :app, App.Monitor,
  host: [default_port: 22], # default ssh port
  interval: 10_000 # Worker interval

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Config env vars
config :app,
  src: {:system, "SRC"},
  dest: {:system, "DEST"}

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
