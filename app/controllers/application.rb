class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  session :off  
  
  def username
    auth = request.env['AUTHORIZATION'] || request.env['HTTP_AUTHORIZATION'] || request.env['X-HTTP_AUTHORIZATION'] || request.env['X_HTTP_AUTHORIZATION'] || request.env['REDIRECT_X_HTTP_AUTHORIZATION']
    render :text => auth and return true
    redirect_to directory_path(  )
    # "username=\"admin\""
  end
  
end
