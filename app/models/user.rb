class User < ActiveRecord::Base
	has_many :microposts, dependent: :destroy
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed

	has_many :reverse_relationships, foreign_key: "followed_id", 
		class_name: "Relationship", dependent: :destroy

	has_many :followers, through: :reverse_relationships, source: :follower

	before_create :create_remember_token
	before_save { self.email = email.downcase }

	validates_confirmation_of :password, :message => "should match confirmation"

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, 
		format: { with: VALID_EMAIL_REGEX }, 
		uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }
	
	has_secure_password
	
	has_attached_file :avatar, :styles => { :medium => "200x200#", :thumb => "50x50#" },
		:default_url => "users/:style/default.png"
	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	#validates :avatar, :attachment_presence => true
	#validates_with AttachmentPresenceValidator, :attributes => :avatar
	validates_with AttachmentSizeValidator, :attributes => :avatar, :less_than => 2.megabytes

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def feed
		Micropost.from_users_followed_by(self)
	end

	def following?(other_user)
		relationships.find_by(followed_id: other_user.id)
	end

	def follow!(other_user)
		relationships.create!(followed_id: other_user.id)
	end

	def unfollow!(other_user)
		relationships.find_by(followed_id: other_user).destroy!
	end

	private

		def create_remember_token
			self.remember_token = User.encrypt(User.new_remember_token)
		end

end
