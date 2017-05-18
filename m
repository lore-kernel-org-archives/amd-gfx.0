From: walter harms <wharms@bfs.de>
Subject: Re: [PATCH] drm/amd/powerplay: ensure loop does not wraparound on
 decrement
Date: Thu, 18 May 2017 09:15:51 +0200
Message-ID: <591D4A27.7020402@bfs.de>
References: <20170517181346.11715-1-colin.king@canonical.com>
Reply-To: wharms@bfs.de
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170517181346.11715-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?B?Q2hyaXN0aWFuIEvDtg==?= =?UTF-8?B?bmln?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, Rex Zhu <Rex.Zhu@amd.com>, Eric Huang <JinHuiEric.Huang@amd.com>, Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org



Am 17.05.2017 20:13, schrieb Colin King:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The current for loop decrements i when it is zero and this causes
> a wrap-around back to ~0 because i is unsigned. In the unlikely event
> that mask is 0, the loop will run forever. Fix this so we can't loop
> forever.
> 
> Detected by CoverityScan, CID#1435469 ("Unsigned compared against 0")
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> index ad30f5d3a10d..d92c9b9b15be 100644
> --- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> +++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_hwmgr.c
> @@ -4199,7 +4199,7 @@ static int vega10_force_clock_level(struct pp_hwmgr *hwmgr,
>  		}
>  		data->smc_state_table.gfx_boot_level = i;
>  
> -		for (i = 31; i >= 0; i--) {
> +		for (i = 32; --i; ) {
>  			if (mask & (1 << i))
>  				break;
>  		}

nitpicking:
we notices at several points that programmers are bad at counting backwards.
Is there a reason not to start with i=0 ?

re,
 wh
