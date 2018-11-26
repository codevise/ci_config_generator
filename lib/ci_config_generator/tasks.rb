require 'ci_config_generator'

namespace :ci do
  namespace :config do
    desc 'Generate config files from *.ci templates'
    task :generate do
      Dir.glob('**/{.,}*.ci') do |file_name|
        target_file_name = file_name.gsub(/.ci$/, '')

        if File.exist?(target_file_name)
          error "#{target_file_name} already exists."
        else
          STDERR.puts("Creating #{target_file_name} from #{file_name}")
          File.write(target_file_name, CiConfigGenerator.interpolate(file_name, ENV))
        end
      end
    end

  end
end
