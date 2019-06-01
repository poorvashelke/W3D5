require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    @arr ||= DBConnection.execute2("select * from #{table_name}")
    # result = @arr.first.each (&:to_sym)
    # result
    @arr.first.map(&:to_sym)
  end

  def self.finalize!
    self.columns.each do |ele|
      define_method(ele) do
        self.attributes[ele]
      end
      define_method(ele.to_s+"=") do |val|
        self.attributes[ele] = val
      end
    end
    
  end

  def self.table_name=(table_name)
    @table = table_name
  end

  def self.table_name
    @table ||= self.to_s.tableize
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

  def initialize(params = {})
    params.each do |ele, val|
      if self.class.columns.include?(ele.to_sym)
        send("#{ele}=", val)
      else
        raise "unknown attribute '#{ele}'"
      end
    end
  end


  def attributes
    @attributes ||= {}
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
