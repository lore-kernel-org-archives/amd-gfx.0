From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] drm/amd/powerplay: work around enum conversion warnings
Date: Mon, 15 Jul 2019 11:20:48 +0200
Message-ID: <CAK8P3a0FyzThq_8dO27OxP7nXVORGf5jQQnfUnnG0u272ChRtQ@mail.gmail.com>
References: <20190708135725.844960-1-arnd@arndb.de> <20190708145430.GC43693@archlinux-epyc>
 <CAK8P3a0ZVqEYCxoCOcAgJL7oV+su0=eZu_XR6X+9vcXzGDwVSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAK8P3a0ZVqEYCxoCOcAgJL7oV+su0=eZu_XR6X+9vcXzGDwVSQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nathan Chancellor <natechancellor@gmail.com>
Cc: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Likun Gao <Likun.Gao@amd.com>, Huang Rui <ray.huang@amd.com>, Gui Chengming <Jack.Gui@amd.com>, Kevin Wang <kevin1.wang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Jul 8, 2019 at 6:05 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Jul 8, 2019 at 4:54 PM Nathan Chancellor
> <natechancellor@gmail.com> wrote:

> > On Mon, Jul 08, 2019 at 03:57:06PM +0200, Arnd Bergmann wrote:
> > > A couple of calls to smu_get_current_clk_freq() and smu_force_clk_levels()
> > > pass constants of the wrong type, leading to warnings with clang-8:
> > >
> > > drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:995:39: error: implicit conversion from enumeration type 'PPCLK_e' to different enumeration type 'enum smu_clk_type' [-Werror,-Wenum-conversion]
> > >                 ret = smu_get_current_clk_freq(smu, PPCLK_SOCCLK, &now);
> > >                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> > > drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:775:82: note: expanded from macro 'smu_get_current_clk_freq'
> > >         ((smu)->funcs->get_current_clk_freq? (smu)->funcs->get_current_clk_freq((smu), (clk_id), (value)) : 0)
> > >
> > > I could not figure out what the purpose is of mixing the types
> > > like this and if it is written like this intentionally.
> > > Assuming this is all correct, adding an explict case is an
> > > easy way to shut up the warnings.
> > >
> > > Fixes: bc0fcffd36ba ("drm/amd/powerplay: Unify smu handle task function (v2)")
> > > Fixes: 096761014227 ("drm/amd/powerplay: support sysfs to get socclk, fclk, dcefclk")
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > I sent a series last week for all of the clang warnings that were added
> > in this driver recently.
> >
> > https://lore.kernel.org/lkml/20190704055217.45860-1-natechancellor@gmail.com/
> >
> > I think it is safe to use the CLK enums from the expected type (from
> > what I could see from going down the code flow rabbit hole).
> >
> > https://lore.kernel.org/lkml/20190704055217.45860-4-natechancellor@gmail.com/
> >
> > https://lore.kernel.org/lkml/20190704055217.45860-7-natechancellor@gmail.com/
>
> I tried that at first but concluded that it could not work because the constants
> are different. Either it's currently broken and you patches fix the runtime
> behavior, or it's currently correct and your patches break it.

d36893362d22 ("drm/amd/powerplay: fix smu clock type change miss error")
was now applied and contains the same change as your first patch.

I assume the other one is still needed though.

       Arnd
