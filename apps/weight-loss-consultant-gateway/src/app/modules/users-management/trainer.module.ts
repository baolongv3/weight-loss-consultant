import {Module} from '@nestjs/common';
import {TrainerController} from '../../controllers/users-management/trainer.controller';
import {ClientsModule} from '@nestjs/microservices';
import {USERS_MANAGEMENT_SERVICE_NAME} from '../../../../../../constant';
import {USERS_MANAGEMENT_GRPC_SERVICE} from "../../../../../common/grpc-services.route";
import {TrainerService} from "../../services/users-management/trainer.service";

@Module({
  imports: [ClientsModule.register([
    {
      name: USERS_MANAGEMENT_SERVICE_NAME,
      ...USERS_MANAGEMENT_GRPC_SERVICE,
    }])],
  controllers: [TrainerController],
  providers: [TrainerService],
  exports: [TrainerService]
})
export class TrainerModule {}
