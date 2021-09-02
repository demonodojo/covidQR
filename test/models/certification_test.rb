# == Schema Information
#
# Table name: certifications
#
#  id         :bigint           not null, primary key
#  category   :string
#  name       :string
#  qr_code    :binary
#  surname    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "test_helper"

class CertificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
