class CreateCertifications < ActiveRecord::Migration[6.1]
  def change
    create_table :certifications do |t|
      t.string :name
      t.string :surname
      t.string :category
      t.binary :qr_code

      t.timestamps
    end
  end
end
