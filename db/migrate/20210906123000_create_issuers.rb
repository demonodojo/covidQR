class CreateIssuers < ActiveRecord::Migration[6.1]
  def change
    create_table :issuers do |t|
      t.string :name
      t.text :private_key
      t.text :public_key

      t.timestamps
    end
  end
end
