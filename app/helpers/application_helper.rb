module ApplicationHelper

	def display_messages level
		case level
    	when 'notice' then 'alert alert-info'
      when 'success' then 'alert alert-success'
      when 'error' then 'alert alert-danger'
      when 'alert' then 'alert alert-danger'
    end
	end

end
