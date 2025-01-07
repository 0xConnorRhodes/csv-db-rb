require 'csv'
require 'import_csv'

class Csvdb
  def initialize(file)
    @db_file = file
    @data = import_csv(@db_file)
  end

  def read
    @data
  end

  def merge(new_data)
    new_data.each do |datum|
      existing_record = @data.find { |item| 
        item[:manufacturer] == datum[:manufacturer] && 
        item[:model] == datum[:model] 
      }

      if existing_record
        # Merge the new data with existing record
        existing_record.merge!(datum)
      else
        # Add as new record if no match found
        @data << datum
      end
    end
    @data
  end

  def write(data)
    data = normalize_data(data)
    CSV.open(@db_file, 'w') do |csv|
      # Write headers first
      csv << data.first.keys
    
      # Write each row of data
      data.each do |row|
        csv << row.values
      end
    end
  end

  private

  def normalize_data(data)
    # Get all possible keys from all hashes
    all_keys = data.map(&:keys).flatten.uniq

    # Ensure each hash has all keys
    data.map do |hash|
      all_keys.each_with_object({}) do |key, new_hash|
        new_hash[key] = hash[key]
      end
    end
  end
end
