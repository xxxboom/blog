module ApplicationHelper

	def full_title(page_title)
		base_title = "Space Party"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def nav_bar
		content_tag(:ul, class: "nav navbar-nav") do
			yield
		end
	end

	def nav_link(text, path, method = 'get')
		options = current_page?(path) ? { class: "active" } : {}
		content_tag(:li, options) do
			link_to text, path, method: method
		end
	end

end
