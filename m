From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Support clang option for stack alignment
Date: Fri, 12 Jul 2019 13:51:09 -0400
Message-ID: <CADnq5_Mm=Fj4AkFtuo+W_295q8r6DY3Sumo7gTG-McUYY=CeVg@mail.gmail.com>
References: <20190712093720.1461418-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190712093720.1461418-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Charlene Liu <charlene.liu@amd.com>, Duke Du <Duke.Du@amd.com>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, clang-built-linux@googlegroups.com, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Jul 12, 2019 at 5:37 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> As previously fixed for dml in commit 4769278e5c7f ("amdgpu/dc/dml:
> Support clang option for stack alignment") and calcs in commit
> cc32ad8f559c ("amdgpu/dc/calcs: Support clang option for stack
> alignment"), dcn20 uses an option that is not available with clang:
>
> clang: error: unknown argument: '-mpreferred-stack-boundary=4'
> scripts/Makefile.build:281: recipe for target 'drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_resource.o' failed
>
> Use the same trick that we have in the other two files.
>
> Fixes: 7ed4e6352c16 ("drm/amd/display: Add DCN2 HW Sequencer and Resource")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.  thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/dcn20/Makefile |  8 +++++++-
>  drivers/gpu/drm/amd/display/dc/dsc/Makefile   | 16 ++++++++++++----
>  2 files changed, 19 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
> index 1b68de27ba74..e9721a906592 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
> @@ -10,7 +10,13 @@ ifdef CONFIG_DRM_AMD_DC_DSC_SUPPORT
>  DCN20 += dcn20_dsc.o
>  endif
>
> -CFLAGS_dcn20_resource.o := -mhard-float -msse -mpreferred-stack-boundary=4
> +ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
> +       cc_stack_align := -mpreferred-stack-boundary=4
> +else ifneq ($(call cc-option, -mstack-alignment=16),)
> +       cc_stack_align := -mstack-alignment=16
> +endif
> +
> +CFLAGS_dcn20_resource.o := -mhard-float -msse $(cc_stack_align)
>
>  AMD_DAL_DCN20 = $(addprefix $(AMDDALPATH)/dc/dcn20/,$(DCN20))
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> index c5d5b94e2604..e019cd9447e8 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> @@ -1,10 +1,18 @@
>  #
>  # Makefile for the 'dsc' sub-component of DAL.
>
> -CFLAGS_rc_calc.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -CFLAGS_rc_calc_dpi.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -CFLAGS_codec_main_amd.o := -mhard-float -msse -mpreferred-stack-boundary=4
> -CFLAGS_dc_dsc.o := -mhard-float -msse -mpreferred-stack-boundary=4
> +ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
> +       cc_stack_align := -mpreferred-stack-boundary=4
> +else ifneq ($(call cc-option, -mstack-alignment=16),)
> +       cc_stack_align := -mstack-alignment=16
> +endif
> +
> +dsc_ccflags := -mhard-float -msse $(cc_stack_align)
> +
> +CFLAGS_rc_calc.o := $(dsc_ccflags)
> +CFLAGS_rc_calc_dpi.o := $(dsc_ccflags)
> +CFLAGS_codec_main_amd.o := $(dsc_ccflags)
> +CFLAGS_dc_dsc.o := $(dsc_ccflags)
>
>  DSC = dc_dsc.o rc_calc.o rc_calc_dpi.o
>
> --
> 2.20.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
