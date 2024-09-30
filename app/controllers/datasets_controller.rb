class DatasetsController < ApplicationController
  def index
    @datasets = Dataset.all
  end

  def show
    @dataset = Dataset.find(params[:id])
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

  def dataset_params
    params.require(:dataset).permit(:name, :source, :data_sample)
  end

  def generate_schema
    schema_generator = SchemaGenerator.new(@dataset.data_sample)
    schema_structure = schema_generator.generate_schema
    @dataset.create_schema(structure: schema_structure)
  end
end