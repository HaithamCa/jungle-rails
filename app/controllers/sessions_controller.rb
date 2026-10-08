class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user
      # logged in when they navigate around our website.
      destination = safe_return_path
      session[:user_id] = user.id
      redirect_to destination
    else
      redirect_to '/login', alert: 'Invalid email or password.'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/login'
  end

  private

  def safe_return_path
    target = session.delete(:return_to).to_s
    return '/' unless target.start_with?('/') && !target.start_with?('//')

    target
  end
end
