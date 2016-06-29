class UsersController < ApplicationController
  before_action :set_user, only: [:new_account, :show]

  def new_account

  end

  def update_account

  end

  def show

  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    # def user_params
    #   params.require(:user).permit(:name)
    # end
end
