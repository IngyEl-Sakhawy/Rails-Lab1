class ArticlesController < ApplicationController
  # before_action :authenticate_user!, except: [:index, :show]
  load_and_authorize_resource 

  def index
    @articles = []
    users = User.all.includes(:articles) 

    users.each do |user|
      last_three_articles = user.articles.where.not(status: 'archived').order(created_at: :desc).limit(3) 
      @articles += last_three_articles if last_three_articles.present?
    end
  end

  def show
    @article = Article.find(params[:id])
  
    if @article.public? || !user_signed_in? || @article.user == current_user
      
    else
      
      authorize! :read, @article
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.build(article_params)

    if @article.save
      
      redirect_to @article
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
    authorize! :edit, @article
  end

  def update
    @article = Article.find(params[:id])
    authorize! :update, @article

    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    authorize! :destroy, @article

    @article.destroy
    redirect_to root_path, status: :see_other
  end
  
  private

  def article_params
    params.require(:article).permit(:title, :body, :status, :image)
  end
end
