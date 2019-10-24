From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 0/3] drm/amdgpu: fix stack alignment ABI mismatch
Date: Thu, 24 Oct 2019 15:08:44 -0700
Message-ID: <CAKwvOdkDCeNCg7N0jyjo9oQmVX6seOXjSv06DvQDCDz_7qSo=Q@mail.gmail.com>
References: <20191016230209.39663-1-ndesaulniers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191016230209.39663-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, "Deucher, Alexander" <alexander.deucher@amd.com>, yshuiv7@gmail.com, "S, Shirish" <shirish.s@amd.com>
Cc: andrew.cooper3@citrix.com, Arnd Bergmann <arnd@arndb.de>, clang-built-linux <clang-built-linux@googlegroups.com>, Matthias Kaehlcke <mka@google.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "Koenig, Christian" <christian.koenig@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Oct 16, 2019 at 4:02 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> The x86 kernel is compiled with an 8B stack alignment via
> `-mpreferred-stack-boundary=3` for GCC since 3.6-rc1 via
> commit d9b0cde91c60 ("x86-64, gcc: Use -mpreferred-stack-boundary=3 if supported")
> or `-mstack-alignment=8` for Clang. Parts of the AMDGPU driver are
> compiled with 16B stack alignment.
>
> Generally, the stack alignment is part of the ABI. Linking together two
> different translation units with differing stack alignment is dangerous,
> particularly when the translation unit with the smaller stack alignment
> makes calls into the translation unit with the larger stack alignment.
> While 8B aligned stacks are sometimes also 16B aligned, they are not
> always.
>
> Multiple users have reported General Protection Faults (GPF) when using
> the AMDGPU driver compiled with Clang. Clang is placing objects in stack
> slots assuming the stack is 16B aligned, and selecting instructions that
> require 16B aligned memory operands.
>
> At runtime, syscall handlers with 8B aligned stack call into code that
> assumes 16B stack alignment.  When the stack is a multiple of 8B but not
> 16B, these instructions result in a GPF.
>
> Remove the code that added compatibility between the differing compiler
> flags, as it will result in runtime GPFs when built with Clang.
>
> The series is broken into 3 patches, the first is an important fix for
> Clang for ChromeOS. The rest are attempted cleanups for GCC, but require
> additional boot testing. The first patch is critical, the rest are nice
> to have. I've compile tested the series with ToT Clang, GCC 4.9, and GCC
> 8.3 **but** I do not have hardware to test on, so I need folks with the
> above compilers and relevant hardware to help test the series.
>
> The first patch is a functional change for Clang only. It does not
> change anything for any version of GCC. Yuxuan boot tested a previous
> incarnation on hardware, but I've changed it enough that I think it made
> sense to drop the previous tested by tag.

Thanks for testing the first patch Shirish. Are you or Yuxuan able to
test the rest of the series with any combination of {clang|gcc < 7.1|
gcc >= 7.1} on hardware and report your findings?

>
> The second patch is a functional change for GCC 7.1+ only. It does not
> affect older versions of GCC or Clang (though if someone wanted to
> double check with pre-GCC 7.1 it wouldn't hurt).  It should be boot
> tested on GCC 7.1+ on the relevant hardware.
>
> The final patch is also a functional change for GCC 7.1+ only. It does
> not affect older versions of GCC or Clang. It should be boot tested on
> GCC 7.1+ on the relevant hardware. Theoretically, there may be an issue
> with it, and it's ok to drop it. The series was intentional broken into
> 3 in order to allow them to be incrementally tested and accepted. It's
> ok to take earlier patches without the later patches.
>
> And finally, I do not condone linking object files of differing stack
> alignments.  Idealistically, we'd mark the driver broken for pre-GCC
> 7.1.  Pragmatically, "if it ain't broke, don't fix it."

Harry, Alex,
Thoughts on the series? Has AMD been able to stress test these more internally?

>
> Nick Desaulniers (3):
>   drm/amdgpu: fix stack alignment ABI mismatch for Clang
>   drm/amdgpu: fix stack alignment ABI mismatch for GCC 7.1+
>   drm/amdgpu: enable -msse2 for GCC 7.1+ users
>
>  drivers/gpu/drm/amd/display/dc/calcs/Makefile | 19 ++++++++++++-------
>  drivers/gpu/drm/amd/display/dc/dcn20/Makefile | 19 ++++++++++++-------
>  drivers/gpu/drm/amd/display/dc/dcn21/Makefile | 19 ++++++++++++-------
>  drivers/gpu/drm/amd/display/dc/dml/Makefile   | 19 ++++++++++++-------
>  drivers/gpu/drm/amd/display/dc/dsc/Makefile   | 19 ++++++++++++-------
>  5 files changed, 60 insertions(+), 35 deletions(-)
>
> --
> 2.23.0.700.g56cf767bdb-goog
>


-- 
Thanks,
~Nick Desaulniers
