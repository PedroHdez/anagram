#---
# Excerpted from "Programming Ruby",
# published by The Pragmatic Bookshelf.
# Copyrights apply to this code. It may not be used to create training material, 
# courses, books, articles, and the like. Contact us if you are in doubt.
# We make no guarantees that this code is fit for any purpose. 
# Visit http://www.pragmaticprogrammer.com/titles/ruby3 for more book information.
#---
require 'optparse' #Provee una libreria para parsear la linea de comandos

module Anagram #Los modulos actuan a modo de mixing -> cabeceras que incluyen código / En este caso actua de espacio de nombres
  class Options
     
    DEFAULT_DICTIONARY = "/usr/share/dict/words"
    
    attr_reader :dictionary
    attr_reader :words_to_find
    
    def initialize(argv)
      @dictionary = DEFAULT_DICTIONARY
      parse(argv) 
      @words_to_find = argv
    end
                 
  private
    
    def parse(argv)
      OptionParser.new do |opts|  
        opts.banner = "Usage:  anagram [ options ]  word..."

        opts.on("-d", "--dict path", String, "Path to dictionary") do |dict|
          @dictionary = dict
        end 

        opts.on("-h", "--help", "Show this message") do
          puts opts
          exit
        end

        begin
          argv = ["-h"] if argv.empty?
          opts.parse!(argv)
        rescue OptionParser::ParseError => e
          STDERR.puts e.message, "\n", opts
          exit(-1)
        end
      end    
    end
  end
end

#Linea para probar el git diff
