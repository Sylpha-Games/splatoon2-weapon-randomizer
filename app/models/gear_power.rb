class GearPower < ApplicationRecord
  
  has_many :main_gear_power, class_name: 'Gear', foreign_key: 'main_gear_power_id', dependent: :destroy
  has_many :sub_gear_power_1, class_name: 'Gear', foreign_key: 'sub_gear_power_1_id', dependent: :destroy
  has_many :sub_gear_power_2, class_name: 'Gear', foreign_key: 'sub_gear_power_2_id', dependent: :destroy
  has_many :sub_gear_power_3, class_name: 'Gear', foreign_key: 'sub_gear_power_3_id', dependent: :destroy
  
  enum gear_category: { 'アタマ・フク・クツ': 0, 'アタマ': 1, 'フク': 2, 'クツ': 3 }
  
end
