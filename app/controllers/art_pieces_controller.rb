class ArtPiecesController < ApplicationController
  def show
    @art_piece = ArtPiece.find(params[:id])
    @booking = Booking.new
    @booking_created = false
    @booking_created = true if params[:booking_created]
  end

  def index
    @art_pieces = ArtPiece.all
  end

  def new
    @art_piece = ArtPiece.new
  end

  def create
    @art_piece = ArtPiece.new(art_piece_params)
    @art_piece.user = current_user
    if @art_piece.save
      redirect_to art_piece_path(@art_piece), notice: "Congratulations, your art piece has been added!" # redirects to the show page
    else
      @art_piece_created = false
      render :new
    end
  end

  private

  def art_piece_params # params for security reasons
    params.require(:art_piece).permit(:title, :description, :price, :artist, photos: []) # add photos: [] if user can upload a photo too
  end

end
