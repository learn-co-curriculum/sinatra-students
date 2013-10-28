# The student class inherits from Sequel Model to wrap a database table
# named students. The columns in that table become attributes of instances
# of this class.

# http://sequel.rubyforge.org/rdoc/classes/Sequel/Model.html

# Read the methods defined:
# http://sequel.rubyforge.org/rdoc/classes/Sequel/Model/ClassMethods.html
# http://sequel.rubyforge.org/rdoc/classes/Sequel/Model/InstanceMethods.html 
# http://sequel.rubyforge.org/rdoc/classes/Sequel/Dataset.html

class Student < Sequel::Model
  #  attr_accessor :name, :profile_image, :background_image, :social_media, :twitter, :linkedin, :github, :quote, :bio, :work, :work_title, :education, :index_photo, :index_description, :index_tagline
  # attr_reader :id
end
