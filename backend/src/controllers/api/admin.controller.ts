import {
  Controller,
  Get,
  Param,
  UseGuards,
} from '@nestjs/common';
import { ApiResponse } from 'src/misc/api.response.class';
import { AdministratorService } from 'src/services/administrator/administrator.service';
import { AllowToRoles } from 'src/misc/allow.to.roles.descriptor';
import { RoleCheckedGuard } from 'src/misc/role.checker.guard';
import { Administrator } from 'src/entities/Administrator';

@Controller('api/admin')
export class AdministratorController {
  constructor(
    private administratorService: AdministratorService,
  ) {}

  @Get()
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles('administrator')
  getAll(): Promise<Administrator[]> {
    return this.administratorService.getAll();
  }
  @Get(':id') 
  @UseGuards(RoleCheckedGuard)
  @AllowToRoles('administrator')
  getById(
    @Param('id') administratorId: number,
  ): Promise<Administrator | ApiResponse> {
    return new Promise(async (resolve) => {
      const admin = await this.administratorService.getById(administratorId);
      if (admin === undefined) {
        resolve(new ApiResponse('error', -1002));
      }
      resolve(admin);
    });
  }
}