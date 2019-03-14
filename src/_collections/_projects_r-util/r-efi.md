---
title: r-efi
description: UEFI Reference Specification Protocol Constants and Definitions
licenses:
  - Apache Software License 2.0
  - Lesser General Public License 2.1+
---
The r-efi project provides the protocol constants and definitions of the
UEFI Reference Specification as native rust code. The scope of this project is
limited to those protocol definitions. The protocols are not actually
implemented. As such, this project serves as base for any UEFI application that
needs to interact with UEFI, or implement (parts of) the UEFI specification.

## Example

The `efi` module of the *r-efi* crate provides a flat namespace of all the
symbols found in the UEFI Specification. The following example shows how to
write a low-level Hello-World application in Rust, using the symbols from the
UEFI Specification directly without any helper libraries.

Note that you are highly recommended to use helper libraries to simplify UEFI
programming. However, this example is explicitly meant to show how the
underlying system works and how to make use of the UEFI Symbols directly.

```rust
#![no_std]

use r_efi::efi;

#[panic_handler]
fn panic_handler(_info: &core::panic::PanicInfo) -> ! {
    loop {}
}

#[export_name = "efi_main"]
pub extern fn main(_h: efi::Handle, st: *mut efi::SystemTable) -> efi::Status {
    let s = [
        0x0048u16, 0x0065u16, 0x006cu16, 0x006cu16, 0x006fu16,              // "Hello"
        0x0020u16,                                                          // " "
        0x0057u16, 0x006fu16, 0x0072u16, 0x006cu16, 0x0064u16,              // "World"
        0x0021u16,                                                          // "!"
        0x000au16,                                                          // "\n"
        0x0000u16,                                                          // NUL
    ];

    // Print "Hello World!".
    let r = unsafe {
        ((*(*st).con_out).output_string)((*st).con_out, s.as_ptr() as *mut efi::Char16)
    };
    if r.is_error() {
        return r;
    }

    // Wait for key input, by waiting on the `wait_for_key` event hook.
    let r = unsafe {
        let mut x: usize = 0;
        ((*(*st).boot_services).wait_for_event)(1, &mut (*(*st).con_in).wait_for_key, &mut x)
    };
    if r.is_error() {
        return r;
    }

    efi::Status::SUCCESS
}
```
