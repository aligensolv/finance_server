-- AlterTable
ALTER TABLE `invoice` MODIFY `status` ENUM('collected', 'pending') NOT NULL;
