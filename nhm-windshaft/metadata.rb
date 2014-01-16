name             'nhm-windshaft'
maintainer       'Andy Allan'
maintainer_email 'andy@gravitystorm.co.uk'
license          'All rights reserved'
description      'Installs/Configures nhm-windshaft'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "apt"
depends "postgres"
depends "nodejs", "1.3.0"
