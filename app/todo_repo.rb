# frozen_string_literal: true

require_relative '../config/sequel'
# require_relative 'todo'

module TodoApp
  class TodoRepo
    def all
      # Todo.all.map(&:values)
      DB[:todos].all
    end
  end
end
