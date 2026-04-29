Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F12CCFA13
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Apr 2026 20:03:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B73310F15D;
	Wed, 29 Apr 2026 20:03:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="PV72sQPF";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8A5610F15D
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Apr 2026 20:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8jLXL0Sss5blu0uiq2+J9B2lQcF3NRkw0klHI4tqFeg=; b=PV72sQPFguEfmeZ6WFMUcQuvCr
 dGIjF7RnqSiy4FFX+vyRAEsKl/1D0HOjAJj6eoZkZm2CzfkeKP7fxGiYuUgkctaCoSGb14WUSaSIb
 bNFJAkf7ZCR2LqV1M3XKMy8QWf+4SCUAxYxAsOjr2UPz7MjZlTKXbkUKOPyU8d/xdh3Sn4wo7YXuC
 NgaOko/B1zQ/To0OV6zrSi61wQB9enWjC5UIy25wP3/KtIpaHcqm7j1ba96P7H3C7w4dw3sanvokv
 wTkvg6TA8XWG/Y7hxd+jA+AC/+PwQM9o5J5ZgRZlWyEDeVOsk+EGVEQOB3TlFj05XnlYIJWQJmMmO
 kH/+g3wA==;
Received: from [186.208.73.228] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wIB8B-0046dq-A1; Wed, 29 Apr 2026 22:03:34 +0200
Message-ID: <da2a59cc-81e4-473c-913b-c320dbdb659c@igalia.com>
Date: Wed, 29 Apr 2026 17:03:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/14] drm/amd/display: Delete
 dce_get_required_clocks_state()
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>,
 amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
 <20260423191519.73127-3-timur.kristof@gmail.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260423191519.73127-3-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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



On 23/04/2026 16:15, Timur Kristóf wrote:
> It is not called from anywhere anymore.
Reviewed-by: Melissa Wen <mwen@igalia.com>
>
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> ---
>   .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 34 -------------------
>   .../display/dc/clk_mgr/dce100/dce_clk_mgr.h   |  3 --
>   2 files changed, 37 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> index ffb70120362e7..988eb6f841f54 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
> @@ -220,40 +220,6 @@ uint32_t dce_get_max_pixel_clock_for_all_paths(struct dc_state *context)
>   	return max_pix_clk;
>   }
>   
> -enum dm_pp_clocks_state dce_get_required_clocks_state(
> -	struct clk_mgr *clk_mgr_base,
> -	struct dc_state *context)
> -{
> -	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
> -	int i;
> -	enum dm_pp_clocks_state low_req_clk;
> -	int max_pix_clk = dce_get_max_pixel_clock_for_all_paths(context);
> -
> -	/* Iterate from highest supported to lowest valid state, and update
> -	 * lowest RequiredState with the lowest state that satisfies
> -	 * all required clocks
> -	 */
> -	for (i = clk_mgr_dce->max_clks_state; i >= DM_PP_CLOCKS_STATE_ULTRA_LOW; i--)
> -		if (context->bw_ctx.bw.dce.dispclk_khz >
> -				clk_mgr_dce->max_clks_by_state[i].display_clk_khz
> -			|| max_pix_clk >
> -				clk_mgr_dce->max_clks_by_state[i].pixel_clk_khz)
> -			break;
> -
> -	low_req_clk = i + 1;
> -	if (low_req_clk > clk_mgr_dce->max_clks_state) {
> -		/* set max clock state for high phyclock, invalid on exceeding display clock */
> -		if (clk_mgr_dce->max_clks_by_state[clk_mgr_dce->max_clks_state].display_clk_khz
> -				< context->bw_ctx.bw.dce.dispclk_khz)
> -			low_req_clk = DM_PP_CLOCKS_STATE_INVALID;
> -		else
> -			low_req_clk = clk_mgr_dce->max_clks_state;
> -	}
> -
> -	return low_req_clk;
> -}
> -
> -
>   /* TODO: remove use the two broken down functions */
>   int dce_set_clock(
>   	struct clk_mgr *clk_mgr_base,
> diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h
> index f6622f58f62eb..f9f0cfa2a7b20 100644
> --- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h
> +++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h
> @@ -32,9 +32,6 @@
>   /* functions shared by other dce clk mgrs */
>   int dce_adjust_dp_ref_freq_for_ss(struct clk_mgr_internal *clk_mgr_dce, int dp_ref_clk_khz);
>   int dce_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base);
> -enum dm_pp_clocks_state dce_get_required_clocks_state(
> -	struct clk_mgr *clk_mgr_base,
> -	struct dc_state *context);
>   
>   uint32_t dce_get_max_pixel_clock_for_all_paths(struct dc_state *context);
>   

