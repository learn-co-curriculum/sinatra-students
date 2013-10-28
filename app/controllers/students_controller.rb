# StudentsController inherits from ApplicationController
# so any settings defined there will apply to this controller.
class StudentsController < ApplicationController

  # GET '/'
  get '/' do
    @students = Student.all
    erb :'students/index' 
  end

  get '/students' do
    @students = Student.all
    erb :'students/index' 
  end

  get '/students/new' do
   erb :'students/new'
  end

  post '/students/new' do
    student = Student.create(:name => params[:name])
    student.profile_image  = params[:profile_image]
    student.background_image  = params[:background_image]
    student.twitter  = params[:twitter]
    student.linkedin  = params[:linkedin]
    student.github  = params[:github]
    student.quote  = params[:quote]
    student.bio  = params[:bio]
    student.work  = params[:work]
    student.work_title  = params[:work_title]
    student.education  = params[:education]
    student.index_tagline  = params[:index_tagline]
    student.index_description  = params[:index_description]
    student.index_photo = params[:index_photo]
    student.save
    redirect to '/students' 
  end


  get '/students/:name' do
    @student = Student[:name=>(params[:name].gsub!("_"," ").split(" ").map(&:capitalize).join(" "))]
    erb :'students/student'
  end

  get '/students/:name/edit' do
    @student = Student[:name=>(params[:name].gsub!("_"," ").split(" ").map(&:capitalize).join(" "))]
    erb :'students/edit'
  end

  post '/students/:name/edit' do
    student = Student[:name=>(params[:name].gsub!("_"," ").split(" ").map(&:capitalize).join(" "))]
    student.profile_image  = params[:profile_image]
    student.background_image  = params[:background_image]
    student.twitter  = params[:twitter]
    student.linkedin  = params[:linkedin]
    student.github  = params[:github]
    student.quote  = params[:quote]
    student.bio  = params[:bio]
    student.work  = params[:work]
    student.work_title  = params[:work_title]
    student.education  = params[:education]
    student.index_tagline  = params[:index_tagline]
    student.index_description  = params[:index_description]
    student.index_photo = params[:index_photo]
    student.save
    redirect to '/students' 
  end
end
 

  # POST '/students'
