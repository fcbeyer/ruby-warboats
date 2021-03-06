class User < ActiveRecord::Base
  
  has_many :players
  has_many :games, through: :players
  
  validates_uniqueness_of :username
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username
  
  after_create :send_welcome_mail
  def send_welcome_mail
     Notifier.welcome_email(self.email,self.username).deliver
  end
  
end
