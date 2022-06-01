class GearSet < ApplicationRecord

  belongs_to :user
  belongs_to :main_weapon
  belongs_to :headgear, class_name: 'Gear'
  belongs_to :clothing, class_name: 'Gear'
  belongs_to :shoes, class_name: 'Gear'

end
