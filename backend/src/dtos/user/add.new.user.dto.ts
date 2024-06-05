import * as Validator from 'class-validator';
export class AddNewUserDto {
    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(2, 255)
    firstName: string;
    
    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(2, 255)
    lastName: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(2, 255)
    middleName: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(2, 255)
    mobile: string;

    @Validator.IsNotEmpty()
    @Validator.IsEmail({
        allow_ip_domain: false,
        allow_utf8_local_part: true,
        require_tld: true,
    })
    email: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(6, 128)
    passwordHash: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(6, 128)
    intro: string;

    @Validator.IsNotEmpty()
    @Validator.IsString()
    @Validator.Length(6, 128)
    profile: string;
}