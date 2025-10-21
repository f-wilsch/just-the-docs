import os
import re

# Input and output directories
INPUT_DIR = "../DocumentationHTML/Documentation/html"   # <-- change this
OUTPUT_DIR = "../DocumentationHTML/Documentation/html-mod" # <-- change this

# Patterns to rewrite: { old_prefix: new_prefix }
LINK_PATTERNS = {
    r'href="\.\./ref/([^"]+)"': r'href="/docs/ref/\1"',
    r'href="\.\./guide/([^"]+)"': r'href="/docs/guide/\1"',
    r'href="\.\./tutorial/([^"]+)"': r'href="/docs/tutorial/\1"',
}

def process_html_content(content):
    """Inject base tag and rewrite href links."""
    # Inject <base target="_top"> inside <head> if not already present
    if '<base target="_top">' not in content:
        content = re.sub(
            r"(<head[^>]*>)",
            r"\1\n    <base target=\"_top\">",
            content,
            count=1,
            flags=re.IGNORECASE,
        )

    # Apply link rewrites
    for old_pattern, new_pattern in LINK_PATTERNS.items():
        content = re.sub(old_pattern, new_pattern, content)

    return content

def process_html_file(input_path, output_path):
    """Read, process, and write the modified HTML file."""
    with open(input_path, "r", encoding="utf-8") as f:
        content = f.read()

    new_content = process_html_content(content)

    # Ensure output directory exists
    os.makedirs(os.path.dirname(output_path), exist_ok=True)

    # Write modified file to the output directory
    with open(output_path, "w", encoding="utf-8") as f:
        f.write(new_content)

def main():
    for root, _, files in os.walk(INPUT_DIR):
        for filename in files:
            if filename.lower().endswith(".html"):
                input_path = os.path.join(root, filename)
                relative_path = os.path.relpath(input_path, INPUT_DIR)
                output_path = os.path.join(OUTPUT_DIR, relative_path)

                print(f"Processing {relative_path}")
                process_html_file(input_path, output_path)
            else:
                # Copy non-HTML files unchanged
                input_path = os.path.join(root, filename)
                relative_path = os.path.relpath(input_path, INPUT_DIR)
                output_path = os.path.join(OUTPUT_DIR, relative_path)

                os.makedirs(os.path.dirname(output_path), exist_ok=True)
                with open(input_path, "rb") as src, open(output_path, "wb") as dst:
                    dst.write(src.read())

if __name__ == "__main__":
    main()