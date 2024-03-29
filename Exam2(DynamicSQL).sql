﻿USE [StockMarket]
GO
/****** Object:  StoredProcedure [dbo].[spReturnPagedData]    Script Date: 11/6/2019 10:11:35 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[spReturnPagedData]
	@PageIndex int,
	@PageSize int,
	@SortCol VARCHAR(100),
        @SortDir VARCHAR(4),
	@Search VARCHAR(MAX)=null

AS
BEGIN
	SELECT sp.Id,c.[Name],sp.,sp.MaxPrice,sp.TradingDay FROM Companies AS c JOIN StockPrices AS sp ON c.Id = sp.CompanyId 
	WHERE
	(c.[Name]=@Search)OR
	(c.Symbol=@Search)OR
	(sp.TradingDay=TRY_CONVERT(datetime2(7),@Search)) OR
	1<>1

	ORDER BY
	CASE WHEN  @SortCol=c.Symbol AND  @SortDir='ASC'
	THEN c.Symbol END ASC,
	CASE WHEN  @SortCol=c.Symbol AND  @SortDir='DESC'
	THEN c.Symbol END DeSC,
	CASE WHEN @SortCol=c.[Name] AND @SortDir='ASC'
	THEN c.[Name] END ASC,
	CASE WHEN @SortCol=c.[Name] AND @SortDir='DESC'
	THEN c.[Name] END DESC

	OFFSET @PageSize*(@PageIndex-1) ROWS
	FETCH NEXT @PageSize ROWS ONLY;

END
