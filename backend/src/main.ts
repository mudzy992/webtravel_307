import { ValidationPipe } from '@nestjs/common';
import { NestFactory } from '@nestjs/core'; //iz cijelog ovog paketa mi importujemo klasu NestFactory
import { NestExpressApplication } from '@nestjs/platform-express';
import { StorageConfig } from 'config/storage.config';
import { AppModule } from './app.module';
import * as cors from 'cors'

async function bootstrap() {
  const app = await NestFactory.create<NestExpressApplication>(AppModule);
  app.use(
    cors({
      /* Odobravamo CORS i cookies */
      origin: '*',
      methods: ['GET', 'PATCH', "POST", 'DELETE']
    })
  );
  app.useStaticAssets(StorageConfig.article.destination, {
    prefix: StorageConfig.article.urlPrefix,
    maxAge: StorageConfig.article.maxAge,
    index: false,
  });
  app.useStaticAssets(StorageConfig.services.destination, {
    prefix: StorageConfig.services.urlPrefix,
    maxAge: StorageConfig.services.maxAge,
    index: false,
  });
  app.useStaticAssets(StorageConfig.gallery.destination, {
    prefix: StorageConfig.gallery.urlPrefix,
    maxAge: StorageConfig.gallery.maxAge,
    index: false,
  });
  app.useStaticAssets(StorageConfig.image.destination, {
    prefix: StorageConfig.image.urlPrefix,
    maxAge: StorageConfig.image.maxAge,
    index: false,
  });
  app.useGlobalPipes(new ValidationPipe());
  await app.listen(3005);
}
bootstrap();