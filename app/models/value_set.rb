# == Schema Information
#
# Table name: value_sets
#
#  id             :bigint           not null, primary key
#  active         :boolean
#  code           :string
#  display        :string
#  lang           :string
#  system         :string
#  value_set_date :date
#  version        :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  value_set_id   :string
#
class ValueSet < ApplicationRecord
end
