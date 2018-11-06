class Admin::CategoriesController < Admin::BaseController
  before_action :load_category, except: %i(new index create import)
  before_action :load_list_category, only: %i(index import)

  def index; end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "successfully_create"
      redirect_to admin_categories_url
    else
      render :new
    end
  end

  def import
    ActiveRecord::Base.transaction do
      Category.import params[:file]
      redirect_to admin_categories_url
      flash[:success] = t "successfully_import"
    end
    rescue Exception
      flash[:danger] = t "not_file_import"
      render :index
  end

  def show; end

  def edit; end

  def update
    if @category.update category_params
      flash[:success] = t "successfully_update"
      redirect_to admin_categories_url
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "category_delete"
    else
      flash[:danger] = t "cannot_delete_category"
    end
    redirect_to admin_categories_url
  end

  private

  def category_params
    params.require(:category).permit :name
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category.present?
    flash[:danger] = t "not_category"
    redirect_to admin_categories_url
  end

  def load_list_category
    @categories = Category.select_category
    return if @categories.present?
    flash[:danger] = t "not_category"
    redirect_to admin_categories_url
  end
end
