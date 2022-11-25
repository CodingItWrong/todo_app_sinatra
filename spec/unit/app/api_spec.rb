# frozen_string_literal: true

require_relative '../../../app/api'
require 'rack/test'

module TodoApp
  RecordResult = Struct.new(:success?, :expense_id, :error_message)

  RSpec.describe API do
    include Rack::Test::Methods

    def app
      API.new(repo:)
    end

    let(:repo) { instance_double('TodoApp::TodoRepo') }

    describe 'GET /todos' do
      todos = [
        { 'id' => 1 },
        { 'id' => 2 }
      ]

      before do
        allow(repo).to receive(:all)
          .and_return(todos)
      end

      it 'returns the todos as JSON' do
        get '/todos'

        parsed = JSON.parse(last_response.body)
        expect(parsed).to include(
          a_hash_including('id' => 1),
          a_hash_including('id' => 2)
        )
      end

      it 'responds with a 200 (OK)' do
        get '/todos'
        expect(last_response.status).to eq(200)
      end
    end
  end
end
