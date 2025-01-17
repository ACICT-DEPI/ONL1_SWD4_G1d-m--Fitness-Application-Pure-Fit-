import 'package:dio/dio.dart';
import 'package:PureFit/Core/Networking/Dio/dio_aichat.dart';
import 'package:PureFit/Core/local_db/EatToday/today_calories.dart';
import 'package:PureFit/Features/Calories/DATA/Repo/todayfood_repo.dart';
import 'package:PureFit/Features/Calories/Logic/cubit/todayfood_cubit.dart';
import 'package:PureFit/Features/Exercises/Logic/weekly_exercises_cubit/weekly_exercises_cubit.dart';
import 'package:get_it/get_it.dart';

import 'package:PureFit/Core/Networking/Dio/dio_workout_categories_api.dart';
import 'package:PureFit/Core/Networking/interceptors/dio_interceptor.dart';
import 'package:PureFit/Core/local_db/SleepDb/sleepdb.dart';
import 'package:PureFit/Core/local_db/TrakStepDb/track_steps_db.dart';
import 'package:PureFit/Core/local_db/WaterIntakeDb/waterer_db.dart';
import 'package:PureFit/Features/AiChat/Data/Repository/ai_chat_repo.dart';
import 'package:PureFit/Features/AiChat/Logic/Cubit/aichat_cubit.dart';
import 'package:PureFit/Features/Auth/Verifiy/Data/Repo/forgot_password_repo.dart';
import 'package:PureFit/Features/Auth/Verifiy/Logic/verifiy_cubit/verification_cubit.dart';
import 'package:PureFit/Features/Diet/Logic/favorite_cubit/favorite_cubit.dart';
import 'package:PureFit/Features/Exercises/Data/Repo/workout_categories_repo.dart';
import 'package:PureFit/Features/Sleep/Data/Reposotiory/sleep_repo.dart';
import 'package:PureFit/Features/Sleep/Logic/cubit/sleep_cubit.dart';
import 'package:PureFit/Features/TrackSteps/Data/Repository/track_steps_repo.dart';
import 'package:PureFit/Features/TrackSteps/Logic/cubit/track_step_cubit.dart';
import 'package:PureFit/Features/Water/Data/Repo/water_repo.dart';
import 'package:PureFit/Features/Water/Logic/cubit/water_intake_cubit.dart';

import '../../Features/Auth/Login/Data/Repo/login_repo.dart';
import '../../Features/Auth/Login/Logic/cubit/login_cubit.dart';
import '../../Features/Auth/Register/Data/Repo/register_repo.dart';
import '../../Features/Auth/Register/Logic/cubit/register_cubit.dart';
import '../../Features/Auth/Verifiy/Data/Repo/change_password_repo.dart';
import '../../Features/Auth/Verifiy/Data/Repo/verification_repo.dart';
import '../../Features/Auth/Verifiy/Logic/change_password_cubit/change_password_cubit.dart';
import '../../Features/Auth/Verifiy/Logic/forgot_pass_cubit/forgot_password_cubit.dart';
import '../../Features/Diet/Data/Repo/drinks_repo.dart';
import '../../Features/Diet/Data/Repo/favorite_repo.dart';
import '../../Features/Diet/Data/Repo/foods_repo.dart';
import '../../Features/Diet/Logic/drink_cubit/drinks_cubit.dart';
import '../../Features/Diet/Logic/food_cubit/foods_cubit.dart';
import '../../Features/Exercises/Data/Repo/exercise_repo.dart';
import '../../Features/Exercises/Data/Repo/weekly_execises_repo.dart';
import '../../Features/Exercises/Logic/exercise_cubit/exercise_cubit.dart';
import '../../Features/Exercises/Logic/workout_cubit/workout_programs_cubit.dart';
import '../../Features/Profile/Data/Repo/profile_repo.dart';
import '../../Features/Profile/Logic/cubit/profile_cubit.dart';
import '../Networking/Dio/dio_auth_api.dart';
import '../Networking/Dio/dio_change_password_api.dart';
import '../Networking/Dio/dio_drink_api.dart';
import '../Networking/Dio/dio_exercise_api.dart';
import '../Networking/Dio/dio_favorite_api.dart';
import '../Networking/Dio/dio_food_api.dart';
import '../Networking/Dio/dio_forgot_password_api.dart';
import '../Networking/Dio/dio_profile_api.dart';
import '../Networking/Dio/dio_verification_api.dart';
import '../Networking/Dio/dio_weekly_execises_api.dart';
import '../local_db/food_db/food_db.dart';

final getIT = GetIt.instance;

