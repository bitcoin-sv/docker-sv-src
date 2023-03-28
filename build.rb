#!/usr/bin/env ruby

require './update'

def build_image(branch, version, platform)
  dir = File.join(branch, version, platform)
  tag = "bitcoin-#{branch}-src:#{version}-#{platform}"

  run "docker build -t #{tag} #{dir}"
end

if __FILE__ == $0
  load_versions.each do |branch, versions|
    versions.each do |version, opts|
      opts["platforms"].each do |platform|
        build_image(branch, version, platform)
      end
    end
  end
end
