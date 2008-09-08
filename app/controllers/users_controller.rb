class UsersController < RestfulController

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

end

