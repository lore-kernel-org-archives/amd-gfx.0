Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EA0EC54E4A
	for <amd-gfx@archiver.kernel.org>; Thu,  7 Mar 2024 19:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0A0A112499;
	Thu,  7 Mar 2024 19:31:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="L0lLEfIo";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0B0C11229E
 for <amd-gfx@lists.freedesktop.org>; Thu,  7 Mar 2024 19:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=claNfNCNdwAuVVdEjxNgaXfvtJQSA+bqs4pghfSbMek=; b=L0lLEfIoPnq8trtY1uMDGCNMBd
 Jq4cp4z1fj+YfkSg5eb5wrs482LxyceAh/8yWNYtB6gTjMltpTPX8xNg3njS5Tf67QlbkEh36eNnQ
 Yt2+EQGbYKJ5oN9+g2EKttsu+zbGN0pDjuxKSEr6Zpx1w/4LUv68gFZdrS2qB90dlJSOCH0W/4erM
 HzzuvRE+aWS7Oz82cnc/2LkeIC/JUcdye4vfkIZ30IIqqOsxaUQl8goFhJuS5HyTi7DH3d1hgxCkX
 Nxmi5eGsgLV/vmyv8F3AmRboy4/S3pbB+aiOuNr4TRB4q0OU51oEXULqhVP7WrHpvMyUsbScwW9KA
 lFmHLXqw==;
Received: from [189.6.17.125] (helo=mail.igalia.com)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1riJSf-007ObZ-9p; Thu, 07 Mar 2024 20:31:25 +0100
Date: Thu, 7 Mar 2024 16:30:28 -0300
From: Melissa Wen <mwen@igalia.com>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org, 
 Harry.Wentland@amd.com, Sunpeng.Li@amd.com, Rodrigo.Siqueira@amd.com, 
 Aurabindo.Pillai@amd.com, roman.li@amd.com, wayne.lin@amd.com,
 agustin.gutierrez@amd.com, 
 chiahsuan.chung@amd.com, hersenxs.wu@amd.com, jerry.zuo@amd.com, 
 Muhammad Ahmed <ahmed.ahmed@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 stable@vger.kernel.org, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: Re: [PATCH 25/34] drm/amd/display: Set the power_down_on_boot
 function pointer to null
Message-ID: <xuprblokiyqlelwnt5bcauyphsaafvb6hfnbkvodsg2wjp4xjr@renc6bbhfdv6>
References: <20240228183940.1883742-1-alex.hung@amd.com>
 <20240228183940.1883742-26-alex.hung@amd.com>
 <54c3aa20-f041-4843-b4b5-362b7ff77844@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54c3aa20-f041-4843-b4b5-362b7ff77844@amd.com>
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

On 02/28, Mario Limonciello wrote:
> On 2/28/2024 12:39, Alex Hung wrote:
> > From: Muhammad Ahmed <ahmed.ahmed@amd.com>
> > 
> > [WHY]
> > Blackscreen hang @ PC EF000025 when trying to wake up from S0i3. DCN
> > gets powered off due to dc_power_down_on_boot() being called after
> > timeout.
> > 
> > [HOW]
> > Setting the power_down_on_boot function pointer to null since we don't
> > expect the function to be called for APU.
> 
> Perhaps, should we be making the same change for other APUs?

any follow-up to Mario's question?

I wonder if this can help solve other "black screen hangs after suspend"
reported for other APUs...

Melissa

> 
> It seems a few others call dcn10_power_down_on_boot() for the callback.
> 
> > 
> > Cc: Mario Limonciello <mario.limonciello@amd.com>
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: stable@vger.kernel.org
> > Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> > Acked-by: Alex Hung <alex.hung@amd.com>
> > Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
> > ---
> >   drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
> > index dce620d359a6..d4e0abbef28e 100644
> > --- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
> > +++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
> > @@ -39,7 +39,7 @@
> >   static const struct hw_sequencer_funcs dcn35_funcs = {
> >   	.program_gamut_remap = dcn30_program_gamut_remap,
> >   	.init_hw = dcn35_init_hw,
> > -	.power_down_on_boot = dcn35_power_down_on_boot,
> > +	.power_down_on_boot = NULL,
> >   	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
> >   	.apply_ctx_for_surface = NULL,
> >   	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
> 
