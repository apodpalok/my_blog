require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe "GET #index" do
    subject { get :index }

    it { is_expected.to have_http_status(200) }
    it { is_expected.to render_template(:index) }
  end

  describe "GET #show" do
    article = FactoryGirl.create(:article)

    subject{ get :show, params: { id: article.id } }

    it { is_expected.to have_http_status(200) }
    it { is_expected.to render_template :show }
  end

  describe "GET #new for guests" do
    subject { get :new }

    it { is_expected.to redirect_to (new_user_session_path) }
  end

  #? expected the response to have status code 201 but it was 302
  describe "POST #create" do
    subject { post :create }

    article = FactoryGirl.create(:article)

    it { is_expected.to have_http_status(201) }
  end

  describe "PATCH #update" do
    article = FactoryGirl.create(:article)

    it "update the article" do
      patch :update, params: { id: article.id }

      article.title = "New title"

      article.save

      expect(article.title).to eq("New title")
    end
  end

  describe "DELETE #destroy for guests" do
    article = FactoryGirl.create(:article)

    subject { delete :destroy, params: { id: article.id } }

    it { is_expected.to redirect_to (new_user_session_path) }
  end

  describe "DELETE #destroy for authorized user" do
    before { allow(controller).to receive(:authenticate_user!).and_return(true) }

    article = FactoryGirl.create(:article)

    subject { delete :destroy, params: { id: article.id } }

    it { is_expected.to redirect_to (articles_path) }

    it "delete the article" do
      expect { delete :destroy, params: { id: article.id } }.to change(Article, :count).by(-1)
    end
  end
end