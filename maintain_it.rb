#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'vehicle.rb'
require_relative 'record.rb'


def main
  # for testing only
  Kernel.srand(1)

  show_header('Welcome to "Maintain It" -- a vehicle maintenance tracker')

  puts "Loading sample data"
  Vehicle.load_vehicles
  Record.load_records

  puts "What about...show one specific vehicle? ID 87708"
  #Vehicle.search_vehicles(87708)

  #puts Vehicle.search_vehicles
  Record.search_records(87708)
  Record.search_records(15192)

  Vehicle.save_vehicles
  Record.save_records
end


def show_header(contents)
  divider = "=" * contents.length
  puts "#{divider}\n#{contents}\n#{divider}"
end


def show_message(contents)
  edge = "***"
  puts edge + contents + edge
end


main
