class ItemCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
		item = Item.find(params[:item_id])
		# comment = Item.new(item_params)
		# comment.user.id = current_user.id
		comment = current_user.item_comments.new(item_comment_params)
		comment.item_id = item.id
		comment.save
		redirect_to item_path(item)
	end

	def destroy
		ItemComment.find_by(id: params[:id],item_id: params[:item_id]).destroy
		redirect_to item_path(params[:item_id])
	end

	private
	def item_comment_params
		params.require(:item_comment).permit(:comment)
  end
end