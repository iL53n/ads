module RequestHelpers
  def app
    described_class
  end

  def response_body
    JSON(response.body)
  end
end
