require "spec_helper"

describe "signing up" do
  it "allows a user to sign up for the site and creates user in database" do
    expect(User.count).to eq(0)
    visit root_path
    expect(page).to have_content("Sign Up")
    click_link("Sign Up")
    fill_in "First Name", with: "Eric"
    fill_in "Last Name", with: "Zell"
    fill_in "Email", with: "EricJZell@gmail.com"
    fill_in "Password", with: "treehouse1234"
    fill_in "Password Confirmation", with: "treehouse1234"
    click_button "Sign Up"
    expect(User.count).to eq(1)
  end
end
