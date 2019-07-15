From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 6/7] drm/amd/powerplay: Use proper enums in
 vega20_print_clk_levels
Date: Mon, 15 Jul 2019 08:39:32 -0700
Message-ID: <20190715153932.GA41785@archlinux-threadripper>
References: <20190704055217.45860-1-natechancellor@gmail.com>
 <20190704055217.45860-7-natechancellor@gmail.com>
 <CAK8P3a1e4xKTZc1Fcd9KLwaGG_wpcAnSNu7mrB6zw+aBJ0e0CA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a1e4xKTZc1Fcd9KLwaGG_wpcAnSNu7mrB6zw+aBJ0e0CA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>, Kevin Wang <kevin1.wang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Mon, Jul 15, 2019 at 11:25:29AM +0200, Arnd Bergmann wrote:
> On Thu, Jul 4, 2019 at 7:52 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > clang warns:
> >
> > drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:995:39: warning:
> > implicit conversion from enumeration type 'PPCLK_e' to different
> > enumeration type 'enum smu_clk_type' [-Wenum-conversion]
> >                 ret = smu_get_current_clk_freq(smu, PPCLK_SOCCLK, &now);
> >                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:1016:39: warning:
> > implicit conversion from enumeration type 'PPCLK_e' to different
> > enumeration type 'enum smu_clk_type' [-Wenum-conversion]
> >                 ret = smu_get_current_clk_freq(smu, PPCLK_FCLK, &now);
> >                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:1031:39: warning:
> > implicit conversion from enumeration type 'PPCLK_e' to different
> > enumeration type 'enum smu_clk_type' [-Wenum-conversion]
> >                 ret = smu_get_current_clk_freq(smu, PPCLK_DCEFCLK, &now);
> >                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~
> >
> > The values are mapped one to one in vega20_get_smu_clk_index so just use
> > the proper enums here.
> >
> > Fixes: 096761014227 ("drm/amd/powerplay: support sysfs to get socclk, fclk, dcefclk")
> > Link: https://github.com/ClangBuiltLinux/linux/issues/587
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> 
> Adding Kevin Wang for further review, as he sent a related patch in
> d36893362d22 ("drm/amd/powerplay: fix smu clock type change miss error")
> 
> I assume this one is still required as it triggers the same warning.
> Kevin, can you have a look?
> 
>       Arnd

Indeed, this one and https://github.com/ClangBuiltLinux/linux/issues/586
are still outstanding.

https://patchwork.freedesktop.org/patch/315581/

Cheers,
Nathan

> 
> >  drivers/gpu/drm/amd/powerplay/vega20_ppt.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> > index 0f14fe14ecd8..e62dd6919b24 100644
> > --- a/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> > +++ b/drivers/gpu/drm/amd/powerplay/vega20_ppt.c
> > @@ -992,7 +992,7 @@ static int vega20_print_clk_levels(struct smu_context *smu,
> >                 break;
> >
> >         case SMU_SOCCLK:
> > -               ret = smu_get_current_clk_freq(smu, PPCLK_SOCCLK, &now);
> > +               ret = smu_get_current_clk_freq(smu, SMU_SOCCLK, &now);
> >                 if (ret) {
> >                         pr_err("Attempt to get current socclk Failed!");
> >                         return ret;
> > @@ -1013,7 +1013,7 @@ static int vega20_print_clk_levels(struct smu_context *smu,
> >                 break;
> >
> >         case SMU_FCLK:
> > -               ret = smu_get_current_clk_freq(smu, PPCLK_FCLK, &now);
> > +               ret = smu_get_current_clk_freq(smu, SMU_FCLK, &now);
> >                 if (ret) {
> >                         pr_err("Attempt to get current fclk Failed!");
> >                         return ret;
> > @@ -1028,7 +1028,7 @@ static int vega20_print_clk_levels(struct smu_context *smu,
> >                 break;
> >
> >         case SMU_DCEFCLK:
> > -               ret = smu_get_current_clk_freq(smu, PPCLK_DCEFCLK, &now);
> > +               ret = smu_get_current_clk_freq(smu, SMU_DCEFCLK, &now);
> >                 if (ret) {
> >                         pr_err("Attempt to get current dcefclk Failed!");
> >                         return ret;
