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

     # guest user (not logged in)
    user ||= User.new
    if user.superadmin?
      can :manage, :all
      can :manage, :rails_admin      
      can :manage, :dashboard
      
    end
    
    if user.admin_role?
      can :access, :rails_admin
      can :manage, :dashboard      
      can :read, User
      can :destroy, User, {superadmin: false, admin_role: false}      
      can :edit, User, {superadmin: false, admin_role: false}
      can :create, User      
      can :manage, Book
      can :manage, Comment
      can :manage, Review
      can :manage, Author
    end

    if user.moderator_role? 
      can :manage, User, {superadmin: false, admin_role: false, moderator_role?: false}
      can :manage, Book
      can :manage, Comment
      can :manage, Review
    end

    if user.user_role?
      can :read, Author
      can :read, Book               
    end

    can :delete, Comment, user_id: user.id
    can :delete, Review, user_id: user.id
  end
end
