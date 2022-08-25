abstract class AppStates {}

class AppInitialState extends AppStates {}

class AppBottomNavBarState extends AppStates {}

class AppBottomSheetState extends AppStates {}

class SeedsGetDataLoading extends AppStates {}

class SeedsGetDataSuccess extends AppStates {}

class SeedsGetDataError extends AppStates {
  final dynamic error;

  SeedsGetDataError(this.error);
}

class ToolsGetDataLoading extends AppStates {}

class ToolsGetDataSuccess extends AppStates {}

class ToolsGetDataError extends AppStates {
  final dynamic error;

  ToolsGetDataError(this.error);
}

class PlantsGetDataLoading extends AppStates {}

class PlantsGetDataSuccess extends AppStates {}

class PlantsGetDataError extends AppStates {
  final dynamic error;

  PlantsGetDataError(this.error);
}
