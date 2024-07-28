class RemoteEndpoints {
  static const String domain = 'https://kemon.com.bd';
  static const String _baseUrl = 'https://api.kemon.com.bd';

  //! business
  static Uri get listingsByCategory => Uri.parse('$_baseUrl/listing-by-category');
  static Uri get findListing => Uri.parse('$_baseUrl/business');

  //! category
  static Uri get featuredCategories => Uri.parse('$_baseUrl/featured-categories');

  //! industry
  static Uri get industries => Uri.parse('$_baseUrl/categories');

  //! location
  static Uri get featuredLocations => Uri.parse('$_baseUrl/featured-locations');

  //! login
  static Uri get login => Uri.parse('$_baseUrl/token');

  //! lookup
  static Uri get lookup => Uri.parse('$_baseUrl/get-lookup');

  //! profile
  static Uri get profile => Uri.parse('$_baseUrl/profile');
  static Uri get updateProfile => Uri.parse('$_baseUrl/update-profile');
}
