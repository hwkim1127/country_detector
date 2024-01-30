#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint country_detector.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'country_detector'
  s.version          = '0.0.1'
  s.summary          = 'plugin to detect the country code of a user for android and ios'
  s.description      = <<-DESC
plugin to detect a user's country for android and ios
                       DESC
  s.homepage         = 'https://hyunwookim.net'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'me@hyunwookim.net' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
