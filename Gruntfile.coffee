module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    coffee:
      compile:
        files:
          'build/blurry_search.js': ['src/blurry_search.coffee']
      compileSpecs:
        expand: true
        cwd: 'test/coffeescripts'
        src: ['shared_examples/*.coffee', '**/*.coffee']
        dest: 'test/javascripts/'
        ext: '.js'

    uglify:
      options:
        mangle: true,
        compress: true,
        report: 'gzip'
      dist:
        files:
          'build/blurry_search.min.js': ['build/blurry_search.js']

    watch:
      files: ['**/*.coffee']
      tasks: ['coffee', 'uglify']

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-watch')
  grunt.loadNpmTasks('grunt-contrib-uglify')

  grunt.registerTask('default', ['coffee', 'watch'])
