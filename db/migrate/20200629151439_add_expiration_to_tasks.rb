class AddExpirationToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :expiration, :date
  end
end
