From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 1/2] drm/radeon: fix KV harvesting
Date: Mon, 5 Mar 2018 19:55:54 +0100
Message-ID: <a5c085ca-4aa8-9955-a333-4d71db4198cd@gmail.com>
References: <20180305183014.4861-1-alexander.deucher@amd.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180305183014.4861-1-alexander.deucher@amd.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Am 05.03.2018 um 19:30 schrieb Alex Deucher:
> Always set the graphics values to the max for the
> asic type.  E.g., some 1 RB chips are actually 1 RB chips,
> others are actually harvested 2 RB chips.
>
> Fixes: https://bugs.freedesktop.org/show_bug.cgi?id=99353
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Christian König <christian.koenig@amd.com> for the series.

> ---
>   drivers/gpu/drm/radeon/cik.c | 31 ++-----------------------------
>   1 file changed, 2 insertions(+), 29 deletions(-)
>
> diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
> index d3045a371a55..7c73bc7e2f85 100644
> --- a/drivers/gpu/drm/radeon/cik.c
> +++ b/drivers/gpu/drm/radeon/cik.c
> @@ -3221,35 +3221,8 @@ static void cik_gpu_init(struct radeon_device *rdev)
>   	case CHIP_KAVERI:
>   		rdev->config.cik.max_shader_engines = 1;
>   		rdev->config.cik.max_tile_pipes = 4;
> -		if ((rdev->pdev->device == 0x1304) ||
> -		    (rdev->pdev->device == 0x1305) ||
> -		    (rdev->pdev->device == 0x130C) ||
> -		    (rdev->pdev->device == 0x130F) ||
> -		    (rdev->pdev->device == 0x1310) ||
> -		    (rdev->pdev->device == 0x1311) ||
> -		    (rdev->pdev->device == 0x131C)) {
> -			rdev->config.cik.max_cu_per_sh = 8;
> -			rdev->config.cik.max_backends_per_se = 2;
> -		} else if ((rdev->pdev->device == 0x1309) ||
> -			   (rdev->pdev->device == 0x130A) ||
> -			   (rdev->pdev->device == 0x130D) ||
> -			   (rdev->pdev->device == 0x1313) ||
> -			   (rdev->pdev->device == 0x131D)) {
> -			rdev->config.cik.max_cu_per_sh = 6;
> -			rdev->config.cik.max_backends_per_se = 2;
> -		} else if ((rdev->pdev->device == 0x1306) ||
> -			   (rdev->pdev->device == 0x1307) ||
> -			   (rdev->pdev->device == 0x130B) ||
> -			   (rdev->pdev->device == 0x130E) ||
> -			   (rdev->pdev->device == 0x1315) ||
> -			   (rdev->pdev->device == 0x1318) ||
> -			   (rdev->pdev->device == 0x131B)) {
> -			rdev->config.cik.max_cu_per_sh = 4;
> -			rdev->config.cik.max_backends_per_se = 1;
> -		} else {
> -			rdev->config.cik.max_cu_per_sh = 3;
> -			rdev->config.cik.max_backends_per_se = 1;
> -		}
> +		rdev->config.cik.max_cu_per_sh = 8;
> +		rdev->config.cik.max_backends_per_se = 2;
>   		rdev->config.cik.max_sh_per_se = 1;
>   		rdev->config.cik.max_texture_channel_caches = 4;
>   		rdev->config.cik.max_gprs = 256;
