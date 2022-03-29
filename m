Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E856FC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 29 Mar 2022 05:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 12C5A10EFD3;
	Tue, 29 Mar 2022 05:54:24 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAD4610EFD9
 for <amd-gfx@lists.freedesktop.org>; Tue, 29 Mar 2022 05:54:22 +0000 (UTC)
Received: from [192.168.0.4] (ip5f5aef5a.dynamic.kabel-deutschland.de
 [95.90.239.90])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8BA6561EA192A;
 Tue, 29 Mar 2022 07:54:20 +0200 (CEST)
Message-ID: <f7a71ce2-d4a3-5529-7883-c9f4a3cd46a8@molgen.mpg.de>
Date: Tue, 29 Mar 2022 07:54:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] amd/display: set backlight only if required
Content-Language: en-US
To: Shirish S <shirish.s@amd.com>
References: <20220311153320.101332-1-shirish.s@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20220311153320.101332-1-shirish.s@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: Bhawanpreet.Lakha@amd.com, Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Shirish,


Thank you for the patch.


Am 11.03.22 um 16:33 schrieb Shirish S:
> [Why]
> comparing pwm bl values (coverted) with user brightness(converted)

1.  co*n*verted
2.  Please add a space before the (.

> levels in commit_tail leads to continuous setting of backlight via dmub
> as they don't to match.

Maybe add a blank line between paragraphs.

> This leads overdrive in queuing of commands to DMCU that sometimes lead

What is “overdrive in queuing”?

lead*s*

> to depending on load on DMCU fw:

Leads to what? Words missing after *to*.

> "[drm:dc_dmub_srv_wait_idle] *ERROR* Error waiting for DMUB idle: status=3"

You could also add the example from your discussion with Harry.

> [How]
> Store last successfully set backlight value and compare with it instead
> of pwm reads which is not what we should compare with.

Maybe extend it with the information gotten from Harry, that this is 
expected, when ABM is enabled.


Kind regards,

Paul


> Signed-off-by: Shirish S <shirish.s@amd.com>
> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 ++++---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h | 6 ++++++
>   2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index df0980ff9a63..2b8337e47861 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3972,7 +3972,7 @@ static u32 convert_brightness_to_user(const struct amdgpu_dm_backlight_caps *cap
>   				 max - min);
>   }
>   
> -static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
> +static void amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>   					 int bl_idx,
>   					 u32 user_brightness)
>   {
> @@ -4003,7 +4003,8 @@ static int amdgpu_dm_backlight_set_level(struct amdgpu_display_manager *dm,
>   			DRM_DEBUG("DM: Failed to update backlight on eDP[%d]\n", bl_idx);
>   	}
>   
> -	return rc ? 0 : 1;
> +	if (rc)
> +		dm->actual_brightness[bl_idx] = user_brightness;
>   }
>   
>   static int amdgpu_dm_backlight_update_status(struct backlight_device *bd)
> @@ -9944,7 +9945,7 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
>   	/* restore the backlight level */
>   	for (i = 0; i < dm->num_of_edps; i++) {
>   		if (dm->backlight_dev[i] &&
> -		    (amdgpu_dm_backlight_get_level(dm, i) != dm->brightness[i]))
> +		    (dm->actual_brightness[i] != dm->brightness[i]))
>   			amdgpu_dm_backlight_set_level(dm, i, dm->brightness[i]);
>   	}
>   #endif
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> index 372f9adf091a..321279bc877b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
> @@ -540,6 +540,12 @@ struct amdgpu_display_manager {
>   	 * cached backlight values.
>   	 */
>   	u32 brightness[AMDGPU_DM_MAX_NUM_EDP];
> +	/**
> +	 * @actual_brightness:
> +	 *
> +	 * last successfully applied backlight values.
> +	 */
> +	u32 actual_brightness[AMDGPU_DM_MAX_NUM_EDP];
>   };
>   
>   enum dsc_clock_force_state {
