From: =?UTF-8?Q?Christian_K=c3=b6nig?= <deathsimple@vodafone.de>
Subject: Re: [PATCH 1/2] drm/radeon: disable runtime pm in certain cases
Date: Mon, 31 Oct 2016 16:12:20 +0100
Message-ID: <08b26706-3b59-e9bb-dd12-68585024ad97@vodafone.de>
References: <1477926480-13391-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1477926480-13391-1-git-send-email-alexander.deucher@amd.com>
Sender: stable-owner@vger.kernel.org
To: Alex Deucher <alexdeucher@gmail.com>, amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Am 31.10.2016 um 16:07 schrieb Alex Deucher:
> If the platform does not support hybrid graphics or ATPX dGPU
> power control.
>
> bug: https://bugzilla.kernel.org/show_bug.cgi?id=51381
>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: stable@vger.kernel.org

Acked-by: Christian König <christian.koenig@amd.com> for both.

> ---
>   drivers/gpu/drm/radeon/radeon_device.c | 13 +++++++++++++
>   1 file changed, 13 insertions(+)
>
> diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
> index 79c9b6f..2be984d 100644
> --- a/drivers/gpu/drm/radeon/radeon_device.c
> +++ b/drivers/gpu/drm/radeon/radeon_device.c
> @@ -104,6 +104,14 @@ static const char radeon_family_name[][16] = {
>   	"LAST",
>   };
>   
> +#if defined(CONFIG_VGA_SWITCHEROO)
> +bool radeon_has_atpx_dgpu_power_cntl(void);
> +bool radeon_is_atpx_hybrid(void);
> +#else
> +static inline bool radeon_has_atpx_dgpu_power_cntl(void) { return false; }
> +static inline bool radeon_is_atpx_hybrid(void) { return false; }
> +#endif
> +
>   #define RADEON_PX_QUIRK_DISABLE_PX  (1 << 0)
>   #define RADEON_PX_QUIRK_LONG_WAKEUP (1 << 1)
>   
> @@ -160,6 +168,11 @@ static void radeon_device_handle_px_quirks(struct radeon_device *rdev)
>   
>   	if (rdev->px_quirk_flags & RADEON_PX_QUIRK_DISABLE_PX)
>   		rdev->flags &= ~RADEON_IS_PX;
> +
> +	/* disable PX is the system doesn't support dGPU power control or hybrid gfx */
> +	if (!radeon_is_atpx_hybrid() &&
> +	    !radeon_has_atpx_dgpu_power_cntl())
> +		rdev->flags &= ~RADEON_IS_PX;
>   }
>   
>   /**
