namespace :ci do
  namespace :config do
    desc 'Generate config files from *.ci templates'
    task :generate do
      Dir.glob('**/*.ci') do |file_name|
        target_file_name = file_name.gsub(/.ci$/, '')

        if File.exist?(target_file_name)
          error "#{target_file_name} already exists."
          # STDERR.puts("Skipping #{target_file_name} - file exists")
        else
          STDERR.puts("Creating #{target_file_name} from #{file_name}")
          File.write(target_file_name, interpolate(file_name, ENV))
        end
      end
    end

    def interpolate(file_name, variables)
      File.read(file_name).gsub(/%{[^}]+}/) do |match|
        key = match.gsub(/^%{([^}]+)}/, '\1')
        variables[key] || error("Cannot interpolate unknown environment variable '#{key}' in '#{file_name}'")
      end
    end

    def error(message)
      STDERR.puts("Error: #{message}")
      exit 1
    end
  end
end
