Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48056C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 14 Dec 2023 19:28:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3463B10E1D3;
	Thu, 14 Dec 2023 19:28:52 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BC2610E1D3
 for <amd-gfx@lists.freedesktop.org>; Thu, 14 Dec 2023 19:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qZ7WdYwuWHLFVxE4aJj+knJztRHGVlKws0Z4WfxGlzM=; b=REdKQ4sJ6wn3XHrF0erIMAoe6f
 zoW4krUTThHQ6o/BGxpREaED7O8skijmiAJwy9Pb97+PoFNy0a9u9GnXlyhsrb4DS+mhdA5y+2Wsb
 g6DE9YxEz0O2c12ne3SKKE0mUuW55kZHd4n1VJUN7wjMfFKQW2JwhGcLwkoCI96qztw/Hxlb5P/n8
 Sc5fYUM+QIt+IJU8tMHxLk2B9N+w+UGxhzVXkBavkaW6Qbh+8KZpBYD9alnNp6UxJu7bhmipqbs/x
 98ZWjvCELcHhPB0SkmdNmNDd1YcHWt2AwnwzNatUWXRYs3Qa4rh9ccDsn8d0vIUPgJxMWRXSyJV+h
 f+rrgKuQ==;
Received: from [102.213.205.115] (helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1rDrNz-00DzyE-TU; Thu, 14 Dec 2023 20:28:44 +0100
Date: Thu, 14 Dec 2023 18:28:40 -0100
From: Melissa Wen <mwen@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: Re: [PATCH] drm/amd/display: fix documentation for
 amdgpu_dm_verify_lut3d_size()
Message-ID: <20231214192840.7n5z3nhajxzaeg7m@mail.igalia.com>
References: <20231214154646.651468-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231214154646.651468-1-alexander.deucher@amd.com>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Harry.Wentland@amd.com,
 amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

On 12/14, Alex Deucher wrote:
> It takes the plane state rather than the crtc state.
> 
> Fixes: aba8b76baabd ("drm/amd/display: add plane shaper LUT support")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Harry.Wentland@amd.com
> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> index 96aecc1a71a3..c6ed0d854b01 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_color.c
> @@ -796,7 +796,7 @@ static int amdgpu_dm_atomic_blend_lut(const struct drm_color_lut *blend_lut,
>   * amdgpu_dm_verify_lut3d_size - verifies if 3D LUT is supported and if user
>   * shaper and 3D LUTs match the hw supported size
>   * @adev: amdgpu device
> - * @crtc_state: the DRM CRTC state
> + * @plane_state: the DRM plane state

Reviewed-by: Melissa Wen <mwen@igalia.com>

>   *
>   * Verifies if pre-blending (DPP) 3D LUT is supported by the HW (DCN 2.0 or
>   * newer) and if the user shaper and 3D LUTs match the supported size.
> -- 
> 2.42.0
> 
