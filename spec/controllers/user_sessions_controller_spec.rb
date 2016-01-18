require 'spec_helper'

describe UserSessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "renders the new template" do
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe "POST 'create'" do
    context "with correct credentials" do
      let!(:user) {
        User.create(first_name: "Eric", last_name: "Zell", email: "EricJZell@gmail.com",
          password: "treehouse1234", password_confirmation: "treehouse1234"
        )
      }
      it "redirects to the todo list path" do
        post :create, email: "EricJZell@gmail.com", password: "treehouse1234"
        expect(response).to be_redirect
        expect(response).to redirect_to(todo_lists_path)
      end

      it "finds the user" do
        expect(User).to receive(:find_by).with(email: "ericjzell@gmail.com").and_return(user)
        post :create, email: "EricJZell@gmail.com", password: "treehouse1234"
      end

      it "authenticates the user" do
        User.stub(:find_by).and_return(user)
        expect(user).to receive(:authenticate)
        post :create, email: "EricJZell@gmail.com", password: "treehouse1234"
      end
    end
  end

end
