class User < ActiveRecord::Base
  has_many :authentications
  
  EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i
  
  validates :firstname, :presence => true, :length => { :maximum => 25 }
  validates :lastname,  :presence => true, :length => { :maximum => 50 }
  validates :email, :presence => true, :length => { :maximum => 100 }, :format => EMAIL_REGEX
  # validates :password, :presence => true, :confirmation => true,:length => {:within => 8..25}
		         
  validate :sex_validation_method
  validates_date  :birthday

 def sex_validation_method
   if self.sex == ''
     errors.add(:sex, "type is required")
     return false
   end
 end
 
  def apply_omniauth(omniauth_hash)
    if (omniauth_hash["provider"].downcase.eql?("facebook"))
       self.email      = omniauth_hash['info']['email'] if email.blank?
       self.firstname  = omniauth_hash['info']['first_name'] if firstname.blank?
       self.lastname   = omniauth_hash['info']['last_name'] if lastname.blank?
       # gender = omniauth_hash['extra']['raw_info']['gender']
       #omniauth_hash['extra']['raw_info']['gender']
       if (omniauth_hash['extra']['raw_info']['gender'].downcase.eql?("male"))
         self.sex = '1'
       else 
         self.sex = '0'
       end
       #self.birthday = Date.strptime(omniauth_hash.fetch('extra', {}).fetch('user_hash', {})['birthday'],'%m/%d/%Y') if omniauth_hash.fetch('extra', {}).fetch('user_hash', {})['birthday']
       self.birthday = Date.strptime(omniauth_hash['extra']['raw_info']['birthday'],'%m/%d/%Y')
      # self.email = omniauth_hash['info']['email'] if email.blank?
      # self.firstname = omniauth_hash['info']['first_name'] if firstname.blank?
      # self.lastname = omniauth_hash['info']['last_name'] if lastname.blank?
      # self.birthday = omniauth_hash['info']['birthday'] if birthday.blank?
      authentications.build(:provider => omniauth_hash['provider'], :uid => omniauth_hash['uid'])
    end
  end
  
  def password_required?
    (authentications.empty? || !password.blank?) && super
  end  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :lastname, :sex, :birthday, :age, :occupation
end
