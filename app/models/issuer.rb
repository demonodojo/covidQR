# == Schema Information
#
# Table name: issuers
#
#  id          :bigint           not null, primary key
#  name        :string
#  private_key :text
#  public_key  :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Issuer < ApplicationRecord
end
