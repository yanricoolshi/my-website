#!/usr/bin/env python3
import re

with open(r'c:\Users\akoda\Documents\GitHub\my-website\index.html', 'r', encoding='utf-8') as f:
    content = f.read()

# Fix broken interests section
broken_pattern = r'<img src="images/capsule_616x353\.jpg" alt="Game capsule"\s+style="max-width: 300px; display: block; margin: 15px 0;" />\s+<li>Old Call of Duty'

fixed_replacement = '''<img src="images/capsule_616x353.jpg" alt="Game capsule"
                        style="max-width: 300px; display: block; margin: 15px 0;" />
                    <p>Here's a comprehensive list of things I'm into:</p>

                    <h3>FPS & Action Games</h3>
                    <div class="interest-list">
                        <ul>
                            <li>Halo</li>
                            <li>Crysis</li>
                            <li>S.T.A.L.K.E.R.</li>
                            <li>Fallout</li>
                            <li>Metal Gear (kojima is a hero in this site)</li>
                            <li>SWAT series (especially SWAT 4)</li>
                            <li>Old Call of Duty'''

content = re.sub(broken_pattern, fixed_replacement, content)

# Remove guestbook iframe  
iframe_pattern = r'<div class="guestbook-container"[^>]*>.*?<iframe.*?</iframe>\s*</div>'
iframe_replacement = '<p>Sign my guestbook: <a href="https://yanri.atabook.org/" target="_blank">yanri.atabook.org</a></p>'
content = re.sub(iframe_pattern, iframe_replacement, content, flags=re.DOTALL)

with open(r'c:\Users\akoda\Documents\GitHub\my-website\index.html', 'w', encoding='utf-8') as f:
    f.write(content)

print("Fixed HTML structure and removed iframe")
