class ContractGenerator
    def initialize(schema)
      @schema = schema
    end
  
    def generate_contract
      contract = {}
      @schema.each do |column, data_type|
        contract[column] = {
          type: data_type,
          required: true, # You may want to make this configurable
          description: "Description for #{column}"
        }
      end
      contract
    end
  end