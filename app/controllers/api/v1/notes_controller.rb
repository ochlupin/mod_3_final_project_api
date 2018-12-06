class Api::V1::NotesController < ApplicationController
  before_action :find_note, only: [:update]

  def index
    @notes = Note.all
    # rendering Note instances using json
    render json: @notes
    
  end

  def update
    # creating a new Note based on whatever note_params we get from our front-end
    @note.update(note_params)
    if @note.save
      render json: @note, status: :accepted
    else
      render json: { errors: @note.errors.full_messages }, status: :unprocessible_entity
    end
  end

  private 

  def note_params
    # We're setting out note_params to permit a parameter named title and a parameter named content. 
    # These must be included in the body of the POST or PATCH requests we will be making with JS fetch.
    params.permit(:title, :content)
  end

  def find_note
    @note = Note.find(params[:id])
  end


end
