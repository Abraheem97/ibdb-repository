class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
         

  has_many :reviews, dependent: :destroy 
  has_many :comments, dependent: :destroy

  has_attached_file :avatar, styles: { medium: "100x100>", thumb: "59x59>" }, default_url: "/assets/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/


  def username
    return email.split('@').first
  end
end
