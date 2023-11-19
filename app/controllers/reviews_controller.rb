class ReviewsController < ApplicationController
  def new
    @list = List.find(params[:list_id])
    @review = Review.new
  end

  def create
    @list = List.find(params[:list_id])
    @review = Review.new(review_params)
    @review.list = @list
    if @review.save!
      redirect_to list_path(@list)
    else
      render :new, notice: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :content, :rating)
  end
end
