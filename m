From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: AMDGPU and 16B stack alignment
Date: Tue, 15 Oct 2019 09:19:04 +0200
Message-ID: <CAK8P3a3_Q15hKT=gyupb0FrPX1xV3tEBpVaYy1LF0kMUj2u8hw@mail.gmail.com>
References: <CAKwvOdnDVe-dahZGnRtzMrx-AH_C+2Lf20qjFQHNtn9xh=Okzw@mail.gmail.com>
 <9e4d6378-5032-8521-13a9-d9d9519d07de@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9e4d6378-5032-8521-13a9-d9d9519d07de@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "S, Shirish" <sshankar@amd.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>, "Wentland, Harry" <Harry.Wentland@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>, "yshuiv7@gmail.com" <yshuiv7@gmail.com>, "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>, clang-built-linux <clang-built-linux@googlegroups.com>, Matthias Kaehlcke <mka@google.com>, "S, Shirish" <Shirish.S@amd.com>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Oct 15, 2019 at 9:08 AM S, Shirish <sshankar@amd.com> wrote:
> On 10/15/2019 3:52 AM, Nick Desaulniers wrote:

> My gcc build fails with below errors:
>
> dcn_calcs.c:1:0: error: -mpreferred-stack-boundary=3 is not between 4 and 12
>
> dcn_calc_math.c:1:0: error: -mpreferred-stack-boundary=3 is not between 4 and 12
>
> While GPF observed on clang builds seem to be fixed.

Ok, so it seems that gcc insists on having at least 2^4 bytes stack
alignment when
SSE is enabled on x86-64, but does not actually rely on that for
correct operation
unless it's using sse2. So -msse always has to be paired with
 -mpreferred-stack-boundary=3.

For clang, it sounds like the opposite is true: when passing 16 byte
stack alignment
and having sse/sse2 enabled, it requires the incoming stack to be 16
byte aligned,
but passing 8 byte alignment makes it do the right thing.

So, should we just always pass $(call cc-option, -mpreferred-stack-boundary=4)
to get the desired outcome on both?

       Arnd
