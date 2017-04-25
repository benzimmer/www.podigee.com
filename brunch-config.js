// See http://brunch.io for documentation.
exports.files = {
  javascripts: {
    joinTo: {
      'js/vendor.js': /^themes\/podigee\/src\/vendor/,
      'js/jquery.js': /^themes\/podigee\/src\/vendor\/jquery.js/,
      'js/app.js': /^themes\/podigee\/src\/js/
    }
  },
  stylesheets: {
    joinTo: {
      '/css/app.css': /css\/styles.scss$/
    }
  }
};

exports.plugins = {
  babel: {presets: ['latest']},
  sass: {
    debug: 'comments',
    mode: 'native'
  }
};

exports.paths = {
  public: 'themes/podigee/static',
  watched: ['themes/podigee/src/']
};
