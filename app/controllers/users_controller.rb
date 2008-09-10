class UsersController < RestfulController
  before_filter :check_admin

  def gets
  end

  def post
    @user = User.create params[:user] 
    if @user
      redirect_to users_path
    else
      raise "Error creating user"
    end
  end

  def put
    @user = User.update params[:user] 
    if @user
      redirect_to users_path
    else
      raise "Error creating user"
    end
  end

  def delete
    @user = User.delete params[:user] 
    if @user
      redirect_to users_path
    else
      raise "Error removing user"
    end
  end


  def check_admin
    redirect_to directory_path if @username != "admin"
  end
end

