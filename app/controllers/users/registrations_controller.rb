class Users::RegistrationsController < Devise::RegistrationsController
  skip_before_action :verify_authenticity_token, only: :create
  respond_to :json

  private

  def respond_with(resource, _opts = {})
    register_success && return if resource.persisted?

    register_failed(resource)
  end

  def register_success
    render json: { message: 'Signed up sucessfully.' }
  end

  def register_failed(resource)
    render json: { message: 'Something went wrong.', errors: resource.errors }
  end
end
