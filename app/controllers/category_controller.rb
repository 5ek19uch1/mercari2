class CategoryController < ApplicationController
  def index
    @category_parents = Category.where(ancestry: nil)
  end

  # def category_children
  #   @children = Category.find(params[:parent_id]).children
  # end

  # def category_grandchildren
  #   @grandchildren = Category.find("#{params[:parent_id]}").children
  # end

end
