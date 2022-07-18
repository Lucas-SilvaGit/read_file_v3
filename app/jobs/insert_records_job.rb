class InsertRecordsJob < ApplicationJob
  queue_as :default

  attr_accessor :state

  def perform(state_id)
    # Do something later

    InsertRecordsService.new(state_id).insert_record
  end
end
