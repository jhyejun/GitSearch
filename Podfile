# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'GitSearch' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for GitSearch
  pod 'Alamofire'
  pod 'ObjectMapper'
  pod 'Kingfisher'
  pod 'ChameleonFramework/Swift', :git => 'https://github.com/ViccAlexander/Chameleon.git'
  pod 'TextFieldEffects'
  pod 'DZNEmptyDataSet'
  
end

post_install do |installer|
   installer.pods_project.build_configurations.each do |config|
       config.build_settings.delete(‘CODE_SIGNING_ALLOWED’)
       config.build_settings.delete(‘CODE_SIGNING_REQUIRED’)
   end
end