require 'yaml'

require 'rubygems'
require 'bundler/setup'

require "google_drive"
require 'sinatra/base'
require "sinatra/config_file"

Bundler.require(:default)

class KingsLanding < Sinatra::Base
  register Sinatra::ConfigFile

  COL_DATETIME = 1
  COL_FULL_NAME = 2
  COL_EMAIL = 3

  config_file 'config.yml'

  get '/' do
    @product_title = settings.product_title
    @product_description = settings.product_description
    @subscribe_headline = settings.subscribe_headline
    @subscribe_button_text = settings.subscribe_button_text
    @subscribe_button_color = settings.subscribe_button_color
    @background_image_url = settings.background_image_url
    @seo_title = settings.seo_title
    @seo_description = settings.seo_description
    @seo_keywords = settings.seo_keywords
    @google_analytics_key = settings.google_analytics_key
    erb :index, :layout => :layout
  end

  post '/subscribe' do
    full_name = params[:full_name]
    email = params[:email]

    unless email.nil? || email.strip.empty?
      collect_email(email, full_name)
      if request.xhr?
        "ok"
      end
    end
  end

  def collect_email(email, full_name)
    auth = settings.google_drive_credentials && settings.google_drive_credentials.split(":")
    credentials = Google::Auth::UserRefreshCredentials.new(
      client_id: auth[0],
      client_secret: auth[1],
      scope: [
        "https://www.googleapis.com/auth/drive",
        "https://spreadsheets.google.com/feeds/",
      ],
      redirect_uri: "urn:ietf:wg:oauth:2.0:oob",
    )
    credentials.refresh_token = auth[2]
    credentials.fetch_access_token!
    session = GoogleDrive::Session.from_credentials(credentials)
    spreadsheet = session.spreadsheet_by_key(settings.spreadsheet_key)
    worksheet = spreadsheet.worksheets[0]
    row = worksheet.num_rows + 1
    worksheet[row, COL_DATETIME] = Time.now.strftime("%-m/%-d/%Y %H:%M:%S")
    worksheet[row, COL_FULL_NAME] = full_name
    worksheet[row, COL_EMAIL] = email
    worksheet.save
  end
end
