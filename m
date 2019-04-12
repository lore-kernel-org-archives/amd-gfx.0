From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH] drm/amdgpu/gmc8: fix VM_L2_CNTL3 programming
Date: Fri, 12 Apr 2019 09:20:01 +0200
Message-ID: <f40b865a-5b9e-a6e6-b95f-79586ee6f794@gmail.com>
References: <20190411195717.30117-1-alexander.deucher@amd.com>
Reply-To: christian.koenig@amd.com
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190411195717.30117-1-alexander.deucher@amd.com>
Content-Language: en-US
Sender: stable-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Am 11.04.19 um 21:57 schrieb Alex Deucher:
> Got accidently dropped when 2+1 level support was added.
>
> Fixes: 6a42fd6fbf534096 ("drm/amdgpu: implement 2+1 PD support for Raven v3")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> Cc: stable@vger.kernel.org
> ---
>   drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> index 1741056e6af6..41a9a5779623 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
> @@ -182,6 +182,7 @@ static void mmhub_v1_0_init_cache_regs(struct amdgpu_device *adev)
>   		tmp = REG_SET_FIELD(tmp, VM_L2_CNTL3,
>   				    L2_CACHE_BIGK_FRAGMENT_SIZE, 6);
>   	}
> +	WREG32_SOC15(MMHUB, 0, mmVM_L2_CNTL3, tmp);
>   
>   	tmp = mmVM_L2_CNTL4_DEFAULT;
>   	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL4, VMC_TAP_PDE_REQUEST_PHYSICAL, 0);
