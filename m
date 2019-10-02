From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 4/6] drm/amd/display: fix dcn21 Makefile for clang
Date: Wed, 2 Oct 2019 16:51:09 +0200
Message-ID: <CAK8P3a0KMT437okhobg=Vzi5LRDgUO7L-x35LczBGXE2jYLg2A@mail.gmail.com>
References: <20191002120136.1777161-1-arnd@arndb.de> <20191002120136.1777161-5-arnd@arndb.de>
 <CADnq5_PkTwTBbQY9JatZD2_sWjdU5_hK7V2GLfviEvMh_QB12Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CADnq5_PkTwTBbQY9JatZD2_sWjdU5_hK7V2GLfviEvMh_QB12Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, clang-built-linux <clang-built-linux@googlegroups.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Oct 2, 2019 at 4:17 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> I'm getting an error with gcc with this patch:
>   CC [M]  drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.o
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c: In
> function ‘calculate_wm_set_for_vlevel’:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.c:964:22:
> error: SSE register return with SSE disabled

I checked again with gcc-8, but do not see that error message.

> > -CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse -mpreferred-stack-boundary=4
> > +CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse $(cc_stack_align)

Nothing should really change with regards to the -msse flag here, only
the stack alignment flag changed. Maybe there was some other change
in your Makefile that conflicts with my my patch?

       Arnd
