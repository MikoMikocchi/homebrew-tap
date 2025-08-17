#!/usr/bin/env ruby
# Usage: ruby scripts/bump_main_url_sha.rb Formula/pretty-git.rb NEW_URL NEW_SHA256
# Safely updates only the main url and sha256 (outside livecheck/resource blocks) and removes revision.

path, new_url, new_sha = ARGV
abort "Usage: #{$PROGRAM_NAME} <formula.rb> <new_url> <new_sha256>" unless path && new_url && new_sha

content = File.read(path)
lines = content.lines

in_block = :none
replaced_url = false
replaced_sha = false
last_url_idx = nil

begin_block = lambda do |line|
  return :livecheck if line =~ /^\s*livecheck\s+do\b/
  return :resource  if line =~ /^\s*resource\s+"/
  :none
end

lines.each_with_index do |line, i|
  if line =~ /^\s*end\s*$/ && in_block != :none
    in_block = :none
  else
    b = begin_block.call(line)
    in_block = b unless b == :none
  end

  next unless in_block == :none

  # drop revision in main section
  if line =~ /^\s*revision\s+\d+\s*$/
    lines[i] = ""
    next
  end

  # replace main url
  if !replaced_url && line =~ /^\s*url\s+"https:\/\/rubygems.org\/downloads\//
    indent = line[/^\s*/]
    lines[i] = "#{indent}url \"#{new_url}\"\n"
    replaced_url = true
    last_url_idx = i
    next
  end

  # replace sha256 after we've updated url
  if replaced_url && !replaced_sha && line =~ /^\s*sha256\s+".*"\s*$/
    indent = line[/^\s*/]
    lines[i] = "#{indent}sha256 \"#{new_sha}\"\n"
    replaced_sha = true
    next
  end
end

# If sha256 not found in main section, insert it right after the url
if replaced_url && !replaced_sha && last_url_idx
  indent = lines[last_url_idx][/^\s*/]
  lines.insert(last_url_idx + 1, "#{indent}sha256 \"#{new_sha}\"\n")
  replaced_sha = true
end

abort "edit-failed: url or sha not updated" unless replaced_url && replaced_sha

File.write(path, lines.join)
puts "updated: #{path}"
