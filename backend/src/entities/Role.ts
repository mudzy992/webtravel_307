import {
  Column,
  Entity,
  Index,
  OneToMany,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Employee } from "./Employee";
import { RolePermission } from "./RolePermission";

@Index("uq_slug", ["slug"], { unique: true })
@Entity("role", { schema: "template" })
export class Role {
  @PrimaryGeneratedColumn({ type: "int", name: "role_id", unsigned: true })
  roleId: number;

  @Column("varchar", { name: "title", length: 75 })
  title: string;

  @Column("varchar", { name: "slug", unique: true, length: 100 })
  slug: string;

  @Column("tinytext", { name: "description", nullable: true })
  description: string | null;

  @Column("smallint", { name: "type", default: () => "'0'" })
  type: number;

  @Column("tinyint", { name: "active", default: () => "'0'" })
  active: number;

  @Column("datetime", { name: "createdAt" })
  createdAt: Date;

  @Column("datetime", { name: "updatedAt", nullable: true })
  updatedAt: Date | null;

  @Column("text", { name: "content", nullable: true })
  content: string | null;

  @OneToMany(() => Employee, (employee) => employee.role)
  employees: Employee[];

  @OneToMany(() => RolePermission, (rolePermission) => rolePermission.role)
  rolePermissions: RolePermission[];
}
