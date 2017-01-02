class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string :name
      t.date :finish_at
      t.references :creator
      t.references :project
      t.references :user
      t.boolean :state, default: false
      t.boolean :is_delete, default: false

      t.timestamps
    end
  end
end
