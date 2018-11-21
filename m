From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH] drm/amd/amdgpu: Remove duplicate header
Date: Wed, 21 Nov 2018 15:05:48 -0500
Message-ID: <CADnq5_NknpPEDTpx+5h_8N=WTXhgbqxsMPsymPs_K+RTDeYedw@mail.gmail.com>
References: <20181121135151.GA2536@hp-pavilion-15-notebook-pc-brajeswar>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121135151.GA2536@hp-pavilion-15-notebook-pc-brajeswar>
Sender: linux-kernel-owner@vger.kernel.org
To: brajeswar.linux@gmail.com
Cc: "Deucher, Alexander" <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>, Andrey Grodzovsky <andrey.grodzovsky@amd.com>, Pixel Ding <Pixel.Ding@amd.com>, "monk.liu" <Monk.Liu@amd.com>, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, Sabyasachi Gupta <sabyasachi.linux@gmail.com>, Souptick Joarder <jrdr.linux@gmail.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Applied.  thanks!
On Wed, Nov 21, 2018 at 9:24 AM Brajeswar Ghosh
<brajeswar.linux@gmail.com> wrote:
>
> Remove gca/gfx_8_0_sh_mask.h which is included more than once
>
> Signed-off-by: Brajeswar Ghosh <brajeswar.linux@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> index 64e875d528dd..6a0fcd67662a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> @@ -37,7 +37,6 @@
>  #include "gmc/gmc_8_2_sh_mask.h"
>  #include "oss/oss_3_0_d.h"
>  #include "oss/oss_3_0_sh_mask.h"
> -#include "gca/gfx_8_0_sh_mask.h"
>  #include "dce/dce_10_0_d.h"
>  #include "dce/dce_10_0_sh_mask.h"
>  #include "smu/smu_7_1_3_d.h"
> --
> 2.17.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
