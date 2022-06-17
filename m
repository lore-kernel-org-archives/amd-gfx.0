Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAB1C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 17 Jun 2022 19:51:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB710112071;
	Fri, 17 Jun 2022 19:51:58 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7302B11207F
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Jun 2022 19:51:57 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D174FB82693;
 Fri, 17 Jun 2022 19:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 867DBC3411B;
 Fri, 17 Jun 2022 19:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655495514;
 bh=vcOOJm1wUymaBtTkgo2NjHrmbosB1icQbnYIP/1obv8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=BMBTZ+lC4qb7dpfc1KSvaI3FUDTrzYEZsVJyPcVqCtbdkeDMcBf+dZoFtgLE+XNuk
 JyDZ6sPMpOEpDrue0O9y7IkhUImQFUm+yo+Zb0NKlXuA+LXYHbvVI/D+8mKz/Mn56L
 urVfSdbu6CsKAeyGR9palOTnifP7vRHmFTRV9oflcQMJh4nwDVeOC9TWUEuxXW4C2g
 dZkFEES5q4syvOMUf6ZGSFqDmXUoUIBxJR55y3oivHFfY466qjA7ELjqBy0+0p+cYN
 WKtqteN0izYOKVeUWWcnB3nPFL/xNVHDUn1LKEwm7YiHkq9bBVcSRLEFADcBse81bd
 VNiP5/7B2xTpw==
Date: Fri, 17 Jun 2022 12:51:51 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: Re: [PATCH 16/31] drm/amd/display: refactor function
 transmitter_to_phy_id
Message-ID: <YqzbVxByDw1xSdXb@dev-arch.thelio-3990X>
References: <20220617193512.3471076-1-Rodrigo.Siqueira@amd.com>
 <20220617193512.3471076-17-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220617193512.3471076-17-Rodrigo.Siqueira@amd.com>
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
Cc: Chao-kai Wang <Stylon.Wang@amd.com>, Alan Liu <HaoPing.Liu@amd.com>,
 Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, qingqing.zhuo@amd.com,
 roman.li@amd.com, amd-gfx@lists.freedesktop.org, solomon.chiu@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 Nicholas Choi <Nicholas.Choi@amd.com>, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 Nathan Chancellor <natechancellor@gmail.com>, Harry.Wentland@amd.com,
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Rodrigo,

On Fri, Jun 17, 2022 at 03:34:57PM -0400, Rodrigo Siqueira wrote:
> From: Nicholas Choi <Nicholas.Choi@amd.com>
> 
> [Why & How]
> Since we only need transmitter value in function transmitter_to_phy_id().
> Replace argument struct dc_link with enum transmitter.
> 
> Reviewed-by: Chao-kai Wang <Stylon.Wang@amd.com>
> Acked-by: Alan Liu <HaoPing.Liu@amd.com>
> Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

How did I end up in the signoff chain for a patch I have never seen up
until this point? That should definitely be cleaned up.

Additionally, this commit message doesn't really seem to line up with
the change. It says that "struct dc_link" is being replaced with "enum
transmitter", when it is really the reverse, and that only the
transmitter value is needed, which is already the case, right? I guess
this is so that you can use DC_ERROR(), which requires a dc_ctx
variable? It is not immediately obvious from the commit message so that
should be clarified as well.

Cheers,
Nathan

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_link.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> index 43b55bc6e2db..58882d42eff5 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
> @@ -3185,8 +3185,11 @@ bool dc_link_get_psr_state(const struct dc_link *link, enum dc_psr_state *state)
>  }
>  
>  static inline enum physical_phy_id
> -transmitter_to_phy_id(enum transmitter transmitter_value)
> +transmitter_to_phy_id(struct dc_link *link)
>  {
> +	struct dc_context *dc_ctx = link->ctx;
> +	enum transmitter transmitter_value = link->link_enc->transmitter;
> +
>  	switch (transmitter_value) {
>  	case TRANSMITTER_UNIPHY_A:
>  		return PHYLD_0;
> @@ -3213,8 +3216,7 @@ transmitter_to_phy_id(enum transmitter transmitter_value)
>  	case TRANSMITTER_UNKNOWN:
>  		return PHYLD_UNKNOWN;
>  	default:
> -		WARN_ONCE(1, "Unknown transmitter value %d\n",
> -			  transmitter_value);
> +		DC_ERROR("Unknown transmitter value %d\n", transmitter_value);
>  		return PHYLD_UNKNOWN;
>  	}
>  }
> @@ -3331,7 +3333,7 @@ bool dc_link_setup_psr(struct dc_link *link,
>  	psr_context->phyType = PHY_TYPE_UNIPHY;
>  	/*PhyId is associated with the transmitter id*/
>  	psr_context->smuPhyId =
> -		transmitter_to_phy_id(link->link_enc->transmitter);
> +		transmitter_to_phy_id(link);
>  
>  	psr_context->crtcTimingVerticalTotal = stream->timing.v_total;
>  	psr_context->vsync_rate_hz = div64_u64(div64_u64((stream->
> -- 
> 2.25.1
> 
> 
