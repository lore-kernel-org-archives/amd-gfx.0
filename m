From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: AMDGPU and 16B stack alignment
Date: Tue, 15 Oct 2019 11:11:28 -0700
Message-ID: <CAKwvOdmEDQ1yy0A1Z+x-8MX6taBJPaAseghpHxphrUi29wWRfA@mail.gmail.com>
References: <CAKwvOdnDVe-dahZGnRtzMrx-AH_C+2Lf20qjFQHNtn9xh=Okzw@mail.gmail.com>
 <9e4d6378-5032-8521-13a9-d9d9519d07de@amd.com> <CAK8P3a3_Q15hKT=gyupb0FrPX1xV3tEBpVaYy1LF0kMUj2u8hw@mail.gmail.com>
 <CAKwvOdnLxm_tZ_qR1D-BE64Z3QaMC2h79ooobdRVAzmCD_2_Sg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKwvOdnLxm_tZ_qR1D-BE64Z3QaMC2h79ooobdRVAzmCD_2_Sg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, "S, Shirish" <sshankar@amd.com>
Cc: "Wentland, Harry" <Harry.Wentland@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "yshuiv7@gmail.com" <yshuiv7@gmail.com>, "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>, clang-built-linux <clang-built-linux@googlegroups.com>, Matthias Kaehlcke <mka@google.com>, "S, Shirish" <Shirish.S@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Oct 15, 2019 at 11:05 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Tue, Oct 15, 2019 at 12:19 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > On Tue, Oct 15, 2019 at 9:08 AM S, Shirish <sshankar@amd.com> wrote:
> > > On 10/15/2019 3:52 AM, Nick Desaulniers wrote:
> >
> > > My gcc build fails with below errors:
> > >
> > > dcn_calcs.c:1:0: error: -mpreferred-stack-boundary=3 is not between 4 and 12
> > >
> > > dcn_calc_math.c:1:0: error: -mpreferred-stack-boundary=3 is not between 4 and 12
>
> I was able to reproduce this failure on pre-7.1 versions of GCC.  It
> seems that when:
> 1. code is using doubles
> 2. setting -mpreferred-stack-boundary=3 -mno-sse2, ie. 8B stack alignment
> than GCC produces that error:
> https://godbolt.org/z/7T8nbH
>

Also, I suspect that very error solves the mystery of "why was 16B
stack alignment ever specified?"
-- 
Thanks,
~Nick Desaulniers
