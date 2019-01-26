require_relative 'db_connection'
require 'active_support/inflector'

# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject

  def self.columns
    if @columns
      @columns
    else
    @columns = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{self.table_name}
        SQL
    end

    col_symbols = []
    @columns.first.each { |name| col_symbols << name.to_sym }
    col_symbols
  end

  def self.finalize!
    columns.each do |column|
      define_method("#{column}") do
        attributes[column]
      end

      define_method("#{column}=") do |val|
        attributes[column] = val
      end  
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    # ...
    if @table_name == nil
      @table_name = self.to_s.tableize
    end

    @table_name
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params)
    params.each do |k,v|
      raise "unknown attribute: #{attr_name}" unless self.class.columns.include?(k.to_sym)
    end
    
  end

  def attributes
    @attributes ||= {}
    # ...
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
