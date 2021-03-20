module ErrorSerializer
  extend self

  def error_response(object)
    { errors: build_errors(object.errors) }.to_json
  end

  private

  def build_errors(errors)
    errors.map do |e|
      {
        source: { pointer: "/data/attributes/#{e.attribute}" },
        detail: e.full_message
      }
    end
  end
end
