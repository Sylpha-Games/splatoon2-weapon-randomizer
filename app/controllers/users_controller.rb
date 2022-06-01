class UsersController < ApplicationController
  
  before_action :require_user_login, only: [:show, :edit, :update, :destroy]
  before_action :ensure_correct_user, only: [:show, :edit, :update, :destroy]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      @headgear = Gear.new(name: "未設定", category: 1, user_id: session[:user_id], main_gear_power_id: 1, sub_gear_power_1_id: 1, sub_gear_power_2_id: 1, sub_gear_power_3_id: 1)
      @headgear.save
      @clothing = Gear.new(name: "未設定", category: 2, user_id: session[:user_id], main_gear_power_id: 1, sub_gear_power_1_id: 1, sub_gear_power_2_id: 1, sub_gear_power_3_id: 1)
      @clothing.save
      @shoes = Gear.new(name: "未設定", category: 3, user_id: session[:user_id], main_gear_power_id: 1, sub_gear_power_1_id: 1, sub_gear_power_2_id: 1, sub_gear_power_3_id: 1)
      @shoes.save
      @main_weapons = MainWeapon.order(id: :asc)
      @main_weapons.each do |main_weapon|
        GearSet.create(user_id: session[:user_id], main_weapon_id: main_weapon.id, headgear_id: @headgear.id, clothing_id: @clothing.id, shoes_id: @shoes.id)
      end
      flash[:success] = '登録しました。'
      redirect_to root_url
    else
      flash.now[:danger] = '登録に失敗しました。'
      render :new
    end
  end
  
  def show
  end
  
  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = '更新しました。'
      redirect_to @user
    else
      flash.now[:danger] = '更新に失敗しました。'
      render :edit
    end
  end
  
  def destroy
    @user.destroy
    flash[:success] = "削除しました"
    redirect_to root_url
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  def ensure_correct_user
    @user = User.find(params[:id])
    if @user.id != current_user.id
      flash[:danger] = "権限がありません"
      redirect_to root_url
    end
  end
  
end
