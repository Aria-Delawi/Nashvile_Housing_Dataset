-- Data Cleaning in SQL

 select * from nashvileHousing.dbo.nashvileHousing

 select SaleDate
 from nashvileHousing.dbo.nashvileHousing

 -- Convert SaleDate column to Date format

 ALTER TABLE nashvileHousing
 add saleDateConverted Date;

 Update nashvileHousing
 SET saleDateConverted = CONVERT(Date,SaleDate)

 select saleDateConverted
 from nashvileHousing.dbo.nashvileHousing

 -----------------------------------------------------

 -- Fill Null values in Property Adress Column

 select * from nashvileHousing
 WHERE PropertyAddress is null

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from  nashvileHousing.dbo.nashvileHousing a
 Join nashvileHousing.dbo.nashvileHousing b
	  on a.ParcelID = b.ParcelID
	  and a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress is null

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from  nashvileHousing.dbo.nashvileHousing a
 Join nashvileHousing.dbo.nashvileHousing b
	  on a.ParcelID = b.ParcelID
	  and a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress is null

---------------------------------------------

--Breaking out Adress into individual columns (Address,City,State)

select PropertyAddress
from nashvileHousing.dbo.nashvileHousing

select SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as Address,
	   SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) as City	
from nashvileHousing.dbo.nashvileHousing


ALTER TABLE nashvileHousing
 add AddressSplitted nvarchar(255);

 Update nashvileHousing
 SET AddressSplitted = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) 

 ALTER TABLE nashvileHousing
 add CitySplitted nvarchar(255);

 Update nashvileHousing
 SET CitySplitted = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress))

 select * from nashvileHousing.dbo.nashvileHousing

 ---------ANOTHER METHOD OF SPLIITING A COLUMN--------------

 -- spliiting the owner address column

 select PARSENAME(REPLACE(OwnerAddress, ',', '.'),3),
 PARSENAME(REPLACE(OwnerAddress, ',', '.'),2),
 PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)
from nashvileHousing.dbo.nashvileHousing

ALTER TABLE nashvileHousing
 add OwnerAddressSplitted nvarchar(255);

 Update nashvileHousing
 SET OwnerAddressSplitted = PARSENAME(REPLACE(OwnerAddress, ',', '.'),3)

 ALTER TABLE nashvileHousing
 add OwnerCitySplitted nvarchar(255);

 Update nashvileHousing
 SET OwnerCitySplitted = PARSENAME(REPLACE(OwnerAddress, ',', '.'),2) 

 ALTER TABLE nashvileHousing
 add OwnerStateSplitted nvarchar(255);

 Update nashvileHousing
 SET OwnerStateSplitted = PARSENAME(REPLACE(OwnerAddress, ',', '.'),1) 

 
 --------Change Y and N to Yes and No In the SoldAsVaccant column-----

 select DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
 from nashvileHousing.dbo.nashvileHousing
 group by SoldAsVacant

 select SoldAsVacant,
	CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	     WHEN SoldAsVacant = 'N' THEN 'No'
		 ELSE SoldAsVacant
		 END
 from nashvileHousing.dbo.nashvileHousing

 Update nashvileHousing.dbo.nashvileHousing
 SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	     WHEN SoldAsVacant = 'N' THEN 'No'
		 ELSE SoldAsVacant
		 END

---------Delete unused Columns

select * from nashvileHousing.dbo.nashvileHousing

ALTER TABLE nashvileHousing.dbo.nashvileHousing
DROP COLUMN PropertyAddress, OwnerAddress, TaxDistrict, SaleDate

