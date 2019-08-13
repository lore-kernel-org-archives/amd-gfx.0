From: Colin Ian King <colin.king@canonical.com>
Subject: Re: [PATCH] drm/amdgpu/powerplay: fix spelling mistake "unsuported"
 -> "unsupported"
Date: Tue, 13 Aug 2019 11:34:05 +0100
Message-ID: <cba2d16e-9518-0d3b-6112-5e33e47cdf94@canonical.com>
References: <20190813103340.11051-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190813103340.11051-1-colin.king@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

[drm-next]

On 13/08/2019 11:33, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a pr_err error message. Fix it. Also
> add a space after a comma to clean up a checkpatch warning.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/powerplay/smu_v11_0.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> index 8bbcf034799c..d324bd28934d 100644
> --- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> +++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
> @@ -288,7 +288,7 @@ static int smu_v11_0_check_fw_version(struct smu_context *smu)
>  		smu->smc_if_version = SMU11_DRIVER_IF_VERSION_NV14;
>  		break;
>  	default:
> -		pr_err("smu unsuported asic type:%d.\n",smu->adev->asic_type);
> +		pr_err("smu unsupported asic type:%d.\n", smu->adev->asic_type);
>  		smu->smc_if_version = SMU11_DRIVER_IF_VERSION_INV;
>  		break;
>  	}
> 
