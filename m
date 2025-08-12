Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56EDACA0EC4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 23:46:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC0DF10E041;
	Tue, 12 Aug 2025 23:46:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hpSu4CkC";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B81F10E041
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 23:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Tflh1RE0X6q/1CgeWTLxukFSJn//pXXIEq89IMw4gc8=; b=hpSu4CkCNmMDIkfEGsyd1/iT4k
 cVlPjvwf9KwF6Vo2X97LInAZCW3+h0vvfa4NFd3W1nYN5w4J/wRwAFOL6yoVExoYwsTsFx1AbDqzs
 XLwCsukf3StZMymEitUOxBBpmUfKMKpcT2O9JJC44o6gIvdinyntu1rwiEZY9kaBloRnb6/rXrtSY
 C8fEe4JWBLbggqyKhElY5gu/IV5Avr9iWnjQ7SQkLpvJt+F2FZXKxyz2Ha3urGb2tqURS25coEqEB
 DUZcM2+iBdfqX7ZezqYCSaGEXzKrVr2F/63SzRaT7g+Xa+AeQXqH7aR9N+baGF8o7TXVSrsZ6vh7W
 UX22cYpQ==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ulyhf-00DRp9-Mg; Wed, 13 Aug 2025 01:46:52 +0200
Date: Tue, 12 Aug 2025 17:46:47 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Hung <alex.hung@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH 7/7] drm/amd/display: Fix fractional fb divider in
 set_pixel_clock_v3
Message-ID: <q7a7pigc4nmfsxfftxgklkvriphotybcikqfurffgasily7zsq@wdhgtsg7rdvt>
References: <20250731094352.29528-1-timur.kristof@gmail.com>
 <20250731094352.29528-8-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250731094352.29528-8-timur.kristof@gmail.com>
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
> For later VBIOS versions, the fractional feedback divider is
> calculated as the remainder of dividing the feedback divider by
> a factor, which is set to 1000000. For reference, see:
> - calculate_fb_and_fractional_fb_divider
> - calc_pll_max_vco_construct
> 
> However, in case of old VBIOS versions that have
> set_pixel_clock_v3, they only have 1 byte available for the
> fractional feedback divider, and it's expected to be set to the
> remainder from dividing the feedback divider by 10.
> For reference see the legacy display code:
> - amdgpu_pll_compute
> - amdgpu_atombios_crtc_program_pll
> 
> This commit fixes set_pixel_clock_v3 by dividing the fractional
> feedback divider passed to the function by 100000.
> 
> Fixes: 4562236b3bc0 ("drm/amd/dc: Add dc display driver (v2)")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/bios/command_table.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> index 2bcae0643e61..58e88778da7f 100644
> --- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> +++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
> @@ -993,7 +993,7 @@ static enum bp_result set_pixel_clock_v3(
>  	allocation.sPCLKInput.usFbDiv =
>  			cpu_to_le16((uint16_t)bp_params->feedback_divider);
>  	allocation.sPCLKInput.ucFracFbDiv =
> -			(uint10_t)bp_params->fractional_feedback_divider;
> +			(uint8_t)(bp_params->fractional_feedback_divider / 100000);
>  	allocation.sPCLKInput.ucPostDiv =
>  			(uint8_t)bp_params->pixel_clock_post_divider;
>  
> -- 
> 2.50.1
>

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com> 

-- 
Rodrigo Siqueira
