class ToppagesController < ApplicationController
  
  before_action :require_user_login, only: [:achievement, :total_ranking, :average_ranking]
  
  def index
    if session[:main_weapon_id]
      @main_weapon = MainWeapon.find_by(id: session[:main_weapon_id])
      if session[:user_id]
        @gear_set = GearSet.find_by(user_id: session[:user_id], main_weapon_id: session[:main_weapon_id])
        if BattleRecord.find_by(user_id: session[:user_id], main_weapon_id: session[:main_weapon_id])
          @level = Math.sqrt((BattleRecord.where(user_id: session[:user_id], main_weapon_id: session[:main_weapon_id]).sum(:point)) / 100).floor
          @average_point = BattleRecord.where(user_id: session[:user_id], main_weapon_id: session[:main_weapon_id]).average(:point).floor
        else
          @level = 1
        end
      end
    end
  end
  
  def achievement
    if BattleRecord.find_by(user_id: session[:user_id])
      @total_point = BattleRecord.where(user_id: session[:user_id]).sum(:point)
      @data_count = BattleRecord.where(user_id: session[:user_id]).group(:main_weapon_id, :stage_id).count.count
      @all_data_count = (MainWeapon.count) * (Stage.count)
      @achievement_rate = (@data_count * 100 / @all_data_count.to_f).round(3)
      @main_weapons = MainWeapon.order(id: :asc)
      @max_weapon_record_weapon = MainWeapon.find(1)
      @max_weapon_record_point = 0
      @main_weapons.each do |main_weapon|
        if BattleRecord.find_by(user_id: session[:user_id], main_weapon_id: main_weapon.id)
          @weapon_total_point = BattleRecord.where(user_id: session[:user_id], main_weapon_id: main_weapon.id).sum(:point)
          if @weapon_total_point > @max_weapon_record_point
            @max_weapon_record_weapon = main_weapon
            @max_weapon_record_point = @weapon_total_point
          end
        end
      end
      @stages = Stage.order(id: :asc)
      @max_stage_record_stage = Stage.find(1)
      @max_stage_record_point = 0
      @stages.each do |stage|
        if BattleRecord.find_by(user_id: session[:user_id], stage_id: stage.id)
          @stage_total_point = BattleRecord.where(user_id: session[:user_id], stage_id: stage.id).sum(:point)
          if @stage_total_point > @max_stage_record_point
            @max_stage_record_stage = stage
            @max_stage_record_point = @stage_total_point
          end
        end
      end
      @max_point_record = BattleRecord.where(user_id: session[:user_id]).order(point: :desc).first
    end
  end
  
  def total_ranking
    @main_weapon_id_order_by_total = BattleRecord.where(user_id: session[:user_id]).group(:main_weapon_id).order('sum(point) desc').pluck(:main_weapon_id)
  end
  
  def max_ranking
    @main_weapon_id_order_by_max = BattleRecord.where(user_id: session[:user_id]).group(:main_weapon_id).order('max(point) desc').pluck(:main_weapon_id)
  end
  
  def average_ranking
    @main_weapon_id_order_by_average = BattleRecord.where(user_id: session[:user_id]).group(:main_weapon_id).order('avg(point) desc').pluck(:main_weapon_id)
  end
  
end
