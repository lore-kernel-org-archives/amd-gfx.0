From: Yuehaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] drm/amd/display: Fix old-style declaration
Date: Tue, 12 Nov 2019 15:51:33 +0800
Message-ID: <3361b760-fe4f-87e8-b0a4-ebda390aa492@huawei.com>
References: <20191111122801.18584-1-yuehaibing@huawei.com>
 <01c630e6d4c58b3f6184603e158f53fb9aaeae7d.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <01c630e6d4c58b3f6184603e158f53fb9aaeae7d.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Joe Perches <joe@perches.com>, harry.wentland@amd.com, sunpeng.li@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Bhawanpreet.Lakha@amd.com, Jun.Lei@amd.com, David.Francis@amd.com, Dmytro.Laktyushkin@amd.com, nicholas.kazlauskas@amd.com, martin.leung@amd.com, Chris.Park@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On 2019/11/12 10:39, Joe Perches wrote:
> On Mon, 2019-11-11 at 20:28 +0800, YueHaibing wrote:
>> Fix a build warning:
>>
>> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:75:1:
>>  warning: 'static' is not at beginning of declaration [-Wold-style-declaration]
> []
>> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> []
>> @@ -69,7 +69,7 @@
>>  #define DC_LOGGER \
>>  	dc->ctx->logger
>>  
>> -const static char DC_BUILD_ID[] = "production-build";
>> +static const char DC_BUILD_ID[] = "production-build";
> 
> DC_BUILD_ID is used exactly once.
> Maybe just use it directly and remove DC_BUILD_ID instead?

commit be61df574256ae8c0dbd45ac148ca7260a0483c0
Author: Jun Lei <Jun.Lei@amd.com>
Date:   Thu Sep 13 09:32:26 2018 -0400

    drm/amd/display: Add DC build_id to determine build type

    [why]
    Sometimes there are indications that the incorrect driver is being
    loaded in automated tests. This change adds the ability for builds to
    be tagged with a string, and picked up by the test infrastructure.

    [how]
    dc.c will allocate const for build id, which is init-ed with default
    value, indicating production build. For test builds, build server will
    find/replace this value. The test machine will then verify this value.

It seems DC_BUILD_ID is used by the build server, so maybe we should keep it.

> 
> ---
>  drivers/gpu/drm/amd/display/dc/core/dc.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 1fdba13..803dc14 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -69,8 +69,6 @@
>  #define DC_LOGGER \
>  	dc->ctx->logger
>  
> -const static char DC_BUILD_ID[] = "production-build";
> -
>  /**
>   * DOC: Overview
>   *
> @@ -815,7 +813,7 @@ struct dc *dc_create(const struct dc_init_data *init_params)
>  	if (dc->res_pool->dmcu != NULL)
>  		dc->versions.dmcu_version = dc->res_pool->dmcu->dmcu_version;
>  
> -	dc->build_id = DC_BUILD_ID;
> +	dc->build_id = "production-build";
>  
>  	DC_LOG_DC("Display Core initialized\n");
>  
> 
> 
> 
> .
> 
