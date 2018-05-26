class HomeController < ApplicationController
	layout 'home'
	include HomeHelper
	before_action :redirect_to_dashboard

	def index
	end
end
