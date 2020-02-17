# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities

    user ||= User.new # guest user (not logged in)
   
    if user.superadmin?
      can :manage, :all
      can :access, :rails_admin
      can :manage, :dashboard 
      can :manage, Review 
      can :manage, Book      
      can :manage, Comment
    end
    
    if user.admin_role?     
      
      cannot :destroy, User, admin_role: true      
      can :manage, Book      
      can :manage, Comment
      can :manage, Review        
    end

    if user.moderator_role?
     
      cannot :destroy, User,  admin_role: true 
      can :manage, User, superadmin: false          
      can :manage, Book
      can :manage, Comment
      can :manage, Review
    end

    if user.user_role?
      can [:update, :delete], Comment, user_id: user.id      
      can :manage, Review, user: user
    end


  end
end
