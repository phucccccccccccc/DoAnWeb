<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Order extends Model
{
    use HasFactory;
protected $table = 'orders';

    protected $fillable = [
        'user_id',
        'total_price',
        'status'
    ];
    public function items()
{
    return $this->hasMany(OrderItem::class, 'order_id', 'order_id');
}
public function product()
{
    return $this->belongsTo(Product::class, 'product_id', 'product_id');
}
}
