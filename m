From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH 1/7] drm/amdgpu: remove set but not used variable
 'mc_shared_chmap' from 'gfx_v6_0.c' and 'gfx_v7_0.c'
Date: Wed, 13 Nov 2019 08:55:47 -0800
Message-ID: <ac4566662a04e0c25039df7ed30789d0792885cd.camel@perches.com>
References: <1573649074-72589-1-git-send-email-yukuai3@huawei.com>
         <1573649074-72589-2-git-send-email-yukuai3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1573649074-72589-2-git-send-email-yukuai3@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: yu kuai <yukuai3@huawei.com>, alexander.deucher@amd.com, Felix.Kuehling@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Rex.Zhu@amd.com, evan.quan@amd.com
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, zhengbin13@huawei.com, yi.zhang@huawei.com
List-Id: amd-gfx.lists.freedesktop.org

On Wed, 2019-11-13 at 20:44 +0800, yu kuai wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c: In function
> ‘gfx_v6_0_constants_init’:
> drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c:1579:6: warning: variable
> ‘mc_shared_chmap’ set but not used [-Wunused-but-set-variable]
[]
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
[]
> @@ -1678,7 +1678,6 @@ static void gfx_v6_0_constants_init(struct amdgpu_device *adev)
>  
>  	WREG32(mmBIF_FB_EN, BIF_FB_EN__FB_READ_EN_MASK | BIF_FB_EN__FB_WRITE_EN_MASK);
>  
> -	mc_shared_chmap = RREG32(mmMC_SHARED_CHMAP);

I do not know the hardware but frequently hardware like
this has read ordering requirements and various registers
can not be read in a random order.

Does removing this read have no effect on the hardware?

>  	adev->gfx.config.mc_arb_ramcfg = RREG32(mmMC_ARB_RAMCFG);
>  	mc_arb_ramcfg = adev->gfx.config.mc_arb_ramcfg;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
[]
> @@ -4336,7 +4336,6 @@ static void gfx_v7_0_gpu_early_init(struct amdgpu_device *adev)
>  		break;
>  	}
>  
> -	mc_shared_chmap = RREG32(mmMC_SHARED_CHMAP);
>  	adev->gfx.config.mc_arb_ramcfg = RREG32(mmMC_ARB_RAMCFG);
>  	mc_arb_ramcfg = adev->gfx.config.mc_arb_ramcfg;

Same question.
