# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Course.create(name:"UsmanHCourse")
# Hole.create(hole_number:8, is_beingEdited:false, course_id:1, user_id:1)

Hole.create(hole_number:18, is_beingEdited:false, user_id:2, course_name: "TestCourse")
UserHole.create(hole_number:18, user_id:2, hole_id:2)