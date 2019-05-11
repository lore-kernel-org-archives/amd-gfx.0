From: Nathan Chancellor <natechancellor@gmail.com>
Subject: Re: [PATCH][next] drm/amdgpu: fix return of an uninitialized value
 in variable ret
Date: Fri, 10 May 2019 18:37:00 -0700
Message-ID: <20190511013700.GA3530@archlinux-i9>
References: <20190510100842.30458-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190510100842.30458-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Fri, May 10, 2019 at 11:08:42AM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where is_enable is false and lo_base_addr is non-zero the
> variable ret has not been initialized and is being checked for non-zero
> and potentially garbage is being returned. Fix this by not returning
> ret but instead returning -EINVAL on the zero lo_base_addr case.
> 
> Addresses-Coverity: ("Uninitialized scalar variable")
> Fixes: a6ac0b44bab9 ("drm/amdgpu: add df perfmon regs and funcs for xgmi")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

This fixes a clang warning complaining about the same thing.

> ---
>  drivers/gpu/drm/amd/amdgpu/df_v3_6.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> index a5c3558869fb..8c09bf994acd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> +++ b/drivers/gpu/drm/amd/amdgpu/df_v3_6.c
> @@ -398,10 +398,7 @@ static int df_v3_6_start_xgmi_link_cntr(struct amdgpu_device *adev,
>  				NULL);
>  
>  		if (lo_base_addr == 0)
> -			ret = -EINVAL;
> -
> -		if (ret)
> -			return ret;
> +			return -EINVAL;
>  
>  		lo_val = RREG32_PCIE(lo_base_addr);
>  
> -- 
> 2.20.1
> 
