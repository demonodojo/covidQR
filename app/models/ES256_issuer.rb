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
class ES256Issuer < Issuer

  CODE = -7

  def create_key
    return if private_key
    ecdsa_key = OpenSSL::PKey::EC.new("prime256v1")
    ecdsa_key.generate_key!
    self.private_key = ecdsa_key.to_pem

    pkey = OpenSSL::PKey::EC.new(ecdsa_key.public_key.group)
    pkey.public_key = ecdsa_key.public_key
    self.public_key =  pkey.to_pem
  end

  def public_instance
    OpenSSL::PKey::EC.new(self.public_key)
  end

  def sign(message)
    priv_key = OpenSSL::PKey::EC.new(self.private_key)
    signature = priv_key.dsa_sign_asn1(OpenSSL::Digest.digest('SHA256', message))

    valid = self.verify(message, signature)
    raise 'Cannot sign message' unless valid
    signature
  end

  def verify(message, signature)
    public_instance.dsa_verify_asn1(OpenSSL::Digest.digest('SHA256', message), signature)
  end



end
