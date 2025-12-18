# Python script to safely replace content in index.html
with open('index.html', 'r', encoding='utf-8') as f:
    lines = f.readlines()

# Read the new About Me content
with open('index_new_about.html', 'r', encoding='utf-8') as f:
    new_about = f.read()

# Find the lines to replace (after audio tag, before Latest Updates h2)
# Lines 359-368 need to be replaced with new content
output_lines = lines[:360]  # Keep everything up to and including line 360 (audio tag)
output_lines.append('\r\n')
output_lines.append(new_about)
output_lines.append('\r\n')
output_lines.extend(lines[361:])  # Add rest starting from line 362 (Latest Updates)

with open('index.html', 'w', encoding='utf-8') as f:
    f.writelines(output_lines)

print("File updated successfully!")
