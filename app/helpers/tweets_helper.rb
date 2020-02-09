module TweetsHelper

	def get_relationship user_id
		relationship = Relationship.find_by_follower_id_and_followed_id(user_id, current_user.id)
		if relationship.present?
			return true
		else
			return false
		end
	end
end
