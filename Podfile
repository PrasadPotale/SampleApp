# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'MDMDeviceConfig' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  # Pods for MDMDeviceConfig
  pod 'Alamofire', '~> 4.3'
  pod 'MBProgressHUD', '~> 0.9.2'
  pod 'IQKeyboardManagerSwift', '4.0.8'
  pod 'SkyFloatingLabelTextField', '~> 2.0'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
