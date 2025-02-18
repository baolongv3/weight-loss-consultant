import {Inject, Injectable} from '@nestjs/common';
import {CONTRACT_MANAGEMENT_SERVICE_NAME} from '../../../../../constant';
import {ClientProxy} from '@nestjs/microservices';
import {DeleteResult} from 'typeorm';
import {ContractEntity} from "../entities/contract.entity";
import {
  CREATE_CONTRACT,
  DELETE_CONTRACT_BY_ID,
  EXPIRE_CONTRACT,
  FIND_ALL_CONTRACT,
  FIND_CONTRACT_BY_ID,
  GET_CONTRACT_BY_CAMPAIGN_ID_OR_PACKAGE_ID,
  UPDATE_CONTRACT_BY_ID,
  UpdateContractPayloadType
} from "../../../../common/routes/contract-management-service-routes";
import {CreateContractDto} from "../dtos/contract/create-health-info.dto";
import {UpdateContractDto} from "../dtos/contract/update-health-info.dto";
import {GetContractByPackageIDOrCampaignIDPayload} from "../../../../common/dtos/update-trainer-dto.payload";

@Injectable()
export class ContractService {

  constructor(@Inject(CONTRACT_MANAGEMENT_SERVICE_NAME)
              private readonly contractManagementServiceProxy: ClientProxy) {}

  async getHealthInfosWithCustomer(): Promise<ContractEntity[]> {
    return this.contractManagementServiceProxy
      .send<ContractEntity[], Record<string, unknown>>({cmd: FIND_ALL_CONTRACT}, {})
      .toPromise();
  }

  async viewDetail(id: number): Promise<ContractEntity> {
    return this.contractManagementServiceProxy
      .send<ContractEntity, number>({cmd: FIND_CONTRACT_BY_ID}, id)
      .toPromise();
  }

  async create(dto: CreateContractDto): Promise<ContractEntity> {
    return this.contractManagementServiceProxy
      .send<ContractEntity, CreateContractDto>({cmd: CREATE_CONTRACT}, dto)
      .toPromise();
  }


  async edit(dto: UpdateContractDto, id: number): Promise<void> {
    return this.contractManagementServiceProxy
      .send<void, UpdateContractPayloadType>
      ({cmd: UPDATE_CONTRACT_BY_ID}, {dto: dto, id: id})
      .toPromise();
  }

  async delete(id: number): Promise<DeleteResult> {
    return this.contractManagementServiceProxy
      .send<DeleteResult, number>
      ({cmd: DELETE_CONTRACT_BY_ID}, id)
      .toPromise();
  }

  async getContractByPackageIdOrCampaignId(payload: GetContractByPackageIDOrCampaignIDPayload) : Promise<ContractEntity>{
    return this.contractManagementServiceProxy
      .send
      ({cmd: GET_CONTRACT_BY_CAMPAIGN_ID_OR_PACKAGE_ID}, payload)
      .toPromise();
  }

  async expireContract(id: number) : Promise<void> {
    return this.contractManagementServiceProxy
      .send
      ({cmd: EXPIRE_CONTRACT}, id)
      .toPromise();
  }
}
