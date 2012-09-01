require 'rubygems'
# If you're using bundler, you will need to add this
require 'bundler/setup'
require 'sinatra'
require 'pdfkit'
use PDFKit::Middleware

HTML = '
  <html>
    <head>
      <title>Hello World</title>
    </head>
    <body>
      <h3>Hello World</h3>
    </body>
  </html>
'
get '/' do
  kit = PDFKit.new(HTML, :page_size => 'Letter')
  content_type 'application/pdf'
  kit.to_pdf
end
