class Team < ActiveRecord::Base
	belongs_to :user

	has_many :relationships

	has_many :joined_users, through: :relationships, source: :user

	default_scope -> { order('created_at DESC') }
	validates :name, presence: true, length: { maximum: 140 }
	validates :user_id, presence: true

	def owned?(other_user)
        user == other_user
    end

    def joined?(other_user)  
        relationships.find_by(user_id: other_user.id)
    end

     def join!(other_user)
        relationships.create!(user_id: other_user.id)
     end

     def quit(other_user)
            relationships.find_by(user_id: other_user.id).destroy!
     end
end
