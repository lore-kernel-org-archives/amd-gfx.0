Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F2FCECAAD3
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 13:31:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13D9210E913;
	Wed, 14 Sep 2022 13:31:13 +0000 (UTC)
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7541610E913
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 13:31:08 +0000 (UTC)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4MSLnh4lRHz9sWq;
 Wed, 14 Sep 2022 15:31:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1663162264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UKUfy2w5mxG+ZB8Pw3fQrcRLpQ1rKs6xhEsMS2DHWj4=;
 b=lDDEs4Y7mVsgHWY6l/vCifehpTgyEAOXXvrGglGJbSCEULAMizl5uraeiMuST2Rv3liMNr
 asv+U+XMulz++/Q4hGVG0ygo4HkaIvF1fPIRXheYWnOWg1KvJxxZBk1lZmpxqRRj/SrM0s
 NcmviZKG67/99/rtogT7es31Z2iznDiGD/DJhsOyTOP8om98i8cNLlTHwNRnbDwM3GzX7g
 gU+AzG8MZ+000nfQdiUkwBXnYvnG37doAGzU3bBq40fT7UPPz+rpJRUkwXb+lygTLCbOLr
 Wr5ZNXw7rw32IvOJrCp8oehEAtCQz075XaUsfSZ0Md/ZDl2mymcjoo+EFrdMSQ==
Message-ID: <604a1d7e-1cd9-ad27-6d37-2e8535ce253b@mailbox.org>
Date: Wed, 14 Sep 2022 15:31:02 +0200
MIME-Version: 1.0
Subject: Re: [PATCH V3 46/47] drm/amd/display: Fix failures of disabling
 primary plans
Content-Language: en-CA
To: Wayne Lin <Wayne.Lin@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
 <20220914051046.1131186-47-Wayne.Lin@amd.com>
From: =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel.daenzer@mailbox.org>
In-Reply-To: <20220914051046.1131186-47-Wayne.Lin@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 00531fba77b782323a9
X-MBO-RS-META: sxchaif8z58qyjjmc166mbp89trnhrja
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>,
 Harry.Wentland@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 2022-09-14 07:10, Wayne Lin wrote:
> From: Alex Hung <alex.hung@amd.com>
> 
> [Why & How]
> This fixes kernel errors when IGT disables primary planes during the
> tests kms_universal_plane::functional_test_pipe/pageflip_test_pipe.

NAK.

This essentially reverts commit b836a274b797 ("drm/amdgpu/dc: Require primary plane to be enabled whenever the CRTC is") (except that it goes even further and completely removes the requirement for any HW plane to be enabled when the HW cursor is), so it would reintroduce the issues described in that commit log.

If IGT tests disable the primary plane while leaving the CRTC enabled, those tests are broken and need to be fixed instead.


P.S. Per above, this patch should never have made it this far without getting in touch with me directly.


> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index c89594f3a5cb..099a226407a3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -376,18 +376,6 @@ static int dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
>  		return ret;
>  	}
>  
> -	/*
> -	 * We require the primary plane to be enabled whenever the CRTC is, otherwise
> -	 * drm_mode_cursor_universal may end up trying to enable the cursor plane while all other
> -	 * planes are disabled, which is not supported by the hardware. And there is legacy
> -	 * userspace which stops using the HW cursor altogether in response to the resulting EINVAL.
> -	 */
> -	if (crtc_state->enable &&
> -		!(crtc_state->plane_mask & drm_plane_mask(crtc->primary))) {
> -		DRM_DEBUG_ATOMIC("Can't enable a CRTC without enabling the primary plane\n");
> -		return -EINVAL;
> -	}
> -
>  	/* In some use cases, like reset, no stream is attached */
>  	if (!dm_crtc_state->stream)
>  		return 0;

-- 
Earthling Michel Dänzer            |                  https://redhat.com
Libre software enthusiast          |         Mesa and Xwayland developer

