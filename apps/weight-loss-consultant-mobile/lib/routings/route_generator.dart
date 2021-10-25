import 'package:flutter/material.dart';
import 'package:weight_loss_consultant_mobile/pages/customer/customer_create_campaign.dart';
import 'package:weight_loss_consultant_mobile/pages/customer/customer_todo_screen.dart';
import 'package:weight_loss_consultant_mobile/pages/customer/upcoming_training_page.dart';
import 'package:weight_loss_consultant_mobile/pages/others/chat_page.dart';
import 'package:weight_loss_consultant_mobile/pages/components/generic_app_bar.dart';
import 'package:weight_loss_consultant_mobile/pages/customer/customer_home_page.dart';
import 'package:weight_loss_consultant_mobile/pages/customer/my_message_page.dart';
import 'package:weight_loss_consultant_mobile/pages/others/ending_phone.dart';
import 'package:weight_loss_consultant_mobile/pages/others/initial_page.dart';
import 'package:weight_loss_consultant_mobile/pages/others/setting_screen_page.dart';
import 'package:weight_loss_consultant_mobile/pages/others/video_call_page.dart';
import 'package:weight_loss_consultant_mobile/pages/register/register_page.dart';
import 'package:weight_loss_consultant_mobile/pages/customer/customer_detail_page.dart';
import 'package:weight_loss_consultant_mobile/pages/authentication/login_page.dart';
import 'package:weight_loss_consultant_mobile/pages/others/get_started_page.dart';
import 'package:weight_loss_consultant_mobile/pages/authentication/recorver_password_page.dart';
import 'package:weight_loss_consultant_mobile/pages/authentication/reset_password_page.dart';
import 'package:weight_loss_consultant_mobile/pages/register/trainer_register_page.dart';
import 'package:weight_loss_consultant_mobile/pages/register/register_sucessful_page.dart';
import 'package:weight_loss_consultant_mobile/pages/trainer/create_packages_page.dart';
import 'package:weight_loss_consultant_mobile/pages/trainer/no_packages_page.dart';
import 'package:weight_loss_consultant_mobile/pages/trainer/trainer_home_page.dart';
import 'package:weight_loss_consultant_mobile/routings/route_paths.dart';


class RouteGenerator{
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch (settings.name){
      case RoutePath.initialPage:
        return MaterialPageRoute(builder: (_){
          return const CreatePackages();
        });
      case RoutePath.getStartedPage:
        return MaterialPageRoute(builder: (_){
          return const GetStartedPage();
        });
      case RoutePath.trainerRegisterPage:
        return MaterialPageRoute(builder: (_){
          return const TrainerRegisterPage();
        });
      case RoutePath.trainerRegisterSuccessfullyPage :
        if (args is Map<dynamic, dynamic>){
          return MaterialPageRoute(builder: (_){
            return RegisterSuccessfulPage(data: args,);
          });
        }
        return _errorRoute();
      case RoutePath.loginPage:
        return MaterialPageRoute(builder: (_){
          return const LoginPage();
        });
      case RoutePath.recoverPasswordPage:
        return MaterialPageRoute(builder: (_){
          return const RecoverPasswordPage();
        });
      case RoutePath.customerHomePage:
          return MaterialPageRoute(builder: (_){
            return const CustomerHomePage();
        });
      case RoutePath.chatPage:
        return MaterialPageRoute(builder: (_){
          return const ChatPage();
        });
      case RoutePath.customerDetailPage:
        return MaterialPageRoute(builder: (_){
          return const CustomerDetailPage();
        });
      case RoutePath.resetPasswordPage:
        if (args is Map<dynamic, dynamic>){
          return MaterialPageRoute(builder: (_){
            return ResetPasswordPage(data: args,);
          });
        }
        return _errorRoute();
      case RoutePath.registerPage:
        return MaterialPageRoute(builder: (_){
          return const RegisterPage();
        });
      case RoutePath.myMessagePage:
        return MaterialPageRoute(builder: (_){
          return const MyMessagesPage();
        });
      case RoutePath.settingPage:
        return MaterialPageRoute(builder: (_){
          return const SettingScreen();
        });
      case RoutePath.customerTodoPage:
        return MaterialPageRoute(builder: (_){
          return const CustomerTodoPage();
        });
      case RoutePath.trainerHomePage:
        return MaterialPageRoute(builder: (_){
          return const TrainerHomePage();
        });
      case RoutePath.upcomingTrainingPage:
        return MaterialPageRoute(builder: (_){
          return const UpcomingTrainingPage();
        });
      case RoutePath.videoCallPage:
        return MaterialPageRoute(builder: (_){
          return const VideoCallPage();
        });
      case RoutePath.endCallPage:
        return MaterialPageRoute(builder: (_){
          return const EndingCallPage();
        });
      default:
        return _errorRoute();

    }
  }

  static Route<dynamic> _errorRoute(){
    return MaterialPageRoute(builder: (_){
      return Scaffold(
        appBar: GenericAppBar.builder("Something went wrong"),
        body: const Center(
          child: Text("Something went wrong"),
        ),
      );
    });
  }
}
