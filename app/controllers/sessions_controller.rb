class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({ "email" => params["email"] })
    if @user
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Welcome, #{@user["username"]}."
        redirect_to "/places"
      else
        flash["notice"] = "Your username and/or password were incorrect."
        redirect_to "/login"
      end
    else
      flash["notice"] = "Your username and/or password were incorrect."
      redirect_to "/login"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "Logged Out Successfully."
    redirect_to "/login"
  end
end
  