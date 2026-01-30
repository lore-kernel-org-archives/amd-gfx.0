Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 457D8D73E85
	for <amd-gfx@archiver.kernel.org>; Fri, 30 Jan 2026 00:45:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C13C210E0B1;
	Fri, 30 Jan 2026 00:45:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="jYmrJt8k";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D89E10E0B1
 for <amd-gfx@lists.freedesktop.org>; Fri, 30 Jan 2026 00:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qlzmAonpTsgHIZXE8JbT3+eT3yWwISCLmNRksIUVi3Y=; b=jYmrJt8k6jRH+6+pTibMX0aXeN
 eC5K8hZHadjZ815WpYd/HCHPmNQQnugkkwx7hKmTHreicrRSS7lulXaiNSCDUSVSlYlSFg3Iks/a6
 RSECM44b53K71fFAqrJ8D5NY1Rs8HAPKvquo0+Nu8qewlU5XpgjInxxKQvMwwa/F2utX1G8pOdiPN
 uyKjnxsuy0/nvORLzP/mTsTvNFu4oBt2LHRIMmfsqr6Vf/nMNqBecpDti21nHl6xmcU4UXY0uk6Ui
 9YNQOHBUy1wji1GzY5OBm5itejMrRemRPV7vjdT7pMcbnicsZ+bN/ke/5uc98ACxCtOQBr1enuGZ7
 AovRy24g==;
Received: from d198-53-218-11.abhsia.telus.net ([198.53.218.11] helo=atmagalia)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vlcdU-00BXzQ-7I; Fri, 30 Jan 2026 01:45:20 +0100
Date: Thu, 29 Jan 2026 17:45:14 -0700
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Alex Hung <alex.hung@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com, 
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com, 
 Leo Li <sunpeng.li@amd.com>
Subject: Re: [PATCH] drm/amd/display: Reject cursor plane on DCE when scaled
 differently than primary
Message-ID: <aXv-e37PeACx549L@atmagalia>
References: <20260118145741.36198-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260118145741.36198-1-timur.kristof@gmail.com>
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

On 01/18, Timur Kristóf wrote:
> Currently DCE doesn't support the overlay cursor, so the
> dm_crtc_get_cursor_mode() function returns DM_CURSOR_NATIVE_MODE
> unconditionally. The outcome is that it doesn't check for the
> conditions that would necessitate the overlay cursor, meaning
> that it doesn't reject cases where the native cursor mode isn't
> supported on DCE.
> 
> Remove the early return from dm_crtc_get_cursor_mode() for
> DCE and instead let it perform the necessary checks and
> return DM_CURSOR_OVERLAY_MODE. Add a later check that rejects
> when DM_CURSOR_OVERLAY_MODE would be used with DCE.
> 
> Fixes: 1b04dcca4fb1 ("drm/amd/display: Introduce overlay cursor mode")
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4600
> Suggested-by: Leo Li <sunpeng.li@amd.com>
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 655c9fcb078a..3e1ba5521f2b 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -12262,10 +12262,9 @@ static int dm_crtc_get_cursor_mode(struct amdgpu_device *adev,
>  
>  	/* Overlay cursor not supported on HW before DCN
>  	 * DCN401 does not have the cursor-on-scaled-plane or cursor-on-yuv-plane restrictions
> -	 * as previous DCN generations, so enable native mode on DCN401 in addition to DCE
> +	 * as previous DCN generations, so enable native mode on DCN401
>  	 */
> -	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == 0 ||
> -	    amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1)) {
> +	if (amdgpu_ip_version(adev, DCE_HWIP, 0) == IP_VERSION(4, 0, 1)) {
>  		*cursor_mode = DM_CURSOR_NATIVE_MODE;
>  		return 0;
>  	}
> @@ -12585,6 +12584,12 @@ static int amdgpu_dm_atomic_check(struct drm_device *dev,
>  		 * need to be added for DC to not disable a plane by mistake
>  		 */
>  		if (dm_new_crtc_state->cursor_mode == DM_CURSOR_OVERLAY_MODE) {
> +			if (amdgpu_ip_version(adev, DCE_HWIP, 0) == 0) {
> +				drm_dbg(dev, "Overlay cursor not supported on DCE\n");
> +				ret = -EINVAL;
> +				goto fail;
> +			}
> +
>  			ret = drm_atomic_add_affected_planes(state, crtc);
>  			if (ret)
>  				goto fail;
> -- 
> 2.52.0
>

Hi,

This change lgtm.

Alex, Dan,
Could you include this patch in the next week promotion? 

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>

Thanks

-- 
Rodrigo Siqueira
