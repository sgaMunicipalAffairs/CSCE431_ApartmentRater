class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    if current_user.nil?
      return redirect_to root_path, notice: 'Need to be logged in to access this page'
    elsif not current_user.is_admin
      return redirect_to root_path, notice: 'Need to be an admin to access this page'
    end
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    redirect_to users_path, notice: 'All users can be viewed from the list'
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if current_user.nil?
      return redirect_to root_path, notice: 'Need to be logged in to access this page'
    elsif not current_user.is_admin
      if current_user.id != params[:id].to_i
        return redirect_to root_path, notice: 'Need to be an admin to access this page'
      end
    end
  end

  # POST /users
  # POST /users.json
  def create
    if verifyInput(user_params)
      @user = User.new(email: user_params["email"], password: user_params["password"], password_confirmation: user_params["password_confirmation"])

      respond_to do |format|
        if @user.save
          session[:user_id] = @user.id
          format.html { redirect_to root_url, notice: "Logged in!" }
        else
          format.html { render :new }
          format.json { render json: @user.errors, status: :unprocessable_entity }
          flash[:notice] = "Error creating account."
          print("Error Creating User")
          format.html { redirect_to action: "new"}
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to action: "new"}
      end
    end
  end

  def verifyInput params
    #ADD SGA EMAIL
    if not (params["email"].include? "@tamu.edu" or params["email"].include? "@blinn.edu" or params["email"] == "ma.tamuexecutive@gmail.com" or params["email"] == "cmythman@gmail.com")
      flash[:notice] = "Please use a Tamu or Blinn email."
      return false
    elsif params["password"] != params["vPassword"]
      flash[:notice] = "Passwords do not match."
      return false
    elsif params["password"] == ""
      flash[:notice] = "Password can\'t be blank"
      return false
    end
    return true
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_url, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def admin_portal
    if current_user.nil?
      return redirect_to root_path
    elsif not current_user.is_admin
      return redirect_to root_path
    end
  end

  def admin
    admin = AdminTable.create(:user_id => params[:id])
    return redirect_to users_path, notice: 'Admin added successfully'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :vPassword, :password_confirmation)
    end
end