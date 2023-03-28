#!/usr/bin/env ruby

require 'erb'
require 'ostruct'
require 'yaml'

# Run external command and test success.
def run(cmd)
  puts cmd
  success = system(cmd)
  exit $?.exitstatus unless success
end

def status(msg)
  puts "\n==> #{msg}"
end

# Update docker files for a version.
def update_version(branch, version, opts={})
  tldir = File.join(branch, version)
  status "Update version #{tldir}"

  # initialize directory
  run "rm -rf #{tldir}"
  run "mkdir -p #{tldir}"

  opts['version'] = version

  # render Dockerfile for each build platform
  opts["platforms"].each do |platform|
    dir = File.join(tldir, platform)
    run "mkdir -p #{dir}"
    platformDockerfileName = 'Dockerfile.' + platform + '.erb'
    platformDockerfile = ERB.new(File.read(platformDockerfileName), nil, '-')
    result = platformDockerfile.result(OpenStruct.new(opts).instance_eval { binding })
    commonDockerFile = ERB.new(File.read('Dockerfile.common.erb'), nil, '-')
    result += commonDockerFile.result(OpenStruct.new(opts).instance_eval { binding })
    File.write(File.join(dir, 'Dockerfile'), result)
  end
end

def load_versions
  versions = YAML.load_file('versions.yml')
  versions.select! { |k, v| k === ENV['BRANCH'] } if ENV['BRANCH']
  versions
end

if __FILE__ == $0
  load_versions.each do |branch, versions|
    versions.each do |version, opts|
      update_version(branch, version, opts)
    end
  end
end
