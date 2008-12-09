require 'rake'

# If we ever need to push the settings out of the source control index...
# (good for multiple devs with disparate environments)
# (create config/properties.yml and .gitignore it)
#require 'yaml'
#config = YAML.load_file(File.join('config', 'properties.yml'))

# Project Directories
source_dir =    "src"
library_dir =   "lib"
test_dir =      "test"
doc_dir =       "doc"
build_dir =     "build"
assets_dir =    "assets"
template_dir =  "template"

# Main Files
main_file =     "#{source_dir}/Application.as"
main_output =   "#{build_dir}/Application.swf"
template_file = "#{template_dir}/index.html"
template_output = "#{build_dir}/index.html"

# Test Files
test_file =   "#{test_dir}/Main.mxml"
test_output = "#{build_dir}/TestMain.swf"

# Applications
flash_player_path = '/Applications/Adobe\ Flash\ CS3/Players/Debug/Flash\ Player.app'
web_browser_path =  '/Applications/Firefox.app'

desc "Compiles and launches the development version of the app. Calling 'rake' does this automatically."
task :default => ["build:compile:development"] do
  sh "cp -r #{assets_dir} #{build_dir}"
  sh "cp #{template_file} #{build_dir}"
  #sh "open -a #{web_browser_path} #{template_output}"
  sh "open -a #{flash_player_path} #{main_output}"
end

namespace :build do
  desc "Removes generated files and directories"
  task :clean do
    sh "rm -rf #{build_dir}"
  end

  desc "Creates build directory"
  task :init => :clean do
    sh "mkdir -p #{build_dir}"
  end

  namespace :compile do 
    desc "Build #{main_file} with debug info to #{main_output} using mxmlc (must have mxmlc on PATH)"
    task :development => :init do
      sh "mxmlc -sp=#{source_dir} #{main_file} -debug=true -library-path+=#{library_dir} -output #{main_output} -use-network=false"
    end
  end
end

desc "Compile and launch the test suite"
task :test => ["build:init"] do
  sh "mxmlc -sp+=#{source_dir} -sp+=#{test_dir} #{test_file} -debug=true -library-path+=#{library_dir} -output #{test_output} -use-network=false"
  sh "cp -r #{assets_dir} #{build_dir}"
  sh "open -a #{flash_player_path} #{test_output}"
end

namespace :doc do
  desc "Delete the document directory"
  task :clean do
    sh "rm -rf #{doc_dir}"
  end
  
  desc "Generate documentation for this project using ASDoc (must have asdoc on PATH)"
  task :asdoc => :clean do
    sh "asdoc -source-path #{source_dir} -doc-sources #{source_dir} -library-path+=#{library_dir} -output #{doc_dir}"
  end
end

desc "Runs ASDoc and opens the API in your browser"
task :doc => ["doc:asdoc"] do 
  sh "open -a #{web_browser_path} #{doc_dir}/index.html"
end