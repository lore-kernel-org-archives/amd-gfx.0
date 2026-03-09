Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE27FCA188
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Mar 2026 20:47:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E04110E1B2;
	Mon,  9 Mar 2026 20:47:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="VaQmclpm";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25CB310E1B2
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Mar 2026 20:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l3hZ5ksGFVbnAk7kx9lByhFccZWjvDvKnQdnWXGagTQ=; b=VaQmclpmUvbXXl+UPGRa+/YagX
 jktpecbBLsaJwwAhf1AS8Zj8Tb37E0K2s9YB6ggTdCjMcz4tAObisxk18AuJ57R2JamKdpQEO2TuF
 j1kIMSeFAhsv06z/Dwrs2rq0v7nX3Xyinv+HUH4NxzkFn9HqOSwSk8mkYpPO4RJsh5BLwtFbuyRui
 4/ykhlZv+ie7qisxZ05poLUGbN3tJrcpAQTKsBrISuAsQDshz+XaLm6avfPICZA9wetuE71Xm8rTl
 uLbD1x7jhawXjOoPP+/EAmVVgFREdX+6uFCK3FgueP2nma4EpUljLZf+cxnqW3RMzQu9tgYgkuSBT
 L4d2v6tQ==;
Received: from [186.208.68.119] (helo=[192.168.18.14])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1vzhVg-00CEOQ-7R; Mon, 09 Mar 2026 21:47:28 +0100
Message-ID: <e36f509b-6d45-4517-b53b-45bc8ccaa263@igalia.com>
Date: Mon, 9 Mar 2026 17:47:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/21] drm/amd/display: Set chroma taps to 1 if luma taps
 are 1
To: Alex Hung <alex.hung@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
References: <20260306031932.136179-1-alex.hung@amd.com>
 <20260306031932.136179-5-alex.hung@amd.com>
Content-Language: en-US
From: Melissa Wen <mwen@igalia.com>
In-Reply-To: <20260306031932.136179-5-alex.hung@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 06/03/2026 00:13, Alex Hung wrote:
> From: Harry Wentland <harry.wentland@amd.com>
>
> When luma is unscaled we also want chroma to be pixel-perfect.
> When luma taps are > 1 the result will be a blurred luma plane,
> even when the image isn't scaled.
>
> This makes WIP IGT tests for CSC colorop pass.
>
> Co-developed by Claude Sonnet 4.5.
Nitpick: I understand this should be an `Assisted-by:` tag [1]

Same for other patches in this series with similar sentence.

[1] https://docs.kernel.org/process/coding-assistants.html
>
> Reviewed-by: Alex Hung <alex.hung@amd.com>
> Signed-off-by: Harry Wentland <harry.wentland@amd.com>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> ---
>   drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c | 8 ++++++--
>   drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c | 8 ++++++--
>   2 files changed, 12 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
> index ce91e5d28956..0e70ffc784b1 100644
> --- a/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn10/dcn10_dpp.c
> @@ -172,10 +172,14 @@ bool dpp1_get_optimal_number_of_taps(
>   		scl_data->taps.h_taps_c = in_taps->h_taps_c;
>   
>   	if (!dpp->ctx->dc->debug.always_scale) {
> -		if (IDENTITY_RATIO(scl_data->ratios.horz))
> +		if (IDENTITY_RATIO(scl_data->ratios.horz)) {
>   			scl_data->taps.h_taps = 1;
> -		if (IDENTITY_RATIO(scl_data->ratios.vert))
> +			scl_data->taps.h_taps_c = 1;
> +		}
> +		if (IDENTITY_RATIO(scl_data->ratios.vert)) {
>   			scl_data->taps.v_taps = 1;
> +			scl_data->taps.v_taps_c = 1;
> +		}
>   		if (IDENTITY_RATIO(scl_data->ratios.horz_c))
>   			scl_data->taps.h_taps_c = 1;
>   		if (IDENTITY_RATIO(scl_data->ratios.vert_c))
> diff --git a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
> index c7923531da83..8a146968ee15 100644
> --- a/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
> +++ b/drivers/gpu/drm/amd/display/dc/dpp/dcn30/dcn30_dpp.c
> @@ -524,10 +524,14 @@ bool dpp3_get_optimal_number_of_taps(
>   		scl_data->taps.v_taps_c = max_taps_c;
>   
>   	if (!dpp->ctx->dc->debug.always_scale) {
> -		if (IDENTITY_RATIO(scl_data->ratios.horz))
> +		if (IDENTITY_RATIO(scl_data->ratios.horz)) {
>   			scl_data->taps.h_taps = 1;
> -		if (IDENTITY_RATIO(scl_data->ratios.vert))
> +			scl_data->taps.h_taps_c = 1;
> +		}
> +		if (IDENTITY_RATIO(scl_data->ratios.vert)) {
>   			scl_data->taps.v_taps = 1;
> +			scl_data->taps.v_taps_c = 1;
> +		}
>   		if (IDENTITY_RATIO(scl_data->ratios.horz_c))
>   			scl_data->taps.h_taps_c = 1;
>   		if (IDENTITY_RATIO(scl_data->ratios.vert_c))

