#!/usr/bin/env ruby
require 'optparse'

dictionary = "/usr/share/dict/words"
OptionParser.new do |opts| #El objeto opts es el objeto Parser
  opts.banner = "Usage: anagram [ options ] word ..."
  opts.on("-d", "--dict path", String, "Path to dictionary") do |dict| #va a tener una opcion -d que requiere un arg string y el bloque es lo que hara en caso de que se establezca esta opción. 
    dictionary = dict
  end
  opts.on("-h", "--help", "Show this message") do
    puts opts #Imprimimos el objeto parser -> imprime todas las opciones disponibles usando los descriptores que pasamos como arg
    exit
  end
  begin #Bloque de manejo de excepciones que se ejecuta cuando se invoca el new
    ARGV << '-h' if ARGV.empty? #ARGV << '-h' esto añade el -h a los argumentos si estos están vacíos
    opts.parse!(ARGV) #se almacenan los argumentos
    rescue OptionParser::ParseError => e #se recupera una excepcion en caso de que hubieran errores en linea de comandos
      STDERR.puts e.message,"\n",opts
      exit(-1)
  end
end


def signature_of(word)
  word.unpack("c*").sort.pack("c*")
end

=begin
signatures = Hash.new { |h,k| h[k] = [] }
File.foreach(dictionary) do |line|
  word = line.chomp
  signature = signature_of(word)
  signatures[signature] << word
end


ARGV.each do |word|
  s = signature_of(word)
  if signatures[s].length != 0
    puts "Anagrams of '#{word}': #{signatures[s].join(', ')}"
  else
    puts "No anagrams of '#{word}' found in #{dictionary}"
  end
end
=end
