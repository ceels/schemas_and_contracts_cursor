class SchemaGenerator
    def initialize(sample_data)
      @sample_data = sample_data
    end
  
    def generate_schema
      schema = {}
      @sample_data.each do |column, sample_value|
        schema[column] = infer_data_type(sample_value)
      end
      schema
    end
  
    private
  
    def infer_data_type(value)
      case value
      when Integer
        'integer'
      when Float
        'float'
      when String
        'string'
      when TrueClass, FalseClass
        'boolean'
      when Date
        'date'
      when Time, DateTime
        'datetime'
      else
        'unknown'
      end
    end
  end