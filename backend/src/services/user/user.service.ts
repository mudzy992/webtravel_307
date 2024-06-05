import { Injectable } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { TypeOrmCrudService } from '@nestjsx/crud-typeorm';
import { AddNewUserDto } from 'src/dtos/user/add.new.user.dto';
import { User } from 'src/entities/user';
import { ApiResponse } from 'src/misc/api.response.class';
import { Repository } from 'typeorm';
import * as crypto from 'crypto';
import { UserToken } from 'src/entities/usertoken';
import { EditUserDto } from 'src/dtos/user/edit.user.dto';

@Injectable()
export class UserService extends TypeOrmCrudService<User> {
  constructor(
    @InjectRepository(User)
    private readonly user: Repository<User>,
    @InjectRepository(UserToken)
    private readonly userToken: Repository<UserToken>,
  ) {
    super(user);
  }

  // METOD REGISTRACIJE (nije isto kao dodavanje POST)
  async createNewUser(data: AddNewUserDto): Promise<User | ApiResponse> {
    const passwordHash = crypto.createHash('sha512');
    passwordHash.update(data.passwordHash);
    const passwordHashString = passwordHash.digest('hex').toUpperCase();

    const newUser: User = new User();
    newUser.firstName = data.firstName;
    newUser.lastName = data.lastName;
    newUser.middleName = data.middleName;
    newUser.mobile = data.mobile;
    newUser.email = data.email;
    newUser.passwordHash = passwordHashString;
    newUser.intro = data.intro;
    newUser.profile = data.profile;

    try {
      const savedUser = await this.user.save(newUser);
      if (!savedUser) {
        throw new Error('');
      }
      return savedUser;
    } catch (e) {
      return new ApiResponse(
        'error',
        -6001,
        'This user account cannot be created.',
      );
    }
  }

  async editById (id: number, data: EditUserDto): Promise<User | ApiResponse> { 
    const user: User = await this.user.findOne({userId: id});
    if (user === undefined) {
      return new Promise((resolve) => {
        resolve (new ApiResponse('error', -6002, 'UserID:' + id +' not found'));
      });
    }

    const passwordHash = crypto.createHash('sha512');
    passwordHash.update(data.passwordHash);
    const passwordHashString = passwordHash.digest('hex').toUpperCase();
    user.firstName = data.firstName;
    user.lastName = data.lastName;
    const exEmail: User = await this.user.findOne({ email: data.email})
    if (exEmail && exEmail.userId != id) {
      console.log(exEmail)
      return new ApiResponse('error', -6005, 'Email:' + data.email +' already exists')
    }
    user.email = data.email;
    user.middleName = data.middleName;
    const exMobile: User = await this.user.findOne({ mobile: data.mobile})
    if (exMobile && exMobile.userId != id) {
      return new ApiResponse('error', -6004, 'Mobile:' + data.mobile +' already exists')
    }
    user.mobile = data.mobile;
    if (user.mobile === data.mobile) {
      
    }
    user.passwordHash = passwordHashString;
    user.intro = data.intro;
    user.profile = data.profile;

    return this.user.save(user);
  }

  getAll(): Promise <User[]> {
    return this.user.find()
  }

  async getById(id) {
    return await this.user.findOne(id);
  }

  async getByEmail(email: string): Promise<User | null> {
    const user = await this.user.findOne({
      email: email,
    });
    if (user) {
      return user;
    }
    return null;
  }
  async addToken(userId: number, token: string, expiresAt: string) {
    const userToken = new UserToken();
    userToken.userId = userId;
    userToken.token = token;
    userToken.expireAt = expiresAt;

    return await this.userToken.save(userToken);
  }

  async getUserToken(token: string): Promise<UserToken> {
    return await this.userToken.findOne({
      token: token,
    });
  }

  async invalidateToken(token: string): Promise<UserToken | ApiResponse> {
    const userToken = await this.userToken.findOne({
      token: token,
    });

    if (!userToken) {
      return new ApiResponse('error', -10001, 'No such refresh token!');
    }

    userToken.isValid = 0;

    await this.userToken.save(userToken);

    return await this.getUserToken(token);
  }

  async invalidateUserTokens(
    userId: number,
  ): Promise<(UserToken | ApiResponse)[]> {
    const userTokens = await this.userToken.find({
      userId: userId,
    });

    const results = [];

    for (const userToken of userTokens) {
      results.push(this.invalidateToken(userToken.token));
    }

    return results;
  }
}