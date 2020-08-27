class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user, only:[:show, :edit, :update]

  def show
    @items = @user.items
    @item = Item.new
  end

  def index
    @users = User.all
  end

  def edit
    if @user != current_user
      redirect_to user_path(current_user)
    end
  end

  def update
    if @user.update(user_params)
       redirect_to user_path(@user), notice: 'User was successfully updated.'
    else #def editの代わり
      render action: :edit
    end
  end

  def get_user
    @user = User.find(params[:id])
  end

private
  def user_params
  	params.require(:user).permit(:profile_image,:name,:introduction)
  end
  
end
