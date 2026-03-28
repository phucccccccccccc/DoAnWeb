<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $table = 'products';

    protected $primaryKey = 'product_id';

    public $incrementing = true;

    protected $keyType = 'int';

    protected $fillable = [
        'name',
        'description',
        'price',
        'stock_quantity',
        'category_id',
        'image_url'
    ];
}