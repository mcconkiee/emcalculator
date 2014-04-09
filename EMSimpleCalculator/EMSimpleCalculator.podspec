Pod::Spec.new do |s|
  s.name = 'EMSimpleCalculator'
  s.version = '1.0.0'
  s.summary = 'Super simple calc without the scientific mumbo jumbo'
  s.description = 'This calculator was written for 3 reasons- (see the README)'
  s.homepage = 'https://github.com/larsacus/LARSAdController'
  s.author = {
    'Eric McConkie' => 'mcconkiee@gmail.com'
  }
  s.source = {
    :git => 'https://github.com/mcconkiee/emcalculator.git',
    :tag => s.version.to_s
  }
  s.platform = :ios, '6.1'
  s.license = 'MIT'
  s.requires_arc = true
  s.source_files = 'EMSimpleCalculator/src/*.{h,m}'
  s.resources = "EMSimpleCalculator/src/*.{xib}"
end
