Certainly! I'd be happy to help you create an app in Ruby or Ruby on Rails to generate schemas and data contracts from existing datasets. Let's start by updating your README.md file with a brief description of the project and its goals. Then, I'll provide you with some initial steps to get started.

Here's an updated version of your README.md file:

```markdown:README.md
# Schema and Contract Generator

This Ruby/Rails application generates schemas and data contracts from existing datasets or tables. It can also check changes to datasets to determine if they are schema-breaking.

## Features

- Generate schemas from sample data (e.g., from Athena or Snowflake)
- Create data contracts based on the generated schemas
- Validate dataset changes against existing schemas
- Support for various data sources and formats

## Getting Started

// ... (We'll add installation and usage instructions later)

## Contributing

// ... (We'll add contribution guidelines later)

## License

// ... (We'll add license information later)
```

Now, let's outline the initial steps to create this application:

1. Set up a new Ruby or Rails project
2. Create a class to handle schema generation
3. Implement data contract creation
4. Add functionality to check for schema-breaking changes

Here's a basic structure to get you started:

```ruby:lib/schema_generator.rb
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
```

```ruby:lib/contract_generator.rb
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
```

```ruby:lib/schema_validator.rb
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
```

These classes provide a basic foundation for your application. You can expand on them by adding more sophisticated type inference, handling nested structures, and supporting various input formats.

To use these classes, you might create a main application file like this:

```ruby:lib/schema_contract_generator.rb
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
```

This structure allows you to easily generate schemas and contracts from sample data, as well as validate changes against existing schemas. You can expand on this foundation by adding more features, improving type inference, and handling various input formats.

Let me know if you'd like me to explain any part of this code in more detail or if you want to focus on a specific aspect of the application!