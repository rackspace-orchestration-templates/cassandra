# Encoding: utf-8

require_relative 'spec_helper'

describe package('lvm2') do
  it { should be_installed }
end
