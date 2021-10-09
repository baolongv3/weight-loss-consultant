import {Module} from '@nestjs/common';
import {JwtModule} from '@nestjs/jwt';
import {JWT_CONFIG} from '../../constant';
import {ConfigModule, ConfigService} from '@nestjs/config';
import {JwtStrategy} from '../../strategies/jwt.strategy';
import {ClientsModule} from '@nestjs/microservices';
import {AUTHENTICATION_SERVICE_NAME} from '../../../../../../constant';
import {PassportModule} from '@nestjs/passport';
import {AuthenticationController} from '../../controllers/authentication/authentication.controller';
import {AuthenticationService} from '../../services/authentication/authentication.service';
import {FirebaseAuthStrategy} from '../../strategies/firebase-auth.strategy';
import {AUTHENTICATION_GRPC_SERVICE} from "../../../../../common/grpc-services.route";

@Module({
  imports: [
    PassportModule,
    ClientsModule.register([
      {
        name: AUTHENTICATION_SERVICE_NAME,
        ...AUTHENTICATION_GRPC_SERVICE,
      },]),
    JwtModule.registerAsync({
      imports: [ConfigModule],
      useFactory: (configService: ConfigService) => ({
        secret: configService.get('JWT_SECRET'),
        signOptions: {
          expiresIn: JWT_CONFIG.expireTime
        }
      }),
      inject: [ConfigService]
    })],

  providers: [JwtStrategy, FirebaseAuthStrategy,  ConfigService,
    AuthenticationService,
    //{provide: APP_GUARD, useClass: RolesGuard}
    ],
  exports: [AuthenticationService],
  controllers: [AuthenticationController]
})
export class AppJwtModule {
}
