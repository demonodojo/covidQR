class AddVaccineDataToCertification < ActiveRecord::Migration[6.1]
  def change
    add_column :certifications, :disease_target, :string
    add_column :certifications, :vaccine_or_prophylaxis, :string
    add_column :certifications, :medicinal_product, :string
    add_column :certifications, :marketing_authorization_holder, :string
    add_column :certifications, :dose_number, :integer
    add_column :certifications, :series_of_doses, :integer
    add_column :certifications, :vaccination_date, :date
    add_column :certifications, :vaccination_country, :string
    add_column :certifications, :issuer, :string
    add_column :certifications, :uvci, :string
  end
end
