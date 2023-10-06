select * from
[Portfolio database]..CovidDeaths
where continent is not null
order by 3,4

--select * from 
--[Portfolio database]..CovidVaccination
--where continent is not null
--order by 3,4

select location, date, total_cases, new_cases, total_deaths, population 
from [Portfolio database]..coviddeaths
where continent is not null
order by 1,2

--looking at total cases vs total deaths
--shows the likelihood of death if for each country

select location, date, total_cases, total_deaths, (total_deaths/total_cases) * 100 as Deathpercentage
from [Portfolio database]..coviddeaths
where location like '%states%' 
order by 1,2

--looking at total cases vs population
--shows percentage of population with covid

select location, date, population, total_cases, (total_cases/population) * 100 as percent_population_affected
from [Portfolio database]..coviddeaths
where location like '%states%' 
order by 1,2;

--looking at countries with highest infection rate compared to population

select location, population, max(total_cases) as HighestInfectionCount, max(total_cases/population) * 100 as percent_population_affected
from [Portfolio database]..coviddeaths
group by location, population
order by 4 desc

--looking at countries with highest death count per population

select location, max(cast (total_deaths as int)) as Total_death
from [Portfolio database]..coviddeaths
where continent is null
group by location
order by 2 desc

--looking at continent with highest death count per population

select continent, max(cast (total_deaths as int)) as Total_death
from [Portfolio database]..coviddeaths
where continent is not null
group by continent
order by 2 desc

--Global numbers

select date, sum(new_cases) as Total_cases, sum(cast(new_deaths as int)) as Total_deaths
from [Portfolio database]..coviddeaths
where continent is not null
group by date
order by 1, 2 

select sum(new_cases) as Total_cases, sum(cast(new_deaths as int)) as Total_deaths, sum(cast(new_deaths as int))/sum (new_cases) * 100 as Deathpercentage
from [Portfolio database]..coviddeaths
where continent is not null
--group by date
order by 1, 2

--looking at total population vs vaccination

--use CTE

with PopvsVac (continent, location, date, population, new_vaccinations, RollingPeopleVaccinated)
as (
select cd.continent, cd.location, cd.date, cd.population, (cast (cv.new_vaccinations as int)),
sum (convert (int, cv.new_vaccinations)) over (partition by cd.location order by cd.location, cd.date ASC)  as RollingPeopleVaccinated
from [Portfolio database]..CovidDeaths cd
join [Portfolio database]..covidvaccination cv
on cd.location = cv.location
and cd.date = cv.date 
where cd.continent is not null
--order by 2, 3 
)
select *, (RollingPeopleVaccinated/population)* 100
from PopvsVac

--TEMP TABLE

DROP TABLE if exists #PercentagePopulationVaccinated
create TABLE #PercentagePopulationVaccinated
(
Continent nvarchar(255),
Location nvarchar(255),
Date datetime,
Population numeric,
New_vaccinations numeric,
RollingPeopleVaccinated numeric
)

insert into #PercentagePopulationVaccinated
select cd.continent, cd.location, cd.date, cd.population, (cast (cv.new_vaccinations as int)),
sum (convert (int, cv.new_vaccinations)) over (partition by cd.location order by cd.location, cd.date ASC)  as RollingPeopleVaccinated
from [Portfolio database]..CovidDeaths cd
join [Portfolio database]..covidvaccination cv
on cd.location = cv.location
and cd.date = cv.date 
where cd.continent is not null
--order by 2, 3 
select *, (RollingPeopleVaccinated/population)* 100
from #PercentagePopulationVaccinated

--creating view to store data for later visualizations

Create view PercentagePopulationVaccinated as
select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
sum (convert (int, cv.new_vaccinations)) over (partition by cd.location order by cd.location, cd.date ASC)  as RollingPeopleVaccinated
from [Portfolio database]..CovidDeaths cd
join [Portfolio database]..covidvaccination cv
on cd.location = cv.location
and cd.date = cv.date 
where cd.continent is not null
--order by 2, 3 

select *
from PercentagePopulationVaccinated