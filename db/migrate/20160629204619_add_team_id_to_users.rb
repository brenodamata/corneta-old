class AddTeamIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :team, index: true
  end
end
