<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Product;
use Illuminate\Support\Facades\DB;
class ProductController extends Controller
{
    //
   public function byCategory($id)
    {
        return Product::where('category_id',$id)->get();
    }
    public function index()
{
    $products = Product::all();
    return response()->json($products);
}
public function show($id)
{
    $product = Product::find($id);
    return response()->json($product);
}
public function getImages($id)
{
    $images = DB::table('product_images')
        ->where('product_id', $id)
        ->get();

    return response()->json($images);
}
}
