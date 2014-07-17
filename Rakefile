require 'rake/testtask'
require 'dotenv'

Rake::TestTask.new do |t|
  t.test_files = FileList['spec/lib/**/*_spec.rb']
  t.verbose = true
end

desc "Anonymize authentication token"
task :anonymize_auth_token do
  Dotenv.load

  find_files_command = "grep -rl --exclude='.env' #{ENV['DEBITOOR_ACCESS_TOKEN']} ."
  replace_token_command = "perl -e 's/#{ENV['DEBITOOR_ACCESS_TOKEN']}/<%= ENV[\"DEBITOOR_ACCESS_TOKEN\"] %>/' -pi"

  system("#{find_files_command} | xargs #{replace_token_command}")
end

desc "Find occurrences of authentication token"
task :find_auth_token do
  Dotenv.load
  find_files_command = "grep -r #{ENV['DEBITOOR_ACCESS_TOKEN']} ."
  system(find_files_command)
end

task default: :test
