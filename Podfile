
platform:ios, '11.0'
use_frameworks!

target 'svgChangeColor' do
    
    pod 'SVGKit', :git => 'https://github.com/SVGKit/SVGKit.git', :branch => '3.x'
    pod 'Cache',  :git => 'https://github.com/hyperoslo/Cache.git'


end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
            config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS'] = 'NO'
            config.build_settings['VALID_ARCHS'] = 'arm64'
            if config.name != 'Debug'
                config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Owholemodule'
                else
                config.build_settings['SWIFT_OPTIMIZATION_LEVEL'] = '-Onone'
            end
        end
    end
end
