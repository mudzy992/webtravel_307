import * as Validator from 'class-validator';

export class EditAdministratorDto {
  @Validator.IsNotEmpty()
  @Validator.IsEmail({
    allow_ip_domain: false,
    allow_utf8_local_part: true,
    require_tld: true,
  })
  email: string;

  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(2, 255)
  firstname: string;

  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(2, 255)
  lastname: string;

  @Validator.IsNotEmpty()
  @Validator.IsString()
  @Validator.Length(6, 128)
  password: string;
}