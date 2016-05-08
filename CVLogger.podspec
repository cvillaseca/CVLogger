

Pod::Spec.new do |s|
  s.name             = "CVLogger"
  s.version          = "0.4"
  s.summary          = "A library to show easily a log viewer in your app."

  s.description      = 'This library provides a app log viewer for your debug mode app'

  s.homepage         = "https://github.com/ravenx88/CVLogger"
  s.screenshots      = "https://cloud.githubusercontent.com/assets/7700085/13728275/5c5f224e-e912-11e5-9d37-b02210ef8a26.gif"
  s.license          = 'MIT'
  s.author           = { "Cristian Villaseca" => "cvillaseca_basco@hotmail.com" }
  s.source           = { :git => "https://github.com/ravenx88/CVLogger.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/cristianviba'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'CVLogger' => ['Pod/Assets/*.png']
  }

  s.frameworks = 'UIKit'
end
