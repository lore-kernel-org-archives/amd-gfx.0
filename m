From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/display: readd -msse2 to prevent Clang from
 emitting libcalls to undefined SW FP routines
Date: Tue, 23 Jul 2019 14:31:03 -0400
Message-ID: <CADnq5_MA+oCYRWLyaJT+oQGwA2jDwfX554qNZoS6BtKmeSru1Q@mail.gmail.com>
References: <20190722223112.199769-1-ndesaulniers@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190722223112.199769-1-ndesaulniers@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, "Wentland, Harry" <harry.wentland@amd.com>, David Airlie <airlied@linux.ie>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, clang-built-linux@googlegroups.com, amd-gfx list <amd-gfx@lists.freedesktop.org>, Matthias Kaehlcke <mka@google.com>, samitolvanen@google.com, Guenter Roeck <linux@roeck-us.net>, Arnd Bergmann <arnd@arndb.de>, Charlene Liu <charlene.liu@amd.com>, Leo Li <sunpeng.li@amd.com>, Sedat Dilek <sedat.dilek@gmail.com>, Nathan Chancellor <natechancellor@gmail.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, =?UTF-8?Q?Michel_D=C3=A4nzer?= <michel.daenzer@amd.com>, LKML <linux-kernel@vger.kernel.org>, "S, Shirish" <Shirish.S@amd.com>, Dmytro Laktyushkin <Dmytro>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Jul 23, 2019 at 3:16 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> arch/x86/Makefile disables SSE and SSE2 for the whole kernel.  The
> AMDGPU drivers modified in this patch re-enable SSE but not SSE2.  Turn
> on SSE2 to support emitting double precision floating point instructions
> rather than calls to non-existent (usually available from gcc_s or
> compiler_rt) floating point helper routines for Clang.
>
> This was originally landed in:
> commit 10117450735c ("drm/amd/display: add -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines")
> but reverted in:
> commit 193392ed9f69 ("Revert "drm/amd/display: add -msse2 to prevent Clang from emitting libcalls to undefined SW FP routines"")
> due to bugreports from GCC builds. Add guards to only do so for Clang.
>
> Link: https://bugs.freedesktop.org/show_bug.cgi?id=109487
> Link: https://github.com/ClangBuiltLinux/linux/issues/327
>
> Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Suggested-by: Sami Tolvanen <samitolvanen@google.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Applied.  Thanks!

Alex

> ---
>  drivers/gpu/drm/amd/display/dc/calcs/Makefile | 4 ++++
>  drivers/gpu/drm/amd/display/dc/dcn20/Makefile | 4 ++++
>  drivers/gpu/drm/amd/display/dc/dml/Makefile   | 4 ++++
>  drivers/gpu/drm/amd/display/dc/dsc/Makefile   | 4 ++++
>  4 files changed, 16 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/calcs/Makefile b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> index 95f332ee3e7e..16614d73a5fc 100644
> --- a/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/calcs/Makefile
> @@ -32,6 +32,10 @@ endif
>
>  calcs_ccflags := -mhard-float -msse $(cc_stack_align)
>
> +ifdef CONFIG_CC_IS_CLANG
> +calcs_ccflags += -msse2
> +endif
> +
>  CFLAGS_dcn_calcs.o := $(calcs_ccflags)
>  CFLAGS_dcn_calc_auto.o := $(calcs_ccflags)
>  CFLAGS_dcn_calc_math.o := $(calcs_ccflags) -Wno-tautological-compare
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
> index e9721a906592..f57a3b281408 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn20/Makefile
> @@ -18,6 +18,10 @@ endif
>
>  CFLAGS_dcn20_resource.o := -mhard-float -msse $(cc_stack_align)
>
> +ifdef CONFIG_CC_IS_CLANG
> +CFLAGS_dcn20_resource.o += -msse2
> +endif
> +
>  AMD_DAL_DCN20 = $(addprefix $(AMDDALPATH)/dc/dcn20/,$(DCN20))
>
>  AMD_DISPLAY_FILES += $(AMD_DAL_DCN20)
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index 0bb7a20675c4..132ade1a234e 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -32,6 +32,10 @@ endif
>
>  dml_ccflags := -mhard-float -msse $(cc_stack_align)
>
> +ifdef CONFIG_CC_IS_CLANG
> +dml_ccflags += -msse2
> +endif
> +
>  CFLAGS_display_mode_lib.o := $(dml_ccflags)
>
>  ifdef CONFIG_DRM_AMD_DC_DCN2_0
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/Makefile b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> index e019cd9447e8..17db603f2d1f 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/Makefile
> @@ -9,6 +9,10 @@ endif
>
>  dsc_ccflags := -mhard-float -msse $(cc_stack_align)
>
> +ifdef CONFIG_CC_IS_CLANG
> +dsc_ccflags += -msse2
> +endif
> +
>  CFLAGS_rc_calc.o := $(dsc_ccflags)
>  CFLAGS_rc_calc_dpi.o := $(dsc_ccflags)
>  CFLAGS_codec_main_amd.o := $(dsc_ccflags)
> --
> 2.22.0.657.g960e92d24f-goog
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
