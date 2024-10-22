require 'csv'

class DatasetsController < ApplicationController
  def index
    @datasets = Dataset.all.order(created_at: :desc)
  end

  def show
    @dataset = Dataset.find(params[:id])
    @csv_preview = generate_csv_preview if @dataset.csv_file.attached?
  end

  def new
    @dataset = Dataset.new
  end

  def create
    @dataset = Dataset.new(dataset_params)
    if @dataset.save
      generate_schema
      redirect_to @dataset, notice: 'Dataset was successfully created.'
    else
      render :new
    end
  end

  def download
    @dataset = Dataset.find(params[:id])
    send_data @dataset.csv_file.download, filename: @dataset.csv_file.filename.to_s, content_type: 'text/csv'
  end

  def download_csv
    @dataset = Dataset.find(params[:id])
    send_data @dataset.csv_file.download, filename: @dataset.csv_file.filename.to_s, content_type: 'text/csv'
  end

  def download_schema
    @dataset = Dataset.find(params[:id])
    if @dataset.schema
      send_data @dataset.schema.structure.to_json, 
                filename: "#{@dataset.name}_schema.json", 
                type: 'application/json'
    else
      redirect_to @dataset, alert: 'No schema available for this dataset.'
    end
  end

  def destroy
    @dataset = Dataset.find(params[:id])
    if @dataset.destroy
      redirect_to datasets_path, notice: 'Dataset was successfully deleted.'
    else
      redirect_to datasets_path, alert: 'Error deleting dataset.'
    end
  end

  private

  def generate_schema
    return if @dataset.csv_file.blank?

    begin
      csv_content = @dataset.csv_file.download
      schema_generator = SchemaGenerator.new(csv_content)
      schema_structure = schema_generator.generate_schema
      @dataset.create_schema(structure: schema_structure)
    rescue => e
      Rails.logger.error "Error generating schema: #{e.message}"
      # Optionally, you could set a flash message here
      # flash[:error] = "Unable to generate schema: #{e.message}"
    end
  end
  
  def dataset_params
    params.require(:dataset).permit(:name, :source, :csv_file)
  end

  def generate_csv_preview
    return nil unless @dataset.csv_file.attached?

    csv_content = @dataset.csv_file.download
    csv = CSV.parse(csv_content, headers: true)
    {
      headers: csv.headers,
      rows: csv.first(10)  # Preview first 10 rows
    }
  rescue CSV::MalformedCSVError => e
    Rails.logger.error "Error parsing CSV: #{e.message}"
    nil
  end
end
