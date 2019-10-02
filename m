From: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 4/6] drm/amd/display: fix dcn21 Makefile for clang
Date: Wed, 2 Oct 2019 14:14:29 -0700
Message-ID: <CAKwvOdmjM80XP7VH83iLn=8mz6W1+SbXST2FChEnH0LSRRm4pA@mail.gmail.com>
References: <20191002120136.1777161-1-arnd@arndb.de> <20191002120136.1777161-5-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191002120136.1777161-5-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Alex Deucher <alexander.deucher@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, clang-built-linux <clang-built-linux@googlegroups.com>, amd-gfx@lists.freedesktop.org, LKML <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Wed, Oct 2, 2019 at 5:03 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> Just like all the other variants, this one passes invalid
> compile-time options with clang after the new code got
> merged:
>
> clang: error: unknown argument: '-mpreferred-stack-boundary=4'
> scripts/Makefile.build:265: recipe for target 'drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_resource.o' failed
>
> Use the same variant that we have for dcn20 to fix compilation.
>
> Fixes: eced51f9babb ("drm/amd/display: Add hubp block for Renoir (v2)")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thanks for the patch!
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Tested-by: Nick Desaulniers <ndesaulniers@google.com>
(Though I think it's already been merged)

Alex, do you know why the AMDGPU driver uses a different stack
alignment (16B) than the rest of the x86 kernel?  (see
arch/x86/Makefile which uses 8B stack alignment).

> ---
>  drivers/gpu/drm/amd/display/dc/dcn21/Makefile | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> index 8cd9de8b1a7a..ef673bffc241 100644
> --- a/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dcn21/Makefile
> @@ -3,7 +3,17 @@
>
>  DCN21 = dcn21_hubp.o dcn21_hubbub.o dcn21_resource.o
>
> -CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse -mpreferred-stack-boundary=4
> +ifneq ($(call cc-option, -mpreferred-stack-boundary=4),)
> +       cc_stack_align := -mpreferred-stack-boundary=4
> +else ifneq ($(call cc-option, -mstack-alignment=16),)
> +       cc_stack_align := -mstack-alignment=16
> +endif
> +
> +CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o := -mhard-float -msse $(cc_stack_align)
> +
> +ifdef CONFIG_CC_IS_CLANG
> +CFLAGS_$(AMDDALPATH)/dc/dcn21/dcn21_resource.o += -msse2
> +endif
>
>  AMD_DAL_DCN21 = $(addprefix $(AMDDALPATH)/dc/dcn21/,$(DCN21))
>
> --
> 2.20.0
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/20191002120136.1777161-5-arnd%40arndb.de.



-- 
Thanks,
~Nick Desaulniers
