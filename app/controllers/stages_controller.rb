class StagesController < ApplicationController

  def index
    @stages = Stage.order(id: :asc)
  end

  def show
    @stage = Stage.find(params[:id])
    @main_weapons_count = MainWeapon.count
  end

end
