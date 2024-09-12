platform :ios, '16.0'  # or your minimum deployment target

target 'Fractal' do
  use_frameworks!

  pod 'FeedKit'
  pod 'Fuzi' 

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
        config.build_settings['ARCHS'] = 'arm64'
      end
    end
  end
end

