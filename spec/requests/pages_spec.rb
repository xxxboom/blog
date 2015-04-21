require 'rails_helper'
require 'spec_helper'
require 'support/utilities.rb'

describe "Pages" do

	subject { page }

	describe "Home page" do
		before { visit root_path }

		it { should have_content('CS Lucky') }
		it { should have_title(full_title('')) }
		it { should_not have_title('| Home') } 

	end

	describe "Help page" do
		before { visit help_path }

		it { should have_content('Help') }
		it { should have_title(full_title('Help')) }
	end

	describe "About page" do
		before { visit about_path }

		it { should have_content('About') }
		it { should have_title(full_title('About')) }
	end

end