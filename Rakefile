
desc 'Setups Google Spreadsheet access'
task :setup_google_auth do
  require 'yaml'

  require 'signet/oauth_2/client'
  require "highline/import"

  say "To use data from Google drive:"
  say "Create a new project with Google's Developer Platform:"
  say "<%= color('https://console.developers.google.com/project', :blue) %>"
  say "Go to the project, select APIs & Auth > APIs from left menu"
  say "Pick the 'Drive API' and make sure it's enabled."
  say "Then select APIs & Auth > Credentials from left menu"
  say "Create new OAuth Client ID"
  say "Pick 'Installed Application' and fill out information"

  client_id = ask "<%= color('Enter your Google Drive API Client ID:', :white) %> "
  client_secret = ask "<%= color('Enter your Google Drive API Client Secret:', :white) %> "

  auth = Signet::OAuth2::Client.new(
    :authorization_uri => 'https://accounts.google.com/o/oauth2/auth',
    :token_credential_uri => 'https://www.googleapis.com/oauth2/v3/token',
    :client_id => client_id,
    :client_secret => client_secret,
    :scope => "https://www.googleapis.com/auth/drive " +
              "https://spreadsheets.google.com/feeds/",
    :redirect_uri => 'urn:ietf:wg:oauth:2.0:oob',
  )

  unless system("open '#{auth.authorization_uri}'")
    say "Open this page in your browser:"
    say "<%= color('#{auth.authorization_uri}', :blue) %>"
  end
  auth.code = ask "<%= color('Enter the authorization code shown in the page:', :white) %> "
  auth.fetch_access_token!

  config = YAML::load_file('config.yml')
  config['google_drive_credentials'] = "#{auth.client_id}:#{auth.client_secret}:#{auth.refresh_token}"
  File.write('config.yml', config.to_yaml)

  say "<%= color('OAuth credentials generated and stored in ', :green) %> <%= color('config.yml', :bold) %> "
end
