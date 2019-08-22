From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: remove duplicated include from gfx_v9_0.c
Date: Wed, 21 Aug 2019 22:40:20 -0400
Message-ID: <CADnq5_OFd8N1PpBXwr5mC0=SvZsKx7QUPqavLDEJ+d43hOO4Ng@mail.gmail.com>
References: <20190710015720.107326-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190710015720.107326-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Feifei Xu <Feifei.Xu@amd.com>, Likun Gao <Likun.Gao@amd.com>, James Zhu <James.Zhu@amd.com>, "S, Shirish" <shirish.s@amd.com>, "Quan, Evan" <evan.quan@amd.com>, Huang Rui <ray.huang@amd.com>, Rex Zhu <Rex.Zhu@amd.com>, kernel-janitors@vger.kernel.org, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Applied. thanks!

Alex

On Tue, Jul 9, 2019 at 11:03 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Remove duplicated include.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 5ba332376710..822f45161240 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -39,7 +39,6 @@
>  #include "vega10_enum.h"
>  #include "hdp/hdp_4_0_offset.h"
>
> -#include "soc15.h"
>  #include "soc15_common.h"
>  #include "clearstate_gfx9.h"
>  #include "v9_structs.h"
>
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
