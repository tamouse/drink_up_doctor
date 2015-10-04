require "thor"

module DrinkUpDoctor
  class NewSite < Thor::Group
    include Thor::Actions

    argument :name
    class_option :author, default: "no one", desc: "Author of the site", type: :string
    class_option :home_page, default: "none", desc: "Home Page for the Site", type: :string
    class_option :description, default: "new site", type: :string

    def self.source_root
      File.expand_path("../../../", __FILE__)
    end

    def create_project_directory
      empty_directory name
    end

    def create_jekyll_project
      unless run "jekyll new #{name}"
        warn "#{File.basename($0)} must be run on a new directory"
        exit -1
      end
    end

    def create_bower_file
      template "templates/bower.json.erb", "#{name}/bower.json"
    end

    def create_package_file
      template "templates/package.json.erb", "#{name}/package.json"
    end

    def copy_gulp_file
      copy_file "templates/gulp.js", "#{name}/gulpfile.js"
    end

    def append_gitinore_file
      append_to_file "#{name}/.gitignore", %Q{

# Added by #{$0}
/_site/
/.sass-cache/
/node_modules/
/assets/
/bower_components/
.DS_Store

}

    end

    def exclude_files
      append_to_file "#{name}/_config.yml", %Q{

# Added by #{$0}
exclude: [README.md, bower.json, package.json, gulpfile.js, node_modules, bower_components]

}

    end

    def remove_main_scss
      remove_file "#{name}/css/main.scss"
    end

    def copy_new_main_scss
      copy_file "templates/main.scss", "#{name}/_sass/main.scss"
    end

    def update_for_assets
      gsub_file("#{name}/_includes/head.html", %r{/css/main.css},"/assets/css/main.css")
    end

    def create_readme_for_site
      template "templates/README.md.erb", "#{name}/README.me"
    end

    def edit_footer
      gsub_file("#{name}/_includes/footer.html",%r{<span class="icon.*?github">.*?</span>}ms, "<i class=\"fa fa-github\"></i>")
      gsub_file("#{name}/_includes/footer.html",%r{<span class="icon.*?twitter">.*?</span>}ms, "<i class=\"fa fa-twitter\"></i>")
    end

    def edit_header
      gsub_file("#{name}/_includes/header.html",%r{<svg.*?>.*</svg>}ms, "<i class=\"fa fa-bars\"></i>")
      gsub_file("#{name}/_includes/header.html",%r{if page.title}, "if page.navbar")
    end

    def edit_about
      insert_into_file("#{name}/about.md", "navbar: true\n", after: %r{title:.*\n})
    end
  end
end
