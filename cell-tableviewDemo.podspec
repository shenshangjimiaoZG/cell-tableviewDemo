Pod::Spec.new do |s|

  s.name         = "cell-tableviewDemo"
  s.version      = "1.1"
  s.summary      = "cell嵌套tableview"


  s.homepage     = "https://github.com/huangping35/cell-tableviewDemo"




  s.license      = "MIT"

  s.author             = { "huangping35" => "huangping@me.com" }

   s.platform     = :ios
   s.platform     = :ios, "8.0"


  s.source       = { :git => "https://github.com/huangping35/cell-tableviewDemo.git", :tag => "1.1" }



  s.source_files  = "cell嵌套tableviewDemo/*.{h,m}"

  s.dependency 'Masonry'
  s.dependency 'IQKeyboardManager'
  s.dependency 'ZYCornerRadius'

   s.requires_arc = true



end
