From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] drm/amd/display: Fix compile error due to 'endif' missing
Date: Tue, 17 Sep 2019 02:46:48 +0900
Message-ID: <CAK7LNARZMr5ZKGufi63GZrZ45k60faAiXr4mBB_mU9h_QifjxQ@mail.gmail.com>
References: <20190916044651.GA72121@LGEARND20B15>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190916044651.GA72121@LGEARND20B15>
Sender: linux-kernel-owner@vger.kernel.org
To: Austin Kim <austindh.kim@gmail.com>, Stephen Rothwell <sfr@canb.auug.org.au>, Mark Brown <broonie@kernel.org>
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Roman.Li@amd.com, amd-gfx@lists.freedesktop.org, dri-devel <dri-devel@lists.freedesktop.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

(+CC Stephen Rothwell, Mark Brown)

On Mon, Sep 16, 2019 at 1:46 PM Austin Kim <austindh.kim@gmail.com> wrote:
>
> gcc throws compile error with below message:

GNU Make throws ...


This is probably a merge mistake in linux-next.

If so, this should be directly fixed in the linux-next.

If it is not fixed in time,
please inform Linus to *not* follow the linux-next.


Thanks.



>
> HDRINST usr/include/drm/i915_drm.h
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/Makefile:70: *** missing 'endif'.  Stop.
> scripts/Makefile.modbuiltin:55: recipe for target 'drivers/gpu/drm/amd/amdgpu' failed
> make[3]: *** [drivers/gpu/drm/amd/amdgpu] Error 2
> make[3]: *** Waiting for unfinished jobs....
>   HDRINST usr/include/drm/omap_drm.h
>   HDRINST usr/include/drm/tegra_drm.h
>   HDRINST usr/include/drm/drm_sarea.h
>   HDRINST usr/include/drm/panfrost_drm.h
>   HDRINST usr/include/drm/drm.h
> scripts/Makefile.modbuiltin:55: recipe for target 'drivers/gpu/drm' failed
> make[2]: *** [drivers/gpu/drm] Error 2
> scripts/Makefile.modbuiltin:55: recipe for target 'drivers/gpu' failed
> make[1]: *** [drivers/gpu] Error 2
> make[1]: *** Waiting for unfinished jobs....
>
> Add 'endif' to Makefile to stop compile error.
>
> Signed-off-by: Austin Kim <austindh.kim@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/Makefile | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> index a2eb59e..5b2a65b 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
> +++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
> @@ -44,6 +44,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20.o := $(dml_ccflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20v2.o := $(dml_ccflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_rq_dlg_calc_20v2.o := $(dml_ccflags)
> +endif
>  ifdef CONFIG_DRM_AMD_DC_DCN2_1
>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_mode_vba_21.o := $(dml_ccflags)
>  CFLAGS_$(AMDDALPATH)/dc/dml/dcn21/display_rq_dlg_calc_21.o := $(dml_ccflags)
> --
> 2.6.2
>


-- 
Best Regards
Masahiro Yamada
