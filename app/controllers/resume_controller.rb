class ResumeController < ApplicationController
	def show
	    if request.method === "POST"
	    	file = ResumeBuilder.save(params[:upload])
	    	if(file)
			    data_hash = ResumeBuilder.parser(file)
			    @contact_details = data_hash["contact"]
			    @eduction_details = data_hash["education"]
			    @work_details = data_hash["work"]
			    @project_details = data_hash["projects"]
			    @language_details = data_hash["language"]
			    @skills_details = data_hash["skills"]
			else
				render plain: "Invalid file type, only json format allowed"
			end

			render template: "resume/show"
		else
			redirect_to action: 'upload'
		end
	end
end
