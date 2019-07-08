From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH] drm/amd/powerplay: work around enum conversion warnings
Date: Mon, 8 Jul 2019 07:54:30 -0700
Message-ID: <20190708145430.GC43693@archlinux-epyc>
References: <20190708135725.844960-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190708135725.844960-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Likun Gao <Likun.Gao@amd.com>, Huang Rui <ray.huang@amd.com>, Gui Chengming <Jack.Gui@amd.com>, Kevin Wang <kevin1.wang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
List-Id: amd-gfx.lists.freedesktop.org

Hi Arnd,

On Mon, Jul 08, 2019 at 03:57:06PM +0200, Arnd Bergmann wrote:
> A couple of calls to smu_get_current_clk_freq() and smu_force_clk_levels()
> pass constants of the wrong type, leading to warnings with clang-8:
> 
> drivers/gpu/drm/amd/amdgpu/../powerplay/vega20_ppt.c:995:39: error: implicit conversion from enumeration type 'PPCLK_e' to different enumeration type 'enum smu_clk_type' [-Werror,-Wenum-conversion]
>                 ret = smu_get_current_clk_freq(smu, PPCLK_SOCCLK, &now);
>                       ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../powerplay/inc/amdgpu_smu.h:775:82: note: expanded from macro 'smu_get_current_clk_freq'
>         ((smu)->funcs->get_current_clk_freq? (smu)->funcs->get_current_clk_freq((smu), (clk_id), (value)) : 0)
> 
> I could not figure out what the purpose is of mixing the types
> like this and if it is written like this intentionally.
> Assuming this is all correct, adding an explict case is an
> easy way to shut up the warnings.
> 
> Fixes: bc0fcffd36ba ("drm/amd/powerplay: Unify smu handle task function (v2)")
> Fixes: 096761014227 ("drm/amd/powerplay: support sysfs to get socclk, fclk, dcefclk")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

I sent a series last week for all of the clang warnings that were added
in this driver recently.

https://lore.kernel.org/lkml/20190704055217.45860-1-natechancellor@gmail.com/

I think it is safe to use the CLK enums from the expected type (from
what I could see from going down the code flow rabbit hole).

https://lore.kernel.org/lkml/20190704055217.45860-4-natechancellor@gmail.com/

https://lore.kernel.org/lkml/20190704055217.45860-7-natechancellor@gmail.com/

Cheers,
Nathan
