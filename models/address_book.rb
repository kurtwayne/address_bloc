require_relative 'entry'

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
