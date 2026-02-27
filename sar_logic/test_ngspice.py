import subprocess
import re

# 簡単なspiceファイルをngspiceで実行
spice = """
Vtest n1 gnd 1.8
R1 n1 n2 1k
R2 n2 gnd 1k
.op
.end
"""

with open('/tmp/test.spice', 'w') as f:
    f.write(spice)

result = subprocess.run(['ngspice', '-b', '/tmp/test.spice'],
                       capture_output=True, text=True)
print(result.stdout)
print(result.stderr)
