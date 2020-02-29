require 'rspec'
require 'byebug'
require "activerecord_cindy"
# require "active_record"

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'my_db'
)

class User < ActiveRecord::Base
end

RSpec.describe "Test User" do
  before(:all)do
    User.new(name: 'Ancestor', phone: '0932445631', age: 12).save
  end

  it '1 test model with attrbutes' do
    user = User.new(name: 'Bob', phone: '0932445631', age: 12)
    expect(user.name).to eq('Bob')
    expect(user.phone).to eq('0932445631')
    expect(user.age).to eq(12)
  end

  it '2 test model save record' do
    user = User.new(name: 'Bob')
    expect{user.save}.to change{User.all.count}.by(1)
    expect{user.save}.to change{User.all.count}.by(0)
  end

  it '2 test model save with value' do
    User.new(name: 'Peter').save
    expect(User.last.name).to eq('Peter')
  end

  it '3 test find' do
    user = User.find(User.first.id)
    expect(user.id).to eq(User.first.id)
  end

  it '4 test where chain' do
    User.new(name: 'A', age: 20, phone: '000').save
    User.new(name: 'A', age: 30, phone: '6666').save
    User.new(name: 'B', age: 30, phone: '000').save
    user = User.where("name = 'A'").where("age > 25").where("age > 25").where("age > 25").first
    expect(user.phone).to eq('6666')
  end
end
