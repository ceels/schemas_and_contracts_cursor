require 'csv'

class SchemaGenerator
  def initialize(csv_content)
    @csv_content = csv_content
  end

  def generate_schema
    csv = CSV.parse(@csv_content, headers: true)
    headers = csv.headers
    sample_row = csv.first

    schema = {}
    headers.each do |header|
      schema[header] = infer_data_type(sample_row[header])
    end

    schema
  end

  private

  def infer_data_type(value)
    return 'integer' if value&.to_i.to_s == value
    return 'float' if value&.to_f.to_s == value
    return 'boolean' if ['true', 'false'].include?(value&.downcase)
    return 'date' if date?(value)
    'string'
  end

  def date?(string)
    return false if string.nil?
    Date.parse(string)
    true
  rescue ArgumentError
    false
  end
end