require 'schema_plus/indexes'
require 'its-it'

require_relative 'columns/active_record/connection_adapters/column'
require_relative 'columns/middleware/model'
require_relative 'columns/version'

SchemaMonkey.register SchemaPlus::Columns
