platform :ios, '9.0'

target 'Movie' do
  use_frameworks!

  # Networking
  pod 'Alamofire'								# https://github.com/Alamofire/Alamofire
  pod 'AlamofireImage'                          # https://github.com/Alamofire/AlamofireImage
    
  # Mapping
  pod 'AlamofireObjectMapper'					# https://github.com/tristanhimmelman/AlamofireObjectMapper

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
