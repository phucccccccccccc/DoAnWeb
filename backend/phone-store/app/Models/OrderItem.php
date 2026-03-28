<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class OrderItem extends Model
{
    protected $table = 'order_items';

    protected $primaryKey = 'order_item_id';

    public $timestamps = false;
  public function index()
    {
        $orders = Order::with('items.product')->get(); // lấy luôn items và product
        return response()->json($orders);
    }
    protected $fillable = [
        'order_id',
        'product_id',
        'quantity',
        'price'
    ];
    public function product()
{
    return $this->belongsTo(Product::class, 'product_id', 'product_id');
}
}