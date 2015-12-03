# #1 include AddressBook using require_relative.
require_relative '../models/address_book'

 class MenuController
   attr_accessor :address_book

   def initialize
     @address_book = AddressBook.new
   end

   def main_menu
     puts "Main Menu - #{@address_book.entries.count} entries"
     puts "1 - View all entries"
     puts "2 - Create an entry"
     puts "3 - Search for an entry"
     puts "4 - Import entries from a CSV"
     puts "5 - Search for Entry by Number"
     puts "6 - Exit"
     print "Enter your selection: "

     selection = gets.to_i
     # #7
     case selection
     when 1
       system "clear"
       view_all_entries
       main_menu
     when 2
       system "clear"
       create_entry
       main_menu
     when 3
       system "clear"
       search_entries
       main_menu
     when 4
       system "clear"
       read_csv
       main_menu
     when 5
       system "clear"
       view_entry_number
       main_menu
       puts "Good-bye!"
     when 6
       puts "Good-bye!"
 # #8
       exit(0)
 # #9
     else
       system "clear"
       puts "Sorry, that is not a valid input"
       main_menu
     end
   end
   # #10
  def view_all_entries
    # # 14 iterate through all entries in AddressBook using each.
    @address_book.entries.each do |entry|
      system "clear"
      puts entry.to_s
      # # 15 we call entry_submenu to display a submenu for each entry.
      entry_submenu(entry)
    end

    system "clear"
    puts "End of Entries"
  end

  def create_entry
    # #11 clear the screen for before displaying the create entry prompts.
    system "clear"
    puts "New AddressBloc Entry"
    # #12 use print to prompt the user for each Entry attribute. print works just like puts, except that it doesn't add a newline.
    print "Name: "
    name = gets.chomp
    print "Phone Number: "
    phone = gets.chomp
    print "Email: "
    email = gets.chomp
    # # 13 add a new entry to @address_book using add_entry to ensure that the new entry is added in the proper order.
    @address_book.add_entry(name, phone, email)

    system "clear"
    puts "New Entry Created"
  end

  def search_entries
  end

  def read_csv
  end

  def view_entry_number
    system "clear"
    puts "Welcome, Please Enter an Entry Number: "
    # remove the trailing whitespace and convert to an integer using .to_i
    selection = gets.chomp.to_i
    # Find the entry in the address book by taking the selection, calling the address book to count the number of addresses.
    if selection < @address_book.entries.count
      #If there is an entry for that number it will put that entry on the screen
      puts @address_book.entries[selection]
      puts "Press Enter to Return to the Main Menu"
      gets.chomp
      system "clear"
    else
      # If the entry is invalid because there are not that many number of entries, it will take them back to try again
      puts "#{selection} not valid input"
      puts "Press Enter to Return to the Main Menu or 1 to Try Another Entry Number"
      gets.chomp
      # I got tired of having no where to go if I typed in a wrong response so I created the below case selection.
      case selection
        when 1
          view_entry_number
          system "clear"
        else
          system "clear"
          puts "That is not a valid entry, try again"
          main_menu
      end
    end
end


  def entry_submenu(entry)
    # #16 display the submenu options.
     puts "n - next entry"
     puts "d - delete entry"
     puts "e - edit this entry"
     puts "m - return to main menu"

 # #17 chomp removes any trailing whitespace from the string gets returns. This is necessary because "m " or "m\n" won't match "m"
     selection = gets.chomp

     case selection
 # #18 when the user asks to see the next entry, we can do nothing and control will be returned to view_all_entries
     when "n"
 # #19 we'll handle deleting and editing in another checkpoint, for now the user will be shown the next entry
     when "d"
     when "e"
 # #20 we return the user to the main menu.
     when "m"
       system "clear"
       main_menu
     else
       system "clear"
       puts "#{selection} is not a valid input"
       entries_submenu(entry)
     end
   end
 end
