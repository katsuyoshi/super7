# -*- coding: utf-8 -*-
require 'rubygems'
require 'sinatra'
require 'haml'
require './super7'

results = []
dai = Super7.new
next_deme = "000"


get '/' do
  @deme = next_deme
  @results = results
  haml :index
end

post '/' do
  deme = params[:deme]
  if /\d{3}/ =~ deme
    results.unshift deme
    results.pop if results.size > 10
    next_deme = dai.put_deme(deme)
    @message = nil
  else
    @message = "数字3桁で入力して下さい"
  end
  @deme = next_deme
  @results = results
  haml :index
end
