class AddTypeToIssuer < ActiveRecord::Migration[6.1]
  def change
    add_column :issuers, :type, :string
  end
end
