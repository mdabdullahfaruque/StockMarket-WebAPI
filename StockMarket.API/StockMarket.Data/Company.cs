﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text;

namespace StockMarket.Data
{
    public class Company
    {
        [Key, DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Id { get; set; }
        [Required,MaxLength(500)]
        public string Name { get; set; }
        [Required,MaxLength(50)]
        public string Symbol { get; set; }
        public IList<StockPrice> StockPrices { get; set; }
    }
}
