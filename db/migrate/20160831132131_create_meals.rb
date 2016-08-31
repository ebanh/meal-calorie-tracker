class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :name
      t.integer :calories
      t.integer :user_id
      t.timestamp null: false
    end
  end
end
