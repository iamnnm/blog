# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe '#index' do
    it 'return status 200' do
      get :index
      expect(response).to have_http_status(:ok)
    end

    it 'render template :index' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe '#new' do
    it 'return status 200' do
      get :new
      expect(response).to have_http_status(:ok)
    end

    it 'render template :new' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe '#create' do
    context 'with valid attributes' do
      before do
        @article = attributes_for(:article)
      end

      it 'creates an article' do
        expect {
          post :create, params: { article: @article }
        }.to change(Article, :count).by(+1)
      end

      it 'return status 302' do
        post :create, params: { article: @article }
        expect(response).to have_http_status(302)
      end

      it 'redirect to article path' do
        post :create, params: { article: @article }
        expect(response).to redirect_to 'http://test.host/articles/1'
      end
    end

    context 'with invalid attributes' do
      before do
        @article = attributes_for(:article, title: '')
      end

      it 'doesnt create an article' do
        expect {
          post :create, params: { article: @article }
        }.to change(Article, :count).by(0)
      end
    end
  end

  describe '#edit' do
    before do
      @article = build_stubbed(:article)
    end

    it 'return status 200' do
      get :edit, params: { id: @article.id }
      expect(response).to have_http_status(:ok)
    end

    it 'render template :edit' do
      get :edit, params: { id: @article.id }
      expect(response).to render_template(:edit)
    end
  end

  describe '#update' do
    context 'with valid attributes' do
      before do
        @article = create(:article, text: 'Old text')
        @article_params = attributes_for(:article, text: 'New text')
      end

      it 'update the article' do
        put :update, params: { id: @article.id, article: @article_params }
        expect(@article.reload.text).to eq('New text')
      end

      it 'return status 302' do
        put :update, params: { id: @article.id, article: @article_params }
        expect(response).to have_http_status(302)
      end

      it 'redirect to article path' do
        put :update, params: { id: @article.id, article: @article_params }
        expect(response).to redirect_to 'http://test.host/articles/1'
      end
    end

    context 'with invalid attributes' do
      before do
        @article = create(:article)
        @article_params = attributes_for(:article, text: '')
      end

      it 'doesnt update the article' do
        expect {
          put :update, params: { id: @article.id, article: @article_params }
        }.to change(Article, :count).by(0)
      end
    end
  end

  describe '#show' do
    before do
      @article = build_stubbed(:article)
    end

    it 'return status 200' do
      get :show, params: { id: @article.id }
      expect(response).to have_http_status(:ok)
    end

    it 'render template :show' do
      get :show, params: { id: @article.id }
      expect(response).to render_template(:show)
    end
  end

  describe '#destroy' do
    before do
      @article = create(:article)
    end

    it 'deletes the article' do
      expect {
        delete :destroy, params: { id: @article.id }
      }.to change(Article, :count).by(-1)
    end

    it 'return status 302' do
      delete :destroy, params: { id: @article.id }
      expect(response).to have_http_status(302)
    end

    it 'redirect to articles path' do
      delete :destroy, params: { id: @article.id }
      expect(response).to redirect_to articles_path
    end
  end
end
