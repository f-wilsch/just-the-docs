# _plugins/auto_docs.rb
module Jekyll
  class IndexPage < Page
    def initialize(site, dir, title, parent=nil)
      @site = site
      @base = site.source
      @dir  = dir
      @name = 'index.md'
      self.process(@name)
      self.read_yaml(File.join(site.source, '_layouts'), 'default.html') rescue nil
      self.data ||= {}
      self.data['layout'] = 'default'
      self.data['title'] = title
      self.data['has_children'] = true
      self.data['parent'] = parent if parent
      self.content = "Auto-generated section for #{title}.\n"
    end
  end

  class IframePage < Page
    def initialize(site, dir, name, title, parent=nil, grand_parent=nil, src_rel=nil)
      @site = site
      @base = site.source
      @dir  = dir
      @name = name
      self.process(name)
      self.read_yaml(File.join(site.source, '_layouts'), 'default.html') rescue nil
      self.data ||= {}
      self.data['layout'] = 'default'
      self.data['title'] = title
      self.data['parent'] = parent if parent
      self.data['grand_parent'] = grand_parent if grand_parent
      # Use Liquid so baseurl is handled
      src_liquid = "{{ '#{src_rel}' | relative_url }}"
      self.content = %Q{<iframe src="#{src_liquid}" style="width:100%; height:80vh; border:0;" loading="lazy"></iframe>\n}
    end
  end

  class AutoDocsGenerator < Generator
    safe true
    priority :low

    def generate(site)
      root = File.join(site.source, 'DocumentationHTML', 'Documentation', 'html')
      return unless Dir.exist?(root)

      # Top-level section under /docs/
      top_title = 'Documentation'
      top_dir   = 'docs'
      site.pages << IndexPage.new(site, top_dir, top_title, nil)

      Dir.glob(File.join(root, '**', '*.html')).sort.each do |html_path|
        rel = html_path.sub(root + '/', '')
        segments = rel.split(File::SEPARATOR)
        fname = segments.pop
        next if fname == 'index.html'

        # Titles from directory names and file name
        parents_titles = segments.map { |s| titleize(s) }
        file_stem = File.basename(fname, '.html') # preserves case, e.g., "BasisOperator" 
        file_title = file_stem # keep title as-is (no titleize) 
        # file_title     = titleize(File.basename(fname, '.html'))

        # Create nested index pages (up to grandchild)
        current_dir    = top_dir
        parent_title   = top_title
        parents_titles.each_with_index do |pt, i|
          current_dir = File.join(current_dir, slugify(pt))
          unless site.pages.any? { |p| p.url == "/#{current_dir}/" }
            site.pages << IndexPage.new(site, current_dir, pt, (i.zero? ? top_title : parents_titles[i-1]))
          end
          parent_title = pt
        end

        # Determine where wrapper lives and its parent/grand_parent
        page_dir          = current_dir
        parent_for_child  = parents_titles.empty? ? top_title : parents_titles.last
        grand_parent      = if parents_titles.length >= 2
                              parents_titles[-2]
                            elsif parents_titles.empty?
                              nil
                            else
                              top_title
                            end

        src_rel = "/DocumentationHTML/Documentation/html/#{rel}"
        
        # name    = slugify(file_title) + '.md'
        # site.pages << IframePage.new(site, page_dir, name, file_title, parent_for_child, grand_parent, src_rel)
        name = "#{file_stem}.md" # preserves case for output file 
        site.pages << IframePage.new(site, page_dir, name, file_title, parent_for_child, grand_parent, src_rel)
      end
    end

    def titleize(str)
      str.tr('_-', ' ').split.map(&:capitalize).join(' ')
    end

    def slugify(str)
      str.downcase.gsub(/[^a-z0-9]+/, '-').gsub(/^-|-$/, '')
    end
  end
end