Pod::Spec.new do |s|
  s.name = 'NcSejima'
  s.version = '0.7.0'
  s.license = 'MIT'
  s.summary = 'NcSejima is a framework that expose reusable components.'
  s.description  = <<-DESC
    As we always use the same or a really close object, we made severals components that we want to share with you.
                   DESC
  s.homepage = 'https://github.com/MoveUpwards/NcSejima.git'
  s.authors = { 'Damien NOËL DUBUISSON' => 'damien@slide-r.com', 'Loïc GRIFFIÉ' => 'loic@slide-r.com' }
  s.source = { :git => 'https://github.com/MoveUpwards/NcSejima.git', :tag => s.version }
  s.swift_version           = '5.2'
  s.ios.deployment_target   = '9.1'
  s.source_files            = 'NcSejima/Sources/**/*.swift'
  s.frameworks              = 'Foundation'
end
