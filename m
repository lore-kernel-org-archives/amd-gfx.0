From: Harry Wentland <hwentlan@amd.com>
Subject: Re: [PATCH -next] drm/amd/display: Fix old-style declaration
Date: Tue, 12 Nov 2019 15:18:45 -0500
Message-ID: <6172e74c-6e85-f904-4284-2ebf9a308d4d@amd.com>
References: <20191111122801.18584-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191111122801.18584-1-yuehaibing@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: YueHaibing <yuehaibing@huawei.com>, harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Bhawanpreet.Lakha@amd.com, Jun.Lei@amd.com, David.Francis@amd.com, Dmytro.Laktyushkin@amd.com, nicholas.kazlauskas@amd.com, martin.leung@amd.com, Chris.Park@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On 2019-11-11 7:28 a.m., YueHaibing wrote:
> Fix a build warning:
> 
> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:75:1:
>  warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 1fdba13..0d8c663 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -69,7 +69,7 @@
>  #define DC_LOGGER \
>  	dc->ctx->logger
>  
> -const static char DC_BUILD_ID[] = "production-build";
> +static const char DC_BUILD_ID[] = "production-build";
>  
>  /**
>   * DOC: Overview
> 
