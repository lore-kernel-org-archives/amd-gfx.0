From: Nick Desaulniers <ndesaulniers@google.com>
Subject: AMDGPU and 16B stack alignment
Date: Mon, 14 Oct 2019 15:22:09 -0700
Message-ID: <CAKwvOdnDVe-dahZGnRtzMrx-AH_C+2Lf20qjFQHNtn9xh=Okzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, "Deucher, Alexander" <alexander.deucher@amd.com>
Cc: yshuiv7@gmail.com, andrew.cooper3@citrix.com, Arnd Bergmann <arnd@arndb.de>, clang-built-linux <clang-built-linux@googlegroups.com>, Matthias Kaehlcke <mka@google.com>, "S, Shirish" <shirish.s@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "Koenig, Christian" <christian.koenig@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Hello!

The x86 kernel is compiled with an 8B stack alignment via
    `-mpreferred-stack-boundary=3` for GCC since 3.6-rc1 via
    commit d9b0cde91c60 ("x86-64, gcc: Use
-mpreferred-stack-boundary=3 if supported")
    or `-mstack-alignment=8` for Clang. Parts of the AMDGPU driver are
    compiled with 16B stack alignment.

    Generally, the stack alignment is part of the ABI. Linking together two
    different translation units with differing stack alignment is dangerous,
    particularly when the translation unit with the smaller stack alignment
    makes calls into the translation unit with the larger stack alignment.
    While 8B aligned stacks are sometimes also 16B aligned, they are not
    always.

    Multiple users have reported General Protection Faults (GPF) when using
    the AMDGPU driver compiled with Clang. Clang is placing objects in stack
    slots assuming the stack is 16B aligned, and selecting instructions that
    require 16B aligned memory operands. At runtime, syscalls handling 8B
    stack aligned code calls into code that assumes 16B stack alignment.
    When the stack is a multiple of 8B but not 16B, these instructions
    result in a GPF.

    GCC doesn't select instructions with alignment requirements, so the GPFs
    aren't observed, but it is still considered an ABI breakage to mix and
    match stack alignment.

I have patches that basically remove -mpreferred-stack-boundary=4 and
-mstack-alignment=16 from AMDGPU:
https://github.com/ClangBuiltLinux/linux/issues/735#issuecomment-541247601
Yuxuan has tested with Clang and GCC and reported it fixes the GPF's observed.

I've split the patch into 4; same commit message but different Fixes
tags so that they backport to stable on finer granularity. 2 questions
BEFORE I send the series:

1. Would you prefer 4 patches with unique `fixes` tags, or 1 patch?
2. Was there or is there still a good reason for the stack alignment mismatch?

(Further, I think we can use -msse2 for BOTH clang+gcc after my patch,
but I don't have hardware to test on. I'm happy to write/send the
follow up patch, but I'd need help testing).
-- 
Thanks,
~Nick Desaulniers
