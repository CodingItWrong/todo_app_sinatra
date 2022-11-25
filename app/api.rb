# frozen_string_literal: true

require 'sinatra/base'
require 'json'
require_relative 'todo_repo'

module TodoApp
  class API < Sinatra::Base
    def initialize(repo: TodoRepo.new)
      @repo = repo
      super()
    end

    get '/todos' do
      todos = @repo.all
      JSON.generate(todos)
    end

    private

    attr_reader :repo
  end
end
