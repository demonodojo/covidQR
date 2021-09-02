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

require 'base45'

class Certification < ApplicationRecord
  before_save :create_qr_code

  private
  def create_qr_code
    json = self.json_info

    self.build_qr_code(json)
  end

  def build_qr_code(payload)
    data_compressed = Zlib::Deflate.deflate(payload)
    base45 = Base45.encode data_compressed
    self.qr_code = RQRCode::QRCode.new(base45).as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 11,
      standalone: true,
      use_path: true
    )
  end

  def json_info
    {
      ver: '1.3.0',
      nam: {
        fn: self.surname.first(80),
        fnt: I18n.transliterate(self.surname).upcase.gsub(/ /,'<').first(80),
        gn: self.name.first(80),
        gnt: I18n.transliterate(self.name).upcase.gsub(/ /,'<').first(80)
      },
      dob: self.date_of_birth.to_s,
      v: [{
            tg: "840539006", # COVID-19 https://github.com/ehn-dcc-development/ehn-dcc-schema/blob/release/1.3.0/valuesets/disease-agent-targeted.json
            vp: "1119349007", # SARS-CoV-2 mRNA vaccine https://github.com/ehn-dcc-development/ehn-dcc-schema/blob/release/1.3.0/valuesets/vaccine-prophylaxis.json
            mp: "EU/1/20/1528", # Comirnaty (Pfizer) https://github.com/ehn-dcc-development/ehn-dcc-schema/blob/release/1.3.0/valuesets/vaccine-medicinal-product.json
            ma: "ORG-100030215", # Biontech https://github.com/ehn-dcc-development/ehn-dcc-schema/blob/release/1.3.0/valuesets/vaccine-mah-manf.json
            dn: 1, # Dose number
            sd: 2, # Total series of doses
            dt: self.vaccination_date
          }]
    }.to_json
  end
end
