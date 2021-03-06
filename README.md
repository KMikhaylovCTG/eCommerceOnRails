# eCommerceOnRails
eCommerce on Rails  project is designed to showcase Ruby on Rails Framework in developing ecommerce platform. 

#Business Requirements

* Admin Services
  * Product Management - CRUD
  * Category Management - CRUD
  * Order Management - View Only
  * User Management - Create/View Only

* Store Services
  * Product Listing - View Only
  * Category Listing - View Only
  * Shopping Cart - CRUD
  * Order Placement - Create Only

# Technical Requirements
The following is the list of services required to set up and run eCommerce on Rails project

* Frontend - in addition to out of the box Rails 4 gems such as Byebug, Turbolinks, SDoc, etc... the following frameworks are being utilized in the project
  * CSS Framework is based on Twitter Bootstrap 3 - http://getbootstrap.com
  * SASS Preprocessor - http://sass-lang.com
  * Image Upload Services utilizes PaperClip Gem - https://github.com/thoughtbot/paperclip
  * Authentication Services utilizes Devise Gem - https://github.com/plataformatec/devise
  * Friendly Url utilizes Friendly Id Gem - https://github.com/norman/friendly_id

* Backend
 * PostgreSQL is selected as RDBMS for this project

# Application Setup 
eCommerce on Rails is broken down into two Rails application each designed to fulfil business requirements outlined above. 

* Backend Rails application (Store Administration)
  * Contains all of the models as well as migration files and seed data for eCommerce application. Run `rake db:seed` in order to populate database with the initial sets of data. Please note seed.rb file is located in Backend Rails application.
    ```
    Order.delete_all
    CartLineItem.delete_all
    Cart.delete_all
    
    
    Category.delete_all
    Category.create(id: 1, title: 'Paintings', slug: 'paintings', description: 'Paniting by Famouse artists', sort_order: 1, meta_title: 'Paintings', meta_description: 'Paniting by Famouse artists', meta_keywords: 'paintings')
    Category.create(id: 2, title: 'Photos', slug: 'photos', description: 'Photos by Famouse artists', sort_order: 2, meta_title: 'Photos', meta_description: 'Photos by Famouse artists', meta_keywords: 'paintings')
    
    Product.delete_all
    Product.create(id:1, title: 'Tulips', slug: 'tulips', description: 'Photo of Tulips for sale', meta_title: 'Tulips', meta_description: 'Photo of Tulips for sale', meta_keywords: 'tulips')
    Product.create(id:2, title: 'Desert', slug: 'desert', description: 'Photo of Desert for sale', meta_title: 'Desert', meta_description: 'Photo of Desert for sale', meta_keywords: 'desert')
    Product.create(id:3, title: 'Penguins', slug: 'penguins', description: 'Photo of Penguins for sale', meta_title: 'Penguins', meta_description: 'Photo of Penguins for sale', meta_keywords: 'penguins')
    
    Image.delete_all
    Image.create(id:1, file_name: 'tulips.jpg', title: 'Tulips', description: 'Photo of Tulips for sale', meta_alt: 'Tulips', product_id: 1, asset_file_name: 'Tulips.jpg', asset_content_type: 'image/jpg', asset_file_size: 620888, asset_updated_at: '2015-09-22')
    Image.create(id:2, file_name: 'desert.jpg', title: 'Desert', description: 'Paintings of Desert for sale', meta_alt: 'Desert', product_id: 2, asset_file_name: 'Desert.jpg', asset_content_type: 'image/jpg', asset_file_size: 845941, asset_updated_at: '2015-09-22')
    Image.create(id:3, file_name: 'penguins.jpg', title: 'Penguins', description: 'Photo of Penguins for sale', meta_alt: 'Penguins', product_id: 3, asset_file_name: 'Penguins.jpg', asset_content_type: 'image/jpg', asset_file_size: 777835, asset_updated_at: '2015-09-22')
    
    Variant.delete_all
    Variant.create(id:1, sku: 'sku001', price: '15.00', stock_level: '10', is_prime: true, product_id: '1', category_id: '1')
    Variant.create(id:2, sku: 'sku002', price: '30.00', stock_level: '10', is_prime: true, product_id: '2', category_id: '1')
    Variant.create(id:3, sku: 'sku003', price: '45.00', stock_level: '10', is_prime: true, product_id: '3', category_id: '2')
    ```
  * Backend application is protected with authentication by Devise and initial user registration is required
  * Requires the following Gems to be included in Gemfile in addition to standard Rails 4 out of the box Gems. Make sure ot run `bundle install` on your machine for below listed gems to be installed
    * gem "devise"
    * gem "paperclip", "~> 4.3"
    * gem "friendly_id", "~> 5.0.1"
    * gem "pg"
    
