class UserHolesController < ApplicationController
  before_action :set_user_hole, only: %i[ show edit update destroy ]

  # GET /user_holes
  def index
    @user_holes = UserHole.all
  end

  # GET /user_holes/1
  def show
  end

  # GET /user_holes/new
  def new
    @user_hole = UserHole.new
  end

  # GET /user_holes/1/edit
  def edit
  end

  # POST /user_holes
  def create
    @user_hole = UserHole.new(user_hole_params)

    if @user_hole.save
      redirect_to @user_hole, notice: "User hole was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /user_holes/1
  def update
    if @user_hole.update(user_hole_params)
      redirect_to @user_hole, notice: "User hole was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /user_holes/1
  def destroy
    @user_hole.destroy
    redirect_to user_holes_url, notice: "User hole was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_hole
      @user_hole = UserHole.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_hole_params
      params.require(:user_hole).permit(:hole_number, :user_id, :course_id)
    end
end