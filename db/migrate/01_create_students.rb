# A Sequel migration is Ruby DSL for modifying the database and creating
# schema.

# You should basically read this entire guide.
# http://sequel.rubyforge.org/rdoc/files/doc/migration_rdoc.html

# Migrations are meant to be iterative. That means, if your students
# table is incomplete, do not modify this migration, but rather, create
# a new file called 02_add_profile_image_to_students.rb that will modify the students
# table to include a TEXT column for the bio.

# You could also create a migration 03_student_attributes.rb that adds the rest
# of the student attributes.

# Migrations go in two directions, up and down. When you migrate your db,
# the up method is triggered. When you rollback (reverse), the down
# method will trigger.

# Don't worry about writing down definitions, we rarely rollback a DB.
Sequel.migration do
  up do 
    create_table(:students) do
      primary_key :id
      String :name, :null=>false
      String :profile_image
      String :background_image
      String :twitter
      String :linkedin
      String :github
      String :quote
      String :bio
      String :work
      String :work_title
      String :education
      String :index_tagline
      String :index_description
      String :index_photo
    end
  end

  down do
    drop_table(:students)
  end
end