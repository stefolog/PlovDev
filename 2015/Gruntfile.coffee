module.exports = (grunt) ->
  grunt.initConfig
    watch:
      options:
        spawn: false
      coffee:
        files: 'dist/coffee/**/*.coffee'
        tasks: 'js'

    clean:
      genjs: 'js-gen'

    coffee:
      options:
        bare: true
      files:
        expand: true
        cwd: './dist/coffee/'
        src: '**/*.coffee'
        dest: './dist/js-gen/'
        ext: '.js'

    ftpush:
      build:
        auth:
          host: 'plovdev.com'
          port: 21
          authKey: 'plovdev'
        src: '.'
        dest: '/public_html/2015'
        exclusions: ['**/.DS_Store', '**/Thumbs.db', 'node_modules', '.git', '.gitignore', 'package.json', '.ftppass', '.grunt', '**/*.coffee']


  # Load tasks
  grunt.loadNpmTasks('grunt-contrib-clean')
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.loadNpmTasks('grunt-contrib-ftpush')

  # Define tasks
  grunt.registerTask 'js', [
    'clean'
    'coffee'
  ]

  grunt.registerTask 'default', [
    'js'
  ]

  grunt.registerTask 'deploy', [
    'js'
    'ftpush:build'
  ]
