Pod::Spec.new do |spec|

  spec.name         = "Forms"
  spec.version      = "0.0.1"
  spec.summary      = "基于swift的表单组件库."
  spec.license      = "MIT"
  spec.homepage     = "https://github.com/bianrui/SwiftForms"
  spec.author       = { "bianruifeng" => "912736557@qq.com" }
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/bianrui/SwiftForms.git", :tag => "#{spec.version}" }

  spec.source_files  = 'Source', 'Source/**/*.{swift}'

  spec.dependency 'SnapKit'
  spec.dependency 'Kingfisher' #网络图片展示 -https://github.com/onevcat/Kingfisher
  spec.dependency 'HandyJSON'
  spec.dependency 'BRPickerView' #https://github.com/91renb/BRPickerView
  spec.dependency 'TZImagePickerController'
  spec.dependency 'GKPhotoBrowser'
  
end
