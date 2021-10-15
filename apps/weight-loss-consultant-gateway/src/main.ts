/**
 * This is not a production server yet!
 * This is only a minimal backend to get started.
 */

import {Logger, ValidationPipe} from '@nestjs/common';
import {NestFactory} from '@nestjs/core';
import {AppModule} from './app/modules/app.module';
import {DocumentBuilder, SwaggerModule} from '@nestjs/swagger';
import * as fs from 'fs';
import * as dotenv from 'dotenv';
import {FastifyAdapter, NestFastifyApplication} from "@nestjs/platform-fastify";
import compression from 'fastify-compress';
import { ENV_FILE_PATH } from '../../common/constants/enums';

async function bootstrap() {
  const settings = dotenv.parse(fs.readFileSync(ENV_FILE_PATH));
  const app = await NestFactory.create<NestFastifyApplication>(AppModule, new FastifyAdapter({logger: false}));
  const globalPrefix = settings.API_ENDPOINT;
  app.setGlobalPrefix(globalPrefix);
  app.useGlobalPipes(new ValidationPipe());
  app.register(compression);
  const host = process.env.HOST || '127.0.0.1';
  const port = process.env.PORT || 5000;

  const config = new DocumentBuilder()
    .setTitle('Weight Loss Consultant')
    .setDescription('The API description')
    .setVersion('1.0')
    .addTag('Admin')
    .addTag('Trainer')
    .addTag('Customer')
    .addTag('Authentication')
    .addTag('Campaign')
    .addBearerAuth()
    .build();
  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup(settings.SWAGGER_UI, app, document);

  await app.listen(port, '0.0.0.0', () => {
    Logger.log(`Application Gateway is listening at http://${host}:${port}/`);
  });
}

bootstrap();
