class HomeController < ApplicationController
  
  def index
    
  end
  
  def generate
    @original_data = params[:q]
    @converted = ""
    @rewrite_map = ""
    @errors = []
    @original_data.split("\r\n").each_with_index do |row,i|      
      from,to = row.split(',')

      if from.nil? || to.nil? || row.nil?
        @errors << row
        next
      end

      @converted += "<rule name=\"generated-#{i} (#{DateTime.now.strftime("%m/%e/%y %I:%M:%S")})\" stopProcessing=\"true\">\r\n" +
      "  <match url=\".*\" />\r\n" +
      "    <conditions logicalGrouping=\"MatchAny\">\r\n" +
      "      <add input=\"{URL}\" pattern=\"#{from.strip}$\" />\r\n" +
      "    </conditions>\r\n" +
      "    <action type=\"Redirect\" appendQueryString=\"false\" url=\"#{to.strip}\" redirectType=\"Permanent\" />\r\n" +
      "</rule>\r\n" + "\r\n"
    end
    
    @original_data.split("\r\n").each_with_index do |row,i|      
      from,to = row.split(',')
      if from.nil? || to.nil? || row.nil?
        next
      end
      
      @rewrite_map += "<add key=\"#{from.strip}\" value=\"#{to.strip}\" />\r\n"
    end
  end

  def setup
    
  end
end
