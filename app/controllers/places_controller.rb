class PlacesController < ApplicationController

  before_action :authenticate_user

  def index
    @places = if current_user.is_manager
                Place.all
              else
                @places = current_user.places.all
              end
  end

  def new
    @place = Place.new
  end

  def show
    @place = Place.find(params[:id])
  end

  def edit
    @place = Place.find(params[:id])
  end

  def create
    @place = current_user.places.new(place_params)
    respond_to do |format|
      if @place.save
        format.html { redirect_to places_path, notice: 'place was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @place = Place.find(params[:id])
    respond_to do |format|
      if @place.update(place_params)
        format.html { redirect_to @place, notice: 'place was successfully updated.' }
        format.json { render :show, status: :ok, location: @place }
      else
        format.html { render :edit }
        format.json { render json: @place.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def place_params
      params.require(:place).permit(:place_name, :address, :approved_by_manager)
    end

end
