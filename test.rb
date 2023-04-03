#!/usr/bin/env ruby

require './update'

def build_image(branch, version, platform)
  dir = File.join(branch, version, platform)
  tag = "bitcoin-#{branch}-src:#{version}-#{platform}"

  num_cores = "cat /proc/cpuinfo | grep processor | wc -l"
  build_cmd = "cd /opt/bitcoin-sv-#{version}; ./autogen.sh; ./configure; make -j `#{num_cores}` src/bitcoind"
  test_cmd = "./src/bitcoind -version | grep \"version v#{version}\""

  run "docker build -t #{tag} #{dir}"
  run %^docker run --rm #{tag} sh -c '#{build_cmd}; test -n "$(#{test_cmd})"'^
end

if __FILE__ == $0
  load_versions.each do |branch, versions|
    latest_version = versions.sort[-1][0]
    opts = versions[latest_version]
    opts["platforms"].each do |platform|
      build_image(branch, latest_version, platform)
    end
  end
end

