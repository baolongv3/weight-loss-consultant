import 'package:json_annotation/json_annotation.dart';

part "campaign_model.g.dart";

@JsonSerializable()
class CampaignModel{
  late int? id;
  late String? description;
  late int? status;
  late String? startDate;
  late String? endDate;
  late String? feedback;
  late int? targetWeight;
  late int? currentWeight;
  late int? spendTimeForTraining;

  CampaignModel(this.id,
      this.description,
      this.status,
      this.startDate,
      this.endDate,
      this.feedback,
      this.targetWeight,
      this.currentWeight,
      this.spendTimeForTraining);

  factory CampaignModel.fromJson(Map<String,dynamic> data) => _$CampaignModelFromJson(data);

  Map<String,dynamic> toJson() => _$CampaignModelToJson(this);

  @override
  String toString() {
    return 'CampaignModel{id: $id, description: $description, status: $status, startDate: $startDate, endDate: $endDate, feedback: $feedback}';
  }


}
