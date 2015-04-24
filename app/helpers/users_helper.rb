module UsersHelper

	def gravatar_for(user)
		gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
		gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
		image_tag(gravatar_url, alt: user.name, class: "gravatar")
	end

	# ONLY JPG AND PNG
	def avatar_for(user, size = 50)
		avatar = "users/#{user.email}"
		exts = %w[jpg png gif]
		image = "users/default.png"
		exts.each do |ext|
			if Rails.application.assets.find_asset "#{avatar}.#{ext}"
				image = avatar + "." + ext
				break
			end 
		end
		image_tag(image, alt: user.name, class: "avatar", height: "#{size}%", width: "#{size}%")
	end

end
