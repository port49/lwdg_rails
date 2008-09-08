class RestfulController < ApplicationController
  before_filter :prepare_restful_action
  before_filter :prepare_restful_instance_variables
  before_filter :prepare_username

  helper :all
  session :off  
  
  def prepare_username
    auth = request.env['AUTHORIZATION'] || request.env['HTTP_AUTHORIZATION'] || request.env['X-HTTP_AUTHORIZATION'] || request.env['X_HTTP_AUTHORIZATION'] || request.env['REDIRECT_X_HTTP_AUTHORIZATION']
    if name = ( auth || "" ).match( /username=\"(\w+)\"/ )
      @username = name[1]
    else
      @username = "admin"
    end
  end

  # Plural methods.
  def gets
    respond_to do |format|
      format.html { render :text => "Gets called from '#{ self.class.name }' with: #{ self.instance_variables.inspect }" }
    end
  end

  def posts
    respond_to do |format|
      format.html { render :text => "Posts called from '#{ self.class.name }' with: #{ self.instance_variables.inspect }" }
    end
  end

  def puts
    respond_to do |format|
      format.html { render :text => "Puts called from '#{ self.class.name }' with: #{ self.instance_variables.inspect }" }
    end
  end

  def deletes
    respond_to do |format|
      format.html { render :text => "Deletes called from '#{ self.class.name }' with: #{ self.instance_variables.inspect }" }
    end
  end

  # Singular methods.
  def get
    respond_to do |format|
      format.html { render :text => "Get called from '#{ self.class.name }' with: #{ self.instance_variables.inspect }" }
    end
  end

  def post
    respond_to do |format|
      format.html { render :text => "Post called from '#{ self.class.name }' with: #{ self.instance_variables.inspect }" }
    end
  end

  def put
    respond_to do |format|
      format.html { render :text => "Put called from '#{ self.class.name }' with: #{ self.instance_variables.inspect }" }
    end
  end

  def delete
    respond_to do |format|
      format.html { render :text => "Delete called from '#{ self.class.name }' with: #{ self.instance_variables.inspect }" }
    end
  end

  def prepare_restful_action
    case params[:grammatical_number]
    when 'plural'
      self.action_name = self.request.request_method.to_s.pluralize
    when 'singular'
      self.action_name = self.request.request_method.to_s.singularize
    end
  end

  def prepare_restful_instance_variables
    resource_class_name = params[:controller].to_s.singularize.camelize
    if true #Check for availability of matching model class.
      resource_class = resource_class_name.constantize 
      case params[:grammatical_number]
      when 'plural'
        instances_name = ( "@" + params[:controller].to_s.pluralize ).to_sym
        if params[:ids]
          instance_variable_set instances_name, resource_class.find( params[:ids].split( ',' ) ) 
        else
          instance_variable_set instances_name, resource_class.find( :all )
        end 
      when 'singular'
        instance_name = ( "@" + params[:controller].to_s.singularize ).to_sym
        if params[:id].to_i == 0
          instance_variable_set instance_name, resource_class.new 
        else
          instance_variable_set instance_name, resource_class.find( params[:id] ) if params[:id]
        end
      end
    end
  end

end
