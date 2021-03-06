module CertificationsHelper
  def value_set_select(model, field)
    select(model, field, ValueSet.where(value_set_id: Certification::CODES[field]).collect {|p| [ p.display, p.code ] }, { include_blank: true })
  end

  def issuers_select(model, field)
    select(model, field, Issuer.all.collect {|p| [ p.name, p.id ] }, { include_blank: true })
  end

end
