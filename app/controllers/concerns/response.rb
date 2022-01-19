module Response
  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def multi_response(object, status = :ok)
    # respond_to do |format|
    # format.html
    # format.json {
    render json: object, status: status
    # }
    # end
  end
end
