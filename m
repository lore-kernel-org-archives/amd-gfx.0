From: Huang Rui <ray.huang@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Add an ATPX quirk for hybrid laptop
Date: Fri, 23 Mar 2018 09:35:46 +0800
Message-ID: <20180323013545.GA12224@hr-amur2>
References: <20180322143718.26686-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <stable-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180322143718.26686-1-alexander.deucher@amd.com>
Sender: stable-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On Thu, Mar 22, 2018 at 09:37:18AM -0500, Alex Deucher wrote:
> _PR3 doesn't seem to work properly, use ATPX instead.
> 
> Bug: https://bugs.freedesktop.org/show_bug.cgi?id=104064
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org

Reviewed-by: Huang Rui <ray.huang@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> index c53095b3b0fb..1ae5ae8c45a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
> @@ -569,6 +569,7 @@ static const struct amdgpu_px_quirk amdgpu_px_quirk_list[] = {
>  	{ 0x1002, 0x6900, 0x1002, 0x0124, AMDGPU_PX_QUIRK_FORCE_ATPX },
>  	{ 0x1002, 0x6900, 0x1028, 0x0812, AMDGPU_PX_QUIRK_FORCE_ATPX },
>  	{ 0x1002, 0x6900, 0x1028, 0x0813, AMDGPU_PX_QUIRK_FORCE_ATPX },
> +	{ 0x1002, 0x67DF, 0x1028, 0x0774, AMDGPU_PX_QUIRK_FORCE_ATPX },
>  	{ 0, 0, 0, 0, 0 },
>  };
>  
> -- 
> 2.13.6
> 
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
