<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Cart;
use App\Models\CartItem;
use Illuminate\Support\Facades\DB;
class CartController extends Controller
{
    // Lấy giỏ hàng
    public function index()
{
    $user_id = auth()->id();

    $cart = Cart::where('user_id', $user_id)->first();

    if (!$cart) {
        return response()->json([]);
    }

    $items = CartItem::join('products', 'cart_items.product_id', '=', 'products.product_id')
        ->where('cart_items.cart_id', $cart->cart_id)
        ->select(
            'cart_items.cart_item_id',
            'products.product_id',
            'products.name',
            'products.price',
            'cart_items.quantity'
        )
        ->get();

    // tính tổng tiền cho từng sản phẩm
    foreach ($items as $item) {
        $item->total = $item->price * $item->quantity;
    }

    return response()->json($items);
}

    // Thêm vào giỏ hàng
    public function add(Request $request)
    {
        $user_id = auth()->id();

        // tìm cart
        $cart = Cart::where('user_id', $user_id)->first();

        // nếu chưa có thì tạo
        if (!$cart) {
            $cart = Cart::create([
                'user_id' => $user_id
            ]);
        }

        // kiểm tra sản phẩm đã có chưa
        $item = CartItem::where('cart_id', $cart->cart_id)
                        ->where('product_id', $request->product_id)
                        ->first();

        if ($item) {
            // tăng số lượng
            $item->quantity += $request->quantity;
            $item->save();
        } else {
            // thêm mới
            $item = CartItem::create([
                'cart_id' => $cart->cart_id,
                'product_id' => $request->product_id,
                'quantity' => $request->quantity
            ]);
        }

        return response()->json([
            'message' => 'Added to cart',
            'item' => $item
        ]);
    }

    // Xóa sản phẩm khỏi giỏ
    public function remove($id)
    {
        $user_id = auth()->id();

        $item = CartItem::find($id);

        if (!$item) {
            return response()->json([
                'message' => 'Item not found'
            ]);
        }

        $cart = Cart::where('user_id', $user_id)->first();

        if (!$cart || $item->cart_id != $cart->cart_id) {
            return response()->json([
                'message' => 'Unauthorized'
            ]);
        }

        $item->delete();

        return response()->json([
            'message' => 'Item removed'
        ]);
    }
    public function updateQuantity(Request $request)
{
    $item = CartItem::where('cart_item_id', $request->cart_item_id)->first();

    if (!$item) {
        return response()->json([
            'message' => 'Item not found'
        ]);
    }

    // cập nhật số lượng mới
    $item->quantity = $request->quantity;
    $item->save();

    return response()->json([
        'message' => 'Quantity updated',
        'item' => $item
    ]);
}
public function checkout()
{
    $user_id = auth()->id();

    $cart = Cart::where('user_id', $user_id)->first();

    if (!$cart) {
        return response()->json([
            'message' => 'Cart is empty'
        ]);
    }

    $items = CartItem::where('cart_id', $cart->cart_id)->get();

    if ($items->count() == 0) {
        return response()->json([
            'message' => 'Cart is empty'
        ]);
    }

    // tính tổng tiền
    $total = 0;

    foreach ($items as $item) {
        $product = DB::table('products')->where('product_id', $item->product_id)->first();
        $total += $product->price * $item->quantity;
    }

    // tạo order
    $order_id = DB::table('orders')->insertGetId([
        'user_id' => $user_id,
        'total_price' => $total,
        'created_at' => now()
    ]);

    // thêm order items
    foreach ($items as $item) {
        $product = DB::table('products')->where('product_id', $item->product_id)->first();

        DB::table('order_items')->insert([
            'order_id' => $order_id,
            'product_id' => $item->product_id,
            'price' => $product->price,
            'quantity' => $item->quantity
        ]);
    }

    // xóa giỏ hàng
    CartItem::where('cart_id', $cart->cart_id)->delete();

    return response()->json([
        'message' => 'Order created successfully',
        'order_id' => $order_id,
        'total_price' => $total
    ]);
}
}