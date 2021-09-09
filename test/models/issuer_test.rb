# == Schema Information
#
# Table name: issuers
#
#  id          :bigint           not null, primary key
#  name        :string
#  private_key :text
#  public_key  :text
#  type        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require "test_helper"

class IssuerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
