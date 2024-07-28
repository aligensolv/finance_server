/*
  Warnings:

  - You are about to drop the `sanctions` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE `invoice` DROP FOREIGN KEY `Invoice_sanction_id_fkey`;

-- DropForeignKey
ALTER TABLE `payment` DROP FOREIGN KEY `Payment_sanction_id_fkey`;

-- DropTable
DROP TABLE `sanctions`;

-- CreateTable
CREATE TABLE `Sanction` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `due_date` VARCHAR(191) NOT NULL,
    `employee_pnid` VARCHAR(191) NOT NULL,
    `status` ENUM('paid', 'not_paid') NOT NULL DEFAULT 'not_paid',
    `deleted_at` VARCHAR(191) NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `SanctionFile` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `file_name` VARCHAR(191) NOT NULL,
    `file_type` ENUM('image', 'document') NOT NULL,
    `file_extension` VARCHAR(191) NOT NULL,
    `file_size` DOUBLE NOT NULL,
    `uploaded_at` VARCHAR(191) NOT NULL,
    `uploaded_by_id` INTEGER NOT NULL,
    `sanction_id` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `SanctionFile` ADD CONSTRAINT `SanctionFile_uploaded_by_id_fkey` FOREIGN KEY (`uploaded_by_id`) REFERENCES `Manager`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `SanctionFile` ADD CONSTRAINT `SanctionFile_sanction_id_fkey` FOREIGN KEY (`sanction_id`) REFERENCES `Sanction`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Payment` ADD CONSTRAINT `Payment_sanction_id_fkey` FOREIGN KEY (`sanction_id`) REFERENCES `Sanction`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Invoice` ADD CONSTRAINT `Invoice_sanction_id_fkey` FOREIGN KEY (`sanction_id`) REFERENCES `Sanction`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
