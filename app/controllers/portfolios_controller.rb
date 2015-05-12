class PortfoliosController < ApplicationController
  # before_action :set_portfolio, only: [:show, :edit, :update, :destroy]
    protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!
  # GET /portfolios
  # GET /portfolios.json
  def index
    @portfolios = current_user.portfolios
      authorize @portfolios
  end

  # GET /portfolios/1
  # GET /portfolios/1.json
  def show
    @portfolio = Portfolio.find(params[:id])
    @stocks = YahooFinance.quotes([@portfolio.stocks.group_by(&:stock_symbol)], [:ask, :bid], { raw: false } )


    # @stocks = @portfolio.stocks.group_by(&:stock_symbol)
    
    # @stocks = YahooFinance.quotes(["AAPL"], [:ask], { raw: false } )
    @stock = Stock.new
    @stock.portfolio_id = @portfolio.id
  end

  # GET /portfolios/new
  def new
    @portfolio = Portfolio.new
      authorize @portfolio
  end

  # GET /portfolios/1/edit
  def edit
    @portfolio = Portfolio.find(params[:id])
      authorize @portfolio
  end

  # POST /portfolios
  # POST /portfolios.json
  def create
    @portfolio = Portfolio.new(portfolio_params)
    @portfolio.user = current_user
    @portfolio.save
    redirect_to portfolios_path
  end

  # PATCH/PUT /portfolios/1
  # PATCH/PUT /portfolios/1.json
  def update
    @portfolio = Portfolio.new(portfolio_params)
      authorize @portfolio
    respond_to do |format|
      if @portfolio.update(portfolio_params)
        format.html { redirect_to @portfolio, notice: 'Portfolio was successfully updated.' }
        format.json { render :show, status: :ok, location: @portfolio }
      else
        format.html { render :edit }
        format.json { render json: @portfolio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /portfolios/1
  # DELETE /portfolios/1.json
  def destroy
    @portfolio.destroy
    respond_to do |format|
      format.html { redirect_to portfolios_url, notice: 'Portfolio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_portfolio
      @portfolio = Portfolio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def portfolio_params
      params.require(:portfolio).permit(:name, :user_id)
    end

    def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:name, :username, :email, :password, :password_confirmation, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :username, :email, :password, :password_confirmation, :current_password) }
  end
end
