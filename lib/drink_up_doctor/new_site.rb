require "thor"
require "yaml"

module DrinkUpDoctor
  class NewSite < Thor::Group
    include Thor::Actions

    def app_name
      @app_name || File.basename($0)
    end

    argument :name
    class_option :title, default: "My awesome site", desc: "Title of your jekyll site", type: :string, aliases: '-t'
    class_option :author, default: "Me", desc: "Author of the site", type: :string, aliases: '-a'
    class_option :email, default: "me@example.com", desc: "Author's Email", type: :string, aliases: '-e'
    class_option :description, default: "My awesome site", type: :string, aliases: '-d'
    class_option :url, default: "", desc: "Home Page for the Site", type: :string, aliases: '-u'
    class_option :twitter_username, default: "", desc: "Twitter User", type: :string, aliases: '-T'
    class_option :github_username, default: "", desc: "Github User", type: :string, aliases: '-G'
    class_option :baseurl, default: "", desc: "Base url of the site, e.g. '/blog' that is the root of the site", type: :string

    def self.source_root
      File.expand_path("../../../", __FILE__)
    end

    def create_project_directory
      empty_directory name
    end

    def create_jekyll_project
      unless run "jekyll new #{name}"
        warn "#{app_name} must be run on a new directory"
        exit -1
      end
    end

    def update_config
      config_file = "#{name}/_config.yml"
      config = YAML.load_file(config_file)
      config.merge! options
      config.merge!({
          "baseurl" => "",
          "markdown" => "kramdown",
          "kramdown" => {
            "input" => "GFM",
            "hard_wrap" => false
          },
          "defaults" => {
            "author" => options["author"]
          }
        })
      remove_file config_file
      create_file config_file, config.to_yaml
      prepend_to_file config_file, "# Generated by #{app_name}\n"
    end

    def create_config_with_baseurl
      config_file = "#{name}/_baseurl.yml"
      config = {
        "baseurl" => options["baseurl"]
      }
      create_file config_file, config.to_yaml
      prepend_to_file config_file, "# Generated by #{app_name}"
    end

    def create_bower_file
      template "templates/bower.json.erb", "#{name}/bower.json"
    end

    def create_package_file
      template "templates/package.json.erb", "#{name}/package.json"
    end

    def copy_gulp_file
      template "templates/gulpfile.js.erb", "#{name}/gulpfile.js"
    end

    def append_gitinore_file
      append_to_file "#{name}/.gitignore", %Q{

# Added by #{app_name}
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

# Added by #{app_name}
exclude: [README.md, bower.json, package.json, gulpfile.js, node_modules, bower_components, Gemfile, Gemfile.lock]

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
      template "templates/README.md.erb", "#{name}/README.md"
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

    def copy_gemfile
      copy_file "templates/Gemfile", "#{name}/Gemfile"
    end

    def create_setup
      copy_file "templates/setup.sh", "#{name}/.setup.sh"
      chmod "#{name}/.setup.sh", 0755
    end

    def print_instructions
      puts <<-instructions

********************************************************************************

  Completing the Installation
  ---------------------------

  Change into the new site directory and run the setup script:


      $ cd "./#{name}"
      $ ./.setup.sh

  This will install the npm modules, bower components, and ruby gems
  needed to work with your new site.

  After the setup is complete, you can start up the gulp server and
  start blogging:

      $ gulp

  When you are ready to publish, shut down the gulp server with Ctrl-C
  and run the distribution build:

      $ gulp dist

  The distribution will be in "./#{name}/_dist/" and you can push that
  to where your site is located. (Github pages, AWS S3, your own server,
  or whatever you choose to use.)

********************************************************************************

instructions
    end
  end
end
