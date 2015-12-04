require_relative 'entry'
require "csv"

class AddressBook
   attr_accessor :entries

   def initialize
     @entries = []
   end

   def add_entry(name, phone_number, email)
     # 1. create a new entry
     new_entry = Entry.new(name, phone_number, email)
     # 2. check to make sure entry does not already exist
     @entries.each do |existing_entry|
       return if existing_entry.name == new_entry.name
     end
     # 3. add entry to entries array
     @entries << new_entry
   end

   def import_from_csv(file_name)
     # we defined import_from_csv. The method starts by reading the file, using File.read.
     csv_text = File.read(file_name)
     # The file will be in a CSV format. We use the CSV class to parse the file. The result of CSV.parse is an object of type CSV::Table.
     csv = CSV.parse(csv_text, headers: true, skip_blanks: true)
     # we iterate over the CSV::Table object's rows. On the next line we create a hash for each row. We convert each row_hash to an Entry by using the add_entry method which will also add the Entry to the AddressBook's entries.
     csv.each do |row|
       row_hash = row.to_hash
       add_entry(row_hash["name"], row_hash["phone_number"], row_hash["email"])
     end
   end

   def remove_entry(name, phone_number, email)
     # 1. find the index, if any, where we have a matching entry
     # 2. if index exists, delete it
     @entries.each_with_index do |existing_entry, index|
       if name == existing_entry.name
         @entries.delete_at(index)
         break
       end
     end
   end
 end
