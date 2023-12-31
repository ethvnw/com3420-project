#  Test if all the pages are displayed

require "rails_helper"
require "capybara/rspec"
require "capybara/rails"

RSpec.describe "testing if all the pages are displayed" do
    
    it "should display the home page" do
        visit root_path
        expect(page).to have_content("Group 31")
    end
    it "should display the signup page" do
        visit new_user_registration_path
        expect(page).to have_content("Registration")
    end
    
    it "should display the login page" do
        visit new_user_session_path
        expect(page).to have_content("Login")
    end

    it "should display the holes page" do
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "map_creator")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit holes_path
        expect(page).to have_content("Listing Holes")
    end

    it "should display the new holes page" do
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "map_creator")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit new_hole_path
        expect(page).to have_content("New Hole")
    end

    it "should display the edit holes page" do
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "map_creator")
        UserHole.delete_all
        Hole.delete_all
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit "/holes/new"
        fill_in "Hole number", with: "1"
        fill_in "Course name", with: "TestCourse"
        click_button "Save"
        datum= Datum.create(id: 1, xCoordinates: 1, yCoordinates: 1, hole_id: 1)
        visit "/holes/1/edit"
        expect(page).to have_content("Edit Hole")
        click_button "Continue to map"
    end

    it "should display the show hole page" do
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "map_creator")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit "/holes/new"
        fill_in "Hole number", with: "1"
        fill_in "Course name", with: "TestCourse"
        click_button "Save"
        visit "/holes/2"
        expect(page).to have_content("Hole Details")
    end

    it "should display the new user holes page" do
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "user")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit new_user_hole_path
        expect(page).to have_content("Choose a Hole")
    end

    it "should display the user holes page" do
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "user")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit "/user_holes"
        expect(page).to have_content("Listing User Holes")
    end

    it "should display the show user holes page" do
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "map_creator")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit "/holes/new"
        fill_in "Hole number", with: "1"
        fill_in "Course name", with: "TestCourse"
        click_button "Save"
        visit destroy_user_session_path

        user2 = User.create(id: 12124, email: "2@gmail.com", password: "123456", user_role: "user")
        visit "/users/sign_in"
        fill_in "Email", with: "2@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit new_user_hole_path
        click_button "Create"
        visit "/user_holes/1"
        expect(page).to have_content("User Hole Details")

    end

    it "should display the edit user holes page" do
    #     # visit root_path
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "map_creator")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit "/holes/new"
        fill_in "Hole number", with: "1"
        fill_in "Course name", with: "TestCourse"
        click_button "Save"
        visit destroy_user_session_path
        user2 = User.create(id: 12124, email: "2@gmail.com", password: "123456", user_role: "user")
        visit "/users/sign_in"
        fill_in "Email", with: "2@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit new_user_hole_path
        click_button "Create"
        visit edit_user_hole_path(2)
        expect(page).to have_content("Edit Hole")
        click_button "Continue to map"
        expect(page).to have_content("Edit Hole")
    end

    it "display forgot password page" do
        visit "/users/sign_in"
        click_link "Forgot your password?"
        expect(page).to have_content "Forgot your password?"
    end

    it "display edit user page" do
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "map_creator")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit "/users/edit"
        expect(page).to have_content "Edit User"
    end

    it "should display the delete account section" do
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "user")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit "/users/edit"
        expect(page).to have_content "Delete my account"
    end

    it "should not display the delete account option" do
        user = User.create(id: 12113, email: "1@gmail.com", password: "123456", user_role: "map_creator")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit "/users/edit"
        expect(page).to have_content "You are a map creator, you cannot delete your account."
        visit destroy_user_session_path
    end

    it "download the csv file" do
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "admin")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        click_link "Download CSV"
    end

    it "should display the admin page" do
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "admin")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        expect(page).to have_content "Admin"
        click_link "Admin"
        expect(page).to have_content "Listing Users"
    end

    it "should display the edit role page for admin" do
        User.delete_all
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "admin")
        user = User.create(id: 1212, email: "2@gmail.com", password: "123456", user_role: "user")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        click_link "Admin"
        click_link "Edit"
        expect(page).to have_content "Edit User Role"
    end

    it "should be able to display user holes for admin" do
        User.delete_all
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "admin")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit "/user_holes"
        expect(page).to have_content("Listing User Holes")
    end

    it "should display user holes page for mapcreator" do
        User.delete_all
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "map_creator")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit "/user_holes"
        expect(page).to have_content("Listing User Holes")
    end

    it "should not display admin page for mapcreator or user" do
        User.delete_all
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "map_creator")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit "/admin"
        # expect root path or home page
        expect(page).to have_content("Group 31")
        expect(page).to have_content("Explore")
        visit destroy_user_session_path
        User.delete_all
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "user")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit "/admin"
        # expect root path or home page
        expect(page).to have_content("Group 31")
        expect(page).to have_content("Explore")
    end

    it "should not display holes page for user" do
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "user")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit "/holes"
        # expect root path or home page
        expect(page).to have_content("Group 31")
        expect(page).to have_content("Explore")
    end

    it "should not let user create hole" do
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "user")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit "/holes/new"
        # expect root path or home page
        expect(page).to have_content("Group 31")
        expect(page).to have_content("Explore")
    end

    it "should not let a mapcreator or user download database" do
        User.delete_all
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "map_creator")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit "/export"
        # expect root path or home page
        expect(page).to have_content("Group 31")
        expect(page).to have_content("Explore")
        visit destroy_user_session_path
        User.delete_all
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "user")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit "/export"
        # expect root path or home page
        expect(page).to have_content("Group 31")
        expect(page).to have_content("Explore")
    end

    it "should not let admin or mapcreator create userhole" do
        User.delete_all
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "map_creator")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit "/user_holes/new"
        # expect root path or home page
        expect(page).to have_content("Group 31")
        expect(page).to have_content("Explore")
        visit destroy_user_session_path
        User.delete_all
        user = User.create(id: 12123, email: "1@gmail.com", password: "123456", user_role: "admin")
        visit "/users/sign_in"
        fill_in "Email", with: "1@gmail.com"
        fill_in "Password", with: "123456"
        click_button "Login"
        visit "/user_holes/new"
        # expect root path or home page
        expect(page).to have_content("Group 31")
        expect(page).to have_content("Explore")
    end
end