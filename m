Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 785F7FD9E2C
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Feb 2026 19:46:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C00A510EC22;
	Fri, 27 Feb 2026 19:46:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="fD52oyPM";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40D1110E1A0;
 Fri, 27 Feb 2026 19:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1KoQc9MvIGOyc6u5CzQpM9KN1npTTONtQXz0YohcajY=; b=fD52oyPMExuINgE1ewZ8stlE6T
 WFV5J4/c6OuNEV/GH83LPHpZnlTwD1dFkNsklxD2/m7GC6CVXZQIhkBAYOFQc43jX9vtyym5yovGu
 8sioyab6rqjsI/B78SJye3Zb7qp2uCafDU5Fc1ycs6JLrNi0/kXnTKGb1vMy+2qIzgdLDBDMUM/Od
 AlVTNe6j7tZeVI6k5f0Y0nqnKHpcooYGb/J0jD4BfuaqiIMg7GchTArjjj6E3f8zKgEKXw1NGlYGS
 jSwqh8Wq06kjfz3Rw5lZnnSqoEO+qCr8Bju3Mia6CUlq9K+WoT9If9XISAnodcxnP2Iam60U2WWn6
 unHCqyOQ==;
Received: from [186.208.68.119] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1vw3nI-006fKr-Jh; Fri, 27 Feb 2026 20:46:36 +0100
Message-ID: <18243ee4-7187-4441-89f5-826b30b3ec3b@igalia.com>
Date: Fri, 27 Feb 2026 16:46:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Enable DEGAMMA and reject
 COLOR_PIPELINE+DEGAMMA_LUT
To: Alex Hung <alex.hung@amd.com>, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, harry.wentland@amd.com, sunpeng.li@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, contact@emersion.fr, ivan.lipski@amd.com,
 kenneth.feng@amd.com, chiahsuan.chung@amd.com, mdaenzer@redhat.com,
 Jerry.Zuo@amd.com, timur.kristof@gmail.com, david.rosca@amd.com,
 daniels@collabora.com, Alvin.Lee2@amd.com, bold.zone2373@fastmail.com,
 dmitry.baryshkov@oss.qualcomm.com, ville.syrjala@linux.intel.com,
 Matthew.Stewart2@amd.com, chaitanya.kumar.borah@intel.com
References: <20260227193038.1377643-1-alex.hung@amd.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260227193038.1377643-1-alex.hung@amd.com>
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



On 27/02/2026 16:30, Alex Hung wrote:
> [WHAT]
> Create DEGAMMA properties even if color pipeline is enabled, and enforce
> the mutual exclusion in atomic check by rejecting any commit that
> attempts to enable both COLOR_PIPELINE on the plane and DEGAMMA_LUT on
> the CRTC simultaneously.
>
> Fixes: 18a4127e9315 ("drm/amd/display: Disable CRTC degamma when color pipeline is enabled")
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> ---
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c   | 16 ++++++++--------
>   .../drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c  |  8 ++++++++
>   2 files changed, 16 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 130190e8a1b2..304437c2284d 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -765,15 +765,15 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manager *dm,
>   	dm->adev->mode_info.crtcs[crtc_index] = acrtc;
>   
>   	/* Don't enable DRM CRTC degamma property for
> -	 * 1. Degamma is replaced by color pipeline.
> -	 * 2. DCE since it doesn't support programmable degamma anywhere.
> -	 * 3. DCN401 since pre-blending degamma LUT doesn't apply to cursor.
> +	 * 1. DCE since it doesn't support programmable degamma anywhere.
> +	 * 2. DCN401 since pre-blending degamma LUT doesn't apply to cursor.
> +	 * Note: DEGAMMA properties are created even if the primary plane has the
> +	 * COLOR_PIPELINE property. User space can use either the DEGAMMA properties
> +	 * or the COLOR_PIPELINE property. An atomic commit which attempts to enable
> +	 * both is rejected.
>   	 */
> -	if (plane->color_pipeline_property)
> -		has_degamma = false;
> -	else
> -		has_degamma = dm->adev->dm.dc->caps.color.dpp.dcn_arch &&
> -			      dm->adev->dm.dc->ctx->dce_version != DCN_VERSION_4_01;
> +	has_degamma = dm->adev->dm.dc->caps.color.dpp.dcn_arch &&
> +		      dm->adev->dm.dc->ctx->dce_version != DCN_VERSION_4_01;
>   
>   	drm_crtc_enable_color_mgmt(&acrtc->base, has_degamma ? MAX_COLOR_LUT_ENTRIES : 0,
>   				   true, MAX_COLOR_LUT_ENTRIES);
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> index 70587e5a8d46..127207e18dcb 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_plane.c
> @@ -1256,6 +1256,14 @@ static int amdgpu_dm_plane_atomic_check(struct drm_plane *plane,
>   	if (ret)
>   		return ret;
>   
> +	/* Reject commits that attempt to use both COLOR_PIPELINE and CRTC DEGAMMA_LUT */
> +	if (new_plane_state->color_pipeline && new_crtc_state->degamma_lut) {
> +		drm_dbg_atomic(plane->dev,
> +			       "[PLANE:%d:%s] COLOR_PIPELINE and CRTC DEGAMMA_LUT cannot be enabled simultaneously\n",
> +			       plane->base.id, plane->name);
> +		return -EINVAL;
> +	}
> +
LGTM.

Reviewed-by: Melissa Wen <mwen@igalia.com>
>   	ret = amdgpu_dm_plane_fill_dc_scaling_info(adev, new_plane_state, &scaling_info);
>   	if (ret)
>   		return ret;

