# frozen_string_literal: true
require 'json'

class Record
  attr_accessor :id, :vehicle_id, :date, :description, :mechanic, :odometer, :cost
  @@records = []
  @@json_filename = 'records.json'


  def initialize(vehicle_id, date, description, mechanic = "", odometer = 0, cost = 0)
    @id = rand(10000..99999)

    @@records << {
      :id => @id,
      :vehicle_id => vehicle_id,
      :date => date.to_i,
      :description => description,
      :mechanic => mechanic,
      :odometer => odometer,
      :cost => cost
    }

    show_message("Added record ID #{@id} for vehicle with internal ID #{vehicle_id}")
  end


  def self.search_records(vehicle_id)
    # List specific records based on vehicle ID
    unless @@records.empty?
      show_message("Now printing records matching vehicle ID# #{vehicle_id}")
      puts @@records.select { |record| record[:vehicle_id] == vehicle_id }
      # puts @@records
    end
  end


  def self.load_records
    # If a file exists, parse contents into the records array
    if File.exist?(@@json_filename)
      show_message('Records exist. Loading now')
      json_contents = JSON.parse(File.open(@@json_filename, 'r').read, :symbolize_names => true)

      json_contents.each do |record|
        puts "Record test: #{record}"
        @@records << record
      end
    else
      # If there are no stored records, let's create them.
      show_message('No records found. Generating')
      Record.new(87708, 20240129, 'Replaced Doohicky',
                 'DIY',
                 62,561)
      Record.new(15192, 20240829, 'New paint: cherry red',
                 'DIY',
                 68567)
    end
  end


  def self.save_records
    show_message('Exporting list of records to JSON')

    json_contents = JSON.pretty_generate(@@records)

    if File.write(@@json_filename, json_contents)
      show_message('Export Complete!')
    else
      show_message('Export FAILED')
    end
  end

end

