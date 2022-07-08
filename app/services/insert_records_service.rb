# app/services/insert_records_service.rb
class InsertRecordsService < ApplicationService
  
  def insert_record
    InsertRecordsJob.perform_now

    flash[:notice] = "We are processing your file."
    redirect_to 'states#index'
  end
  # Initialize
  # def initialize(state) #create constructor method
  #   @state = state #set the instance variable
  # end
  
  # def insert_record
  #   # binding.pry
  #   upload = @state.attachment.path  #get the relative path of my state.attachment object
  #     File.open(upload).each_with_index do |line,index| #opens the uploaded file by iterating each line with an index
  #       next if index == 0 #checks if the index is equal to 0 and skips to the next one
  #       record = line.split(';') #assign the variable record each line using split method to break the line at each (;)
  #       Client.find_or_create_by(name:  record[0], age:  record[1], address:  record[2].gsub("\n",''))#create the Client object by assigning to the database table fields the position of the record variable array
  #   end
  # end
end

