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

  describe "GET #new" do
    context "when user is signed_in" do
      before do
        login_user
      end

      it "render new template" do
        get :new

        expect(response).to render_template :new
      end
    end

    context "when user is not signed_in" do
      subject { get :new }

      it { is_expected.to redirect_to (new_user_session_path) }
    end
  end


  describe "POST #create" do
    let(:create_article){ post :create, params:{ article: FactoryGirl.attributes_for(:article) } }

    context "when user is signed_in" do
      before do
        login_user
      end

      it "create a new Article" do
        expect { create_article }.to change(Article, :count).by(1)
      end

      it "if instance of ArticleClass" do
        create_article
        expect(assigns(:article)).to be_a(Article)
      end

      it "redirect to article" do
        create_article
        expect(response).to redirect_to(Article.last)
      end
    end
  end

  describe "PATCH #update" do
    article = FactoryGirl.create(:article)

    it "update an article" do
      patch :update, params: { id: article.id }

      article.title = "New title"
      article.save

      expect(article.title).to eq("New title")
    end
  end

  describe "DELETE #destroy" do
    context "when user is signed_in" do
      before do
        login_user
      end

      it "delete the article" do
        article = FactoryGirl.create(:article)

        expect {
          delete :destroy, params: { id: article.id }
        }.to change(Article, :count).by(-1)
      end

      it "redirect to index_path" do
        article = FactoryGirl.create(:article)

        delete :destroy, params: { id: article.id }

        expect(response).to redirect_to(articles_path)
      end
    end

    context "when user is not signed_in" do
      article = FactoryGirl.create(:article)

      subject { delete :destroy, params: { id: article.id } }

      it { is_expected.to redirect_to (new_user_session_path) }
    end
  end
end