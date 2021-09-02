class AddDateOfBirthToCertification < ActiveRecord::Migration[6.1]
  def change
    add_column :certifications, :date_of_birth, :date
  end
end
