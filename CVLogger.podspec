#
# Be sure to run `pod lib lint CVLogger.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CVLogger"
  s.version          = "0.2.3"
  s.summary          = "A library to show a log viewer in your app."

  s.description      = 'This library provides a app log viewer for your debug mode app'

  s.homepage         = "https://github.com/ravenx88/CVLogger"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
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
