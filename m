From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd: remove meaningless descending into amd/amdkfd/
Date: Tue, 27 Aug 2019 11:09:38 -0400
Message-ID: <CADnq5_OUC_Wtwe2+w-DRtEUoBEmNa6GkoQ10_qD8=28xF32jBg@mail.gmail.com>
References: <20190827064425.19627-1-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190827064425.19627-1-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?B?Q2hyaXN0aWFuIEvvv73vv73Dk25pZw==?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, Maxime Ripard <maxime.ripard@bootlin.com>, David Airlie <airlied@linux.ie>, LKML <linux-kernel@vger.kernel.org>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Sean Paul <sean@poorly.run>
List-Id: amd-gfx.lists.freedesktop.org

On Tue, Aug 27, 2019 at 3:29 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Since commit 04d5e2765802 ("drm/amdgpu: Merge amdkfd into amdgpu"),
> drivers/gpu/drm/amd/amdkfd/Makefile does not contain any syntax that
> is understood by the build system.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied.  thanks!

Alex

> ---
>
>  drivers/gpu/drm/Makefile | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 9f0d2ee35794..3f9195b7ad13 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -62,7 +62,6 @@ obj-$(CONFIG_DRM_TTM) += ttm/
>  obj-$(CONFIG_DRM_SCHED)        += scheduler/
>  obj-$(CONFIG_DRM_TDFX) += tdfx/
>  obj-$(CONFIG_DRM_R128) += r128/
> -obj-$(CONFIG_HSA_AMD) += amd/amdkfd/
>  obj-$(CONFIG_DRM_RADEON)+= radeon/
>  obj-$(CONFIG_DRM_AMDGPU)+= amd/amdgpu/
>  obj-$(CONFIG_DRM_MGA)  += mga/
> --
> 2.17.1
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
