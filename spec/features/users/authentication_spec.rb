require "spec_helper"

describe "logging in" do
  it "logs the user in and redirects to todo lists" do
    User.create(
      first_name: "Eric", last_name: "Zell", email: "ericjzell@gmail.com",
      password: "password1", password_confirmation: "password1"
    )
    visit new_user_session_path
    fill_in "Email", with: "ericjzell@gmail.com"
    fill_in "Password", with: "password1"
    click_button "Log In"
    expect(page).to have_content("Todo Lists")
    expect(page).to have_content("Thanks for logging in")

  end
  it "displays the email address in event of a failed loggin" do
    visit new_user_session_path
    fill_in "Email", with: "ericjzell@gmail.com"
    fill_in "Password", with: "incorrecto"
    click_button "Log In"
    expect(page).to have_content("There was a problem logging in. Please check your email and password.")
    expect(page).to have_field("Email", with: "ericjzell@gmail.com")
  end
end
