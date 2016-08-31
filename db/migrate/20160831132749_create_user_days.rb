class CreateUserDays < ActiveRecord::Migration
  def change
    create_table :user_days do |t|
      t.integer :user_id
      t.integer :day_id
      t.timestamp null: false
    end
  end
end
