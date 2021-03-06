class Admin::ProductsController < Admin::BaseController

    before_action :find_product, only: [:edit, :update, :destroy]
  
    def index
      @products = Product.page(params[:page] || 1).per_page(params[:per_page] || 10)
        .order("id desc")
    end
  
    def new
      @product = Product.new
      @root_categories = Category.roots
    end
  
    def create
      @product = Product.new(params.require(:product).permit!)
      @root_categories = Category.roots
  
      if @product.save
        flash[:notice] = "  Create sucessfully"
        redirect_to admin_products_path
      else
        render action: :new
      end
    end
  
    def edit
      @root_categories = Category.roots
      render action: :new
    end
  
    def update
      @product.attributes = params.require(:product).permit!
      @root_categories = Category.roots
      if @product.save
        flash[:notice] = "Update sucessfully"
        redirect_to admin_products_path
      else
        render action: :new
      end
    end
  
    def destroy
      if @product.destroy
        flash[:notice] = "Delete successfully"
        redirect_to admin_products_path
      else
        flash[:notice] = "Delete failed"
        
      redirect_back(fallback_location:"/")
      end
    end
  
    private
    def find_product
      @product = Product.find(params[:id])
    end
  
  end