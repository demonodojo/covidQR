# == Schema Information
#
# Table name: certifications
#
#  id                             :bigint           not null, primary key
#  category                       :string
#  date_of_birth                  :date
#  disease_target                 :string
#  dose_number                    :integer
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
#  issuer_id                      :bigint
#
# Indexes
#
#  index_certifications_on_issuer_id  (issuer_id)
#

require 'base45'

class Certification < ApplicationRecord

  belongs_to :issuer

  CODES = {
    disease_target: "disease-agent-targeted",
    vaccine_or_prophylaxis: "sct-vaccines-covid-19",
    medicinal_product: "vaccines-covid-19-names",
    vaccination_country: "country-2-codes",
    marketing_authorization_holder: "vaccines-covid-19-auth-holders"
  }.with_indifferent_access

  URI_SCHEMA = 'HC1'

  CWT_ISSUER = 1
  CWT_SUBJECT = 2
  CWT_AUDIENCE = 3
  CWT_EXPIRATION = 4
  CWT_NOT_BEFORE = 5
  CWT_ISSUED_AT = 6
  CWT_ID = 7
  CWT_HCERT = -260
  CWT_HCERT_V1 = 1

  COSE_ALG_TAG = 1
  COSE_KID_TAG = 4

  before_save :create_qr_code

  def create_qr_code
    base = self.json_info
    cwt = self.make_cwt(base, 4, self.issuer)
    cbor = sign(cwt)
    self.build_qr_code(cbor)
  end

  def build_qr_code(payload)
    data_compressed = Zlib::Deflate.deflate(payload)
    base45 = Base45.encode data_compressed
    total = "#{URI_SCHEMA}:#{base45}"
    self.qr_code = total
  end

  def show_qr_code
    RQRCode::QRCode.new(self.qr_code).as_svg(
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
            tg: self.disease_target,
            vp: self.vaccine_or_prophylaxis,
            mp: self.medicinal_product,
            ma: self.marketing_authorization_holder,
            dn: self.dose_number, # Dose number
            sd: self.series_of_doses, # Total series of doses
            dt: self.vaccination_date.to_s,
            co: self.vaccination_country,
            is: self.issuer.name,
            ci: self.uvci
          }]
    }
  end

  def make_cwt(payload, expiration_months=nil, issuer=nil)
    cwt = {
      CWT_ISSUER => issuer.name,
      CWT_ISSUED_AT => Time.now.to_i,
      CWT_HCERT => {
        CWT_HCERT_V1 => payload
      }
    }
    if expiration_months
      cwt[CWT_EXPIRATION] = (Time.now + expiration_months.months).to_i
    end
    cwt
  end

  def sign(payload)
    sig_structure = [
      'Signature1',
      { 1 => issuer.cose_code,
        4 => issuer.kid }.to_cbor,
      "".b,
      payload.to_cbor
    ]
    message = sig_structure.to_cbor
    signature = issuer.sign(message)

    self.create_security_message({ 1 => issuer.cose_code, 4 => issuer.kid }, "".b, payload.to_cbor, signature.b, cbor_tag: 18)
  end

  def create_security_message(protected_headers, unprotected_headers, *args, cbor_tag: 0)
    CBOR::Tagged.new(cbor_tag, [CBOR.encode(protected_headers), unprotected_headers, *args]).to_cbor
  end

  def verify
    str_code = self.qr_code.to_s
    base45_code = str_code[4..]
    zipped = Base45.decode base45_code
    cose = Zlib::Inflate.inflate(zipped)
    sign = COSE::Sign1.deserialize(cose)

    valid = sign.verify(issuer.cose_public_key)
    raise 'Not verified' unless valid

    sign.payload
  end

end
