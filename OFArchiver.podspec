
Pod::Spec.new do |s|
s.name             = 'OFArchiver'
s.version          = '0.1.4'
s.summary          = '此项目用于实现对象的归档与解档，归档对象统一保存在 /document/cn_com_company_archive/domain/filename 路径下.'

s.description      = <<-DESC
TODO: Add long description of the pod here.
DESC

s.homepage         = 'https://github.com/Cooooper/OFArchiver'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Coooper' => 'idevhan@gmail.com' }
s.source           = { :git => 'https://github.com/idevhan@gmail.com/OFArchiver.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'

s.source_files = 'OFArchiver/Classes/**/*'

end
