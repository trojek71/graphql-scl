-- CreateEnum
CREATE TYPE "Role" AS ENUM ('ADMIN', 'ORDINARY');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "role" "Role" NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Profile" (
    "id" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "room" INTEGER NOT NULL,
    "bio" TEXT NOT NULL,
    "userId" TEXT NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Itsystem" (
    "id" TEXT NOT NULL,
    "itSystemUserId" TEXT NOT NULL,
    "permission" TEXT NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "SysInfo" (
    "id" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "active" BOOLEAN NOT NULL,
    "description" TEXT NOT NULL,
    "bisnessOwner" TEXT NOT NULL,
    "adminstrator" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "itSystemId" TEXT NOT NULL,

    PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "_ItsystemToUser" (
    "A" TEXT NOT NULL,
    "B" TEXT NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "Profile.userId_unique" ON "Profile"("userId");

-- CreateIndex
CREATE UNIQUE INDEX "SysInfo.itSystemId_unique" ON "SysInfo"("itSystemId");

-- CreateIndex
CREATE UNIQUE INDEX "_ItsystemToUser_AB_unique" ON "_ItsystemToUser"("A", "B");

-- CreateIndex
CREATE INDEX "_ItsystemToUser_B_index" ON "_ItsystemToUser"("B");

-- AddForeignKey
ALTER TABLE "_ItsystemToUser" ADD FOREIGN KEY ("A") REFERENCES "Itsystem"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ItsystemToUser" ADD FOREIGN KEY ("B") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Itsystem" ADD FOREIGN KEY ("itSystemUserId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Profile" ADD FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "SysInfo" ADD FOREIGN KEY ("itSystemId") REFERENCES "Itsystem"("id") ON DELETE CASCADE ON UPDATE CASCADE;
