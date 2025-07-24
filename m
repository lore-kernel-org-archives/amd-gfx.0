Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C53BC83F26
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jul 2025 22:32:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CDD910E07C;
	Thu, 24 Jul 2025 22:32:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="l5ha4Zvv";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B885810E07C
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jul 2025 22:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TtWK8SEqkDuQENn2gRiyc4Ds9c7q8T0oa9Jvm+hsAro=; b=l5ha4ZvviXke2yiZfr7F4YKKjX
 3gIeYy6bqCfKeDc/EFMXBXKeHuP1rctACmrRx8FTNMA9DqcenMCiXF8oaQF8F38Gd7ZOhuVZALaUI
 pQ7TxgRqGaXyN0T4H08YTehMj1WMYIrlyQin+9XM8Ccsg3vGKbTrnqQAZf8egzzPCKYpjmmjVCNBb
 w6AwzYsERbLRZxL3Zpnat94qgkN9kRbmxvejUVl/tASRKqbQh1TkJhn/dIE4If33j6+hULP5RIsm4
 ZocmSBrrmTQlpJZP3aFKgYwFZUX5cGvD2Ct9gF//trH9QjDhDaQqLNgn8zLAkn2rpuTUCOXz3LPF+
 QEjDB0Iw==;
Received: from [104.193.135.201] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uf4UC-003PQg-5s; Fri, 25 Jul 2025 00:32:24 +0200
Date: Thu, 24 Jul 2025 16:32:19 -0600
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Timur =?utf-8?Q?Krist=C3=B3f?= <timur.kristof@gmail.com>, 
 Dillon Varone <dillon.varone@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Alex Hung <alex.hung@amd.com>, 
 Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 1/3] drm/amd/display: Fix refactored DSC cap calculation
Message-ID: <kzydigo7sq2odubrh5cci54lw2htowj56g3ihg6hn5pynnnq6u@oof6cdqts3h3>
References: <20250722155830.67401-1-timur.kristof@gmail.com>
 <20250722155830.67401-2-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250722155830.67401-2-timur.kristof@gmail.com>
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

On 010/22, Timur Kristóf wrote:
> After refactoring the DSC capability calculation, the
> get_min_slice_count_for_odm could crash on some GPUs due to a
> division by zero when max_total_throughput_mps was zero.
> As a result, DC was broken when connecting a GPU that doesn't
> support DSC to a monitor that supports DSC.
> Tested on Oland (DCE 6) and Fiji (DCE 10).
> 
> This commit fixes it by returning zero instead.
> 
> Fixes: 4909b8b3846c ("drm/amd/display: Refactor DSC cap calculations")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> index a454d16e6586..4169ece9c535 100644
> --- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> +++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
> @@ -642,14 +642,15 @@ static unsigned int get_min_slice_count_for_odm(
>  	unsigned int max_dispclk_khz;
>  
>  	/* get max pixel rate and combine caps */
> -	max_dispclk_khz = dsc_enc_caps->max_total_throughput_mps * 1000;
> -	if (dsc && dsc->ctx->dc) {
> -		if (dsc->ctx->dc->clk_mgr &&
> -			dsc->ctx->dc->clk_mgr->funcs->get_max_clock_khz) {
> -			/* dispclk is available */
> -			max_dispclk_khz = dsc->ctx->dc->clk_mgr->funcs->get_max_clock_khz(dsc->ctx->dc->clk_mgr, CLK_TYPE_DISPCLK);
> -		}
> -	}
> +	if (dsc && dsc->ctx->dc && dsc->ctx->dc->clk_mgr &&
> +		dsc->ctx->dc->clk_mgr->funcs->get_max_clock_khz)
> +		max_dispclk_khz =
> +			dsc->ctx->dc->clk_mgr->funcs->get_max_clock_khz(
> +				dsc->ctx->dc->clk_mgr, CLK_TYPE_DISPCLK);
> +	else if (dsc_enc_caps->max_total_throughput_mps)
> +		max_dispclk_khz = dsc_enc_caps->max_total_throughput_mps * 1000;
> +	else
> +		return 0;
>  
>  	/* consider minimum odm slices required due to
>  	 * 1) display pipe throughput (dispclk)
> -- 
> 2.50.1
>

This patch lgtm.

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>

I added other display folks to this patch.

I'm not sure if the original modification (4909b8b3846c) is already in
the stable kernel; if so, it could be a good idea to send this fix to
the stable kernel as well.

Thanks

-- 
Rodrigo Siqueira
