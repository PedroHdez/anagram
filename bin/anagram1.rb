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
  word.unpack("c*").sort.pack("c*") #desempaquetar la cadena segun el formato especificado, en este caso en caracteres
end

signatures = Hash.new { |h,k| h[k] = [] } #creamos un hash tal que cada elemento del hash, si no está inicializado, se crea como se indica
File.foreach(dictionary) do |line|
  word = line.chomp #Quita el ultimo caracter solo si es el separador de linea (retorno de carro por defecto)
  signature = signature_of(word)
  signatures[signature] << word #añadimos la palabra a su hash
end


ARGV.each do |word| #Todas las palabras restantes de la linea de comandos
  s = signature_of(word)
  if signatures[s].length != 0
    puts "Anagrams of '#{word}': #{signatures[s].join(', ')}" #Une las coincidencias por una , y un espacio
  else
    puts "No anagrams of '#{word}' found in #{dictionary}"
  end
end
