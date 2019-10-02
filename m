From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 6/6] [RESEND] drm/amdgpu: work around llvm bug #42576
Date: Wed, 2 Oct 2019 14:06:33 -0700
Message-ID: <CAKwvOdmfD-vYNw=YZKBhZhaK04BSMD9xjPJ4seqDe+keHb42_w@mail.gmail.com>
References: <20191002120136.1777161-7-arnd@arndb.de> <20191002165137.15726-1-ndesaulniers@google.com>
 <20191002170733.GB1076951@archlinux-threadripper>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191002170733.GB1076951@archlinux-threadripper>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, Hawking.Zhang@amd.com, David Airlie <airlied@linux.ie>, "Deucher, Alexander" <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org, "Koenig, Christian" <christian.koenig@amd.com>, clang-built-linux <clang-built-linux@googlegroups.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel <dri-devel@lists.freedesktop.org>, le.ma@amd.com, LKML <linux-kernel@vger.kernel.org>, ray.huang@amd.com
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Oct 2, 2019 at 10:07 AM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Wed, Oct 02, 2019 at 09:51:37AM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> > > Apparently this bug is still present in both the released clang-9
> > > and the current development version of clang-10.
> > > I was hoping we would not need a workaround in clang-9+, but
> > > it seems that we do.

Here's a fix: https://reviews.llvm.org/D68356
Can't possibly land until clang-10 though.

> >
> > I think I'd rather:
> > 1. mark AMDGPU BROKEN if CC_IS_CLANG. There are numerous other issues building
> >    a working driver here.
>
> The only reason I am not thrilled about this is we will lose out on
> warning coverage while the compiler bug gets fixed. I think the AMDGPU
> drivers have been the single biggest source of clang warnings.
>
> I think something like:
>
> depends on CC_IS_GCC || (CC_IS_CLANG && COMPILE_TEST)
>
> would end up avoiding the runtime issues and give us warning coverage.
> The only issue is that we would still need this patch...
>
> Cheers,
> Nathan



-- 
Thanks,
~Nick Desaulniers
