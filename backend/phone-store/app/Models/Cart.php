<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Cart extends Model
{
    protected $table = 'carts';

    protected $primaryKey = 'cart_id';

    protected $fillable = [
        'user_id'
    ];

    public $timestamps = true;
}