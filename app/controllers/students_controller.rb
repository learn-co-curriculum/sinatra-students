# StudentsController inherits from ApplicationController
# so any settings defined there will apply to this controller.
class StudentsController < ApplicationController

  # GET '/'
  get '/' do
    # Homepage action to display the student index.
    # Load all the students into an instance variable.
    # We use the ::all method on the Student class, provided by Sequel
    @students = Student.all
    erb :'students/index' # render the index.erb within app/views/students
  end

  # lets you upload/change your profile photo
  get "/upload/:slug" do
    @s = Student[slug: params[:slug]]
    erb :'students/upload'
  end

  # changes your profile picture
  post "/upload/:slug" do 
    @s = Student[slug: params[:slug]]
    File.open('public/img/' + params['myfile'][:filename], "w") do |f|
      f.write(params['myfile'][:tempfile].read)
    end
    @s.update(profile_image: params['myfile'][:filename])
    erb :'students/show'
  end

  # Build the rest of the routes here.
  # GET '/students/new'
  get '/students/new' do
    erb :'students/new'
  end
  # POST '/students'
  post '/students' do
    s = Student.create(params)
    redirect "/upload/#{s.slug}"
  end

  # GET '/students/avi-flombaum'
  get "/students/:slug" do
    @s = Student[slug: params[:slug]]
    erb :'students/show'
  end

  # GET '/students/avi-flombaum/edit'
  get '/students/:slug/edit' do
    @s = Student[slug: params[:slug]]
    erb :'students/edit'
  end

  # POST '/students/avi-flombaum'
  post '/students/:slug' do
    s = Student[slug: params[:slug]]
    s.update(params.reject {|k, v| k == "splat" || k == "captures"})
    redirect "/students/#{s.slug}"
  end

  # GET '/students/slug/destroy'
  get '/students/:slug/destroy' do
    s = Student[slug: params[:slug]]
    s.delete
    redirect '/'
  end

end