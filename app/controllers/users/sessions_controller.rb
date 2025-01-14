class Users::SessionsController < Devise::SessionsController
  def create
    respond_to do |format|
      format.html { super }
      format.json do
        if current_user
          ender status: 200, json: { message: 'already logged in' }
        else
          warden.authenticate!(scope: resource_name, recall: "#{controller_path}#new")
          render status: 200, json: { message: 'Log in successful' }
        end
      end
    end
  end

  # private

  # def respond_with(_resource, _opts = {})
  #   render json: { message: 'You are logged in.' }, status: :ok
  # end

  # def respond_to_on_destroy
  #   log_out_success && return if current_user

  #   log_out_failure
  # end

  # def log_out_success
  #   render json: { message: 'You are logged out.' }, status: :ok
  # end

  # def log_out_failure
  #   render json: { message: 'Hmm nothing happened.' }, status: :unauthorized
  # end
end
