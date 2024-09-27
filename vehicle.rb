# frozen_string_literal: true
require 'json'

class Vehicle
  attr_accessor :id, :year, :manufacturer, :model, :vin, :odometer
  @@vehicles = []
  @@json_filename = 'vehicles.json'


  def initialize(year, make, model, vin = "", odometer = 0)
    @id = rand(10000..99999)

    # Create a hash and store it in the vehicles array
    @@vehicles << {
      :id => @id,
      :year => year.to_i,
      :manufacturer => make,
      :model => model,
      :vin => vin,
      :odometer => odometer.to_i
    }

    show_message("Created #{year} #{make} #{model} with ID # #{@id}.")
  end


  def self.search_vehicles(id = nil)
      unless @@vehicles.empty?
        if id.nil?
          show_message("No vehicle ID specified. Displaying ALL vehicles.")
          puts @@vehicles
        else
          show_message("Found vehicle ID# #{id}")
          puts @@vehicles.select { |vehicle| vehicle[:id] == id }
          # puts @@vehicles
        end
      end
  end


  def self.load_vehicles
    # If a file exists, parse contents into the vehicles array
    if File.exist?(@@json_filename)
      show_message('Vehicles exist. Loading now')
      json_contents = JSON.parse(File.open(@@json_filename, 'r').read, :symbolize_names => true)

      json_contents.each do |vehicle|
        puts "Vehicle test: #{vehicle}"
        @@vehicles << vehicle
      end
    else
      # If there are no stored vehicles, let's create them.
      show_message('No vehicles found. Generating')
      Vehicle.new(2002, 'Ford', 'Ranger')
      Vehicle.new(2004, 'BMW', 'Z4')
    end
  end


  def self.save_vehicles
    show_message('Exporting list of vehicles to JSON')

    json_contents = JSON.pretty_generate(@@vehicles)

    if File.write(@@json_filename, json_contents)
      show_message('Export Complete!')
    else
      show_message('Export FAILED')
    end
  end
end
