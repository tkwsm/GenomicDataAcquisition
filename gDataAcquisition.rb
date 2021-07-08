#!/usr/bin/ruby

def getData( url, outputdir )

  STDERR.puts "Start getData"
  fname = "-"; fname_mod1 = "-"; fname_mod2 = "-";
  fname      = url.chomp.split("\/")[-1]
  fname_mod1 = fname.slice(/^(\S+).tar.gz/, 1) if fname =~ /.tar.gz/
  fname_mod2 = fname.slice(/^(\S+).gz/, 1)     if fname =~ /.gz/
  if    File.exist?( "#{outputdir}/#{fname}")
  elsif File.exist?( "#{outputdir}/#{fname_mod1}")
  elsif File.exist?( "#{outputdir}/#{fname_mod2}")
  else
    `wget -o "#{outputdir}/#{fname}" "#{url}" `
  end

end

def parse_list( list4url_f, dir4download )
  open( list4url_f ).each do |x|
    next if x =~ /^\#/
    a = x.chomp.split("\t")
    url = a[4]
    getData( url, dir4download )
  end
end

######################################################

error_message_01 if ARGV.size != 3

list4url_f      = ARGV.shift
list4taxonomy_f = ARGV.shift
dir4download    = ARGV.shift

parse_list( list4url_f, dir4download )

