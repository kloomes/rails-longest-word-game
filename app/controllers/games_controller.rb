require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    @selection = []
    letters = ("a".."z").to_a
    10.times { @selection << letters.sample }
  end

  def score
    @letter_count = {}
    params[:letters].split('').each do |letter|
      if @letter_count[letter.to_sym].nil?
        @letter_count[letter.to_sym] = 1
      else
        @letter_count[letter.to_sym] += 1
      end
    end

    @word_letter_count = {}
    params[:word].split('').each do |letter|
      if @word_letter_count[letter.to_sym].nil?
        @word_letter_count[letter.to_sym] = 1
      else
        @word_letter_count[letter.to_sym] += 1
      end
    end

    @valid = true if @word_letter_count.each_key do |key|
      @letter_count[key] >= @word_letter_count[key]
    end

    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    word_object = open(url).read
    word = JSON.parse(word_object)
    @found = word["found"]
  end
end
