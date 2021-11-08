Return-Path: <SRS0=eROb=P3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0A5C433EF
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 08:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E41661029
	for <amd-gfx@archiver.kernel.org>; Mon,  8 Nov 2021 08:57:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6E41661029
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B5316E935;
	Mon,  8 Nov 2021 08:57:54 +0000 (UTC)
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 112556E91A
 for <amd-gfx@lists.freedesktop.org>; Mon,  8 Nov 2021 08:57:53 +0000 (UTC)
Received: from [192.168.0.2] (ip5f5aef86.dynamic.kabel-deutschland.de
 [95.90.239.134])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested) (Authenticated sender: pmenzel)
 by mx.molgen.mpg.de (Postfix) with ESMTPSA id 82B7361E5FE00;
 Mon,  8 Nov 2021 09:57:51 +0100 (CET)
Message-ID: <d85871bd-72af-d02d-5c23-f3c13ccbfd52@molgen.mpg.de>
Date: Mon, 8 Nov 2021 09:57:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] drm/amd/display: log amdgpu_dm_atomic_check() failure
 cause
Content-Language: en-US
To: Shirish S <shirish.s@amd.com>
References: <20211108084054.11162-1-shirish.s@amd.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20211108084054.11162-1-shirish.s@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Dear Shrish,


