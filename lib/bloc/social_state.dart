abstract class SocialState {}

class InitialState extends SocialState{}

class BottomNavState extends SocialState{}
class PostScreenState extends SocialState{}

class LoadingGetUserScreen extends SocialState{}
class SuccessGetUserScreen extends SocialState{}
class ErrorGetUserScreen extends SocialState{
  final String error;
  ErrorGetUserScreen(this.error);
}

class LoadingGetAllUser extends SocialState{}
class SuccessGetAllUser extends SocialState{}
class ErrorGetAllUser extends SocialState{
  final String error;
  ErrorGetAllUser(this.error);
}

class ChangeProfileImage extends SocialState{}
class ChangeCoverImage extends SocialState{}
class ShowImagePost extends SocialState{}
class ClearImagePost extends SocialState{}


class LoadingUpdateUser extends SocialState{}
class SuccessUpdateUser extends SocialState{}
class ErrorUpdateUser extends SocialState{
  final String error;
  ErrorUpdateUser(this.error);
}

  class LoadingUpdateProfile extends SocialState{}
  class SuccessUpdateProfile extends SocialState{}
  class ErrorUpdateProfile extends SocialState{
  final String error;
  ErrorUpdateProfile(this.error);
}

class LoadingUpdateCover extends SocialState{}
class SuccessUpdateCover extends SocialState{}
class ErrorUpdateCover extends SocialState{
  final String error;
  ErrorUpdateCover(this.error);
}

class LoadingAddPost extends SocialState{}
class SuccessAddPost extends SocialState{}
class ErrorAddPost extends SocialState{
  final String error;
  ErrorAddPost(this.error);
}

class LoadingPostWithImage extends SocialState{}
class SuccessPostWithImage extends SocialState{}
class ErrorPostWithImage extends SocialState{
  final String error;
  ErrorPostWithImage(this.error);
}

class LoadingGetPostsState extends SocialState{}
class SuccessGetPostsState extends SocialState{}
class ErrorGetPostsState extends SocialState{
  final String error;
  ErrorGetPostsState(this.error);
}


class LoadingAddLikeState extends SocialState{}
class SuccessAddLikeState extends SocialState{}
class ErrorAddLikeState extends SocialState{
  final String error;
  ErrorAddLikeState(this.error);
}

class LoadingSendMessage extends SocialState{}
class SuccessSendMessage  extends SocialState{}
class ErrorSendMessage  extends SocialState{
  final String error;
  ErrorSendMessage(this.error);
}

class LoadingGetMessage extends SocialState{}
class SuccessGetMessage extends SocialState{}
