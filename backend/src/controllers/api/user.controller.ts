import { Controller, Get, Param, UseGuards } from '@nestjs/common';
import { Crud } from '@nestjsx/crud';
import { User } from 'src/entities/user';
import { AllowToRoles } from 'src/misc/allow.to.roles.descriptor';
import { ApiResponse } from 'src/misc/api.response.class';
import { RoleCheckedGuard } from 'src/misc/role.checker.guard';
import { UserService } from 'src/services/user/user.service';

@Controller('api/user')
@Crud({
    model: {
      type: User,
    },
    params: {
      id: {
        field: 'userId',
        type: 'number',
        primary: true,
      },
    },
    query: {
      join: {
        employees: {
          eager: true,
        },
        employees2: {
          eager: true,
        },
        employees3: {
          eager: true,
        },
        organizations: {
          eager: true,
        },
        organizations2: {
          eager: true,
        },
        posts: {
          eager: true,
        },
        // pretpostavljam da će ovdje trebati napraviti vezu da se vidi koje narudžbe ima user
    },
  }
})
export class UserController {
  constructor(
    private userService: UserService
  ) {}
  
  @Get()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles('administrator' || 'user')
  getAll(): Promise <User[]> {
    return this.userService.getAll();
  }

  @Get(':id')
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles('administrator' || 'user')
  getById(
    @Param('id') userId: number,
  ): Promise<User | ApiResponse> {
    return new Promise (async (resolve) => {
      const user = await this.userService.getById(userId);
      if (user === undefined) {
        resolve(new ApiResponse('error', -6002));
       }
       resolve(user)
    })
  }
}