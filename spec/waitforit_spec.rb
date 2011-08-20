require 'rspec'
require "#{File.dirname(__FILE__)}/../lib/waitforit"

describe 'waitforit' do
  it 'should wait until the prescribed thing has happened' do
    end_time = Time.now + 1
    wait_until do
      end_time < Time.now
    end
    end_time.should be < Time.now
  end
  
  it 'should throw an exception if when the prescribed action does not happen in time' do
    expect{wait_until(0.5){false}}.to raise_error RuntimeError
  end
  
  it 'should keep trying for a specified period' do
    start_time = Time.now
    wait_time = 1
    
    lambda{wait_until(wait_time){false}}
    
    (start_time + wait_time).should be >= Time.now 
  end
  
  it 'should be possible for user to supply the retry time' do
    count = 0
    wait_until(2.seconds, :retry_every => 0.5.seconds) do
      count += 1
      count == 4
    end
  end
end