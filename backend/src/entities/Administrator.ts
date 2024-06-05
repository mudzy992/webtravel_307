import { Column, Entity, Index, PrimaryGeneratedColumn } from "typeorm";

@Index("uq_firstname_lastname_email", ["firstname", "lastname", "email"], {
  unique: true,
})
@Entity("administrator", { schema: "template" })
export class Administrator {
  @PrimaryGeneratedColumn({
    type: "int",
    name: "administrator_id",
    unsigned: true,
  })
  administratorId: number;

  @Column("varchar", { name: "firstname", length: 255 })
  firstname: string;

  @Column("varchar", { name: "lastname", length: 255 })
  lastname: string;

  @Column("varchar", { name: "email", length: 255 })
  email: string;

  @Column("varchar", { name: "password", length: 2550 })
  password: string;
}
