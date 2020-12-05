Pod::Spec.new do |spec|
  spec.name = 'Prelude'
  spec.version = '1.1.4'
  spec.summary = 'Functional operators for Swift'
  spec.homepage = 'https://github.com/1989allen126/Kickstarter-Prelude'
  spec.license = { :type => 'MIT', :file => 'LICENSE' }
  spec.author = {
    'Gordon Fontenot' => '1989allen126@gmail.com',
    'thoughtbot' => nil,
  }
  spec.source = { :git => 'https://github.com/1989allen126/Kickstarter-Prelude.git', :tag => spec.version.to_s }
  spec.source_files = 'Sources/{Prelude,Prelude-UIKit}/*.{h,swift}','Sources/Prelude-UIKit/lenses/*.swift'
  spec.requires_arc = true
  spec.ios.deployment_target = '9.0'
  spec.frameworks = 'UIKit','CoreGraphics'
  spec.dependency 'Runes'
  
  spec.swift_version = '5.1'
end
