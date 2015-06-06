class PagesController < ApplicationController
	def home
		if signed_in?
			@micropost = current_user.microposts.build
			@feed_items = current_user.feed.paginate(page: params[:page])
			@maxlength = Micropost.validators_on(:content).second.options[:maximum]
		end
	end

	def help

	end
	
	def about
		@cnt = User.count;
	end
end
