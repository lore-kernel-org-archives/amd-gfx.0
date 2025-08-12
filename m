Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4728CA0EC4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 22:47:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FFE010E02D;
	Tue, 12 Aug 2025 22:47:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="GIU+HBul";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7401510E02D
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 22:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=BDEtFalh/iuEO0eREl7sxCXE/kqZ7L5LvLhKYPRKRaI=; b=GIU+HBulCjmwlhpSTtrYTPNfqE
 RLrZP7MYyKSqkeGD8sRdOOIN84Yqq2LPUhAEZiJnV9sLW7p/osNg+g3clH1ow2V2bnJwESN4I8NiS
 SiLm0CU2nGDt36yLZScxVBODuzQsIM/PDo7R+7LHjxE/vQfPayOp+P/JujcW/oOUbEWyN3v1iL6x/
 gD4osMknd9P5pDzP5WCpZFXS8BfQJVsfpVWLCbpBEQ+FzLseEJwnQPO2p9biHg44GIvWSRNjrRdE4
 NbgtgxpDq8fDoYH7wELR9Y9mULUUSa4OACtLfal9Zix/hG5ZbY7rmXs3lgoOhf9FvybT/mtfMeAtu
 yKsd2HeQ==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ulxlz-00DQo8-3g; Wed, 13 Aug 2025 00:47:15 +0200
Date: Tue, 12 Aug 2025 16:47:11 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Hung <alex.hung@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH 5/7] drm/amd/display: Don't warn when missing DCE encoder
 caps
Message-ID: <fyznjd2pfth6vokc4hvac2xkjle36j5nefreq3zcyuyy7v5znk@swjqullitunf>
References: <20250731094352.29528-1-timur.kristof@gmail.com>
 <20250731094352.29528-6-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250731094352.29528-6-timur.kristof@gmail.com>
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

On 07/31, Timur Kristóf wrote:
> On some GPUs the VBIOS just doesn't have encoder caps,
> or maybe not for every encoder.
> 
> This isn't really a problem and it's handled well,
> so let's not litter the logs with it.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> index 4a9d07c31bc5..0c50fe266c8a 100644
> --- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> +++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
> @@ -896,13 +896,13 @@ void dce110_link_encoder_construct(
>  						enc110->base.id, &bp_cap_info);
>  
>  	/* Override features with DCE-specific values */
> -	if (BP_RESULT_OK == result) {
> +	if (result == BP_RESULT_OK) {
>  		enc110->base.features.flags.bits.IS_HBR2_CAPABLE =
>  				bp_cap_info.DP_HBR2_EN;
>  		enc110->base.features.flags.bits.IS_HBR3_CAPABLE =
>  				bp_cap_info.DP_HBR3_EN;
>  		enc110->base.features.flags.bits.HDMI_6GB_EN = bp_cap_info.HDMI_6GB_EN;
> -	} else {
> +	} else if (result != BP_RESULT_NORECORD) {
>  		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
>  				__func__,
>  				result);
> @@ -1798,13 +1798,13 @@ void dce60_link_encoder_construct(
>  						enc110->base.id, &bp_cap_info);
>  
>  	/* Override features with DCE-specific values */
> -	if (BP_RESULT_OK == result) {
> +	if (result == BP_RESULT_OK) {
>  		enc110->base.features.flags.bits.IS_HBR2_CAPABLE =
>  				bp_cap_info.DP_HBR2_EN;
>  		enc110->base.features.flags.bits.IS_HBR3_CAPABLE =
>  				bp_cap_info.DP_HBR3_EN;
>  		enc110->base.features.flags.bits.HDMI_6GB_EN = bp_cap_info.HDMI_6GB_EN;
> -	} else {
> +	} else if (result != BP_RESULT_NORECORD) {
>  		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
>  				__func__,
>  				result);
> -- 
> 2.50.1
>

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com> 

-- 
Rodrigo Siqueira
