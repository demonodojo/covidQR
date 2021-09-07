
namespace :covid do
  desc 'Loads value sets from https://raw.githubusercontent.com/ehn-dcc-development/ehn-dcc-schema/release/1.3.0/valuesets/'
  task load_value_sets: :environment do
    base = 'https://raw.githubusercontent.com/ehn-dcc-development/ehn-dcc-schema/release/1.3.0/valuesets'
    Rails.logger.info("Loading countries")
    ValueSetLoader.load("#{base}/country-2-codes.json")
    Rails.logger.info("Loading disease agent targeted")
    ValueSetLoader.load("#{base}/disease-agent-targeted.json")
    Rails.logger.info("Loading test manfs")
    ValueSetLoader.load("#{base}/test-manf.json")
    Rails.logger.info("Loading test results")
    ValueSetLoader.load("#{base}/test-result.json")
    Rails.logger.info("Loading test types")
    ValueSetLoader.load("#{base}/test-type.json")
    Rails.logger.info("Loading vaccine mah manf")
    ValueSetLoader.load("#{base}/vaccine-mah-manf.json")
    Rails.logger.info("Loading vaccine medical products")
    ValueSetLoader.load("#{base}/vaccine-medicinal-product.json")
    Rails.logger.info("Loading vaccine profilaxies")
    ValueSetLoader.load("#{base}/vaccine-prophylaxis.json")

  end
end