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

#   # Search AddressBook for a specific entry by name
#   def binary_search(name)
     # #1 We save the index of the leftmost item in the array in a variable named lower, and the index of rightmost item in the array in upper
#    lower = 0
#    upper = @entries.length - 1

    # #2 We loop while our lower index is less than or equal to our upper index.
#    while lower <= upper
      # #3 We find the middle index by taking the sum of lower and upper and dividing it by two.
#      mid = (lower + upper) / 2
#      mid_name = @entries[mid].name

      # #4 We compare the name that we are searching for, name, to the name of the middle index, mid_name
#      if name == mid_name
#        return @entries[mid]
#      elsif name < mid_name
#        upper = mid - 1
#      elsif name > mid_name
#        lower = mid + 1
#      end
#    end

#     return nil
#   end

   def iterative_search(name)
     @entries.each do |existing_entry|
       if name == existing_entry.name
         return existing_entry
       end
     end

     return nil
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