Future<void> setUpGit() async {
  Dio dio = Dio();
  dio.interceptors.add(DioInterceptor());

  getIT.registerLazySingleton<DioAuthApi>(() => DioAuthApi(dio: dio));
  getIT.registerLazySingleton<TodayCaloriesDB>(() => TodayCaloriesDB());
  getIT.registerLazySingleton<TrackStepsDB>(() => TrackStepsDB());
  getIT.registerLazySingleton<SleepDb>(() => SleepDb());
  getIT.registerLazySingleton<DietFavoriteDb>(() => DietFavoriteDb());
  getIT.registerLazySingleton<DioFoodsApi>(() => DioFoodsApi(dio: dio));
  getIT.registerLazySingleton<DioDrinksApi>(() => DioDrinksApi(dio: dio));
  getIT.registerLazySingleton<DioChatApi>(() => DioChatApi(dio: dio));
  getIT.registerLazySingleton<DioProfileApi>(() => DioProfileApi(dio: dio));
  getIT.registerLazySingleton<DioExerciseApi>(() => DioExerciseApi(dio: dio));
  getIT.registerLazySingleton<DioWorkoutCategoriesApi>(
      () => DioWorkoutCategoriesApi(dio: dio));
  getIT.registerLazySingleton<WatererDb>(() => WatererDb());

  // TrackSteps
  getIT.registerLazySingleton<Trackstepsrepo>(
      () => Trackstepsrepo(trackStepsDB: getIT()));
  getIT.registerFactory<TrackStepCubit>(() => TrackStepCubit(getIT()));

  //Login
  getIT.registerLazySingleton<LoginRepo>(() => LoginRepo(dioAuthApi: getIT()));
  getIT.registerFactory<LoginCubit>(() => LoginCubit(getIT()));

  //Forgot Password
  getIT.registerLazySingleton<DioForgotPasswordApi>(
      () => DioForgotPasswordApi(dio: dio));
  getIT
      .registerFactory<ForgotPasswordCubit>(() => ForgotPasswordCubit(getIT()));
  getIT.registerLazySingleton<ForgotPasswordRepo>(
      () => ForgotPasswordRepo(getIT()));

  // Verification
  getIT.registerLazySingleton<DioVerificationApi>(
      () => DioVerificationApi(dio: dio));
  getIT.registerFactory<VerificationCubit>(() => VerificationCubit(getIT()));
  getIT
      .registerLazySingleton<VerificationRepo>(() => VerificationRepo(getIT()));

  // Change Password
  getIT.registerLazySingleton<DioChangePasswordApi>(
      () => DioChangePasswordApi(dio: dio));
  getIT
      .registerFactory<ChangePasswordCubit>(() => ChangePasswordCubit(getIT()));
  getIT.registerLazySingleton<ChangePasswordRepo>(
      () => ChangePasswordRepo(getIT()));

  //Sign up
  getIT.registerLazySingleton<RegisterRepo>(
      () => RegisterRepo(dioAuthApi: getIT()));
  getIT.registerFactory<RegisterCubit>(() => RegisterCubit(getIT()));

  // Profile - Adding new dependencies

  getIT.registerLazySingleton<ProfileRepo>(
      () => ProfileRepo(dioProfileApi: getIT()));
  getIT.registerLazySingleton<ProfileCubit>(
      () => ProfileCubit(getIT<ProfileRepo>()));

  //Exercise
  getIT.registerLazySingleton<ExerciseRepo>(
      () => ExerciseRepo(dioExerciseApi: getIT<DioExerciseApi>()));
  getIT.registerFactory<ExerciseCubit>(
      () => ExerciseCubit(getIT<ExerciseRepo>()));

  //WorkoutProgram
  getIT.registerLazySingleton<WorkoutCategoriesRepo>(
      () => WorkoutCategoriesRepo(dioWorkoutCategoriesApi: getIT()));
  getIT.registerLazySingleton<WorkoutProgramsCubit>(
      () => WorkoutProgramsCubit(getIT()));

  // Weekly Exercise
  getIT.registerLazySingleton<DioWeeklyExerciseApi>(
      () => DioWeeklyExerciseApi(dio: dio));
  getIT.registerLazySingleton<WeeklyExerciseRepo>(
      () => WeeklyExerciseRepo(dioWeeklyExerciseApi: getIT()));
  getIT
      .registerFactory<WeeklyExerciseCubit>(() => WeeklyExerciseCubit(getIT()));

  //Water intake
  getIT.registerLazySingleton<WaterRepo>(() => WaterRepo(watererDb: getIT()));
  getIT.registerFactory<WaterIntakeCubit>(() => WaterIntakeCubit(getIT()));

  //Sleep

  getIT.registerLazySingleton<SleepRepo>(() => SleepRepo(db: getIT()));
  getIT.registerFactory<SleepCubit>(() => SleepCubit(getIT()));

  // Food
  getIT.registerLazySingleton<FoodsRepo>(() => FoodsRepo(dioFoodsApi: getIT()));
  getIT.registerFactory<FoodsCubit>(() => FoodsCubit(getIT()));
  // Drinks
  getIT.registerLazySingleton<DrinksRepo>(
      () => DrinksRepo(dioDrinksApi: getIT()));
  getIT.registerFactory<DrinksCubit>(() => DrinksCubit(getIT()));

  // Favorite
  getIT.registerLazySingleton<DioFavoriteApi>(() => DioFavoriteApi(dio: dio));

// Now register FavoriteRepo
  getIT.registerLazySingleton<FavoriteRepo>(() => FavoriteRepo(
        dioFavoriteApi: getIT<DioFavoriteApi>(),
        dietFavoriteDb: getIT<DietFavoriteDb>(),
      ));

  getIT.registerFactory<FavoriteCubit>(
      () => FavoriteCubit(favoriteRepo: getIT()));

//Ai chat
  getIT
      .registerLazySingleton<AiChatRepo>(() => AiChatRepo(dioChatApi: getIT()));
  getIT.registerFactory<AichatCubit>(() => AichatCubit(getIT()));

//Calories
  getIT.registerLazySingleton<TodayfoodRepo>(() => TodayfoodRepo(getIT()));
  getIT.registerFactory<TodayfoodCubit>(() => TodayfoodCubit(getIT()));
}
