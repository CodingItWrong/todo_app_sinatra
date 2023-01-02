# frozen_string_literal: true

require "rack/test"
require "json"
require "debug"
require_relative "../../app/api"

def app
  TodoApp::API.new
end

module TodoApp
  RSpec.describe "Todo API", :db do
    include Rack::Test::Methods

    it "returns todos" do
      DB[:todos].insert(
        name: "Buy coffee",
        completed_at: nil
      )
      DB[:todos].insert(
        name: "Go to the zoo",
        completed_at: "2017-06-10"
      )

      get "/todos"
      expect(last_response.status).to eq(200)
      expect(last_response.headers).to include(
        "Content-Type" => "application/json"
      )

      expenses = JSON.parse(last_response.body)
      expect(expenses).to contain_exactly(
        a_hash_including("name" => "Buy coffee"),
        a_hash_including("name" => "Go to the zoo")
      )
    end

    it "allows creating todos" do
      todo = {"name" => "Buy coffee"}
      post "/todos", JSON.generate(todo)

      expect(last_response.status).to eq(200)
      expect(last_response.headers).to include(
        "Content-Type" => "application/json"
      )

      parsed = JSON.parse(last_response.body)
      expect(parsed).to include("id" => a_kind_of(Integer))
      id = parsed["id"]

      get "/todos"
      expect(last_response.status).to eq(200)

      expenses = JSON.parse(last_response.body)
      expect(expenses).to contain_exactly(
        a_hash_including("id" => id, "name" => "Buy coffee")
      )
    end
  end
end
