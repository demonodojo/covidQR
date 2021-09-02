# == Schema Information
#
# Table name: value_sets
#
#  id           :bigint           not null, primary key
#  active       :boolean
#  code         :string
#  display      :string
#  lang         :string
#  system       :string
#  valueSetDate :date
#  valueSetId   :string
#  version      :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class ValueSetLoader
  def self.load(uri)
    response = HTTParty.get(uri)

    json = JSON.parse(response.body)

    value_set_id = json['valueSetId']
    value_set_date = json['valueSetDate']
    ValueSet.delete_by(value_set_id: value_set_id)
    values = json['valueSetValues']
    values.each do |key, value|
      ValueSet.create({
                     value_set_id: value_set_id,
                     value_set_date: value_set_date,
                     active: value['active'],
                     code: key,
                     display: value['display'],
                     lang: value['lang'],
                     system: value['system'],
                     version: value['version']
                   })
    end

  end
end
