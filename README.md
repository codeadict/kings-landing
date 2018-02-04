# Kings Landing

A modern, simple, customizable landing page dedicated to early customer acquisition for frugal entrepreneurs. It is a prelaunch landing page aimed at gathering signups and market interest. Think it as an open-source alternative to LaunchRock without spending 5 bucks monthly. Designed to be deployed to [Heroku](https://www.heroku.com/) and gather email addresses in a Google Spreadsheet with minimal effort and cost.

## Demo

You can currently see a deployed demo []()

## Configuration

The app configuration resides in a file named **config.yml**, you can actually copy **config.example.yml** as follows and add your own settings:

```console
cp config.example.yml config.yml
```

The available options are:

* **product_title:** Set your product title, e.g. "My Supercool Startup".
* **product_description:** Enter the description of your product.
* **subscribe_headline:** A text used to invite users to signup.
* **seo_title:** A SEO friendly title, also used for social sharing.
* **seo_keywords:** A comma separated list of SEO keywords for your site.
* **seo_description:** A SEO friendly description of your site.
* **subscribe_button_color:** Hexadecimal color of your subscribe button, e.g. #000000.
* **subscribe_button_text:** Text of the subscribe button, e.g. "I'm In".
* **background_image_url:** The url to your site's background image, use one with good resolution.
* **google_drive_credentials:** Credentials to access Google Drive and write the spreadsheet, the easiest way to generate this is by running `$ rake setup_google_auth` and follow the instructions.
* **spreadsheet_key:** The key that identifies your spreadsheet, can be found in the spreadsheet url in your browser, e.g. in https://docs.google.com/spreadsheets/d/1Uepgo8_MyxqQrpr-ON94Q26Pyi0I9zTvno19kecef4I the key is **1Uepgo8_MyxqQrpr-ON94Q26Pyi0I9zTvno19kecef4I**
* **google_analytics_key:** This is the Google anlytics tracking code, see https://support.google.com/analytics/answer/1008080?hl=en for more info on how to obtain it.

## Getting started

Run it locally with:

```console
foreman start
```
