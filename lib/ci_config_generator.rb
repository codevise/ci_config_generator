require "ci_config_generator/version"

module CiConfigGenerator

  def self.interpolate(file_name, variables)
    File.read(file_name).gsub(/%{[^}]+}/) do |match|
      key = match.gsub(/^%{([^}]+)}/, '\1')
      variables[key] || error("Cannot interpolate unknown environment variable '#{key}' in '#{file_name}'")
    end
  end

  def self.error(message)
    STDERR.puts("Error: #{message}")
    exit 1
  end

end
