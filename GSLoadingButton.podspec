 Pod::Spec.new do |s|
  s.name         = "GSLoadingButton"
  s.version      = "0.3.0"
  s.summary      = "GSLoadingButton is a loading button"
  s.description  = <<-DESC
                    GSLoadingButton is loading button. It's looks like cool.
                   DESC
  s.homepage     = "https://github.com/gangstarmn/GSLoadingButton"
  s.license      = "MIT"
  s.author             = { "Gantulga" => "gangstarmn@gmail.com" }
  s.platform = :ios, '8.0'
  s.source = { :git => 'https://github.com/gangstarmn/GSLoadingButton.git', :tag => "#{s.version}" }
  
  s.source_files = "GSLoadingButton/**/*.{h,m}"
    
  s.framework = 'UIKit'
  s.requires_arc = true
  end


