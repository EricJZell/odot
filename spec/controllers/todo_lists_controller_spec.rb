require 'spec_helper'

describe TodoListsController do

  let(:valid_attributes) { { "title" => "MyString", "description" => "My Todo List" } }

  let(:valid_session) { {} }
  let!(:user) { create(:user) }

  context "logged out" do
    it "requires the user to log in" do
      get :index, {}, valid_session
      expect(response).to be_redirect
      expect(response).to redirect_to(new_user_session_path)
    end
  end

  context "logged in" do
    before do
      sign_in(user)
    end

    describe "GET index" do
      it "assigns all todo_lists as @todo_lists" do
        todo_list = user.todo_lists.create! valid_attributes
        get :index, {}, valid_session
        assigns(:todo_lists).should eq([todo_list])
        expect(assigns(:todo_lists).map(&:user)).to eq([user])
      end

      it "does not load other user's todo lists" do
        other_todo_list = TodoList.create!(valid_attributes.merge(user_id: create(:user)))
        get :index, {}, valid_session
        expect(assigns(:todo_lists)).to_not include(other_todo_list)
      end
    end

    describe "GET show" do
      it "assigns the requested todo_list as @todo_list" do
        todo_list = user.todo_lists.create! valid_attributes
        get :show, {:id => todo_list.to_param}, valid_session
        assigns(:todo_list).should eq(todo_list)
      end
    end

    describe "GET new" do
      it "assigns a new todo_list as @todo_list" do
        get :new, {}, valid_session
        assigns(:todo_list).should be_a_new(TodoList)
      end
    end

    describe "GET edit" do
      it "assigns the requested todo_list as @todo_list" do
        todo_list = user.todo_lists.create! valid_attributes
        get :edit, {:id => todo_list.to_param}, valid_session
        assigns(:todo_list).should eq(todo_list)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new TodoList" do
          expect {
            post :create, {:todo_list => valid_attributes}, valid_session
          }.to change(TodoList, :count).by(1)
        end

        it "assigns a newly created todo_list as @todo_list" do
          post :create, {:todo_list => valid_attributes}, valid_session
          assigns(:todo_list).should be_a(TodoList)
          assigns(:todo_list).should be_persisted
        end

        it "redirects to the created todo_list" do
          post :create, {:todo_list => valid_attributes}, valid_session
          response.should redirect_to(TodoList.last)
        end

        it "creates a todo list for the current user" do
          post :create, {:todo_list => valid_attributes}, valid_session
          todo_list = TodoList.last
          expect(todo_list.user).to eq(user)
        end

        it "does not allow users to create todo_lists for other users" do
          other_user = create(:user)
          post :create, {:todo_list => valid_attributes.merge(user_id: other_user.id)}, valid_session
          todo_list = TodoList.last
          expect(todo_list.user).to eq(user)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved todo_list as @todo_list" do
          # Trigger the behavior that occurs when invalid params are submitted
          TodoList.any_instance.stub(:save).and_return(false)
          post :create, {:todo_list => { "title" => "invalid value" }}, valid_session
          assigns(:todo_list).should be_a_new(TodoList)
        end

        it "re-renders the 'new' template" do
          # Trigger the behavior that occurs when invalid params are submitted
          TodoList.any_instance.stub(:save).and_return(false)
          post :create, {:todo_list => { "title" => "invalid value" }}, valid_session
          response.should render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "updates the requested todo_list" do
          todo_list = user.todo_lists.create! valid_attributes
          TodoList.any_instance.should_receive(:update).with({ "title" => "MyString" })
          put :update, {:id => todo_list.to_param, :todo_list => { "title" => "MyString" }}, valid_session
        end

        it "assigns the requested todo_list as @todo_list" do
          todo_list = user.todo_lists.create! valid_attributes
          put :update, {:id => todo_list.to_param, :todo_list => valid_attributes}, valid_session
          assigns(:todo_list).should eq(todo_list)
        end

        it "redirects to the todo_list" do
          todo_list = user.todo_lists.create! valid_attributes
          put :update, {:id => todo_list.to_param, :todo_list => valid_attributes}, valid_session
          response.should redirect_to(todo_list)
        end
      end

      describe "with invalid params" do
        it "assigns the todo_list as @todo_list" do
          todo_list = user.todo_lists.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          TodoList.any_instance.stub(:save).and_return(false)
          put :update, {:id => todo_list.to_param, :todo_list => { "title" => "invalid value" }}, valid_session
          assigns(:todo_list).should eq(todo_list)
        end

        it "re-renders the 'edit' template" do
          todo_list = user.todo_lists.create! valid_attributes
          # Trigger the behavior that occurs when invalid params are submitted
          TodoList.any_instance.stub(:save).and_return(false)
          put :update, {:id => todo_list.to_param, :todo_list => { "title" => "invalid value" }}, valid_session
          response.should render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested todo_list" do
        todo_list = user.todo_lists.create! valid_attributes
        expect {
          delete :destroy, {:id => todo_list.to_param}, valid_session
        }.to change(TodoList, :count).by(-1)
      end

      it "redirects to the todo_lists list" do
        todo_list = user.todo_lists.create! valid_attributes
        delete :destroy, {:id => todo_list.to_param}, valid_session
        response.should redirect_to(todo_lists_url)
      end
    end
  end

end
