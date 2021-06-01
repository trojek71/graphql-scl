/*
  Warnings:

  - You are about to drop the column `itSystemUserId` on the `Itsystem` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "Itsystem" DROP CONSTRAINT "Itsystem_itSystemUserId_fkey";

-- AlterTable
ALTER TABLE "Itsystem" DROP COLUMN "itSystemUserId";
