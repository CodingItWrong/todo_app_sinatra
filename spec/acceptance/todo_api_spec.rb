# frozen_string_literal: true

require 'rack/test'
require 'json'
require_relative '../../app/api'
# require_relative '../../app/todo'

def app
  TodoApp::API.new
end

module TodoApp
  RSpec.describe 'Todo API', :db do
    include Rack::Test::Methods

    it 'returns todos' do
      DB[:todos].insert(
        name: 'Buy coffee',
        completed_at: nil
      )
      DB[:todos].insert(
        name: 'Go to the zoo',
        completed_at: '2017-06-10'
      )

      get '/todos'
      expect(last_response.status).to eq(200)

      expenses = JSON.parse(last_response.body)
      expect(expenses).to contain_exactly(
        a_hash_including('name' => 'Buy coffee'),
        a_hash_including('name' => 'Go to the zoo')
      )
    end
  end
end
