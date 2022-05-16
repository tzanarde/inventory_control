class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :update, :destroy]
  before_action :products_filter, only: [:index]

  # GET /products
  def index
    render json: @products
  end

  # GET /products/1
  def show
    render json: @product
  end

  # POST /products
  def create
    @product = Product.new(product_params)

    if @product.save
      render json: @product, status: :created, location: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /products/1
  def update
    if @product.update(product_params)
      render json: @product
    else
      render json: @product.errors, status: :unprocessable_entity
    end
  end

  # DELETE /products/1
  def destroy
    @product.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    def category_filter?
      params['category_id'].present?
    end

    def no_filter?
      !category_filter?
    end

    def products_filter
      byebug
      @products = Product.all if no_filter?
      @products = Product.by_category(params["category_id"]) if category_filter?
    end

    # Only allow a trusted parameter "white list" through.
    def product_params
      params.permit(:description, :quantity, :barcode, :category_id)
    end
end
