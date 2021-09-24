import { PassportStrategy } from '@nestjs/passport';
import { Strategy, ExtractJwt} from "passport-jwt";
import { Injectable, Logger } from '@nestjs/common';
import { ConfigService } from '@nestjs/config';
import { JwtRequestPayload } from '../models/jwt-request-payload';

@Injectable()
export class JwtStrategy extends PassportStrategy(Strategy){
  private logger = new Logger(JwtStrategy.name);
  constructor(private configService: ConfigService) {
    super({
      jwtFromRequest: ExtractJwt.fromAuthHeaderAsBearerToken(),
      secretOrKey: configService.get("JWT_SECRET"),
      ignoreExpiration: false,
    });

  }
  async validate(payload: JwtRequestPayload){
    return {
      name: payload.fullname,
      email: payload.email,
      role: payload.role
    }
  }


}
