class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy, :test]
  before_action :test, only: [:edit, :destroy, :update]

  # GET /pictures
  # GET /pictures.json
  def index
    @pictures = Picture.all.includes(:user)
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @comments = @picture.comments
    @comment = @picture.comments.build
  end

  # GET /pictures/new
  def new
    @picture = Picture.new
  end

  # GET /pictures/1/edit
  def edit
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    if params[:back]
      render :new and return
    end
    respond_to do |format|
      if @picture.save
        format.html { redirect_to @picture, notice: 'Picture was successfully created.' }
        format.json { render :show, status: :created, location: @picture }
      else
        format.html { render :new }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    if params[:back]
      @picture = Picture.new(picture_params)
      render :edit
    else
      respond_to do |format|
        if @picture.update(picture_params)
          format.html { redirect_to @picture, notice: 'Picture was successfully updated.' }
          format.json { render :show, status: :ok, location: @picture }
        else
          format.html { render :edit }
          format.json { render json: @picture.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to pictures_url, notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def confirm
    @picture = Picture.new(picture_params)
    @picture.user_id = current_user.id
    @picture.id = params[:id]
    render :new if @picture.invalid?
  end

  def test
    if current_user.id != @picture.user_id
      redirect_to pictures_path, notice: "権限がありません"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:id, :title, :content, :user_id, :image, :image_cache)
    end
  end
