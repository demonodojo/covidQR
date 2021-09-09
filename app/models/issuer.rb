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
class Issuer < ApplicationRecord

  before_create :create_key

  def create_key; raise NotImplementedError; end
  def public_instance; raise NotImplementedError; end
  def sign(message); raise NotImplementedError; end
  def verify(message,signature); raise NotImplementedError; end

  def binary_public_key
    Base64.decode64(raw_public_key)
  end

  def binary_private_key
    Base64.decode64(raw_private_key)
  end

  def raw_public_key
    raw_key(self.public_key)
  end

  def raw_private_key
    raw_key(self.public_key)
  end

  def raw_key(key)
    key = key[0..-1] if key.ends_with? "\n"
    key = key[-1..] if key.starts_with? "\n"
    self.public_key.split("\n")[1..-2].join()
  end

  def kid
    hex = Digest::SHA256.hexdigest(self.binary_public_key)
    bin = [hex].pack('H*')[0..7]
    Base64.strict_encode64(bin)
  end

  def cose_public_key
    cose_key = COSE::Key.from_pkey(public_instance)
    cose_key.kid = kid
    cose_key
  end

  def cose_code
    self.class.const_get("CODE")
  end

  def public_X509_certificate
    csr = OpenSSL::X509::Certificate.new
    csr.subject = OpenSSL::X509::Name.new([['CN', self.name]])
    csr.public_key = public_instance
    csr.to_pem
  end

end
