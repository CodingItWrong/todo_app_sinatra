# frozen_string_literal: true

require_relative '../../../app/todo_repo'

module TodoApp
  RSpec.describe TodoRepo, :aggregate_failures, :db do
    subject(:repo) { TodoRepo.new }

    describe '#all' do
      it 'returns all todos' do
        DB[:todos].insert(
          name: 'Buy coffee',
          completed_at: nil
        )
        DB[:todos].insert(
          name: 'Go to the zoo',
          completed_at: '2017-06-10'
        )

        expect(repo.all).to contain_exactly(
          a_hash_including(name: 'Buy coffee'),
          a_hash_including(name: 'Go to the zoo')
        )
      end
    end
  end
end
