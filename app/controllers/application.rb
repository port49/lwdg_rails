class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  session :off  
end
