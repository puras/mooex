'use strict'

module.exports = function(grunt) {
    grunt.initConfig({
        pkg: grunt.file.readJSON('package.json'),
        clean: {
            files: ['dist']
        },
        watch: {
            coffee: {
                files: ['app/{,*/}*.coffee'],
                tasks: ['coffee:dist']
            },
            copy: {
                files: ['app/views/**'],
                tasks: ['copy']
            },
            express: {
                files: ['app/.tmp/app/**/*.js'],
                tasks: ['express:dev'],
                options: {
                    spawn: false
                }
            }
        },
        express: {
            options: {
 
            },
            dev: {
                options: {
                    script: 'app/.tmp/app/server.js'
                }
            },
            prod: {
                options: {
                    script: 'path/to/prod/server.js',
                    node_env: 'production'
                }
            },
            test: {
                options: {
                    script: 'path/to/test/server.js'
                }
            }
        },
        coffee: {
            dist: {
                files: [{
                    expand: true,
                    cwd: 'app',
                    src: '{,*/}*.coffee',
                    dest: 'app/.tmp/app',
                    ext: '.js'
                }]
            },
            test: {
                files: [{
                    expand: true,
                    cwd: '',
                    src: '{,*/}*.coffee',
                    dest: 'app/.tmp/spec',
                    ext: '.js'
                }]
            }
        },
        copy: {
            main: {
                expand: true,
                files: [
                    {
                        expand: true,
                        cwd: 'app/views',
                        src: ['**/*.jade'],
                        dest: 'app/.tmp/app/views/'
                    }
                ]
            }
        }
    });

    grunt.loadNpmTasks('grunt-contrib-coffee');
    grunt.loadNpmTasks('grunt-contrib-watch');
    grunt.loadNpmTasks('grunt-express-server');
    grunt.loadNpmTasks('grunt-contrib-copy');


    grunt.registerTask('default', ['coffee:dist', 'copy', 'express:dev', 'watch']);
};