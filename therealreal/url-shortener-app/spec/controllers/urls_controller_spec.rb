require 'rails_helper'

RSpec.describe UrlsController, :type => :controller do
  let(:url) { Url.create({long_url: 'http://www.foobar.com'}) }

  describe "GET index" do
    it "assigns @urls" do
      get :index
      expect(assigns(:urls)).to eq([url])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end
  
  describe "GET show" do
    it "assigns @url" do
      get :show, id: url.id
      expect(assigns(:url)).to eq(url)
    end

    it "renders the show template" do
      get :show, id: url.id
      expect(response).to render_template("show")
    end
  end
  
  describe "GET new" do
    it "assigns @url" do
      get :new
      expect(assigns(:url)).to be_a_new(Url)
    end

    it "renders the show template" do
      get :new
      expect(response).to render_template("new")
    end
  end
  
  describe "GET edit" do
    it "assigns @url" do
      get :edit, id: url.id
      expect(assigns(:url)).to eq(url)
    end

    it "renders the show template" do
      get :edit, id: url.id
      expect(response).to render_template("edit")
    end
  end
  
  describe "POST create" do
    context "when input is valid" do
      it "renders the show template" do
        params = {long_url: 'http://www.yahoo.com'}
        valid_url = Url.new(params)
        allow(Url).to receive_messages(:new => valid_url)
        
        post :create, url: params
        expect(response).to redirect_to(url_path(Url.last))
      end
    end
    
    context "when input is invalid" do
      it "render new template with error" do
        post :create, url: {long_url: 'xyz'}
        expect(response).to render_template("new")
      end
    end
  end
  
  describe "PUT update" do
    context "when input is valid" do
      it "renders the show template" do
        params = {long_url: 'http://www.xyz.com'}
        
        put :update, url: params, id: url.id
        
        url.reload
        expect(assigns(:url)).to eq(url)
        expect(url.long_url).to eq('http://www.xyz.com')
        expect(response).to redirect_to(url_path(url))
      end
    end
    
    context "when input is invalid" do
      it "render edit template with error" do
        put :update, url: {long_url: 'xyz'}, id: url.id
        expect(response).to render_template("edit")
      end
    end
  end
  
  describe "DELETE delete" do
    it "destroys url" do
      link = Url.create({long_url: 'http://www.foobar.com'})
      
      expect {
        delete :destroy, id: link.id
      }.to change(Url, :count).by(-1)
        
      expect(response).to redirect_to(urls_url)
    end
  end
  
  describe "GET redirect" do
    context "with valid key" do
      it "redirects to long_url" do
        link = Url.create({long_url: 'http://www.yahoo.com'})
        
        get :redirect, key: link.key
        expect(response).to redirect_to(link.long_url)
      end
    end
    
    context "with invalid key" do
      it "raises RecordNotFound" do
        expect {
          get :redirect, key: 'invalid key'
        }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end
end
