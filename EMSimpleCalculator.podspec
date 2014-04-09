Pod::Spec.new do |s|
  s.name         = "EMSimpleCalculator"
  s.version      = "1.0.0"
  s.summary      = "A basic calculator without all the scientific mumbo jumbo"

  s.description  = <<-DESC
                   This calculator was written for 3 reasons:

* we needed a ***basic*** calculator that was skimable
* it needed to update on *operator*. e.g. User taps `5 + 5 + 2`. Obviously on `=` the display will ready 12. However on pressing the 2nd `+` we needed this to calculate and update the display so it would read `10` before the user presses the next digit/decimal
* there were 2 keys hard to find in an open source solution

  - **&#9003;** backspace
  - **+/-** toggle
  
  
and there you go.
                   DESC

  s.homepage     = "https://github.com/mcconkiee/emcalculator"
  s.license      = { :type => 'MIT', :file => 'FILE_LICENSE' }
  s.author             = { "Eric McConkie" => "mcconkiee@gmail.com" }
  s.platform     = :ios  
  s.source       = { :git => "https://github.com/mcconkiee/emcalculator", :tag => "1.0.0" }
  s.requires_arc  = true
  s.source_files    = 'EMSimpleCalculator/src/*.{h,m}'
  s.exclude_files   = 'Classes/Exclude'
  s.resource  = "src/*.xib"
  
end
