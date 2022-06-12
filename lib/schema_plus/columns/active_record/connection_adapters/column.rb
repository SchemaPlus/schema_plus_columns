# frozen_string_literal: true

module SchemaPlus::Columns
  module ActiveRecord
    module ConnectionAdapters

      #
      # SchemaPlus::Index adds several methods to Column
      #
      module Column
        # AR 6.1+ freezes the columns.  Temporary hack until I figure a better way to set the model
        def freeze
          self
        end

        attr_writer :model # model assigned set by Middleware::Model::Columns

        # Returns the list of IndexDefinition instances for each index that
        # refers to this column.  Returns an empty list if there are no
        # such indexes.
        def indexes
          @model.indexes.select{|index| index.columns.include? self.name}
        end

        # If the column is in a unique index, returns a list of names of other columns in
        # the index.  Returns an empty list if it's a single-column index.
        # Returns nil if the column is not in a unique index.
        def unique_scope
          if index = indexes.select{|i| i.unique}.sort_by{|i| i.columns.size}.first
            index.columns.reject{|name| name == self.name}
          end
        end

        # Returns true if the column is in a unique index.  See also
        # unique_scope
        def unique?
          indexes.any?{|i| i.unique}
        end

        # Returns true if the column is in one or more indexes that are
        # case sensitive.  Will raise exception if
        # IndexDefinition#case_sensitive? isn't defined, i.e. if
        # schema_plus_pg_indexes hasn't been loaded.
        def case_sensitive?
          indexes.any?{|i| i.case_sensitive?}
        end

        # The default as_jon includes all instance variables.  but
        # @model can't be dumped (it contains circular references)
        def as_json(options=nil)
          instance_values.except "model", "adapter"
        end

        # Returns the circumstance in which the column must have a value:
        #   nil     if the column may be null
        #   :save   if the column has no default value
        #   :update otherwise
        def required_on
          if null
            nil
          elsif default.nil?
            :save
          else
            :update
          end
        end
      end
    end
  end
end
