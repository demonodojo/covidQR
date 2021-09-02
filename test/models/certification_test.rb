# == Schema Information
#
# Table name: certifications
#
#  id                             :bigint           not null, primary key
#  category                       :string
#  date_of_birth                  :date
#  disease_target                 :string
#  dose_number                    :integer
#  issuer                         :string
#  marketing_authorization_holder :string
#  medicinal_product              :string
#  name                           :string
#  qr_code                        :binary
#  series_of_doses                :integer
#  surname                        :string
#  uvci                           :string
#  vaccination_country            :string
#  vaccination_date               :date
#  vaccine_or_prophylaxis         :string
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#
require "test_helper"

class CertificationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
