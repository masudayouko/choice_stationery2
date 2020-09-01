class ItemCommentsController < ApplicationController
  before_action :authenticate_user!

  def create
		@item = Item.find(params[:item_id])
		# comment = Item.new(item_params)
		@item_comment = current_user.item_comments.new(item_comment_params)
		@item_comment.item_id = params[:item_id]
		if @item_comment.save
			flash[:success] = "Comment was succesfully created."
		else
			@item_comments = ItemComment.where(id: item)
		end
	end

	def destroy
		@item_comment = ItemComment.find(params[:id])
		@item = @item_comment.item
		if @item_comment.user != current_user
			redirect_to request.referer
		end
			@item_comment.destroy
	end

	private
	def item_comment_params
		params.require(:item_comment).permit(:comment)
  end
end