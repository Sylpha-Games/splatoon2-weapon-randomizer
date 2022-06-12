class MainWeaponsController < ApplicationController
  
  def index
    @main_weapons = MainWeapon.order(id: :asc).page(params[:page]).per(66)
  end
  
  def show
    @main_weapon = MainWeapon.find(params[:id])
    @stages_count = Stage.count
    if session[:user_id]
      @gear_set = GearSet.find_by(user_id: session[:user_id], main_weapon_id: params[:id])
      if BattleRecord.find_by(user_id: session[:user_id], main_weapon_id: params[:id])
        @level = Math.sqrt((BattleRecord.where(user_id: session[:user_id], main_weapon_id: params[:id]).sum(:point)) / 100).floor
        @average_point = BattleRecord.where(user_id: session[:user_id], main_weapon_id: params[:id]).average(:point).floor
      else
        @level = 1
      end
    end
  end
  
  def random
    rand = Rails.env.production? ? "RANDOM()" : "rand()"
    @main_weapon = MainWeapon.order(rand).first
    session[:main_weapon_id] = @main_weapon.id
    redirect_to root_url
  end
  
  def random_destroy
    session[:main_weapon_id] = nil
    redirect_to root_url
  end
  
end
