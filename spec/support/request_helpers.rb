module RequestHelpers
  def app
    described_class
  end

  def response_body
    JSON(last_response.body)
  end
end
