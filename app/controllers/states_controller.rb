class StatesController < ApplicationController
  before_action :set_state, only: %i[ show edit update destroy ]

  # GET /states or /states.json
  def index
    @states = State.all
  end

  # GET /states/1 or /states/1.json
  def show
  end

  # GET /states/new
  def new
    @state = State.new
  end

  # GET /states/1/edit
  def edit
  end

  # POST /states or /states.json
  def create
    @state = State.new(state_params)

    respond_to do |format|
      if @state.save
        # binding.pry
        upload = @state.attachment.path  #get the relative path of my state.attachment object
        File.open(upload).each_with_index do |line,index| #opens the uploaded file by iterating each line with an index
          next if index == 0 #checks if the index is equal to 0 and skips to the next one
          record = line.split(';') #assign the variable record each line using split method to break the line at each (;)
          Client.create(name:  record[0], age:  record[1], address:  record[2].gsub("\n",''))#create the Client object by assigning to the database table fields the position of the record variable array
        end

        format.html { redirect_to state_url(@state), notice: "State was successfully created." }
        format.json { render :show, status: :created, location: @state }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /states/1 or /states/1.json
  def update
    respond_to do |format|
      if @state.update(state_params)
        format.html { redirect_to state_url(@state), notice: "State was successfully updated." }
        format.json { render :show, status: :ok, location: @state }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /states/1 or /states/1.json
  def destroy
    @state.destroy

    respond_to do |format|
      format.html { redirect_to states_url, notice: "State was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # def uploaded_io
  #   upload = @state.attachment.path
  #   File.open(upload).each_with_index do |line,index|
  #     next if index == 0
  #     record = line.split(';')
  #     client = Client.new(name:  record[0], age:  record[1], address:  record[2])
  #     client.save
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_state
      @state = State.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def state_params
      params.require(:state).permit(:name, :attachment)
    end
end
