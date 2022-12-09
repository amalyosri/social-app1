abstract class SocialStates {}

class InitialSocialState extends SocialStates {}

class SocialSuccess extends SocialStates {}

class Socialloding extends SocialStates {}

class SocialError extends SocialStates {
  String error;
  SocialError(this.error);
}

class ChangeBottombarState extends SocialStates {}

class ChangeBottombarAddPostState extends SocialStates {}

class ProfileImageSuccessState extends SocialStates {}

class ProfileImageErrorState extends SocialStates {}

class CoverImageSuccessState extends SocialStates {}

class CoverImageErrorState extends SocialStates {}

class UploadCoverImageSuccessState extends SocialStates {}

class UploadCoverImageErrorState extends SocialStates {}

class UploadProfileImageSuccessState extends SocialStates {}

class UploadProfileImageErrorState extends SocialStates {}

class UpdateUserDataErrorState extends SocialStates {}

class UpdateUserDataLodingState extends SocialStates {}

class UpdateUserDataCoverLodingState extends SocialStates {}

////////create post//////////////////////
class PostImageSuccessState extends SocialStates {}

class PostImageErrorState extends SocialStates {}

class UplodePostImageLodingState extends SocialStates {}

class UplodePostImageSuccessState extends SocialStates {}

class UploadPostImageErrorState extends SocialStates {}

class CreateNewPostImageLoadingState extends SocialStates {}

class CreateNewPostImageSuccessState extends SocialStates {}

class CreateNewPostImageErrorState extends SocialStates {}

class RemovePostImageState extends SocialStates {}

class GetPostDataSuccessState extends SocialStates {}

class GetPostDataErrorState extends SocialStates {}

class LikePostSuccessState extends SocialStates {}

class LikePostErrorState extends SocialStates {}

class ChatSuccessState extends SocialStates {}

class ChatErrorState extends SocialStates {}

/////// Send Chat/////
class SendChatSuccessState extends SocialStates {}

class SendChatErrorState extends SocialStates {}

class GetChatSuccessState extends SocialStates {}

class GetChatErrorState extends SocialStates {}
