Pod::Spec.new do |s|
  s.name             = 'vocsy_epub_viewer'
  s.version          = '1.0.0'
  s.summary          = 'A simple EPUB package for reading EPUB files.'
  s.description      = <<-DESC
  This library provides an easy way to read EPUB files, leveraging powerful tools like FolioReaderKit.
  Includes features such as customizable UI, font rendering, and advanced EPUB parsing.
  DESC
  s.homepage         = 'https://github.com/anjalmaharjan/b_epub'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'anjalmaharjan' => 'heromaharjan@gmail.com' }
  s.source           = { :git => "https://github.com/anjalmaharjan/b_epub", :branch => "main",:tag => s.version.to_s }

  s.source_files = [
    'Classes/**/*',
  ]

  # Flutter dependency
  s.dependency 'Flutter'

  # Declare the FolioReaderKit dependency without source
  # s.dependency 'FolioReaderKit'
  
  # s.dependency 'EpubViewerKit', '~> 0.1.3'
  s.dependency 'b_epub', '~> 1.0.0'

  # s.ios.deployment_target = '13.0'
  # s.dependency 'SSZipArchive', '1.5'


  
end
