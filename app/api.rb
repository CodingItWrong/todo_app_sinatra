# frozen_string_literal: true

require "sinatra/base"
require "json"
require_relative "todo_repo"

module TodoApp
  class API < Sinatra::Base
    def initialize(repo: TodoRepo.new)
      @repo = repo
      super()
    end

    get "/todos" do
      todos = @repo.all

      content_type "application/json"
      JSON.generate(todos)
    end

    post "/todos" do
      todo = JSON.parse(request.body.read)
      result = repo.create(todo)

      content_type "application/json"
      JSON.generate("id" => result.todo_id)
    end

    private

    attr_reader :repo
  end
end
