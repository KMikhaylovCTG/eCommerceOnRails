class ProductsController < ApplicationController
  def index
		 #Only display primary product elimintating other variants for catalog index
  	    @variants = Variant.where("is_prime = ?", true)
  	    @categories = Category.all
		
	end

	def show
		 #TODO: add index to slug
		  product_relation = Product.all                             
                              .where(slug: params[:id])
		 @variant = Variant.joins(:product).merge(product_relation).first

		 @categories = Category.all
	end
end
