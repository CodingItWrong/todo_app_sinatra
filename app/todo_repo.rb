# frozen_string_literal: true

require_relative "../config/sequel"

module TodoApp
  RecordResult = Struct.new(:success?, :todo_id, :error_message)

  class TodoRepo
    def all
      DB[:todos].all
    end

    def create(todo)
      DB[:todos].insert(todo)
      id = DB[:todos].max(:id)
      RecordResult.new(true, id, nil)
    end
  end
end
