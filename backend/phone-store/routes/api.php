<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Models\Product;
use App\Http\Controllers\ProductController;
use App\Http\Controllers\CategoryController;
use App\Http\Controllers\OrderController;
use App\Http\Controllers\AuthController;



/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();    
});
Route::get('/test', function () {
    return "API OK";
});
//product
Route::get('/products', function () {
    return Product::all();
});
//category
Route::get('/categories',[CategoryController::class,'index']);
Route::get('/categories/{id}',[CategoryController::class,'show']);
Route::post('/categories',[CategoryController::class,'store']);
Route::put('/categories/{id}',[CategoryController::class,'update']);
Route::delete('/categories/{id}',[CategoryController::class,'destroy']);

Route::get('/products/category/{id}',[ProductController::class,'byCategory']);
Route::get('/product-images/{id}', [ProductController::class, 'getImages']);
// cart 
use App\Http\Controllers\CartController;

Route::prefix('cart')->group(function () {
    Route::get('/{user_id}', [CartController::class, 'index']);
    Route::post('/add', [CartController::class, 'add']);
    Route::delete('/{id}', [CartController::class, 'remove']);
    Route::put('/update', [CartController::class, 'updateQuantity']);
    Route::post('/checkout', [CartController::class, 'checkout']);   // thêm dòng này
    
});


Route::post('/checkout',[OrderController::class,'checkout']);
Route::get('orders/{order_id}', [OrderController::class, 'show']);
Route::get('orders', [OrderController::class, 'index']);

Route::get('/product/{id}', [ProductController::class, 'show']);

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

