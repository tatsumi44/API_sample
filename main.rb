require 'bundler/setup'
Bundler.require
require 'sinatra'
require 'sinatra/reloader'
require 'open-uri'
require 'net/http'
require 'nokogiri'
require 'json'



get '/' do
  @links = Array.new
  @img = Hash.new

  url = 'https://life-is-tech.com/'
  html = open(url).read
  parsed_html = Nokogiri::HTML.parse(html,nil,'utf-8')
  parsed_html.to_html
  i = 0
  parsed_html.css('.supporter-list').css('li').each do |node|
    anchor = node.css('a')
    @links.push(anchor.attribute('href').value.match(/https?:\/\/(?:www\.)?(?:jp\.)?(?:info\.)?(?:docs\.)?([^\.]*)/)[1])
    temp = anchor.css('img')
    temp.attribute('src').value = url + temp.attribute('src').value
    @img[@links[i]] = temp.to_html
    i += 1
    # logger.info temp.to_html
  end
  erb :main
end

get '/news' do
  #最後の日にちを変更すればいい感じに
  url = "https://news.goo.ne.jp/topstories/backnumber/politics/2018#{params[:date]}/"
  html = open(url).read

  parsed_html = Nokogiri::HTML.parse(html,nil,'utf-8')
  i = 0
  hash_array = Array.new
  parsed_html.css('ul.gn-news-list > li').each do |node|
    contents_hash = Hash.new
    news_url = "https://news.goo.ne.jp#{node.css('a').attribute('href').value}"
    news_name = puts "#{node.css('a').css('p.list-title-topics').inner_text}"
    news_date = puts "#{node.css('a').css('p.list-news-source').inner_text}"
    contents_hash["url"] = "https://news.goo.ne.jp#{node.css('a').attribute('href').value}"
    contents_hash["name"] = "#{node.css('a').css('p.list-title-topics').inner_text}"
    contents_hash["date"] = "#{node.css('a').css('p.list-news-source').inner_text}"
    hash_array.push(contents_hash)
    i += 1
  end
  puts hash_array
  json_array =  JSON.generate(hash_array)
  puts json_array
  json json_array
end