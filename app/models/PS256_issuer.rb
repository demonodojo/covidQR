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
class PS256Issuer < Issuer

  CODE = -37

  def create_key
    return if private_key
    rsa_key = OpenSSL::PKey::RSA.new(2048)
    self.private_key = rsa_key.to_pem
    self.public_key = rsa_key.public_key.to_pem
  end

  def public_instance
    OpenSSL::PKey::RSA.new(self.public_key)
  end

  def sign(message)
    private_key = OpenSSL::PKey::RSA.new(self.private_key)

    signature = private_key.sign_pss("SHA256", message, salt_length: 32, mgf1_hash: "SHA256")

    valid = self.verify(message, signature)
    raise 'Cannot sign message' unless valid
    signature
  end

  def verify(message, signature)
    public_instance.verify_pss("SHA256", signature, message, salt_length: :auto, mgf1_hash: "SHA256")
  end

end
