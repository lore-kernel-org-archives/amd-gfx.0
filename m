From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: AMDGPU and 16B stack alignment
Date: Tue, 15 Oct 2019 11:05:56 -0700
Message-ID: <CAKwvOdnLxm_tZ_qR1D-BE64Z3QaMC2h79ooobdRVAzmCD_2_Sg@mail.gmail.com>
References: <CAKwvOdnDVe-dahZGnRtzMrx-AH_C+2Lf20qjFQHNtn9xh=Okzw@mail.gmail.com>
 <9e4d6378-5032-8521-13a9-d9d9519d07de@amd.com> <CAK8P3a3_Q15hKT=gyupb0FrPX1xV3tEBpVaYy1LF0kMUj2u8hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a3_Q15hKT=gyupb0FrPX1xV3tEBpVaYy1LF0kMUj2u8hw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, "S, Shirish" <sshankar@amd.com>
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "yshuiv7@gmail.com" <yshuiv7@gmail.com>, "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>, clang-built-linux <clang-built-linux@googlegroups.com>, Matthias Kaehlcke <mka@google.com>, "S, Shirish" <Shirish.S@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Oct 15, 2019 at 12:19 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Tue, Oct 15, 2019 at 9:08 AM S, Shirish <sshankar@amd.com> wrote:
> > On 10/15/2019 3:52 AM, Nick Desaulniers wrote:
>
> > My gcc build fails with below errors:
> >
> > dcn_calcs.c:1:0: error: -mpreferred-stack-boundary=3 is not between 4 and 12
> >
> > dcn_calc_math.c:1:0: error: -mpreferred-stack-boundary=3 is not between 4 and 12

I was able to reproduce this failure on pre-7.1 versions of GCC.  It
seems that when:
1. code is using doubles
2. setting -mpreferred-stack-boundary=3 -mno-sse2, ie. 8B stack alignment
than GCC produces that error:
https://godbolt.org/z/7T8nbH

That's already a tall order of constraints, so it's understandable
that the compiler would just error likely during instruction
selection, but was eventually taught how to solve such constraints.

> >
> > While GPF observed on clang builds seem to be fixed.

Thanks for the report.  Your testing these patches is invaluable, Shirish!

>
> Ok, so it seems that gcc insists on having at least 2^4 bytes stack
> alignment when
> SSE is enabled on x86-64, but does not actually rely on that for
> correct operation
> unless it's using sse2. So -msse always has to be paired with
>  -mpreferred-stack-boundary=3.

Seemingly only for older versions of GCC, pre 7.1.

>
> For clang, it sounds like the opposite is true: when passing 16 byte
> stack alignment
> and having sse/sse2 enabled, it requires the incoming stack to be 16
> byte aligned,

I don't think it requires the incoming stack to be 16B aligned for
sse2, I think it requires the incoming and current stack alignment to
match. Today it does not, which is why we observe GPFs.

> but passing 8 byte alignment makes it do the right thing.
>
> So, should we just always pass $(call cc-option, -mpreferred-stack-boundary=4)
> to get the desired outcome on both?

Hmmm...I would have liked to remove it outright, as it is an ABI
mismatch that is likely to result in instability and non-fun-to-debug
runtime issues in the future.  I suspect my patch does work for GCC
7.1+.  The question is: Do we want to either:
1. mark AMDGPU broken for GCC < 7.1, or
2. continue supporting it via stack alignment mismatch?

2 is brittle, and may break at any point in the future, but if it's
working for someone it does make me feel bad to outright disable it.
What I'd image 2 looks like is (psuedo code in a Makefile):

if CC_IS_GCC && GCC_VERSION < 7.1:
  set stack alignment to 16B and hope for the best

So my diff would be amended to keep the stack alignment flags, but
only to support GCC < 7.1.  And that assumes my change compiles with
GCC 7.1+. (Looks like it does for me locally with GCC 8.3, but I would
feel even more confident if someone with hardware to test on and GCC
7.1+ could boot test).
-- 
Thanks,
~Nick Desaulniers
