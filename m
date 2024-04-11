Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 581EBC4345F
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Apr 2024 15:05:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C6C710F148;
	Thu, 11 Apr 2024 15:05:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="BmvqBvVE";
	dkim-atps=neutral
X-Greylist: delayed 2320 seconds by postgrey-1.36 at gabe;
 Thu, 11 Apr 2024 15:05:46 UTC
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EA08110F145
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Apr 2024 15:05:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dwUQ1zoQf/ipPwR+kdnLAnyaMibb3uyip6qsFZjM6As=; b=BmvqBvVEmFfg5j9MHL2e5XIEBU
 zE53iyZpjY3qc5ZcZTquno9UtoQWWNZjy12S//TTasKBIHGqRVubwqj4SkO9VuUAqnPR7HEl+DJMW
 /hEBRwFuQLN867P18Ltl+vBypMSWgW5olvxXlrDi5f8lf4KLDnyL8woU99AdlixI6TGwUeYOfweZi
 5daq35v8txu69hjWJQ7ZqWXOs/Cd1In77P4f6iD4fTMSAtcSZOpO6YNvlE2r6h5Gzzb51P7mvraQ5
 080VRBXOF2pKQTOeTy3C1d8mNfdelhvEkId755KuLTah8WYHVR/jwQ0szgr5KxIawxqWJaMHwmcxs
 JjSOwEBw==;
Received: from [189.6.17.125] (helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ruvOH-003ahB-M6; Thu, 11 Apr 2024 16:27:02 +0200
Date: Thu, 11 Apr 2024 11:26:23 -0300
From: Melissa Wen <mwen@igalia.com>
To: Joshua Ashton <joshua@froggi.es>
Cc: amd-gfx@lists.freedesktop.org, Harry Wentland <harry.wentland@amd.com>, 
 Xaver Hugl <xaver.hugl@gmail.com>, Ethan Lee <flibitijibibo@gmail.com>
Subject: Re: [PATCH] drm/amd/display: Enable ogam_ram for dcn32+dcn35+dcn351
Message-ID: <nhr535ncnm6n5btn7o6kkmblppnywvvnni6i4y3v6fmiazbopz@v5wo7kqarrlv>
References: <20240410221336.34627-1-joshua@froggi.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410221336.34627-1-joshua@froggi.es>
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

On 04/10, Joshua Ashton wrote:
> The comment here states "no OGAM in DPP since DCN1", yet that is not
> true.
> 
> Testing on an RX 7900XTX (dcn32), it actually does exist in hardware and
> works fine.
> My best guess is the comment is confused with OGAM ROM for DPP, rather
> than OGAM RAM.
> 
> I did not test dcn35/351 as I do not have that hardware, but I assume
> the same follows there given the seemingly erroneous comment.
> Someone at AMD should check that before merging this commit.

hmm... I don't have any of these hw versions, but AFAIU if there is
ogam/blend lut block in dcn32, the helper implementation for programming
it properly (i.e. dpp_program_blnd_lut) is also missing here:
- https://gitlab.freedesktop.org/agd5f/linux/-/blob/amd-staging-drm-next/drivers/gpu/drm/amd/display/dc/dpp/dcn32/dcn32_dpp.c#L125
right? So, it's good if AMD people can check it too.

Melissa

> 
> Signed-off-by: Joshua Ashton <joshua@froggi.es>
> 
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Xaver Hugl <xaver.hugl@gmail.com>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Ethan Lee <flibitijibibo@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 2 +-
>  drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c  | 2 +-
>  .../gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> index 9aa39bd25be9..94f5d2b5aadf 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> @@ -2182,7 +2182,7 @@ static bool dcn32_resource_construct(
>  	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
>  
>  	dc->caps.color.dpp.hw_3d_lut = 1;
> -	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
> +	dc->caps.color.dpp.ogam_ram = 1;
>  	// no OGAM ROM on DCN2 and later ASICs
>  	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
>  	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> index 25ac450944e7..708d63cc3f7f 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.c
> @@ -1861,7 +1861,7 @@ static bool dcn35_resource_construct(
>  	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
>  
>  	dc->caps.color.dpp.hw_3d_lut = 1;
> -	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
> +	dc->caps.color.dpp.ogam_ram = 1;
>  	// no OGAM ROM on DCN301
>  	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
>  	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> index 8a57adb27264..053e8ec6d1ef 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn351/dcn351_resource.c
> @@ -1841,7 +1841,7 @@ static bool dcn351_resource_construct(
>  	dc->caps.color.dpp.dgam_rom_for_yuv = 0;
>  
>  	dc->caps.color.dpp.hw_3d_lut = 1;
> -	dc->caps.color.dpp.ogam_ram = 0;  // no OGAM in DPP since DCN1
> +	dc->caps.color.dpp.ogam_ram = 1;
>  	// no OGAM ROM on DCN301
>  	dc->caps.color.dpp.ogam_rom_caps.srgb = 0;
>  	dc->caps.color.dpp.ogam_rom_caps.bt2020 = 0;
> -- 
> 2.44.0
> 
