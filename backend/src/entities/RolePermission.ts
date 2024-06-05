import {
  Column,
  Entity,
  Index,
  JoinColumn,
  ManyToOne,
  PrimaryGeneratedColumn,
} from "typeorm";
import { Permission } from "./Permission";
import { Role } from "./Role";

@Index("idx_rp_permission", ["permissionId"], {})
@Index("idx_rp_role", ["roleId"], {})
@Entity("role_permission", { schema: "template" })
export class RolePermission {
  @PrimaryGeneratedColumn({ type: "int", name: "role_id", unsigned: true })
  roleId: number;

  @Column("int", { primary: true, name: "permission_id", unsigned: true })
  permissionId: number;

  @Column("datetime", { name: "createdAt" })
  createdAt: Date;

  @Column("datetime", { name: "updatedAt", nullable: true })
  updatedAt: Date | null;

  @ManyToOne(() => Permission, (permission) => permission.rolePermissions, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "permission_id", referencedColumnName: "permissionId" }])
  permission: Permission;

  @ManyToOne(() => Role, (role) => role.rolePermissions, {
    onDelete: "NO ACTION",
    onUpdate: "NO ACTION",
  })
  @JoinColumn([{ name: "role_id", referencedColumnName: "roleId" }])
  role: Role;
}
