# frozen_string_literal: true

require 'spec_helper'

describe "Column" do

  before(:all) do
      class User < ::ActiveRecord::Base ; end
  end

  let(:migration) { ::ActiveRecord::Migration }

  context "JSON serialization" do
    before(:each) do
      create_table(User, :login => { :index => true})
      @login = User.columns.find{|column| column.name == "login"}
    end
    it "works properly" do
      type = case
             when SchemaDev::Rspec::Helpers.mysql?
               { "sql_type" => "varchar(255)" }
             when SchemaDev::Rspec::Helpers.postgresql?
               { "sql_type" => "character varying" }
             when SchemaDev::Rspec::Helpers.sqlite3?
               { "sql_type" => "varchar" }
             end
      expect(JSON.parse(@login.to_json)).to include(
        "name" => "login",
        "sql_type_metadata" => a_hash_including(type)
      )
    end
  end

  context "regarding indexes" do

    context "if not unique" do

      before(:each) do
        create_table(User, :login => { :index => true})
        @login = User.columns.find{|column| column.name == "login"}
      end

      it "should report not unique" do
        expect(@login).not_to be_unique
      end

      it "should report nil unique scope" do
        create_table(User, :login => { :index => true})
        expect(@login.unique_scope).to be_nil
      end
    end

    context "if unique single column" do
      before(:each) do
        create_table(User, :login => { :index => :unique})
        @login = User.columns.find{|column| column.name == "login"}
      end

      it "should report unique" do
        expect(@login).to be_unique
      end

      it "should report an empty unique scope" do
        expect(@login.unique_scope).to eq([])
      end
    end

    context "if unique multicolumn" do

      before(:each) do
        create_table(User, :first => {}, :middle => {}, :last => { :index => {:with => [:first, :middle], :unique => true}})
        @first = User.columns.find{|column| column.name == "first"}
        @middle = User.columns.find{|column| column.name == "middle"}
        @last = User.columns.find{|column| column.name == "last"}
      end

      it "should report unique for each" do
        expect(@first).to be_unique
        expect(@middle).to be_unique
        expect(@last).to be_unique
      end

      it "should report unique scope for each" do
        expect(@first.unique_scope).to match_array(%W[middle last])
        expect(@middle.unique_scope).to match_array(%W[first last])
        expect(@last.unique_scope).to match_array(%W[first middle])
      end
    end

    context "with case insensitive" do
      before(:each) do
        create_table(User, :login => { :index => {}})
        User.reset_column_information
        @column = User.columns.find { |it| it.name == "login" }
      end

      context "index", :mysql => :skip do

        it "reports column as case insensitive" do
          allow(User.indexes.first).to receive(:case_sensitive?).and_return(false);
          expect(@column).not_to be_case_sensitive
        end
      end

      context "database", :mysql => :only do

        # make sure we haven't broken mysql's method
        it "reports column as case insensitive" do
          allow(migration).to receive(:collation).and_return("utf8_unicode_ci") # mysql determines case insensitivity its own way
          expect(@column).not_to be_case_sensitive
        end
      end
    end

  end

  context "regarding when it requires a value" do

    it "not required if the column can be null" do
      create_table(User, :login => { :null => true})
      expect(User.columns.find{|column| column.name == "login"}.required_on).to be_nil
    end

    it "must have a value on :save if there's no default" do
      create_table(User, :login => { :null => false })
      expect(User.columns.find{|column| column.name == "login"}.required_on).to eq(:save)
    end

    it "must have a value on :update if there's default" do
      create_table(User, :login => { :null => false, :default => "foo" })
      expect(User.columns.find{|column| column.name == "login"}.required_on).to eq(:update)
    end

  end

  context "Postgresql array", :postgresql => :only do

    before(:each) do
      create_table(User, :alpha => { :default => [], :array => true })
    end

    it "respects array: true" do
      column = User.columns.find { |it| it.name == "alpha" }
      expect(column.array).to be_truthy
    end
  end

  protected

  def create_table(model, columns_with_options)
    migration.suppress_messages do
      migration.create_table model.table_name, :force => :cascade do |t|
        columns_with_options.each_pair do |column, options|
          t.string column, **options
        end
      end
      model.reset_column_information
    end
  end

end
