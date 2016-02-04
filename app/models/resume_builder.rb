class ResumeBuilder < ActiveRecord::Base
  attr_accessor :upload

  def self.save(upload)
    file_name = upload['datafile'].original_filename  if  (upload['datafile'] !='')
    file = upload['datafile'].read
    file_type = file_name.split('.').last
    if(file_type == "json")
      file_name_obj = file_name.split('.').first
      new_name_file = file_name_obj+"_"+(Time.now.to_i).to_s
      new_file_name_with_type = "#{new_name_file}." + file_type
      directory = 'public/data/resumes/'
      
      Dir.mkdir(directory) if !Dir.exists?(directory)
      File.open(directory + new_file_name_with_type, "wb")  do |f|  
  	   f.write(file) 
  	  end

  	  new_file_name_with_type
    else
      false
    end
  end

  def self.parser(filename)
  	file = File.read('public/data/resumes/'+filename)
    JSON.load(file)
  end
end