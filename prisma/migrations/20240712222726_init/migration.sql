-- CreateTable
CREATE TABLE `DebtCollect` (
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

-- CreateTable
CREATE TABLE `FinancialReport` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `report_file` VARCHAR(191) NOT NULL,
    `start_date` VARCHAR(191) NOT NULL,
    `end_date` VARCHAR(191) NOT NULL,
    `total_income` DOUBLE NOT NULL,
    `tax_deducted` DOUBLE NOT NULL,
    `report_title` VARCHAR(191) NOT NULL,
    `report_file_size` VARCHAR(191) NOT NULL,
    `created_at` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ExtraAddedFiles` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `file_type` ENUM('pdf', 'image') NOT NULL,
    `file_size` VARCHAR(191) NOT NULL,
    `file_name` VARCHAR(191) NOT NULL,
    `uploaded_at` VARCHAR(191) NOT NULL,
    `control_number` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