Am 08.11.21 um 09:40 schrieb Shirish S:
> update user with next level of info about which condition led to
> atomic check failure.
> 
> Signed-off-by: Shirish S <shirish.s@amd.com>
> ---
>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 70 ++++++++++++++-----
>   1 file changed, 52 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 1e26d9be8993..37ea8a76fa09 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -10746,8 +10746,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   	trace_amdgpu_dm_atomic_check_begin(state);
>   
>   	ret = drm_atomic_helper_check_modeset(dev, state);
> -	if (ret)
> +	if (ret) {
> +		DRM_DEV_ERROR(adev->dev, "drm_atomic_helper_check_modeset() failed\n");

Does the Linux kernel provide means (for example ftrace) to trace such 
things, so the (generic) debug lines don’t have to be added? Or is it to 
better debug user bug reports?


Kind regards,

Paul


>   		goto fail;
> +	}
>   
>   	/* Check connector changes */
>   	for_each_oldnew_connector_in_state(state, connector, old_con_state, new_con_state, i) {
> @@ -10763,6 +10765,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   
>   		new_crtc_state = drm_atomic_get_crtc_state(state, new_con_state->crtc);
>   		if (IS_ERR(new_crtc_state)) {
> +			DRM_DEV_ERROR(adev->dev, "drm_atomic_get_crtc_state() failed\n");
>   			ret = PTR_ERR(new_crtc_state);
>   			goto fail;
>   		}
> @@ -10777,8 +10780,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   		for_each_oldnew_crtc_in_state(state, crtc, old_crtc_state, new_crtc_state, i) {
>   			if (drm_atomic_crtc_needs_modeset(new_crtc_state)) {
>   				ret = add_affected_mst_dsc_crtcs(state, crtc);
> -				if (ret)
> +				if (ret) {
> +					DRM_DEV_ERROR(adev->dev, "add_affected_mst_dsc_crtcs() failed\n");
>   					goto fail;
> +				}
>   			}
>   		}
>   	}
> @@ -10793,19 +10798,25 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   			continue;
>   
>   		ret = amdgpu_dm_verify_lut_sizes(new_crtc_state);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEV_ERROR(adev->dev, "amdgpu_dm_verify_lut_sizes() failed\n");
>   			goto fail;
> +		}
>   
>   		if (!new_crtc_state->enable)
>   			continue;
>   
>   		ret = drm_atomic_add_affected_connectors(state, crtc);
> -		if (ret)
> -			return ret;
> +		if (ret) {
> +			DRM_DEV_ERROR(adev->dev, "drm_atomic_add_affected_connectors() failed\n");
> +			goto fail;
> +		}
>   
>   		ret = drm_atomic_add_affected_planes(state, crtc);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEV_ERROR(adev->dev, "drm_atomic_add_affected_planes() failed\n");
>   			goto fail;
> +		}
>   
>   		if (dm_old_crtc_state->dsc_force_changed)
>   			new_crtc_state->mode_changed = true;
> @@ -10842,6 +10853,7 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   
>   			if (IS_ERR(new_plane_state)) {
>   				ret = PTR_ERR(new_plane_state);
> +				DRM_DEV_ERROR(adev->dev, "new_plane_state is BAD\n");
>   				goto fail;
>   			}
>   		}
> @@ -10854,8 +10866,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   					    new_plane_state,
>   					    false,
>   					    &lock_and_validation_needed);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEV_ERROR(adev->dev, "dm_update_plane_state() failed\n");
>   			goto fail;
> +		}
>   	}
>   
>   	/* Disable all crtcs which require disable */
> @@ -10865,8 +10879,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   					   new_crtc_state,
>   					   false,
>   					   &lock_and_validation_needed);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEV_ERROR(adev->dev, "DISABLE: dm_update_crtc_state() failed\n");
>   			goto fail;
> +		}
>   	}
>   
>   	/* Enable all crtcs which require enable */
> @@ -10876,8 +10892,10 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   					   new_crtc_state,
>   					   true,
>   					   &lock_and_validation_needed);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEV_ERROR(adev->dev, "ENABLE: dm_update_crtc_state() failed\n");
>   			goto fail;
> +		}
>   	}
>   
>   	/* Add new/modified planes */
> @@ -10887,20 +10905,26 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   					    new_plane_state,
>   					    true,
>   					    &lock_and_validation_needed);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEV_ERROR(adev->dev, "dm_update_plane_state() failed\n");
>   			goto fail;
> +		}
>   	}
>   
>   	/* Run this here since we want to validate the streams we created */
>   	ret = drm_atomic_helper_check_planes(dev, state);
> -	if (ret)
> +	if (ret) {
> +		DRM_DEV_ERROR(adev->dev, "drm_atomic_helper_check_planes() failed\n");
>   		goto fail;
> +	}
>   
>   	/* Check cursor planes scaling */
>   	for_each_new_crtc_in_state(state, crtc, new_crtc_state, i) {
>   		ret = dm_check_crtc_cursor(state, crtc, new_crtc_state);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEV_ERROR(adev->dev, "dm_check_crtc_cursor() failed\n");
>   			goto fail;
> +		}
>   	}
>   
>   	if (state->legacy_cursor_update) {
> @@ -10987,20 +11011,28 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   	 */
>   	if (lock_and_validation_needed) {
>   		ret = dm_atomic_get_state(state, &dm_state);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEV_ERROR(adev->dev, "dm_atomic_get_state() failed\n");
>   			goto fail;
> +		}
>   
>   		ret = do_aquire_global_lock(dev, state);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEV_ERROR(adev->dev, "do_aquire_global_lock() failed\n");
>   			goto fail;
> +		}
>   
>   #if defined(CONFIG_DRM_AMD_DC_DCN)
> -		if (!compute_mst_dsc_configs_for_state(state, dm_state->context, vars))
> +		if (!compute_mst_dsc_configs_for_state(state, dm_state->context, vars)) {
> +			DRM_DEV_ERROR(adev->dev, "compute_mst_dsc_configs_for_state() failed\n");
>   			goto fail;
> +		}
>   
>   		ret = dm_update_mst_vcpi_slots_for_dsc(state, dm_state->context, vars);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEV_ERROR(adev->dev, "dm_update_mst_vcpi_slots_for_dsc() failed\n");
>   			goto fail;
> +		}
>   #endif
>   
>   		/*
> @@ -11010,11 +11042,13 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>   		 * to get stuck in an infinite loop and hang eventually.
>   		 */
>   		ret = drm_dp_mst_atomic_check(state);
> -		if (ret)
> +		if (ret) {
> +			DRM_DEV_ERROR(adev->dev, "drm_dp_mst_atomic_check() failed\n");
>   			goto fail;
> +		}
>   		status = dc_validate_global_state(dc, dm_state->context, false);
>   		if (status != DC_OK) {
> -			drm_dbg_atomic(dev,
> +			DRM_DEV_ERROR(adev->dev,
>   				       "DC global validation failure: %s (%d)",
>   				       dc_status_to_str(status), status);
>   			ret = -EINVAL;
> 
