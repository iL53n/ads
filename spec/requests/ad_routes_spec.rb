RSpec.describe AdsController, type: :request do
  describe 'GET /' do
    let(:user) { create(:user) }

    before do
      create_list(:ad, 3, user: user)
    end

    it 'returns a collection of ads' do
      get '/'

      expect(last_response.status).to eq(200)
      expect(response_body['data'].size).to eq(3)
    end
  end

  describe 'POST /ads' do
    let(:user) { create(:user) }

    context 'missing parameters' do
      it 'returns an error' do
        post '/ads'

        expect(last_response.status).to eq(422)
      end
    end

    context 'invalid parameters' do
      let(:ad_params) do
        {
          title: 'Ad title',
          description: 'Ad description',
          city: ''
        }
      end

      it 'returns an error' do
        post '/ads', ad_params

        expect(last_response.status).to eq(422)
        expect(response_body['errors']).to include(
                                             {
                                               'detail' => "City can't be blank",
                                               'source' => {
                                                 'pointer' => '/data/attributes/city'
                                               }
                                             }
                                           )
      end
    end

    context 'valid parameters' do
      let(:user) { create(:user) }
      let(:ad_params) do
        {
          title: 'Ad title',
          description: 'Ad description',
          city: 'City'
        }
      end

      let(:last_ad) { Ad.last }

      it 'creates a new ad' do
        expect { post '/ads', ad_params, user: user }
          .to change { Ad.count }.from(0).to(1)

        expect(last_response.status).to eq(201)
      end

      it 'returns an ad' do
        post '/ads', ad_params, user: user

        expect(response_body['data']).to a_hash_including(
                                           'id' => last_ad.id.to_s,
                                           'type' => 'ad'
                                         )
      end
    end
  end
end
