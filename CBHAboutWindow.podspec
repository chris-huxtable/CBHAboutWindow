Pod::Spec.new do |spec|

  spec.name                   = 'CBHAboutWindow'
  spec.version                = '1.1.0'
  spec.module_name            = 'CBHAboutWindow'

  spec.summary                = 'A fancier about window.'
  spec.homepage               = 'https://github.com/chris-huxtable/CBHAboutWindow'

  spec.license                = { :type => 'ISC', :file => 'LICENSE' }

  spec.author                 = { 'Chris Huxtable' => 'chris@huxtable.ca' }
  spec.social_media_url       = 'https://twitter.com/@Chris_Huxtable'

  spec.osx.deployment_target  = '10.10'

  spec.source                 = { :git => 'https://github.com/chris-huxtable/CBHAboutWindow.git', :tag => "v#{spec.version}" }

  spec.requires_arc           = true

  spec.public_header_files    = 'CBHAboutWindow/*.h'
  spec.private_header_files   = 'CBHAboutWindow/_*.h'
  spec.source_files           = 'CBHAboutWindow/*.{h,m}'

end
