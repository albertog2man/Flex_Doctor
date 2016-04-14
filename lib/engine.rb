require 'nokogiri'
require 'active_support/all'
class Engine
  class << self

    def parse(issues)
      @issues = issues
      parse_xml
      generate_output
    end

    def parse_xml
      @issues.map! do |issue|
        issue = Nokogiri::XML(issue)
      end
    end

    def generate_output
      @issues = @issues[3..-1]
      @issues.map! do |issue|
        details = issue.children[0]
        text = issue.children[1].to_s
        issue = {
          type: "issue",
          check_name: details.attr('rule'),
          description: text,
          categories: get_category(details),
          location: get_location(details),
          severity: get_severity(details)
        }
      end
      puts @issues
    end

    def get_location(details)
      response = "line: #{details.attr('beginline')}"
      if details.attr('beginline') != details.attr('endline')
        response += " - #{details.attr('endline')}"
      end
      response += "column: #{details.attr('endline')}"
      if details.attr('begincolumn') != details.attr('endcolumn')
        response += " - #{details.attr('endline')}"
      end
      response
    end

    def get_severity(details)
      severity = details.attr('priority').to_i
      return 'info' if severity == 5
      return 'normal' if severity >= 3
      return 'critical' if severity >= 1
    end

    def get_category(details)
      
    end

  end
end
