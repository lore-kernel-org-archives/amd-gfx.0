Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B129F8DFF9
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Apr 2026 18:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0AAE10E2CF;
	Fri, 17 Apr 2026 18:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Bdv8//eM";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C762F10E2CF
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Apr 2026 18:10:53 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A208402E5;
 Fri, 17 Apr 2026 18:10:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41B82C19425;
 Fri, 17 Apr 2026 18:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776449453;
 bh=tuxiTGBuN+7rcgtfs/VhkNHSLxeOZIQ8KHTwryYGenM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Bdv8//eM4ZAxdDir2sIYKDgp/+9gDR/URXl3LXhioeys/it8erTwNtsrD7kpxgtHK
 6AMd+CWdvxgTZzA0Zuaq5etZbBBANgUAAswOkUfTIOQm4YObIHkmkOwwI9uz4PB0G4
 Z9vpGi4Y41PQjAF6MN2aUX+ZprPap4lbc0ZHJzXQTuFVnx0IVLAmy7shBdxrfWPh7T
 KXXGBXd3lh/MJI0Y5l0QEjbdGmypgTSQsIgz2W113zGVRclNPC4jio2h9G5sZBixST
 kQOuT6zuEya+hWrOCT9A35nhoJyvkywjARqa9ydKzKVa3bFCRCOjaHdbv0lpugrfGy
 Dztf/1+pGOmUA==
Message-ID: <7a32da73-2ac8-4edf-bcfc-4c10d30bf162@kernel.org>
Date: Fri, 17 Apr 2026 13:10:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Undo accidental fix revert in
 amdgpu_dm_ism.c
Content-Language: en-US
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, Ray.Wu@amd.com
References: <20260417175430.47434-1-sunpeng.li@amd.com>
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20260417175430.47434-1-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 4/17/26 12:54, sunpeng.li@amd.com wrote:
> From: Leo Li <sunpeng.li@amd.com>
> 
> [Why]
> 
> Pausing DPM power profiles during static screen caused a bunch of
> audio/performance/clock issues that were addressed in this fix:
> 1412482b7143 ("Revert "drm/amd/display: pause the workload setting in dm"")
> 
> This logic in function amdgpu_dm_crtc_vblank_control_worker() was moved
> to amdgpu_dm_ism.c, but the fix was lost in the process.
> 
> [How]
> 
> Reapply the fix to amdgpu_dm_ism.c
> 
> Fixes: 0b572a6bf04a ("drm/amd/display: Add Idle state manager(ISM)")
> Signed-off-by: Leo Li <sunpeng.li@amd.com>

Oh joy.  Well glad it's caught early in the kernel cycle.  Pretty much 
identical revert to 1412482b714358ffa30d38fd3dd0b05795163648.

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c | 10 ----------
>   1 file changed, 10 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> index d2f47c69921d4..d03ea3bafd469 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_ism.c
> @@ -270,7 +270,6 @@ static void dm_ism_commit_idle_optimization_state(struct amdgpu_dm_ism *ism,
>   	struct amdgpu_crtc *acrtc = ism_to_amdgpu_crtc(ism);
>   	struct amdgpu_device *adev = drm_to_adev(acrtc->base.dev);
>   	struct amdgpu_display_manager *dm = &adev->dm;
> -	int r;
>   
>   	trace_amdgpu_dm_ism_commit(dm->active_vblank_irq_count,
>   				   vblank_enabled,
> @@ -315,16 +314,7 @@ static void dm_ism_commit_idle_optimization_state(struct amdgpu_dm_ism *ism,
>   	 */
>   	if (!vblank_enabled && dm->active_vblank_irq_count == 0) {
>   		dc_post_update_surfaces_to_stream(dm->dc);
> -
> -		r = amdgpu_dpm_pause_power_profile(adev, true);
> -		if (r)
> -			dev_warn(adev->dev, "failed to set default power profile mode\n");
> -
>   		dc_allow_idle_optimizations(dm->dc, true);
> -
> -		r = amdgpu_dpm_pause_power_profile(adev, false);
> -		if (r)
> -			dev_warn(adev->dev, "failed to restore the power profile mode\n");
>   	}
>   }
>   

