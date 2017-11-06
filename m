From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] drm/amd/display: checking for NULL instead of IS_ERR()
Date: Mon, 6 Nov 2017 12:51:35 +0100
Message-ID: <823814f1-4133-bffa-fe34-c676a2466d1d@amd.com>
References: <20171106114340.w6li3f4iltg24bdp@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <kernel-janitors-owner@vger.kernel.org>
In-Reply-To: <20171106114340.w6li3f4iltg24bdp@mwanda>
Content-Language: en-US
Sender: kernel-janitors-owner@vger.kernel.org
To: Dan Carpenter <dan.carpenter@oracle.com>, Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@linux.ie>, Harry Wentland <harry.wentland@amd.com>, Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, Tom St Denis <tom.stdenis@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Am 06.11.2017 um 12:43 schrieb Dan Carpenter:
> backlight_device_register() never returns NULL, it returns error
> pointers on error so the check here is wrong.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

Acked-by: Christian König <christian.koenig@amd.com>

>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 33a15a1d818c..75f9383f5b9b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -1296,7 +1296,7 @@ amdgpu_dm_register_backlight_device(struct amdgpu_display_manager *dm)
>   			&amdgpu_dm_backlight_ops,
>   			&props);
>   
> -	if (NULL == dm->backlight_dev)
> +	if (IS_ERR(dm->backlight_dev))
>   		DRM_ERROR("DM: Backlight registration failed!\n");
>   	else
>   		DRM_DEBUG_DRIVER("DM: Registered Backlight device: %s\n", bl_name);


