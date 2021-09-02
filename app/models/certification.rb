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
class Certification < ApplicationRecord
  before_save :create_qr_code

  private
  def create_qr_code
    json = self.json_info
    self.build_qr_code(json)
  end

  def build_qr_code(payload)
    self.qr_code = RQRCode::QRCode.new(payload).as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 11,
      standalone: true,
      use_path: true
    )
  end

  def json_info
    {
      name: self.name,
      surname: self.surname
    }.to_json
  end
end
