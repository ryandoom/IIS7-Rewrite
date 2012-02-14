class HomeController < ApplicationController
  
  def index
    
  end
  
  def generate
    data = params[:q]
    @converted = ""
    data.split("\r\n").each_with_index do |row,i|      
      from,to = row.split(',')
      @converted += "<rule name=\"generated-#{i}\" stopProcessing=\"true\">\r\n" +
      "  <match url=\".*\" />\r\n" +
      "    <conditions logicalGrouping=\"MatchAny\">\r\n" +
      "      <add input=\"{URL}\" pattern=\"#{from.strip}$\" />\r\n" +
      "    </conditions>\r\n" +
      "    <action type=\"Redirect\" appendQueryString=\"false\" url=\"#{to.strip}\" redirectType=\"Permanent\" />\r\n" +
      "</rule>\r\n" + "\r\n"
    end
  end
end
