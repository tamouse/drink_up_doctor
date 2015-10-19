require "thor"
require "yaml"

module DrinkUpDoctor
  class NewTwbsSite < Thor::Group
    include Thor::Actions

    def app_name
      @app_name || File.basename($0)
    end

    argument :name
    class_option :title, default: "My awesome site", desc: "Title of your jekyll site", type: :string, aliases: '-t'
    class_option :author, default: "Me", desc: "Author of the site", type: :string, aliases: '-a'
    class_option :email, default: "me@example.com", desc: "Author's Email", type: :string, aliases: '-e'
    class_option :description, default: "My awesome site", type: :string, aliases: '-d'
    class_option :url, default: "http://example.com", desc: "Home Page for the Site", type: :string, aliases: '-u'
    class_option :twitter_username, default: "me", desc: "Twitter User", type: :string, aliases: '-T'
    class_option :github_username, default: "me", desc: "Github User", type: :string, aliases: '-G'
    class_option :baseurl, default: "", desc: "Base url of the site, e.g. '/blog' that is the root of the site", type: :string

    def self.source_root
      File.expand_path("../../../", __FILE__)
    end

    def create_project_directory
      empty_directory name
    end

    def create_config
      config_file = "#{name}/_config.yml"
      config = {"name" => name}
      config.merge! options
      config.merge!({
          "social" => {
            "twitter" => options["twitter_username"],
            "github"  => options["github_username"]
          },
          "baseurl" => "",
          "markdown" => "kramdown",
          "kramdown" => {
            "input" => "GFM",
            "hard_wrap" => false
          },
          "highlighter" => "pygments",
          "defaults" => {
            "author" => options["author"]
          },
          "exclude" => %w[README.md bower.json package.json gulpfile.js node_modules bower_components]
        })
      create_file config_file, config.to_yaml
      prepend_to_file config_file, "# Generated by #{app_name}\n"
    end

    def create_baseurl_config
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

    def copy_gemfile
      copy_file "templates/Gemfile", "#{name}/Gemfile"
    end

    def create_setup
      copy_file "templates/setup.sh", "#{name}/.setup.sh"
      chmod "#{name}/.setup.sh", 0755
    end

    def copy_bootstrap_boilerplate
      directory "bootstrap-boilerplate", name
    end
  end
end
