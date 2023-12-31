class HolesController < ApplicationController
  before_action :set_hole, only: %i[ show edit update destroy ]
  before_action :require_map_creator

  # Require map creator role to access holes page
  def require_map_creator
    unless current_user.user_role == "map_creator" || current_user.user_role == "admin"
      redirect_to root_path
    end
  end

  # GET /holes
  def index
    @holes = Hole.all
  end

  # GET /holes/1
  def show
    @data = Datum.where(hole_id: @hole.id)
    @xCoordinates = []
    @yCoordinates = []
    @terrain_type = []
    
    @data.each do |data| 
      @xCoordinates.append(data.xCoordinates)
      @yCoordinates.append(data.yCoordinates)
      @terrain_type.append(data.terrain_type)
    end
  end

  # GET /holes/new
  def new
    @hole = Hole.new
  end

  # GET /holes/1/edit
  def edit  
  end

 
  # POST /holes/new
  def create
    @hole = Hole.new(hole_params)
    @hole.user_id = current_user.id
    if @hole.save
      redirect_to new_datum_path(:id => @hole.id,:course_name => @hole.course_name), notice: "Hole was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /holes/1
  def update
    if @hole.update(hole_params)

      # Email notif
      @user_holes = UserHole.where(hole_id: @hole.id)
      @user_holes.each do |user_hole|
        @user = User.find_by(id: user_hole.user_id)
        UserMailer.update_notification(@user, @hole).deliver_now
      end

      @data = Datum.where(hole_id: @hole.id)
      @xCoordinates = []
      @yCoordinates = []
      @terrain_type = []
    
      @data.each do |data| 
        @xCoordinates.append(data.xCoordinates)
        @yCoordinates.append(data.yCoordinates)
        @terrain_type.append(data.terrain_type)
      end

      redirect_to edit_datum_path(:id => @hole.id,:course_name => @hole.course_name, :xCoordinates => @xCoordinates, :yCoordinates => @yCoordinates, :terrain_type => @terrain_type), notice: "Hole was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /holes/1
  def destroy
    @hole.destroy
    redirect_to holes_url, notice: "Hole was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hole
      @hole = Hole.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def hole_params
      params.require(:hole).permit(:hole_number,:course_name)
    end
end
