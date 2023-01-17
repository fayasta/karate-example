function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }
  var config = {
    base_url: 'https://conduit.productionready.io/api/'
  }
  if (env == 'dev') {
    config.userEmail = 'karate@test.com'
    config.userPassword = 'Karate123'
  } else if (env == 'qa') {
    config.userEmail = 'karate2@test.com'
    config.userPassword = 'Karate456'
  }

  var accessToken = karate.callSingle('classpath:helpers/createToke.feature', config).response
  karate.configure('headers',{Authorization: 'Token '+ accessToken})
  return config;
}