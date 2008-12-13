require 'rake'

#########
# System-dependent settings: Each developer will set these for themselves in config/properties.yml
#########

# Load config/properties.yml. If it doesn't exist, copy config/properties.yml.sample to it
require 'yaml'
begin
  config = YAML.load_file(File.join('config', 'properties.yml'))
rescue
  sh "cp config/properties.yml.sample config/properties.yml"
  puts "You need to edit config/properties.yml to match your system."
  exit
end

# Applications
flash_player_path = config["applications"]["flash_player_path"]
web_browser_path =  config["applications"]["web_browser_path"]
flash_log =         config["applications"]["flash_log"]


#########
# Project-wide settings: These settings should be the same for all developers on the project
#########

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

namespace :log do
  desc "Convenience task for tailing your flash logs."
  task :tail do
    sh "tail -f #{flash_log}"
  end
  
  desc "Empties your flash log (because it gets big)."
  task :flush do
    sh "rm #{flash_log}"
    sh "touch #{flash_log}"
  end
end

desc "Shortcut to flush and tail your logs."
task :log => ["log:flush", "log:tail"]

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