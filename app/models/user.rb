class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
         

  has_many :reviews, dependent: :destroy 
  has_many :comments, dependent: :destroy


  def username
    return email.split('@').first
  end
end
