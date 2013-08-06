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

    watch:
      files: ['**/*.coffee']
      tasks: ['coffee']

  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-watch')

  grunt.registerTask('default', ['coffee', 'watch'])
