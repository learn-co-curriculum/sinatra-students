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

  # Build the rest of the routes here.
  # GET '/students/new'
  get '/students/new' do
    erb :'students/new'
  end

  # POST '/students'
  post '/students' do
    student = Student.create(params[:student])
    redirect "/students/#{student.slug}"
  end

  # GET '/students/avi-flombaum'
  get "/students/:slug" do
    @student = Student.find(slug: params[:slug])
    erb :'students/show'
  end

  # GET '/students/avi-flombaum/edit'
  get '/students/:slug/edit' do
    @student = Student.find(slug: params[:slug])
    erb :'students/edit'
  end

  # POST '/students/avi-flombaum'
  post '/students/:slug' do
    student = Student.find(slug: params[:slug])
    student.update(params[:student])
    redirect "/students/#{student.slug}"
  end

end