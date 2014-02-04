require 'spec_helper'

describe 'rake ci:config:generate' do
  it 'creates files from template files ending with .ci' do
    in_tmpdir do
      File.write('database.yml.ci', 'db: "my_db"')

      rake 'ci:config:generate'

      expect(File.read('database.yml')).to eq('db: "my_db"')
    end
  end

  it 'creates files from template files ending with .ci' do
    in_tmpdir do
      File.write('.env.ci', 'FOO=bar')

      rake 'ci:config:generate'

      expect(File.read('.env')).to eq('FOO=bar')
    end
  end

  it 'interpolates environment variables' do
    in_tmpdir do
      File.write('database.yml.ci', 'db: "%{DB_NAME}"')

      rake 'ci:config:generate', :env => {'DB_NAME' => 'replaced'}

      expect(File.read('database.yml')).to eq('db: "replaced"')
    end
  end

  it 'does not override existing files' do
    in_tmpdir do
      File.write('database.yml.ci', 'db: "ci"')
      File.write('database.yml', 'db: "custom"')

      rake 'ci:config:generate'

      expect(File.read('database.yml')).to eq('db: "custom"')
    end
  end

  it 'fails if files exist' do
    in_tmpdir do
      File.write('database.yml.ci', 'db: "ci"')
      File.write('database.yml', 'db: "custom"')

      sucess = rake 'ci:config:generate'

      expect(sucess).to be(false)
    end
  end

  it 'does not touch files named exactly .ci' do
    in_tmpdir do
      File.write('.ci', 'db: "ci"')

      sucess = rake 'ci:config:generate'

      expect(sucess).to be(true)
    end
  end

  def in_tmpdir(&block)
    path = File.expand_path("spec/tmp/")

    FileUtils.rm_rf(path) if File.exists?(path)
    FileUtils.mkdir_p(path)

    Dir.chdir(path, &block)
  end

  def rake(task_name, options = {})
    env = options[:env] && options[:env].map { |key, value| [key, value] * '=' } * ' '
    system("#{env} rake #{task_name} -f lib/ci_config_generator/tasks.rb > rake.out 2>&1")
  end
end
