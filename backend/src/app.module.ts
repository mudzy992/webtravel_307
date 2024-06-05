import { MiddlewareConsumer, Module, NestModule } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DatabaseConfiguration } from 'config/database.configuratio';
import { AdministratorController } from './controllers/api/admin.controller';
import { UserController } from './controllers/api/user.controller';
import { Administrator } from './entities/Administrator';
import { AdministratorToken } from './entities/AdministratorToken';
import { Permission } from './entities/Permission';
import { Role } from './entities/Role';
import { RolePermission } from './entities/RolePermission';
import { User } from './entities/User';
import { UserToken } from './entities/UserToken';
import { AuthMiddleware } from './middlewares/auth.middleware';
import { AdministratorService } from './services/administrator/administrator.service';
import { UserService } from './services/user/user.service';
import { AuthController } from './controllers/api/auth.controller';

@Module({
  imports: [TypeOrmModule.forRoot({
    type: 'mysql',
    host: DatabaseConfiguration.hostname,
    port: 3306,
    username: DatabaseConfiguration.username,
    password: DatabaseConfiguration.password,
    database: DatabaseConfiguration.database,

    entities: [
      /* ENTITETI */
      Administrator,
      AdministratorToken,
      Permission,
      User,
      UserToken,
      Role,
      RolePermission,
    ],
  }),
  // Repozitorijumi ispod (čim ga spomenemo, moramo da ga dodamo)
  TypeOrmModule.forFeature([
      Administrator,
      AdministratorToken,
      User,
      UserToken,
      Permission,
      Role, 
      RolePermission,      
  ]),
  /* KONFIGURACIJA MAILA 
  npm i @nestjs-modules/mailer nodemailer 
  */

 /* MailerModule.forRoot({
     transport:
      'smtps://' +
      MailConfig.username +
      ':' +
      MailConfig.password +
      '@' +
      MailConfig.hostname,
    defaults: {
      from: MailConfig.senderEmail, 
    },
  }),*/
],
controllers: [
  /* KONTROLERI */
  AuthController,
  AdministratorController,
  UserController,
],
providers: [
  /* SERVISI */
  AdministratorService,
  UserService,
],
exports: [
  /* MIDDLEWARES */
  // zbog middleware potrebno je exportovati servis
  // da bi svi ostali elementi koji se nalaze van okvira modula
  AdministratorService,
  UserService,
],
})
// export class AppModule {}

/* KADA SE IPLEMENTIRA MIDDLEWARE URADITI IZMJENE
// Konzumer middleware-a
// sve što se dešava u ovom modulu (kontroleri, sve rute),
// mogu da budu podložene tih nekih presretača requestova
// potrebno je konvertovati AppModule u nestModul (implementirati)*/
export class AppModule implements NestModule {
configure(consumer: MiddlewareConsumer) {
  // Nema throw već mi treba da odredimo šta treba da radi
  // a mi želimo da on primjeni određeni middleware
  consumer
    .apply(AuthMiddleware)
    // kada kažemo koji middleware naš konzumer treba da primjenjuje
    // moramo da damo nekoliko izuzetaka, i spisak ruta za koje će važiti
    .exclude('auth/*') // Izbjegni sve što počinje sa auth/*, 'assets/*', 'uploads/*'itd.
    .forRoutes('api/*'); // Ali primjeni se na sve što počinje sa api/
}
} 