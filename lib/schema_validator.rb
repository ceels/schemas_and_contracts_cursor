class SchemaValidator
    def initialize(existing_schema)
      @existing_schema = existing_schema
    end
  
    def validate_changes(new_sample_data)
      new_schema = SchemaGenerator.new(new_sample_data).generate_schema
      breaking_changes = {}
  
      @existing_schema.each do |column, data_type|
        if new_schema[column] != data_type
          breaking_changes[column] = {
            old_type: data_type,
            new_type: new_schema[column]
          }
        end
      end
  
      new_schema.keys.each do |column|
        unless @existing_schema.key?(column)
          breaking_changes[column] = {
            old_type: nil,
            new_type: new_schema[column]
          }
        end
      end
  
      breaking_changes
    end
  end