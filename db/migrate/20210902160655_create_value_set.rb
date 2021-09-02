class CreateValueSet < ActiveRecord::Migration[6.1]
  def change
    create_table :value_sets do |t|
      t.string :value_set_id
      t.date :value_set_date
      t.string :code
      t.string :display
      t.string :lang
      t.boolean :active
      t.string :version
      t.string :system

      t.timestamps
    end
  end
end
