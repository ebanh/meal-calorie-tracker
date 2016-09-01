class CreateMealDays < ActiveRecord::Migration
  def change
    create_table :meal_days do |t|
      t.integer :meal_id
      t.integer :day_id
      t.timestamp null: false
    end
  end
end
