Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0288CA0EC4
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Aug 2025 21:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D3B510E492;
	Tue, 12 Aug 2025 21:10:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="gGDNdzNc";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 944E110E012
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 21:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=t4bmhnhq05eLwa1S4o+rm+W0xLGcICULggiibX2Xiss=; b=gGDNdzNcD1yksL0NuAgZreTpPV
 mdSJhpMiiLW97xpdq3wCSISCoRShwEqHK9bN8A9+MV7tXPtszqAfGmO/ePS+UBn53bwyq/taZVsDs
 Qz9BiorFgbjTBvD6CGsR56vYNjrgt+9YWRffuObYZvTY6IgS/sGybzcjMxLxePsk8lNmYF/ePE21g
 8qTvum4ApuFPWUqt4htB8S1QCreJCKa1fB+5/5hNEfnNexZrM9007T/51rdxhRLU7QSu/8c1KLxE2
 k9Lk4Of+2N4Jasc4lw649jhUHAk9N51oFDgUpjh/bvgA3f3teJttajeA8u+UZwfFBwu5FIkyGLstX
 rUltSkVw==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1ulwFv-00DP3P-1k; Tue, 12 Aug 2025 23:10:03 +0200
Date: Tue, 12 Aug 2025 15:09:58 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>
Cc: amd-gfx@lists.freedesktop.org, Alex Hung <alex.hung@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Harry Wentland <harry.wentland@amd.com>
Subject: Re: [PATCH 1/3] drm/amd/display: Disable fastboot on DCE 6 too.
Message-ID: <el5hgtubblrdcoqjf3k3uq5qfanivn476fo55cm24hwidp732s@qtoshmmbxa65>
References: <20250802160602.12698-1-timur.kristof@gmail.com>
 <20250802160602.12698-2-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250802160602.12698-2-timur.kristof@gmail.com>
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

On 08/02, Timur Kristóf wrote:
> It already didn't work on DCE 8,
> so there is no reason to assume it would on DCE 6.
> 
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> index 153d68375fa3..1d57df7fc948 100644
> --- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> +++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
> @@ -1923,10 +1923,8 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
>  
>  	get_edp_streams(context, edp_streams, &edp_stream_num);
>  
> -	// Check fastboot support, disable on DCE8 because of blank screens
> -	if (edp_num && edp_stream_num && dc->ctx->dce_version != DCE_VERSION_8_0 &&
> -		    dc->ctx->dce_version != DCE_VERSION_8_1 &&
> -		    dc->ctx->dce_version != DCE_VERSION_8_3) {
> +	/* Check fastboot support, disable on DCE 6-8 because of blank screens */
> +	if (edp_num && edp_stream_num && dc->ctx->dce_version < DCE_VERSION_10_0) {
>  		for (i = 0; i < edp_num; i++) {
>  			edp_link = edp_links[i];
>  			if (edp_link != edp_streams[0]->link)
> -- 
> 2.50.1
>

As usual, CCed other display folks.

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>

Thanks
-- 
Rodrigo Siqueira
