#
#  Be sure to run `pod spec lint SwiftForms.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  spec.name         = "SwiftForms"
  spec.version      = "0.0.1"
  spec.summary      = "基于swift的表单组件库"
  spec.homepage     = "https://github.com/bianrui/SwiftForms"
  spec.license      = "MIT"
  spec.author             = { "bianruifeng" => "912736557@qq.com" }
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/bianrui/SwiftForms.git", :tag => "#{spec.version}" }
  spec.source_files  = 'Sources', 'Sources/**/*.{swift}'

  spec.dependency 'SnapKit'
  spec.dependency 'Kingfisher'
  spec.dependency 'HandyJSON'
  spec.dependency 'BRPickerView'
  spec.dependency 'TZImagePickerController'
  spec.dependency 'GKPhotoBrowser'

end
