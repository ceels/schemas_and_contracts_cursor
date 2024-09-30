class SchemasController < ApplicationController
  def show
    @dataset = Dataset.find(params[:dataset_id])
    @schema = @dataset.schema
  end
end