import {
  Column,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Employee } from "./Employee";
import { Organization } from "./Organization";
import { PostEntity } from "./Post";

@Index("uq_email", ["email"], { unique: true })
@Index("uq_mobile", ["mobile"], { unique: true })
@Entity("user", { schema: "template" })
export class User {
  @PrimaryGeneratedColumn({ type: "int", name: "user_id", unsigned: true })
  userId: number;

  @Column("varchar", { name: "firstName", nullable: true, length: 50 })
  firstName: string | null;

  @Column("varchar", { name: "middleName", nullable: true, length: 50 })
  middleName: string | null;

  @Column("varchar", { name: "lastName", nullable: true, length: 50 })
  lastName: string | null;

  @Column("varchar", {
    name: "mobile",
    nullable: true,
    unique: true,
    length: 15,
  })
  mobile: string | null;

  @Column("varchar", {
    name: "email",
    nullable: true,
    unique: true,
    length: 50,
  })
  email: string | null;

  @Column("varchar", { name: "passwordHash", length: 2550 })
  passwordHash: string;

  @Column("datetime", { name: "registeredAt", default: () => "CURRENT_TIMESTAMP", })
  registeredAt: Date;

  @Column("datetime", { name: "lastLogin", nullable: true })
  lastLogin: Date | null;

  @Column("tinytext", { name: "intro", nullable: true })
  intro: string | null;

  @Column("text", { name: "profile", nullable: true })
  profile: string | null;

  @OneToMany(() => Employee, (employee) => employee.createdBy2)
  employees: Employee[];

  @OneToMany(() => Employee, (employee) => employee.updatedBy2)
  employees2: Employee[];

  @OneToMany(() => Employee, (employee) => employee.user)
  employees3: Employee[];

  @OneToMany(() => Organization, (organization) => organization.createdBy2)
  organizations: Organization[];

  @OneToMany(() => Organization, (organization) => organization.updatedBy2)
  organizations2: Organization[];

  @OneToMany(() => PostEntity, (post) => post.author)
  posts: PostEntity[];
}
