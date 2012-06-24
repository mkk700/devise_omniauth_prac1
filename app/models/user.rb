class User < ActiveRecord::Base
  has_many :authentications
  
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  
  validates :firstname, :presence => true, :length => { :maximum => 25 }
  validates :lastname,  :presence => true, :length => { :maximum => 50 }
  validates :email, :presence => true, :length => { :maximum => 100 }, :format => EMAIL_REGEX
  validates :password, :presence => true, :confirmation => true,:length => {:within => 8..25}
		         
  validate :sex_validation_method
  validates_date  :birthday

 def sex_validation_method
   if self.sex == ''
     errors.add(:sex, "type is required")
     return false
   end
 end
 
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable#, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :lastname, :sex, :birthday, :age, :occupation
end
