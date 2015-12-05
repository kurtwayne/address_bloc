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
     puts "6 - Don't go here!"
     puts "7 - Exit"
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
     when 6
       system "clear"
       big_red_button
       main_menu
     when 7
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
    # Prompt the user for entry
    print "Search by name: "
    name = gets.chomp
    # Searches through the our iterative search for the name
    match = @address_book.iterative_search(name)
    system "clear"
    # if/else statement in case of match.  See search search_submenu for what happens when the match is made.
    if match
       puts match.to_s
       search_submenu(match)
     else
       puts "No match found for #{name}"
     end
  end

  def search_submenu(entry)
    # Prompts user for input on the searched entry.
    puts "\nd - delete entry"
    puts "e - edit this entry"
    puts "m - return to main menu"
    selection = gets.chomp
    # We use a case statement and take a specific action basked on input. On "d" and "e" we take action in seperate methods found in this menu_controller program.
    case selection
     when "d"
       system "clear"
       delete_entry(entry)
       main_menu
     when "e"
       edit_entry(entry)
       system "clear"
       main_menu
     when "m"
       system "clear"
       main_menu
     else
       system "clear"
       puts "#{selection} is not a valid input"
       puts entry.to_s
       search_submenu(entry)
     end
   end

  def read_csv
    # First, we prompt the user to enter a name of a CSV file to import.
    print "Enter CSV File to import: "
    file_name = gets.chomp
    # Second, we check to see if the file name is empty. If it is then we return the user back to the main menu.
    if file_name.empty?
      system "clear"
      puts "No CSV file read"
      main_menu
    end
    # Third, we import the specified file with import_from_csv on address_book. We then clear the screen and print the number of entries that were read from the file.
    begin # begin will protect the program from crashing if an exception is thrown.
      entry_count = @address_book.import_from_csv(file_name).count
      system "clear"
      puts "#{entry_count} new entries added from #{file_name}"
    rescue # Our begin and rescue block catches potential exceptions and handles them by printing an error message and calling import_from_csv again.
      puts "#{file_name} is not a valid CSV file, please enter the name of a valide CSV file."
      read_csv
    end
  end

  # We remove entry from address_book and print out a message to the user that says entry has been removed. Let's add the ability to edit an entry
  def delete_entry(entry)
     @address_book.entries.delete(entry)
     puts "#{entry.name} has been deleted"
   end

   def edit_entry(entry)
     # Grab the new updated entry information
     print "Updated name: "
     name = gets.chomp
     print "Updated phone number: "
     phone_number = gets.chomp
     print "Updated email: "
     email = gets.chomp
     # We use !attribute.empty? to set attributes on entry only if a valid attribute was read from user input.
     entry.name = name if !name.empty?
     entry.phone_number = phone_number if !phone_number.empty?
     entry.email = email if !email.empty?
     system "clear"
     # We then display the updated entry.
     puts "Updated entry:"
     puts entry
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

  # The detonation assignment for lesson 23.
  def big_red_button
    system "clear"
    puts "I told you not to got here. Push the button?"
    puts "y - for yes"
    puts "n - for no"
    selection = gets.chomp
    case selection
      when "y"
        button_submenu
        system "clear"
      when "n"
        system "clear"
        puts "Thank goodness"
        main_menu
      else
        system "clear"
        main_menu
    end
  end

  def button_submenu
    puts "Last chance, Bub!"
    puts "d - delete all entries"
    puts "m - return to main menu"
    selection = gets.chomp

    case selection
    when "d"
      @address_book.detonate_entries
      system "clear"
      main_menu
    when "m"
      system "clear"
      main_menu
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
       # When the user pressed "d" it will delete the entry and then return to view_all_entries.
       delete_entry(entry)
     when "e"
 # #20 we return the user to the main menu.
     # We call edit_entry when a user presses e. We then display a sub-menu with entry_submenu for the entry under edit.
      edit_entry(entry)
      entry_submenu(entry)
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
