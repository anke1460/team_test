class AccessesController < ApplicationController
  before_action :set_access, only: [:show, :edit, :update, :destroy]

  def index
    @accesses = Access.all
  end

  def show
  end

  def new
    @access = Access.new
  end

  def edit
  end

  def create
    @access = Access.new(access_params)

    respond_to do |format|
      if @access.save
        format.html { redirect_to @access, notice: 'Access was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @access.update(access_params)
        format.html { redirect_to @access, notice: 'Access was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @access.destroy
    respond_to do |format|
      format.html { redirect_to accesses_url, notice: 'Access was successfully destroyed.' }
    end
  end

  private
    def set_access
      @access = Access.find(params[:id])
    end

    def access_params
      params.fetch(:access, {})
    end
end
