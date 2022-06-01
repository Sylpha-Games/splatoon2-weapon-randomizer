class GearSetsController < ApplicationController

  before_action :require_user_login
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def index
    @gear_sets = GearSet.where(user_id: session[:user_id]).order(main_weapon_id: :asc).page(params[:page]).per(66)
  end

  def edit
    @headgear = Gear.where(category: 1, user_id: session[:user_id]).order(main_gear_power_id: :asc)
    @clothing = Gear.where(category: 2, user_id: session[:user_id]).order(main_gear_power_id: :asc)
    @shoes = Gear.where(category: 3, user_id: session[:user_id]).order(main_gear_power_id: :asc)
  end

  def update
    if @gear_set.update(gear_set_update_params)
      flash[:success] = '更新しました。'
      redirect_to gear_sets_path
    else
      flash.now[:danger] = '更新に失敗しました。'
      render :edit
    end
  end

  def destroy
    @gear_set.destroy
    flash[:success] = "削除しました"
    redirect_to gear_sets_path
  end

  private

  def gear_set_create_params
    params.require(:gear_set).permit(:main_weapon_id, :headgear_id, :clothing_id, :shoes_id)
  end

  def gear_set_update_params
    params.require(:gear_set).permit(:headgear_id, :clothing_id, :shoes_id)
  end

  def ensure_correct_user
    @gear_set = GearSet.find(params[:id])
    if @gear_set.user_id != current_user.id
      flash[:danger] = "権限がありません"
      redirect_to root_url
    end
  end

end
