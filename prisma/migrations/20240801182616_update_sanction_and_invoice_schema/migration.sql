/*
  Warnings:

  - You are about to drop the column `control_number` on the `invoice` table. All the data in the column will be lost.
  - You are about to drop the column `kid_number` on the `invoice` table. All the data in the column will be lost.
  - You are about to drop the column `total_charge` on the `invoice` table. All the data in the column will be lost.
  - Added the required column `control_number` to the `Sanction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `kid_number` to the `Sanction` table without a default value. This is not possible if the table is not empty.
  - Added the required column `total_charge` to the `Sanction` table without a default value. This is not possible if the table is not empty.

*/
-- AlterTable
ALTER TABLE `invoice` DROP COLUMN `control_number`,
    DROP COLUMN `kid_number`,
    DROP COLUMN `total_charge`;

-- AlterTable
ALTER TABLE `sanction` ADD COLUMN `control_number` VARCHAR(191) NOT NULL,
    ADD COLUMN `kid_number` VARCHAR(191) NOT NULL,
    ADD COLUMN `total_charge` DOUBLE NOT NULL,
    MODIFY `status` ENUM('paid', 'not_paid', 'sent_to_debt_collect') NOT NULL DEFAULT 'not_paid';
