# frozen_string_literal: true

require_relative '../config/sequel'

module TodoApp
  class TodoRepo
    def all
      DB[:todos].all
    end
  end
end
