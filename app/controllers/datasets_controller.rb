class DatasetsController < ApplicationController
  def index
    @datasets = Dataset.all
  end

  def show
    @dataset = Dataset.find(params[:id])
    generate_schema if @dataset.schema.nil?
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

  def generate_schema
    return if @dataset.csv_file.blank?

    csv_content = @dataset.csv_file.download
    schema_generator = SchemaGenerator.new(csv_content)
    schema_structure = schema_generator.generate_schema
    @dataset.create_schema(structure: schema_structure)
  end
end