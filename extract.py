import re

with open('assets/index-ClG9q0mi.js', 'r', encoding='utf-8') as f:
    text = f.read()

# find JSX strings or literal strings in JS
strings = re.findall(r'"([^"\\]*(?:\\.[^"\\]*)*)"', text)
strings += re.findall(r"'([^'\\]*(?:\\.[^'\\]*)*)'", text)

with open('extracted.txt', 'w', encoding='utf-8') as out:
    seen = set()
    for s in strings:
        s_clean = s.strip()
        if len(s_clean) > 12 and any(c in 'áéíóúàãõâêôçÁÉÍÓÚÀÃÕÂÊÔÇ' for c in s_clean):
            if s_clean not in seen:
                seen.add(s_clean)
                out.write(s_clean + '\n')

print(f"Extracted {len(seen)} Portuguese strings.")
