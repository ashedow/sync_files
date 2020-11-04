# Naive sync files client written in elixir

Learn Elixir by writen simplified [SyncThing](syncthing.net)

## Usage

Install Dependency

```bash
mix deps.get
```

Comile dependency
```bash
mix compile && mix escript.build
```

Run tests:
```bash
mix test
```

Run app, for exampel, like
```bash
./app --src <src@host:port:/dir> --dest <dest@host:port:/dir>
```
or
```bash
export SRC=<src@host:port:/dir> DEST=<dest@host:port:/dir>
./app
```
use `dest@host::/dir` for default 22 port

Or
```bash
iex -S mix
```
or
```bash
mix run --no-halt
```

## TODO:

* [ ] Custom path to ssh_keys
* [ ] Decentralized (P2P)
* [ ] Neighborhood discovery (local network)
* [ ] Sync even behind different NATs
* [ ] Several host, several destination
