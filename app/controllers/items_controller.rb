class ItemsController < ApplicationController
  before_action :authenticate_user!

  def show
    @item = Item.find(params[:id])
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
      if @item.save!
        redirect_to item_path(@item.id)
      else
        pp @item.errors
        render 'new'
      end
  end

  def index
    @items = Item.all
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
      if @item.update(item_params)
        redirect_to item_path(@item.id)
      else
        render 'edit'
      end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to items_path, notice: 'Item was successfully destroyed.'
  end

  def rankings
  end

  private
  def item_params
    params.require(:item).permit(
      :title,
      :comment,
      :image,
      :genre_name,
    )
  end 
end
