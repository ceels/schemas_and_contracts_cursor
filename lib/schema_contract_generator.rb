require_relative 'schema_generator'
require_relative 'contract_generator'
require_relative 'schema_validator'

class SchemaContractGenerator
  def self.generate_from_sample(sample_data)
    schema = SchemaGenerator.new(sample_data).generate_schema
    contract = ContractGenerator.new(schema).generate_contract
    
    {
      schema: schema,
      contract: contract
    }
  end

  def self.validate_changes(existing_schema, new_sample_data)
    SchemaValidator.new(existing_schema).validate_changes(new_sample_data)
  end
end