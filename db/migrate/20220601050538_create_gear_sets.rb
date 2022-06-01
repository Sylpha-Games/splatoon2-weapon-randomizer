class CreateGearSets < ActiveRecord::Migration[5.2]
  
  def change
    create_table :gear_sets do |t|
      t.references :user, foreign_key: true
      t.references :main_weapon, foreign_key: true
      t.references :headgear, foreign_key: { to_table: :gears }
      t.references :clothing, foreign_key: { to_table: :gears }
      t.references :shoes, foreign_key: { to_table: :gears }
      t.timestamps
    end
  end
  
end
