abstract class NewsStates {}

class NewsInitiaState extends NewsStates {}

class NewsBottomNavBarState extends NewsStates {}

class NewsGetLoadsState extends NewsStates {}

class NewsGetBusinessSuccessState extends NewsStates {}

class NewsGetBusinessErrorState extends NewsStates {
  late final String error;

  NewsGetBusinessErrorState(this.error);
}

class NewsGetSportsSuccessState extends NewsStates {}

class NewsGetSportsErrorState extends NewsStates {
  late final String error;

  NewsGetSportsErrorState(this.error);
}

class NewsGetScienceSuccessState extends NewsStates {}

class NewsGetScienceErrorState extends NewsStates {
  late final String error;

  NewsGetScienceErrorState(this.error);

  
}
class NewsSearchSuccessState extends NewsStates {}

class NewsGetSearchErrorState extends NewsStates {
  late final String error;
    NewsGetSearchErrorState(this.error);
}