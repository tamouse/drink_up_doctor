var gulp        = require('gulp');
var help        = require('gulp-task-listing');
var cp          = require('child_process');
var minifyCss   = require('gulp-minify-css');
var notify      = require("gulp-notify") 
var sass        = require('gulp-ruby-sass') ;
var bower       = require('gulp-bower');
var replace     = require('gulp-replace');
var browserSync = require('browser-sync');

var config = {
    sassPath: "./_sass",
    bowerDir: "./bower_components",
    assetDir: "./assets",
    outputDir: "./_site",
    distDir: "./_dist"
}

var messages = {
  jekyllBuild: '<span style="color: grey">Running:</span> $ jekyll build'
};

gulp.task('help', help);

gulp.task('bower', function() {
  return bower()
         .pipe(gulp.dest(config.bowerDir))
});

gulp.task('jekyll-build', ['css','icons','bower'], function (done) {
  browserSync.notify(messages.jekyllBuild);
  return cp.spawn('bundle', ['exec', 'jekyll', 'build'], {stdio: 'inherit'})
    .on('close', done);
});

gulp.task('jekyll-rebuild', ['jekyll-build'], function () {
  browserSync.reload();
});

gulp.task('icons', function() {
  return gulp.src(
    config.bowerDir + "/fontawesome/fonts/**.*")
         .pipe(gulp.dest(config.assetDir + "/fonts"))
         .pipe(gulp.dest(config.outputDir + "/assets/fonts"));
});

gulp.task('css', function() {
  return sass(config.sassPath + "/main.scss", {
    style: "compressed",
    loadPath: [
      config.sassPath,
      config.bowerDir + "/normalize.scss/",
      config.bowerDir + "/fontawesome/scss"
    ],
    compass: true
  })
         .pipe(minifyCss())
         .pipe(gulp.dest(config.assetDir + "/css"))
         .pipe(gulp.dest(config.outputDir + "/assets/css"))
.pipe(browserSync.stream());

});

gulp.task('build', ['bower', 'icons', 'css' ,'jekyll-build']);

gulp.task('serve', ['build'], function() {
  browserSync.init({
    server: {
      baseDir: "./_site"
    }
  });

  // Start a watch for rebuilds
  gulp.watch(['_sass/*.scss'], ['css'])
  gulp.watch(['_config.yml', '*.html', '*.md', '*.xml', 'pages/**/*.*', '_layouts/*.html', '_includes/*', '_posts/*'], ['jekyll-rebuild']);
});

gulp.task('jekyll-build-dist', ['css','icons','bower'], function () {
  return cp.spawn('bundle', ['exec', 'jekyll', 'build', '--config', '_config.yml,_baseurl.yml', '--destination', config.distDir], {stdio: 'inherit'});
});

gulp.task('dist', ['bower', 'icons', 'css', 'jekyll-build-dist']);

gulp.task('default', ['serve']);
