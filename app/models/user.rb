class User < ActiveRecord::Base
  has_many :teams, dependent: :destroy

  has_many :relationships

  # has_many :joined_teams, through: :relationships, source: :teams
  has_many :joined_teams, :through => :relationships, :source => :team
  
	before_save { self.email = email.downcase }


  before_create :create_remember_token

	validates :name,  presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },uniqueness: { case_sensitive: false }

	validates :age, presence: true, numericality: { :greater_than => 0, :less_than => 150 }

	has_secure_password

	validates :password, length: { minimum: 6 }

	def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def feed
    Team.where("user_id = ?", id)
  end

  	private

    def create_remember_token
      self.remember_token = User.encrypt(User.new_remember_token)
    end
end
