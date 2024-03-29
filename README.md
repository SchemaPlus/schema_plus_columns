[![Gem Version](https://badge.fury.io/rb/schema_plus_columns.svg)](http://badge.fury.io/rb/schema_plus_columns)
[![Build Status](https://github.com/SchemaPlus/schema_plus_columns/actions/workflows/pr.yml/badge.svg)](http://github.com/SchemaPlus/schema_plus_columns/actions)
[![Coverage Status](https://coveralls.io/github/SchemaPlus/schema_plus_columns/badge.svg)](https://coveralls.io/github/SchemaPlus/schema_plus_columns)

# SchemaPlus::Columns

SchemaPlus::Columns adds some useful accessors the objects returned by ActiveRecord's [`Model.columns`](http://api.rubyonrails.org/classes/ActiveRecord/ConnectionAdapters/PostgreSQL/SchemaStatements.html#method-i-columns) database introspection query.

SchemaPlus::Columns is part of the [SchemaPlus](https://github.com/SchemaPlus/) family of Ruby on Rails extension gems.

## Installation

<!-- SCHEMA_DEV: TEMPLATE INSTALLATION - begin -->
<!-- These lines are auto-inserted from a schema_dev template -->
As usual:

```ruby
gem "schema_plus_columns"                # in a Gemfile
gem.add_dependency "schema_plus_columns" # in a .gemspec
```

<!-- SCHEMA_DEV: TEMPLATE INSTALLATION - end -->

## Usage

SchemaPlus::Columns makes these accessors available:

#### `column.indexes`

Returns a list of index definitions for each index that refers to this column.  Returns an empty list if there are no such indexes.

#### `column.unique?`

Returns true if the column is in a unique index.

#### `column.unique_scope`

If the column is in a unique index, returns a list of names of other columns in the index.  Returns an empty list if it's a single-column index. Returns nil if the column is not in a unique index.

#### `column.case_sensitive?`

Returns true if the column is in one or more indexes that are case sensitive.  *Requires the index definitions to respond to `:case_sensitive?`* -- i.e. Only works with `schema_plus_pg_indexes` having been loaded.

#### `column.required_on`

Returns an indicator of the circumstance in which the column must have a value:

* `nil` If the column may be null
* `:save` If the column has no default value
* `:update` Otherwise


## Compatibility

SchemaPlus::Columns is tested on:

<!-- SCHEMA_DEV: MATRIX - begin -->
<!-- These lines are auto-generated by schema_dev based on schema_dev.yml -->
* ruby **2.5** with activerecord **5.2**, using **mysql2**, **sqlite3** or **postgresql:9.6**
* ruby **2.5** with activerecord **6.0**, using **mysql2**, **sqlite3** or **postgresql:9.6**
* ruby **2.5** with activerecord **6.1**, using **mysql2**, **sqlite3** or **postgresql:9.6**
* ruby **2.7** with activerecord **5.2**, using **mysql2**, **sqlite3** or **postgresql:9.6**
* ruby **2.7** with activerecord **6.0**, using **mysql2**, **sqlite3** or **postgresql:9.6**
* ruby **2.7** with activerecord **6.1**, using **mysql2**, **sqlite3** or **postgresql:9.6**
* ruby **2.7** with activerecord **7.0**, using **mysql2**, **sqlite3** or **postgresql:9.6**
* ruby **3.0** with activerecord **6.0**, using **mysql2**, **sqlite3** or **postgresql:9.6**
* ruby **3.0** with activerecord **6.1**, using **mysql2**, **sqlite3** or **postgresql:9.6**
* ruby **3.0** with activerecord **7.0**, using **mysql2**, **sqlite3** or **postgresql:9.6**
* ruby **3.1** with activerecord **6.0**, using **mysql2**, **sqlite3** or **postgresql:9.6**
* ruby **3.1** with activerecord **6.1**, using **mysql2**, **sqlite3** or **postgresql:9.6**
* ruby **3.1** with activerecord **7.0**, using **mysql2**, **sqlite3** or **postgresql:9.6**

<!-- SCHEMA_DEV: MATRIX - end -->


## Release Notes

* **1.0.1** - Add AR 6.1 and 7.0, also add Ruby 3.1 support
* **1.0.0** - Add AR 6, Drop AR < 5.2, Drop Ruby < 2.5, add Ruby 3.0
* **0.3.0** - AR 5.2
* **0.2.0** - AR 5.1 Support
* **0.1.3** - AR 5.0 Support
* **0.1.2** - Missing require
* **0.1.1** - Explicit gem dependencies
* **0.1.0** - Initial release, extracted from SchemaPlus 1.x

## Development & Testing

Are you interested in contributing to SchemaPlus::Columns?  Thanks!  Please follow
the standard protocol: fork, feature branch, develop, push, and issue pull
request.

Some things to know about to help you develop and test:

<!-- SCHEMA_DEV: TEMPLATE USES SCHEMA_DEV - begin -->
<!-- These lines are auto-inserted from a schema_dev template -->
* **schema_dev**:  SchemaPlus::Columns uses [schema_dev](https://github.com/SchemaPlus/schema_dev) to
  facilitate running rspec tests on the matrix of ruby, activerecord, and database
  versions that the gem supports, both locally and on
  [github actions](https://github.com/SchemaPlus/schema_plus_columns/actions)

  To to run rspec locally on the full matrix, do:

        $ schema_dev bundle install
        $ schema_dev rspec

  You can also run on just one configuration at a time;  For info, see `schema_dev --help` or the [schema_dev](https://github.com/SchemaPlus/schema_dev) README.

  The matrix of configurations is specified in `schema_dev.yml` in
  the project root.

<!-- SCHEMA_DEV: TEMPLATE USES SCHEMA_DEV - end -->

<!-- SCHEMA_DEV: TEMPLATE USES SCHEMA_PLUS_CORE - begin -->
<!-- These lines are auto-inserted from a schema_dev template -->
* **schema_plus_core**: SchemaPlus::Columns uses the SchemaPlus::Core API that
  provides middleware callback stacks to make it easy to extend
  ActiveRecord's behavior.  If that API is missing something you need for
  your contribution, please head over to
  [schema_plus_core](https://github.com/SchemaPlus/schema_plus_core) and open
  an issue or pull request.

<!-- SCHEMA_DEV: TEMPLATE USES SCHEMA_PLUS_CORE - end -->

<!-- SCHEMA_DEV: TEMPLATE USES SCHEMA_MONKEY - begin -->
<!-- These lines are auto-inserted from a schema_dev template -->
* **schema_monkey**: SchemaPlus::Columns is implemented as a
  [schema_monkey](https://github.com/SchemaPlus/schema_monkey) client,
  using [schema_monkey](https://github.com/SchemaPlus/schema_monkey)'s
  convention-based protocols for extending ActiveRecord and using middleware stacks.

<!-- SCHEMA_DEV: TEMPLATE USES SCHEMA_MONKEY - end -->
