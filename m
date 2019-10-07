From: Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH -next] drm/amdgpu: remove duplicated include from mmhub_v1_0.c
Date: Mon, 7 Oct 2019 12:05:48 -0400
Message-ID: <CADnq5_Pjh2xXFHOSHg2NVQfYju21LUnWeAC4+rv-G2_hJVmOYw@mail.gmail.com>
References: <20191006074404.48416-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191006074404.48416-1-yuehaibing@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian Koenig <christian.koenig@amd.com>, Chunming Zhou <David1.Zhou@amd.com>, Dave Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "Le.Ma" <le.ma@amd.com>, Yong Zhao <Yong.Zhao@amd.com>, Trigger Huang <Trigger.Huang@amd.com>, Tao Zhou <tao.zhou1@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, kernel-janitors@vger.kernel.org, Maling list - DRI developers <dri-devel@lists.freedesktop.org>, amd-gfx list <amd-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Applied.  thanks!

Alex

On Sun, Oct 6, 2019 at 11:05 PM YueHaibing <yuehaibing@huawei.com> wrote:
>
> Remove duplicated include.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> index 4c7e8c64a94e..6965e1e6fa9e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> @@ -31,7 +31,6 @@
>  #include "vega10_enum.h"
>
>  #include "soc15_common.h"
> -#include "amdgpu_ras.h"
>
>  #define mmDAGB0_CNTL_MISC2_RV 0x008f
>  #define mmDAGB0_CNTL_MISC2_RV_BASE_IDX 0
>
>
>
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
