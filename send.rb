def sender
  api_key = 'YOUR_API_KEY_HERE'
project_id = 'YOUR_PROJECT_ID_HERE'
phone_id = 'SENDER_PHONE_ID_HERE'
to_number = 'RECIPIENT_PHONE_NUMBER_HERE'
content = 'SMS MESSAGE CONTENT HERE'

require 'net/https'
require 'json'

uri = URI("https://api.telerivet.com/v1/projects/#{project_id}/messages/outgoing")
http = Net::HTTP.new(uri.host, uri.port)
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER

# you will need to download SSL certificates from https://telerivet.com/_media/cacert.pem .
http.ca_file = File.join(File.dirname(__FILE__), "cacert.pem")

http.start {
    req = Net::HTTP::Post.new(uri.path)
    req.form_data = {
        "content" => content,
        "phone_id" => phone_id,
        "to_number" => to_number,
    }
    req.basic_auth api_key, ''

    res = JSON.parse(http.request(req).body)

    print res   # do something with res
}
end