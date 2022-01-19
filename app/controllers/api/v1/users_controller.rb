module Api
    module V1
        class UsersController < ApplicationController
            before_action :authenticate_user!
        
            def index
            @users = User.all
            json_response(@users)
            end
        
            def show
                @user = User.find(params[:id])
                json_response(@user)
            end
        end
    end
end