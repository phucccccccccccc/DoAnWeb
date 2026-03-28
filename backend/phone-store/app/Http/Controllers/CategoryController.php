<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Category;

class CategoryController extends Controller
{

    public function index()
    {
        return Category::all();
    }

    public function show($id)
    {
        return Category::find($id);
    }

    public function store(Request $request)
    {
        $category = Category::create($request->all());
        return response()->json($category);
    }

    public function update(Request $request,$id)
    {
        $category = Category::find($id);
        $category->update($request->all());
        return response()->json($category);
    }

    public function destroy($id)
    {
        Category::destroy($id);
        return response()->json(["message"=>"deleted"]);
    }

}