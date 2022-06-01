class BattleRecord < ApplicationRecord
  
  belongs_to :user
  belongs_to :main_weapon
  belongs_to :stage
  
end
