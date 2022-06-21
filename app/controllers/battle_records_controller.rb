class BattleRecordsController < ApplicationController
  
  before_action :require_user_login
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  
  def index
    @battle_records = BattleRecord.where(user_id: session[:user_id]).order(id: :desc).page(params[:page]).per(50)
  end
  
  def new
    @battle_record = BattleRecord.new
    @main_weapon = MainWeapon.find(params[:main_weapon_id])
    @gear_set = GearSet.find_by(user_id: session[:user_id], main_weapon_id: params[:main_weapon_id])
    @stages = Stage.order(id: :asc)
    if BattleRecord.find_by(user_id: session[:user_id], main_weapon_id: params[:main_weapon_id])
      @level = Math.sqrt((BattleRecord.where(user_id: session[:user_id], main_weapon_id: params[:main_weapon_id]).sum(:point)) / 100).floor
      @average_point = BattleRecord.where(user_id: session[:user_id], main_weapon_id: params[:main_weapon_id]).average(:point).floor
    else
      @level = 1
    end
    if BattleRecord.find_by(user_id: session[:user_id])
      @battle_records = BattleRecord.where(user_id: session[:user_id]).order(id: :desc).limit(2)
    end
  end
  
  def create
    @battle_record = BattleRecord.new(battle_record_create_params)
    @battle_record.user_id = session[:user_id]
    @battle_record.main_weapon_id = params[:main_weapon_id]
    if BattleRecord.find_by(user_id: session[:user_id], main_weapon_id: params[:main_weapon_id], stage_id: @battle_record.stage_id)
      @previous_max_point = BattleRecord.where(user_id: session[:user_id], main_weapon_id: params[:main_weapon_id], stage_id: @battle_record.stage_id).maximum(:point)
    else
      @previous_max_point = 0
    end
    if BattleRecord.find_by(user_id: session[:user_id], main_weapon_id: params[:main_weapon_id])
      @previous_main_weapon_average_point = BattleRecord.where(user_id: session[:user_id], main_weapon_id: params[:main_weapon_id]).average(:point).floor
    else
      @previous_main_weapon_average_point = 0
    end
    if BattleRecord.find_by(user_id: session[:user_id], stage_id: @battle_record.stage_id)
      @previous_stage_average_point = BattleRecord.where(user_id: session[:user_id], stage_id: @battle_record.stage_id).average(:point).floor
    else
      @previous_stage_average_point = 0
    end
    if @battle_record.save
      @main_weapon_average_point = BattleRecord.where(user_id: session[:user_id], main_weapon_id: params[:main_weapon_id]).average(:point).floor
      @stage_average_point = BattleRecord.where(user_id: session[:user_id], stage_id: @battle_record.stage_id).average(:point).floor
      msg = "ブキ：#{@battle_record.main_weapon.name},（平均：#{@previous_main_weapon_average_point}p → #{@main_weapon_average_point}p）,ステージ：#{@battle_record.stage.name},（平均：#{@previous_stage_average_point}p → #{@stage_average_point}p）,ポイント：#{@battle_record.point}p（過去最高：#{@previous_max_point}p）"
      msg = msg.gsub(",","<br>")
      flash[:success] = msg
    else
      flash[:danger] = '登録に失敗しました。'
    end
    redirect_to root_url
  end
  
  def edit
    @main_weapons = MainWeapon.order(id: :asc)
    @stages = Stage.order(id: :asc)
  end
  
  def update
    if @battle_record.update(battle_record_update_params)
      flash[:success] = '更新しました。'
      redirect_to battle_records_path
    else
      flash.now[:danger] = '更新に失敗しました。'
      render :edit
    end
  end
  
  def destroy
    @battle_record.destroy
    flash[:success] = "削除しました"
    redirect_to battle_records_path
  end
  
  private
  
  def battle_record_create_params
    params.require(:battle_record).permit(:stage_id, :point)
  end
  
  def battle_record_update_params
    params.require(:battle_record).permit(:main_weapon_id, :stage_id, :point)
  end
  
  def ensure_correct_user
    @battle_record = BattleRecord.find(params[:id])
    if @battle_record.user_id != current_user.id
      flash[:danger] = "権限がありません"
      redirect_to root_url
    end
  end
  
end
