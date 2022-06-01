class CreateGears < ActiveRecord::Migration[5.2]
  
  def change
    create_table :gears do |t|
      t.string :name
      t.integer :category
      t.references :user, foreign_key: true
      t.references :main_gear_power, foreign_key: { to_table: :gear_powers }
      t.references :sub_gear_power_1, foreign_key: { to_table: :gear_powers }
      t.references :sub_gear_power_2, foreign_key: { to_table: :gear_powers }
      t.references :sub_gear_power_3, foreign_key: { to_table: :gear_powers }
      t.timestamps
    end
  end
  
end
