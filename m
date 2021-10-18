Return-Path: <SRS0=XteM=PG=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85073C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 23:03:25 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CB7E61027
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Oct 2021 23:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9CB7E61027
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38E3A6EA96;
	Mon, 18 Oct 2021 23:03:24 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD4CE6EA96
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Oct 2021 23:03:22 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5ae8cf.dynamic.kabel-deutschland.de
 [95.90.232.207])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2990E61E5FE33;
 Tue, 19 Oct 2021 01:03:21 +0200 (CEST)
Subject: Re: [PATCH] amd/display: remove ChromeOS workaround
To: Simon Ser <contact@emersion.fr>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <hwentlan@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Sean Paul <seanpaul@chromium.org>, amd-gfx@lists.freedesktop.org
References: <20211014153433.169454-1-contact@emersion.fr>
From: Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <7105dc75-eaba-d3b6-3d81-c92528961e0a@molgen.mpg.de>
Date: Tue, 19 Oct 2021 01:03:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211014153433.169454-1-contact@emersion.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Simon,


Am 14.10.21 um 17:35 schrieb Simon Ser:
> This reverts commits ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication
> when using overlay") and e7d9560aeae5 ("Revert "drm/amd/display: Fix overlay
> validation by considering cursors"").
> 
> tl;dr ChromeOS uses the atomic interface for everything except the cursor. This
> is incorrect and forces amdgpu to disable some hardware features. Let's revert
> the ChromeOS-specific workaround in mainline and allow the Chrome team to keep
> it internally in their own tree.
> 
> See [1] for more details. This patch is an alternative to [2], which added
> ChromeOS detection.

Excuse my ignorance. Reading the commit message, there was a Linux 
kernel change, that broke Chrome OS userspace, right? If so, and we do 
not know if there is other userspace using the API incorrectly, 
shouldn’t the patch breaking Chrome OS userspace be reverted to adhere 
to Linux’ no-regression rule?


Kind regards,

Paul


> [1]: https://lore.kernel.org/amd-gfx/JIQ_93_cHcshiIDsrMU1huBzx9P9LVQxucx8hQArpQu7Wk5DrCl_vTXj_Q20m_L-8C8A5dSpNcSJ8ehfcCrsQpfB5QG_Spn14EYkH9chtg0=@emersion.fr/
> [2]: https://lore.kernel.org/amd-gfx/20211011151609.452132-1-contact@emersion.fr/
> 
> Signed-off-by: Simon Ser <contact@emersion.fr>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Harry Wentland <hwentlan@amd.com>
> Cc: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Cc: Bas Nieuwenhuizen <bas@basnieuwenhuizen.nl>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Sean Paul <seanpaul@chromium.org>
> Fixes: ddab8bd788f5 ("drm/amd/display: Fix two cursor duplication when using overlay")
> Fixes: e7d9560aeae5 ("Revert "drm/amd/display: Fix overlay validation by considering cursors"")
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 51 -------------------
>   1 file changed, 51 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 20065a145851..014c5a9fe461 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10628,53 +10628,6 @@ static int add_affected_mst_dsc_crtcs(struct drm_atomic_state *state, struct drm
>   }
>   #endif
>   
> -static int validate_overlay(struct drm_atomic_state *state)
> -{
> -	int i;
> -	struct drm_plane *plane;
> -	struct drm_plane_state *new_plane_state;
> -	struct drm_plane_state *primary_state, *overlay_state = NULL;
> -
> -	/* Check if primary plane is contained inside overlay */
> -	for_each_new_plane_in_state_reverse(state, plane, new_plane_state, i) {
> -		if (plane->type == DRM_PLANE_TYPE_OVERLAY) {
> -			if (drm_atomic_plane_disabling(plane->state, new_plane_state))
> -				return 0;
> -
> -			overlay_state = new_plane_state;
> -			continue;
> -		}
> -	}
> -
> -	/* check if we're making changes to the overlay plane */
> -	if (!overlay_state)
> -		return 0;
> -
> -	/* check if overlay plane is enabled */
> -	if (!overlay_state->crtc)
> -		return 0;
> -
> -	/* find the primary plane for the CRTC that the overlay is enabled on */
> -	primary_state = drm_atomic_get_plane_state(state, overlay_state->crtc->primary);
> -	if (IS_ERR(primary_state))
> -		return PTR_ERR(primary_state);
> -
> -	/* check if primary plane is enabled */
> -	if (!primary_state->crtc)
> -		return 0;
> -
> -	/* Perform the bounds check to ensure the overlay plane covers the primary */
> -	if (primary_state->crtc_x < overlay_state->crtc_x ||
> -	    primary_state->crtc_y < overlay_state->crtc_y ||
> -	    primary_state->crtc_x + primary_state->crtc_w > overlay_state->crtc_x + overlay_state->crtc_w ||
> -	    primary_state->crtc_y + primary_state->crtc_h > overlay_state->crtc_y + overlay_state->crtc_h) {
> -		DRM_DEBUG_ATOMIC("Overlay plane is enabled with hardware cursor but does not fully cover primary plane\n");
> -		return -EINVAL;
> -	}
> -
> -	return 0;
> -}
> -
>   /**
>    * amdgpu_dm_atomic_check() - Atomic check implementation for AMDgpu DM.
>    * @dev: The DRM device
> @@ -10856,10 +10809,6 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   			goto fail;
>   	}
>   
> -	ret = validate_overlay(state);
> -	if (ret)
> -		goto fail;
> -
>   	/* Add new/modified planes */
>   	for_each_oldnew_plane_in_state_reverse(state, plane, old_plane_state, new_plane_state, i) {
>   		ret = dm_update_plane_state(dc, state, plane,
> 
