extern crate ffmpeg;

use std::env;

fn main () {
    ffmpeg::init().unwrap();

    println!("Hello, world!");
}
