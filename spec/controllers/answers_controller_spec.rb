require 'spec_helper'

describe AnswersController do

  # This should return the minimal set of attributes required to create a valid
  # Answer. As you add validations to Answer, be sure to
  # adjust the attributes here as well.
  # valid_attributes = FactoryGirl.build(:answer).attributes
  let(:valid_attributes){
    @answer = FactoryGirl.build(:answer)
    {
    brief: @answer.brief,
    user_id: @answer.user.id,
    question_id: @answer.question.id
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AnswersController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before(:each) {
    @user = User.find(valid_attributes[:user_id])
    sign_in @user
  }

  describe "GET index" do
    it "assigns all answers as @answers" do
      answer = Answer.create! valid_attributes
      get :index, {}, valid_session
      assigns(:answers).should eq([answer])
    end
  end

  describe "GET show" do
    it "assigns the requested answer as @answer" do
      answer = Answer.create! valid_attributes
      get :show, {:id => answer.to_param}, valid_session
      assigns(:answer).should eq(answer)
    end
  end

  describe "GET new" do
    it "assigns a new answer as @answer" do
      get :new, {:question_id => valid_attributes[:question_id]}, valid_session
      assigns(:answer).should be_a_new(Answer)
    end
  end

  describe "GET edit" do
    it "assigns the requested answer as @answer" do
      answer = Answer.create! valid_attributes
      get :edit, {:id => answer.to_param}, valid_session
      assigns(:answer).should eq(answer)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Answer" do
        expect {
          post :create, :answer => valid_attributes, :question_id => valid_attributes[:question_id]
        }.to change(Answer, :count).by(1)
      end

      it "assigns a newly created answer as @answer" do
        post :create, :answer => valid_attributes, :question_id => valid_attributes[:question_id]
        assigns(:answer).should be_a(Answer)
        assigns(:answer).should be_persisted
      end

      it "redirects to the created answer's question" do
        post :create, :answer => valid_attributes, :question_id => valid_attributes[:question_id]
        response.should redirect_to(Answer.last.question)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved answer as @answer" do
        # Trigger the behavior that occurs when invalid params are submitted
        Answer.any_instance.stub(:save).and_return(false)
        post :create, {:answer => { "brief" => "invalid value" }}, valid_session
        assigns(:answer).should be_a_new(Answer)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Answer.any_instance.stub(:save).and_return(false)
        post :create, {:answer => { "brief" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested answer" do
        answer = Answer.create! valid_attributes
        # Assuming there are no other answers in the database, this
        # specifies that the Answer created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Answer.any_instance.should_receive(:update).with({ "brief" => "MyText" })
        put :update, {:id => answer.to_param, :answer => { "brief" => "MyText" }}, valid_session
      end

      it "assigns the requested answer as @answer" do
        answer = Answer.create! valid_attributes
        put :update, {:id => answer.to_param, :answer => valid_attributes}, valid_session
        assigns(:answer).should eq(answer)
      end

      it "redirects to the answer's question" do
        answer = Answer.create! valid_attributes
        put :update, {:id => answer.to_param, :answer => valid_attributes}, valid_session
        response.should redirect_to(answer.question)
      end
    end

    describe "with invalid params" do
      it "assigns the answer as @answer" do
        answer = Answer.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Answer.any_instance.stub(:save).and_return(false)
        put :update, {:id => answer.to_param, :answer => { "brief" => "invalid value" }}, valid_session
        assigns(:answer).should eq(answer)
      end

      it "re-renders the 'edit' template" do
        answer = Answer.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Answer.any_instance.stub(:save).and_return(false)
        put :update, {:id => answer.to_param, :answer => { "brief" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested answer" do
      answer = Answer.create! valid_attributes
      expect {
        delete :destroy, {:id => answer.to_param}, valid_session
      }.to change(Answer, :count).by(-1)
    end

    it "redirects to the answers list" do
      answer = Answer.create! valid_attributes
      delete :destroy, {:id => answer.to_param}, valid_session
      response.should redirect_to(answers_url)
    end
  end

end
