Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE814CD98E2
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 07:14:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFB1D10E953;
	Wed, 17 Jun 2026 07:14:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="iAaIKY+4";
	dkim-atps=neutral
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com
 [95.215.58.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5069510E916
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 04:36:25 +0000 (UTC)
Message-ID: <3ad7d4a1-093b-45ac-b3b2-5df5bbb0fde8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1781670983;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oF6TwsV0l6MAzb3NyVYxGJZWoCROeUrwy7UZiyUtELQ=;
 b=iAaIKY+4JTjsghBdT/vLmHC6toDlWjW7NxzeWcBIrELFt9ei3qBqZEQZhwZv3PDC+oeGVe
 /4BKHrVuUkwWnw1opRdI3ovvQXsCqp0YGCoCfyxMCqMtBAbQrLCWhNC1vuVE2d41eDVXRE
 qOjZOHLEx3IqRLh1RUwoutIcNCdX9uE=
Date: Tue, 16 Jun 2026 21:35:55 -0700
MIME-Version: 1.0
Subject: Re: [PATCH 1/3] drm/amd/display: consolidate DCN vblank/flip handling
 onto vupdate_no_lock
To: sunpeng.li@amd.com, amd-gfx@lists.freedesktop.org
Cc: Harry.Wentland@amd.com, mario.limonciello@amd.com, wiagn233@outlook.com,
 sysdadmin@m1k.cloud, timur.kristof@gmail.com, xaver.hugl@kde.org,
 mario.kleiner.de@gmail.com
References: <20260616201828.389985-1-sunpeng.li@amd.com>
 <20260616201828.389985-2-sunpeng.li@amd.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Matthew Schwartz <matthew.schwartz@linux.dev>
In-Reply-To: <20260616201828.389985-2-sunpeng.li@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Mailman-Approved-At: Wed, 17 Jun 2026 07:14:49 +0000
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

On 6/16/26 1:18 PM, sunpeng.li@amd.com wrote:

[...]

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index c9916ed0ddc14..8a6b732cf80c8 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -281,7 +281,14 @@ static inline int amdgpu_dm_crtc_set_vblank(struct drm_crtc *crtc, bool enable)
>  			drm_crtc_vblank_restore(crtc);
>  	}
>  
> -	if (dc_supports_vrr(dm->dc->ctx->dce_version)) {
> +	/*
> +	 * On DCN, VUPDATE_NO_LOCK is the single OTG interrupt used to deliver
> +	 * vblank and pageflip completion events, so enable it whenever vblank
> +	 * is enabled. On DCE, vupdate is only needed in VRR mode.
> +	 */
> +	if (amdgpu_ip_version(adev, DCE_HWIP, 0) != 0) {
> +		rc = amdgpu_dm_crtc_set_vupdate_irq(crtc, enable);
> +	} else if (dc_supports_vrr(dm->dc->ctx->dce_version)) {

Hi Leo (dropping Stable),

This arms VUPDATE_NO_LOCK on all of DCN, but amdgpu_dm_handle_vrr_transition() still disables it when switching from VRR active -> inactive. This causes a new flip_done timed out event when a compositor like gamescope disables VRR while it's already active.

I had to fix it up with something like:

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index e09c0eb9f865..ee337ca816cf 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10085,8 +10085,16 @@ static void amdgpu_dm_handle_vrr_transition(struct amdgpu_display_manager *dm,
 					    struct dm_crtc_state *old_state,
 					    struct dm_crtc_state *new_state)
 {
+	struct amdgpu_device *adev = dm->adev;
 	bool old_vrr_active = amdgpu_dm_crtc_vrr_active(old_state);
 	bool new_vrr_active = amdgpu_dm_crtc_vrr_active(new_state);
+	/*
+	 * On DCN, VUPDATE_NO_LOCK is the sole vblank and pageflip completion
+	 * source and amdgpu_dm_crtc_set_vblank() keeps it armed whenever
+	 * vblank is enabled, so it must not be toggled with the VRR state.
+	 * Only DCE gates vupdate on VRR.
+	 */
+	bool vrr_gates_vupdate = amdgpu_ip_version(adev, DCE_HWIP, 0) == 0;
 
 	if (!old_vrr_active && new_vrr_active) {
 		/* Transition VRR inactive -> active:
@@ -10097,7 +10105,8 @@ static void amdgpu_dm_handle_vrr_transition(struct amdgpu_display_manager *dm,
 		 * We also need vupdate irq for the actual core vblank handling
 		 * at end of vblank.
 		 */
-		WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, true) != 0);
+		if (vrr_gates_vupdate)
+			WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, true) != 0);
 		WARN_ON(drm_crtc_vblank_get(new_state->base.crtc) != 0);
 		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=%u VRR off->on: Get vblank ref\n",
 				 __func__, new_state->base.crtc->base.id);
@@ -10113,7 +10122,8 @@ static void amdgpu_dm_handle_vrr_transition(struct amdgpu_display_manager *dm,
 		/* Transition VRR active -> inactive:
 		 * Allow vblank irq disable again for fixed refresh rate.
 		 */
-		WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, false) != 0);
+		if (vrr_gates_vupdate)
+			WARN_ON(amdgpu_dm_crtc_set_vupdate_irq(new_state->base.crtc, false) != 0);
 		drm_crtc_vblank_put(new_state->base.crtc);
 		drm_dbg_driver(new_state->base.crtc->dev, "%s: crtc=%u VRR on->off: Drop vblank ref\n",
 				 __func__, new_state->base.crtc->base.id);

Feel free to fold some version of this into the next version if it makes sense, or pick it up with my s-o-b.

Thanks,
Matthew

