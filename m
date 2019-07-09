From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH 5/7] drm/amd/display: Use proper enum conversion functions
Date: Tue, 9 Jul 2019 13:21:50 -0700
Message-ID: <20190709202150.GB96242@archlinux-threadripper>
References: <20190704055217.45860-1-natechancellor@gmail.com>
 <20190704055217.45860-6-natechancellor@gmail.com>
 <CAK8P3a1vEtrS7SbhCPVxoYBcroT+Hr3Q4LFs6AJJ8G8GVw5SVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAK8P3a1vEtrS7SbhCPVxoYBcroT+Hr3Q4LFs6AJJ8G8GVw5SVA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx list <amd-gfx@lists.freedesktop.org>, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, clang-built-linux <clang-built-linux@googlegroups.com>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 09, 2019 at 08:51:33PM +0200, Arnd Bergmann wrote:
> On Thu, Jul 4, 2019 at 7:52 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > clang warns:
> >
> > drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:336:8:
> > warning: implicit conversion from enumeration type 'enum smu_clk_type'
> > to different enumeration type 'enum amd_pp_clock_type'
> > [-Wenum-conversion]
> >                                         dc_to_smu_clock_type(clk_type),
> >                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_pp_smu.c:421:14:
> > warning: implicit conversion from enumeration type 'enum
> > amd_pp_clock_type' to different enumeration type 'enum smu_clk_type'
> > [-Wenum-conversion]
> >                                         dc_to_pp_clock_type(clk_type),
> >                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > There are functions to properly convert between all of these types, use
> > them so there are no longer any warnings.
> 
> I had a different solution for this one as well. The difference is that your
> patch keeps the types and assumes that the functions do the right thing
> (i.e. the warning was correct), while my version assumes that the code
> works correctly, but the types are wrong (a false positive warning).
> 
> One of the two patches is correct, the other one is broken, but I have
> no idea which one.
> 
>       Arnd

Indeed. I would personally argue that if using the correct conversion
functions (which are here to specifically avoid this type of warning)
causes issues, this code should probably not be using enumerated types
at all since the entire point is to enforce semantic correctness, not
just be a special way to represent small integer values, especially in
the case where the CLK values are completely different numerical values
in various enumerated types. I think enumerated type casts are ugly and
defeat the purpose of them but that's obviously just my opinion :)

Hopefully we can get some clarity on this soon.

Cheers,
Nathan
