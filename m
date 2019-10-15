From: Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: AMDGPU and 16B stack alignment
Date: Tue, 15 Oct 2019 16:26:38 -0400
Message-ID: <20191015202636.GA1671072@rani>
References: <CAKwvOdnDVe-dahZGnRtzMrx-AH_C+2Lf20qjFQHNtn9xh=Okzw@mail.gmail.com>
 <9e4d6378-5032-8521-13a9-d9d9519d07de@amd.com>
 <CAK8P3a3_Q15hKT=gyupb0FrPX1xV3tEBpVaYy1LF0kMUj2u8hw@mail.gmail.com>
 <CAKwvOdnLxm_tZ_qR1D-BE64Z3QaMC2h79ooobdRVAzmCD_2_Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKwvOdnLxm_tZ_qR1D-BE64Z3QaMC2h79ooobdRVAzmCD_2_Sg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "S, Shirish" <sshankar@amd.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "yshuiv7@gmail.com" <yshuiv7@gmail.com>, "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>, clang-built-linux <clang-built-linux@googlegroups.com>, Matthias Kaehlcke <mka@google.com>, "S, Shirish" <Shirish.S@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Oct 15, 2019 at 11:05:56AM -0700, Nick Desaulniers wrote:
> Hmmm...I would have liked to remove it outright, as it is an ABI
> mismatch that is likely to result in instability and non-fun-to-debug
> runtime issues in the future.  I suspect my patch does work for GCC
> 7.1+.  The question is: Do we want to either:
> 1. mark AMDGPU broken for GCC < 7.1, or
> 2. continue supporting it via stack alignment mismatch?
> 
> 2 is brittle, and may break at any point in the future, but if it's
> working for someone it does make me feel bad to outright disable it.
> What I'd image 2 looks like is (psuedo code in a Makefile):
> 
> if CC_IS_GCC && GCC_VERSION < 7.1:
>   set stack alignment to 16B and hope for the best
> 
> So my diff would be amended to keep the stack alignment flags, but
> only to support GCC < 7.1.  And that assumes my change compiles with
> GCC 7.1+. (Looks like it does for me locally with GCC 8.3, but I would
> feel even more confident if someone with hardware to test on and GCC
> 7.1+ could boot test).
> -- 
> Thanks,
> ~Nick Desaulniers

If we do keep it, would adding -mstackrealign make it more robust?
That's simple and will only add the alignment to functions that require
16-byte alignment (at least on gcc).

Alternative is to use
__attribute__((force_align_arg_pointer)) on functions that might be
called from 8-byte-aligned code.

It looks like -mstackrealign should work from gcc 5.3 onwards.
