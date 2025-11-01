class ApiConstants {
  static const String baseUrl = 'https://api.themoviedb.org/3';
  static const String imageBaseUrl = 'https://image.tmdb.org/t/p/w500';
  static const String apiToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwZTBkYjcxMzAyODliM2UwYjgxMGUzYjdkMjBmMjc5MyIsIm5iZiI6MTY5MTkyOTU2MS43MTksInN1YiI6IjY0ZDhjYmQ5NjNhYWQyMDEwMDIyODFlNSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.3JOVdx59I7fdIcRA91f3lOSrW_aB7FJUgpem0BoEr_g';

  static const String popularMoviesEndpoint = '/movie/popular';

  static Map<String, String> get headers => {
    'Authorization': 'Bearer $apiToken',
    'accept': 'application/json',
  };
}
