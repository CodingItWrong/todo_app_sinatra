# todo_app_sinatra

A REST backend for a todo app, implemented in Sinatra.rb

## Requirements

1. Ruby 3.1.2
1. PostgreSQL (e.g. [Postgres.app][postgres-app])

## Installation

Change Db connection config in `config/sequel.rb` if necessary.

```sh
$ bin/setup
```

## Running

```bash
$ bin/serve
```

## Testing

```sh
$ bin/rspec
```

## Releases

Runs on Heroku.

- Push or merge to `main`; it will be automatically deployed
- Run database migrations with `heroku run bin/migrate-prod`

## License

MIT
