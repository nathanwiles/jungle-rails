require 'rails_helper'

describe '#id' do
  it 'should not exist for new records' do
    @widget = Widget.new
    expect(@widget.id).to be_nil
  end

  it 'should be auto-assigned by AR for saved records' do
    @widget = Widget.new
    # we use bang here because we want it to fail if save fails (due to validations)
    @widget.save!

    expect(@widget.id).to be_present
  end
end
