Jekyll::Hooks.register :site, :before_init do
  puts "Running pre-build Python script..."
  system("python3 scripts/update_html_links.py") or raise "Python pre-build script failed!"
end