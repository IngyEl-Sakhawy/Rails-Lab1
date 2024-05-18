# app/models/ability.rb
class Ability
    include CanCan::Ability
  
    def initialize(user)
      user ||= User.new 
  
      can :read, Article, status: 'public'

    if user.persisted?
      can :manage, Article, user_id: user.id
    end
    end
  end
  