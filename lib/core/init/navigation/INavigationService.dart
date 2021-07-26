abstract class INavigationService {
  Future<void> navigateToPage(String path, Object object);
  Future<void> navigateToClearPage(String path, Object object);
}
