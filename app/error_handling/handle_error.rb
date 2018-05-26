module HandleError
	class Error
		class << self
			def report_errors error_message
				(Thread.current[:errors] ||= []) << "#{error_message}"
			end 
		end
	end
end