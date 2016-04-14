require '../lib/engine.rb'

`cd "../lib/flex-pmd-command-line-1.2";java -Xmx256m -jar flex-pmd-command-line-1.2.jar -s /code -o ../../lib/results`


Engine.parse(File.readlines('../lib/results/pmd.xml'))
