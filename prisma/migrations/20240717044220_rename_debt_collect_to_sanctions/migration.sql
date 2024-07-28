/*
  Warnings:

  - You are about to drop the column `debt_collect_id` on the `payment` table. All the data in the column will be lost.
  - You are about to drop the `debtcollect` table. If the table is not empty, all the data it contains will be lost.
  - A unique constraint covering the columns `[sanction_id]` on the table `Payment` will be added. If there are existing duplicate values, this will fail.

*/
-- DropForeignKey
ALTER TABLE `payment` DROP FOREIGN KEY `Payment_debt_collect_id_fkey`;

-- AlterTable
ALTER TABLE `payment` DROP COLUMN `debt_collect_id`,
    ADD COLUMN `sanction_id` INTEGER NULL;

-- DropTable
DROP TABLE `debtcollect`;

-- CreateTable
CREATE TABLE `Sanctions` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `control_number` VARCHAR(191) NOT NULL,
    `kid_number` VARCHAR(191) NOT NULL,
    `charge` DOUBLE NOT NULL,
    `due_date` VARCHAR(191) NOT NULL,
    `employee_pnid` VARCHAR(191) NOT NULL,
    `status` ENUM('paid', 'not_paid') NOT NULL DEFAULT 'not_paid',
    `deleted_at` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateIndex
CREATE UNIQUE INDEX `Payment_sanction_id_key` ON `Payment`(`sanction_id`);

-- AddForeignKey
ALTER TABLE `Payment` ADD CONSTRAINT `Payment_sanction_id_fkey` FOREIGN KEY (`sanction_id`) REFERENCES `Sanctions`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
