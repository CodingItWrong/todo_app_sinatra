# frozen_string_literal: true

require "sequel"

config_by_env = {
  "development" => {
    adapter: "postgres",
    host: "localhost",
    user: "josh",
    password: nil,
    database: "todo_app_sinatra_development"
  },
  "test" => {
    adapter: "postgres",
    host: "localhost",
    user: "josh",
    password: nil,
    database: "todo_app_sinatra_test"
  },
  "ci" => {
    adapter: "postgres",
    host: "localhost",
    user: "postgres",
    password: nil,
    database: "circle_test"
  }
}

config = ENV.fetch("DATABASE_URL") { config_by_env.fetch(ENV.fetch("RACK_ENV", "development")) }

DB = Sequel.connect(config)
