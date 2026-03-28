<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Order;
use App\Models\OrderItem;
use App\Models\Cart;
use App\Models\CartItem;
use App\Models\Product;

class OrderController extends Controller
{
    public function checkout(Request $request)
{
    $user_id = 1;

    $cart = Cart::where('user_id', $user_id)->first();

    if (!$cart) {
        return response()->json([
            'message' => 'Cart not found'
        ]);
    }

    $items = CartItem::where('cart_id', $cart->cart_id)->get();

    if ($items->count() == 0) {
        return response()->json([
            'message' => 'Cart is empty'
        ]);
    }

    $total = 0;

    foreach ($items as $item) {
        $product = Product::where('product_id', $item->product_id)->first();
        $total += $product->price * $item->quantity;
    }

    // tạo order
    $order = Order::create([
        'user_id' => $user_id,
        'total_price' => $total,
        'status' => 'pending'
    ]);

    // thêm order items
    foreach ($items as $item) {
        $product = Product::where('product_id', $item->product_id)->first();

        OrderItem::create([
            'order_id' => $order->order_id,
            'product_id' => $item->product_id,
            'quantity' => $item->quantity,
            'price' => $product->price
        ]);
    }

    // xóa giỏ hàng
    CartItem::where('cart_id', $cart->cart_id)->delete();

    return response()->json([
        'message' => 'Order created successfully',
        'order_id' => $order->order_id,
        'total_price' => $total
    ]);
}
public function show($order_id)
{
    // Lấy order kèm items và thông tin product
    $order = Order::with('items.product')->where('order_id', $order_id)->first();

    if (!$order) {
        return response()->json([
            'message' => 'Order not found'
        ], 404);
    }

    return response()->json([
        'order' => $order
    ]);
}
public function index()
    {
        $user_id = 1;

        $orders = Order::with('items.product')
            ->where('user_id', $user_id)
            ->orderBy('created_at', 'desc')
            ->get();

        return response()->json([
            'orders' => $orders
        ]);
    }
}