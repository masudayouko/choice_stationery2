class ItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_item, only:[:show, :edit, :update, :destroy]

  def show
    @item_comment = ItemComment.new
    @item_comments = @item.item_comments
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = current_user.id
      if @item.save
        redirect_to item_path(@item.id)
      else
        render 'new'
      end
  end

  def index
    search_tags
    @items = Item.all.order(created_at: :desc)
  end

  def edit
  end

  def update
      if @item.update(item_params)
        redirect_to item_path(@item.id)
      else
        render 'edit'
      end
  end

  def destroy
    @item.destroy
    redirect_to items_path, notice: 'Item was successfully destroyed.'
  end


  def rankings
    @all_ranks = Item.find(Favorite.group(:item_id).order('count(item_id) desc').limit(3).pluck(:item_id))
  end


  def search_tags
    @search_items = Item.tagged_with(params[:tag])
    @tags = Item.tag_counts_on(:tags).order('count DESC')
    @tag = params[:tag]
  end

  def get_item
    @item = Item.find(params[:id])

  private
  def item_params
    params.require(:item).permit(
      :title,
      :body,
      :image,
      :genre_name,
      :tag_list
    )
  end
end
