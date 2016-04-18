Pod::Spec.new do |s|

  s.name         = "SigmaTableViewModel"
  s.version      = "1.0.0"
  s.summary      = "A lightweight view model for iOS tableview."
  s.homepage     = "https://github.com/youzan/SigmaTableViewModel"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "yangke" => "yangke@qima-inc.com" }
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/youzan/SigmaTableViewModel.git", :tag => s.version.to_s }
  s.requires_arc = true
  s.source_files  = "SigmaTableViewModel", 'Lib/*.{h,m}'
  s.ios.deployment_target = "7.0"

end