* Frontend Rails application (Store Catalog + Shopping Cart)
  * Contains eCommerce shopping cart and order placement code as well as sharing models from Backend Rails application
    * There is a specific Rake Task setup to synchronize all of the project models as well as assets from the Backend Application. This file is called sync.rake and is <b>required</b> to be ran via rake `rake sync:copy` command <b>every time new model is added or updated</b> to the Backend Rails application in addition to out of the box Rails 4 gems or <b>new images are loaded via admin interface</b> for products!
    ```
    namespace :sync do
    
      desc 'Copy common models and tests from Master'
      task :copy do
        source_path = 'C:\DEV\eCommerceOnRails\backend'
        dest_path = 'C:\DEV\eCommerceOnRails\frontend'
    
        # Copy all models & tests
        %x{cp #{source_path}/app/models/*.rb #{dest_path}/app/models/}
        %x{cp #{source_path}/test/models/*_test.rb #{dest_path}/test/models/}
    
        # Fixtures
        %x{cp #{source_path}/test/fixtures/*.yml #{dest_path}/test/fixtures/}
    
        # Database YML
        %x{cp #{source_path}/config/database.yml #{dest_path}/config/database.yml}
    
        # CSS/JS
         %x{cp #{source_path}/vendor/assets/stylesheets/main.css #{dest_path}/vendor/assets/stylesheets/main.css}
    
        #Images recursive copy for uploaded assets
        %x{cp -r #{source_path}/public/system/images/assets/* #{dest_path}/public/system/images/assets/}
    
    
      end
    end
   ```
  * Requires the following Gems to be included in Gemfile in addition to standard Rails 4 out of the box Gems. Make sure ot run `bundle install` on your machine for below listed gems to be installed in addition to out of the box Rails 4 gems.
    * gem "devise"
    * gem "paperclip", "~> 4.3"
    * gem "friendly_id", "~> 5.0.1"
    * gem "pg"


# Testing Approach
RSpec is used as our unit testing tool. This project has unit test setup to validate each project's models required fields as well as controllers for presence of required actions as outlined in business requirements. Test Database must be provisioned and synced up with the project development database via `rake db:migrate RAILS_ENV=test`

This project is tested via executing individual test files via `rake test TEST=path_to_test_file` command line. 
Manual testing was performed for visual as well as integration testing

* Tests types set up with backend and frontend Rails applications are: 
 * Required Fields Validations
 * Uniqueness of the fields validations
 * Controller actions validations
 * Index presence validations

# Project Priorities in the order of development
* Architecture Design
 1. Define project domain and outline models for Products, Variants, Categories, Images, Carts and Orders
 2. Select Frontend Frameworks and set it up
 3. Select authentication framework and set it up 
 4. Select gems for image upload and friendly url
 5. Decide on project breakdown into two Backend and Frontend Rails applications for better separation of concerns, scalability and security

* Backend Rails application development
 1. Created initial Model migrations files as well as Controllers for the backend project
 2. Added and run unit test to ensure validations have been set up for models and controllers
 3. Ensured appropriate validations have been set up
 4. Added Bootstrap templated solution to the project
 5. Created views for backend Rails application
 6. Set up Authentication with the help of Devise Gem
 7. Populated test data for products, categories, images via admin UI and perform manual test
 8.  Added Friendly Url via Friendly_id Gem

* Frontend Rails application development
 1. Created sync.rake file for Models synchronization for the fronted project based on backend project migration files
 2. Added unit tests for frontend application controllers
 3. Generated frontend controllers for viewing Catalog of products as well as Shopping Cart management and Order placement
 4. Created Cart and Order models via backend migrations files
 5. Added Bootstrap templated solution to the project
 6. Created views for handling catalog, shopping cart and order placement functionality
 7. Added Friendly Url via Friendly_id Gem
 8. Manually tested shopping cart and order placement

* Wrote documentation
 1. Business and Technical Requirements
 2. Application Setup
 3. Testing strategy

# Additional Information 

* Important project considerations
 * Products are set up to have corresponding Variants for handling of product combinations based on size/color or other options as may be required in the future of this project
 * Variants can be two types: master and secondary. 
 * Each product must have at least one variant
 * Catalog displayes products with master variants only, secondary variants are incorporated as a model by not displayed on the site
 * Images are assigned directly to product model for now but can be extended by adding images to specific product variants
 * Categories are assigned to Variants and Products are filtered via Variants affiliation with the category
 * Categories are designed to be self referenced models via Category.Id and Category.parent_id but not implemented in code
 * Taxonomy model in the form of many to many relationship between Variant and Category models is set up but not currently used
 * CanCan gem will be preferred choice for authorization implementation for future development
 * FactoryGirl gem will be preferred choice for unit testing for future development
 * Added Devise authentication as an extra binus for the project
 * Missed managing stock level requirement during alloted timeframe but will add this functionality as post release addition
 * Free Bootrtap template used for CSS/HTML look and feel of the site 
 * Optimization for the site needed such as better encapuslation with additonal private methods, partial pages for better html/css reuse. 
 * Delete for Categories, Products, Variants is avaible but not exposed via UI. 
 * Product stock level is tracked by the site and add to cart button is disbaled if product becomes our of stock
 * Check for product stock if performed by adding number of items in the shopping cart and number of selected items in the quantity text box next to "add to cart" button.

* Credits
 * Bootstrap Free Template by Themeum - http://www.themeum.com/
 * Sharing models between two projects approach - http://hiltmon.com/blog/2013/10/14/rails-tricks-sharing-the-model


