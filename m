From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH 0/6] amdgpu build fixes
Date: Wed, 2 Oct 2019 14:47:10 -0400
Message-ID: <CADnq5_MLg=J5dmSGzx8jC=1--d2S3HJzWH3EHhyzT6da5a3wcA@mail.gmail.com>
References: <20191002120136.1777161-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191002120136.1777161-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Alex Deucher <alexander.deucher@amd.com>, clang-built-linux <clang-built-linux@googlegroups.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Oct 2, 2019 at 8:02 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Here are a couple of build fixes from my backlog in the randconfig
> tree. It would be good to get them all into linux-5.4.
>
>      Arnd
>
> Arnd Bergmann (6):
>   drm/amdgpu: make pmu support optional, again
>   drm/amdgpu: hide another #warning
>   drm/amdgpu: display_mode_vba_21: remove uint typedef
>   drm/amd/display: fix dcn21 Makefile for clang
>   [RESEND] drm/amd/display: hide an unused variable
>   [RESEND] drm/amdgpu: work around llvm bug #42576

I've applied 1-5 and I'll send them for 5.4.  There still seems to be
some debate about 6.

Thanks.

Alex

>
>  drivers/gpu/drm/amd/amdgpu/Makefile                 |  2 +-
>  drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c              |  1 +
>  drivers/gpu/drm/amd/amdgpu/soc15.c                  |  2 --
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   |  2 ++
>  drivers/gpu/drm/amd/display/dc/dcn21/Makefile       | 12 +++++++++++-
>  .../amd/display/dc/dml/dcn21/display_mode_vba_21.c  | 13 +++++--------
>  6 files changed, 20 insertions(+), 12 deletions(-)
>
> --
> 2.20.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
