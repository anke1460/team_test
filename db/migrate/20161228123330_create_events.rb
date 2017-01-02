class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.references :sender, polymorphic: true
      t.references :owner, polymorphic: true
      t.string :key
      t.text :parameters
      t.references :receiver, polymorphic: true

      t.timestamps
    end
  end
end
