From: Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH] drm/amd/display: add missing void parameter to
 dc_create_transfer_func
Date: Tue, 31 Jul 2018 10:03:31 -0400
Message-ID: <39ae8791-f3fb-ecc8-7409-3bb6b134e4a4@amd.com>
References: <20180731104254.14683-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180731104254.14683-1-colin.king@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

On 2018-07-31 06:42 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Add a missing void parameter to function dc_create_transfer_func, fixes
> sparse warning:
> 
> warning: non-ANSI function declaration of function 'dc_create_transfer_func'
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_surface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> index 815dfb50089b..8fb3aefd195c 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
> @@ -192,7 +192,7 @@ void dc_transfer_func_release(struct dc_transfer_func *tf)
>  	kref_put(&tf->refcount, dc_transfer_func_free);
>  }
>  
> -struct dc_transfer_func *dc_create_transfer_func()
> +struct dc_transfer_func *dc_create_transfer_func(void)
>  {
>  	struct dc_transfer_func *tf = kvzalloc(sizeof(*tf), GFP_KERNEL);
>  
> 
