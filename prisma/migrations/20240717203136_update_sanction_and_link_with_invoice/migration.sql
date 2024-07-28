/*
  Warnings:

  - A unique constraint covering the columns `[sanction_id]` on the table `Invoice` will be added. If there are existing duplicate values, this will fail.

*/
-- AlterTable
ALTER TABLE `invoice` ADD COLUMN `sanction_id` INTEGER NULL;

-- CreateIndex
CREATE UNIQUE INDEX `Invoice_sanction_id_key` ON `Invoice`(`sanction_id`);

-- AddForeignKey
ALTER TABLE `Invoice` ADD CONSTRAINT `Invoice_sanction_id_fkey` FOREIGN KEY (`sanction_id`) REFERENCES `Sanctions`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;
