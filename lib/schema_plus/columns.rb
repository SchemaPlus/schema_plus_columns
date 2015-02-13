require 'schema_plus/core'

require_relative 'columns/version'

# Load any mixins to ActiveRecord modules, such as:
#
#require_relative 'columns/active_record/base'

# Load any middleware, such as:
#
# require_relative 'columns/middleware/model'

SchemaMonkey.register SchemaPlus::Columns
