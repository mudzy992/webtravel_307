import { Column, Entity, PrimaryGeneratedColumn } from "typeorm";

@Entity("administrator_token", { schema: "template" })
export class AdministratorToken {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "administrator_token_id",
    unsigned: true,
  })
  administratorTokenId: number;

  @Column("int", { name: "administrator_id", unsigned: true })
  administratorId: number;

  @Column("timestamp", {
    name: "created_at",
    default: () => "CURRENT_TIMESTAMP",
  })
  createdAt: Date;

  @Column("varchar", { name: "token", length: 2550 })
  token: string;

  @Column("datetime", { name: "expire_at" })
  expireAt: string;

  @Column("tinyint", { name: "is_valid", default: () => "'1'" })
  isValid: number;
}
