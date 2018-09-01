#
# Be sure to run `pod lib lint AnimationChain.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AnimationChain'
  s.version          = '0.1.0'
  s.summary          = 'Make animations in a promise-like chain'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Make animations in a promise-like chain, Supports Liner animations and Spring animations
                       DESC

  s.homepage         = 'https://github.com/BeMxself/AnimationChain'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Song Mingxu' => 'song.mingxu@foxmail.com' }
  s.source           = { :git => 'https://github.com/BeMxself/AnimationChain.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/MingxuSong'

  s.ios.deployment_target = '8.0'

  s.source_files = 'AnimationChain/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AnimationChain' => ['AnimationChain/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
