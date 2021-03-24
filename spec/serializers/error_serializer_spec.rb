RSpec.describe ErrorSerializer do

  describe 'from_model' do
    let(:model) do
      Class.new do
        include ActiveModel::Model

        attr_accessor :blue
        attr_accessor :blue, :green


        validates :blue, :green, presence: true
        validates :green, inclusion: { in: [1] }

        def self.name
          'Model'
        end
      end.new
    end

    before do
      model.validate
    end

    it 'returns errors representation' do
      expect(subject.error_response(model)).to eq(
        errors: [
          {
            detail: "Blue can't be blank",
            source: {
              pointer: '/data/attributes/blue'
            }
          },
          {
            detail: "Green can't be blank",
            source: {
              pointer: '/data/attributes/green'
            }
          },
          {
            detail: "Green is not included in the list",
            source: {
              pointer: '/data/attributes/green'
            }
          }
        ]
      )
    end
  end
end
