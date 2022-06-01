class Gear < ApplicationRecord
  
  belongs_to :user
  belongs_to :main_gear_power, class_name: 'GearPower'
  belongs_to :sub_gear_power_1, class_name: 'GearPower'
  belongs_to :sub_gear_power_2, class_name: 'GearPower'
  belongs_to :sub_gear_power_3, class_name: 'GearPower'

  has_many :headgear, class_name: 'GearSet', foreign_key: 'headgear_id', dependent: :destroy
  has_many :clothing, class_name: 'GearSet', foreign_key: 'clothing_id', dependent: :destroy
  has_many :shoes, class_name: 'GearSet', foreign_key: 'shoes_id', dependent: :destroy

  enum category: { 'アタマ': 1, 'フク': 2, 'クツ': 3 }
  
end
