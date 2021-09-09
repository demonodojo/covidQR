class ChangeIssuerInCertification < ActiveRecord::Migration[6.1]
  def change
    remove_column :certifications, :issuer, :string
    add_belongs_to :certifications, :issuer
  end
end
