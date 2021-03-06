require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe DORB::Droplet do

  it_should_behave_like 'a resource'

  let(:droplet_attributes) do
    {
      :id => 100823,
      :name => 'test222',
      :backups_active => false,
      :image_id => 420,
      :region_id => 1,
      :size_id => 33,
      :ip_address => '192.168.1.10',
      :status => 'active'
    }
  end

  subject { DORB::Droplet.new droplet_attributes }

  its(:id) { should == droplet_attributes[:id] }
  its(:name) { should == droplet_attributes[:name] }
  its(:backups_active) { should == droplet_attributes[:backups_active] }
  its(:image_id) { should == droplet_attributes[:image_id] }
  its(:region_id) { should == droplet_attributes[:region_id] }
  its(:size_id) { should == droplet_attributes[:size_id] }
  its(:ip_address) { should == droplet_attributes[:ip_address] }
  its(:status) { should == droplet_attributes[:status] }

  let(:other_droplet) { stub(:ip_address => '1.2.3.4', :name => 'OtherDroplet') }

  describe '.find_by_ip_address' do

    subject { DORB::Droplet.find_by_ip_address(droplet_attributes[:ip_address]) }

    context 'when no droplet exists with the specified ip' do
      it 'should raise an APIError' do
        DORB::Droplet.stub(:all).and_return([other_droplet])
        expect { subject }.to raise_error(DORB::APIError)
      end
    end

    context 'when a droplet exists with the specified ip' do
      let(:matching_ip_droplet) { stub(:ip_address => droplet_attributes[:ip_address]) }
      it 'returns the droplet' do
        DORB::Droplet.stub(:all).and_return([other_droplet, matching_ip_droplet])
        should == matching_ip_droplet
      end
    end

  end

  describe '.find_all_by_name' do
     
    subject { DORB::Droplet.find_all_by_name(droplet_attributes[:name]) }

    context 'when no droplet exists with the specified name' do
      it 'should raise an APIError' do
        DORB::Droplet.stub(:all).and_return([other_droplet])
        expect { subject }.to raise_error(DORB::APIError)
      end
    end

    context 'when a droplet exists with the specified name' do
      let(:matching_name_droplet) { stub(:name => droplet_attributes[:name]) }
      it 'returns the droplet' do
        DORB::Droplet.stub(:all).and_return([other_droplet, matching_name_droplet])
        should == [matching_name_droplet]
      end
    end

  end

end
