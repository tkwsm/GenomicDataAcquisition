#!/usr/bin/ruby
require 'date'

def  error_message_01
  print "USAGE: ruby gDataAcquisition.rb ./list4url ./list4taxonomy\n"; exit;
end

def  error_message_02( row_number, filename )
  print "Check the row number #{row_number} in #{filename}\n"; exit;
end

def  error_message_03( row_number, filename )
  print "Check the serial number (column 1) in the row number: #{ row_number } in ./#{filename}\n"; exit;
end

def checker01( list_file, column_size )

  open( list_file ).each_with_index do |x, i|
    next if x =~ /^\#/; next if x !~ /\S/; 
    a = x.chomp.split("\t")
    error_message_02( (i+1), list_file ) if a.size != column_size 
    serial_num = a[0]
    error_message_03( (i+1), list_file ) if serial_num !~ /\d+/
  end

  STDERR.puts "checker01 is successfully done for #{list_file}."

end

########

def checker02( list_file, column_num, data_type )

  counter_i = 0

  open( list_file ).each_with_index do |x|
    next if x =~ /^\#/; next if x !~ /\S/; 
    counter_i += 1
    a = x.chomp.split("\t")
    if data_type == "serial-num"
      serial_num = a[ column_num ]
      error_message_03( counter_i, list_file ) if serial_num !~ /\d+/
    else
      STDERR.puts "please modify the correct data_type"; exit;
    end
  end

  STDERR.puts "checker02 is successfully done for #{list_file}."

end

########

#######################################################

error_message_01 if ARGV.size != 2

list4url_f      = ARGV.shift
list4taxonomy_f = ARGV.shift

checker01( list4url_f,      5 )
checker01( list4taxonomy_f, 2 )
checker02( list4url_f, 1, "serial-num" )



