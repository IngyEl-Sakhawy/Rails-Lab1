class UsersController < ApplicationController
  

  def reportpage
    @users = User.includes(:articles)
  end

  
end
