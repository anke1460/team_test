class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.references :team, foreign_key: true
      t.references :user
      t.string :name

      t.timestamps
    end
  end
end
