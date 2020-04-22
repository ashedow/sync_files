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
./app --src <src@host:/dir> --dest <dest@host:/dir>
```

## TODO:

* [ ] Decentralized (P2P)
* [ ] Neighborhood discovery (local network)
* [ ] Sync even behind different NATs
* [ ] Several host, several destination
