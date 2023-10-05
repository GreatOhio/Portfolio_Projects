select * from NashvilleHousing


--Standardize SaleDate Format


select SaleDate, convert(Date,SaleDate)
from NashvilleHousing

update NashvilleHousing
set SaleDate = convert(Date,SaleDate);

alter table NashvilleHousing
add SaleDateConverted date

update NashvilleHousing
set SaleDateConverted = convert(Date,SaleDate);

select SaleDateConverted 
from NashvilleHousing;


--------------------------------------------------------------
--Populate Property Address data


select * from NashvilleHousing
--where PropertyAddress is null
order by ParcelID

select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
from NashvilleHousing a join NashvilleHousing b
on a.ParcelID = b.ParcelID
	and a.uniqueID != b.uniqueID
where a.PropertyAddress is null

update a
set PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
from NashvilleHousing a join NashvilleHousing b
on a.ParcelID = b.ParcelID
	and a.uniqueID != b.uniqueID
where a.PropertyAddress is null

select PropertyAddress
from NashvilleHousing
where PropertyAddress is null


--------------------------------------------------------------
--Breaking out address into individual columns (address, city, state)


select PropertyAddress
from NashvilleHousing
--where PropertyAddress is null

select 
SUBSTRING(PropertyAddress,1, CHARINDEX(',',PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress)) as City
from NashvilleHousing

alter table NashvilleHousing
add Property_Address nvarchar(200) 
 
update NashvilleHousing
set Property_Address = SUBSTRING(PropertyAddress,1, CHARINDEX(',',PropertyAddress)-1);

alter table NashvilleHousing
add City nvarchar(200) 
 
update NashvilleHousing
set City = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) +1, LEN(PropertyAddress));

select top 100 *
from NashvilleHousing

--------------------------------------------------------------
-- Breaking out owner address into individual columns (address, city, state) using alternative way


select
Parsename(REPLACE(OwnerAddress,',','.'), 3),
Parsename(REPLACE(OwnerAddress,',','.'), 2),
Parsename(REPLACE(OwnerAddress,',','.'), 1)
from NashvilleHousing

alter table NashvilleHousing
add Owner_Address nvarchar(200) 
 
update NashvilleHousing
set Owner_Address = Parsename(REPLACE(OwnerAddress,',','.'), 3);


alter table NashvilleHousing
add Owner_City nvarchar(200) 
 
update NashvilleHousing
set Owner_City = Parsename(REPLACE(OwnerAddress,',','.'), 2);

alter table NashvilleHousing
add Owner_State nvarchar(200) 
 
update NashvilleHousing
set Owner_State = Parsename(REPLACE(OwnerAddress,',','.'), 1);

Select * from NashvilleHousing


--------------------------------------------------------------
--Change Y and N to Yes and No in SoldAsvacant field


select DISTINCT(SoldAsvacant),Count(SoldAsvacant)
from NashvilleHousing
group by SoldAsvacant
order by 2

Select SoldAsvacant,
 CASE when SoldAsvacant = 'N' then 'No'
	  when SoldAsvacant = 'Y' then 'Yes'
 Else SoldAsvacant
 END
from NashvilleHousing

update NashvilleHousing
set SoldAsvacant = CASE when SoldAsvacant = 'N' then 'No'
	  when SoldAsvacant = 'Y' then 'Yes'
 Else SoldAsvacant
 END
from NashvilleHousing;


--------------------------------------------------------------
--Remove Duplicates

With RowNumCTE as (
Select *, 
	ROW_NUMBER() over(
	Partition by ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 order by 
				 UniqueID) row_num
	from NashvilleHousing)

Delete
from RowNumCTE
where row_num > 1
--order by Property_Address

--Confirming duplicate deleted

With RowNumCTE as (
Select *, 
	ROW_NUMBER() over(
	Partition by ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 order by 
				 UniqueID) row_num
	from NashvilleHousing)

Select *
from RowNumCTE
where row_num > 1
--order by Property_Address


--------------------------------------------------------------
--Delete Unused columns


Alter Table NashvilleHousing
Drop column ownerAddress, TaxDistrict, PropertyAddress

Alter Table NashvilleHousing
Drop column SaleDate

Select *
from NashvilleHousing