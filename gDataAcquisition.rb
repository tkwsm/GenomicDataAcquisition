#!/usr/bin/ruby

def getData( url, outputdir, subdir )

  STDERR.puts "Start getData"
  fname = "-"; fname_mod1 = "-"; fname_mod2 = "-";
  fname      = url.chomp.split("\/")[-1]
  fname_mod1 = fname.slice(/^(\S+).tar.gz/, 1) if fname =~ /.tar.gz/
  fname_mod2 = fname.slice(/^(\S+).gz/, 1)     if fname =~ /.gz/

  if    File.exist?( "#{outputdir}")
  else
    ` mkdir #{outputdir}`
  end

  if    File.exist?( "#{outputdir}/#{subdir}")
  else
    ` mkdir #{outputdir}/#{subdir} `
  end

  if    File.exist?( "#{outputdir}/#{subdir}/#{fname}")
  elsif File.exist?( "#{outputdir}/#{subdir}/#{fname_mod1}")
  elsif File.exist?( "#{outputdir}/#{subdir}/#{fname_mod2}")
  else
    ` wget -P "#{outputdir}/#{subdir}" "#{url}" `
  end

end

def parse_list( list4url_f, list4taxonomy_f, dir4download )

  outputdir_h = {}

  open( list4taxonomy_f ).each do |x|
    a = x.chomp.split("\t")
    data_id = a[0]
    tax_id  = a[1]
    dirname = a[2]
    outputdir_h[ data_id ] = dirname
  end

  open( list4url_f ).each do |x|
    next if x =~ /^\#/
    a = x.chomp.split("\t")
    data_id = a[1]
    url     = a[4]
    subdirname = outputdir_h[ data_id ]
    getData( url, dir4download, subdirname )
  end

end

######################################################

def  error_message_01
  print "USAGE: ruby gDataAcquisition.rb ./list4url ./list4taxonomy <db>\n"; 
  exit;
end
#######################################################

error_message_01 if ARGV.size != 3

list4url_f      = ARGV.shift
list4taxonomy_f = ARGV.shift
dir4download    = ARGV.shift

parse_list( list4url_f, list4taxonomy_f, dir4download )

