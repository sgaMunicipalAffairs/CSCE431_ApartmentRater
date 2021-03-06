class MetricsController < ApplicationController
  before_action :set_metric, only: [:show, :edit, :update, :destroy]

  # GET /metrics
  # GET /metrics.json
  def index
    if current_user.nil?
      return redirect_to root_path, notice: 'Need to be logged in to access this page'
    elsif not current_user.is_admin
      return redirect_to root_path, notice: 'Need to be an admin to access this page'
    end
    @metrics = Metric.all

    @metric = Metric.new
  end

  # GET /metrics/1
  # GET /metrics/1.json
  def show
    redirect_to metrics_path, notice: 'All metrics can be viewed from the list'
  end

  # GET /metrics/1/edit
  def edit
    if current_user.nil?
      return redirect_to root_path, notice: 'Need to be logged in to access this page'
    elsif not current_user.is_admin
      return redirect_to root_path, notice: 'Need to be an admin to access this page'
    end
  end

  def new
    redirect_to metrics_path, notice: 'New metrics are created at the top of the page'
  end

  # POST /metrics
  # POST /metrics.json
  def create
    @metric = Metric.new(metric_params)

    respond_to do |format|
      if @metric.save
        format.html { redirect_to metrics_url, notice: 'Metric was successfully created.' }
        format.json { render :show, status: :created, location: @metric }
      else
        format.html { redirect_to metrics_url, notice: 'Metric failed to be created.'}
        format.json { render json: @metric.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /metrics/1
  # PATCH/PUT /metrics/1.json
  def update
    respond_to do |format|
      if @metric.update(metric_params)
        format.html { redirect_to metrics_url, notice: 'Metric was successfully updated.' }
        format.json { render :show, status: :ok, location: @metric }
      else
        format.html { render :edit }
        format.json { render json: @metric.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /metrics/1
  # DELETE /metrics/1.json
  def destroy
    @metric.destroy
    respond_to do |format|
      format.html { redirect_to metrics_url, notice: 'Metric was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_metric
      @metric = Metric.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def metric_params
      params.require(:metric).permit(:name)
    end
end
