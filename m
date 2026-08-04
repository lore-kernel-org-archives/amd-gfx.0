Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B502C561E6
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2026 07:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 699E810ED45;
	Wed,  5 Aug 2026 07:25:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=freenet.de header.i=@freenet.de header.b="UA3MjWE5";
	dkim-atps=neutral
X-Greylist: delayed 307 seconds by postgrey-1.36 at gabe;
 Tue, 04 Aug 2026 20:06:18 UTC
Received: from mout.freenet.de (mout.freenet.de [194.97.212.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D7B710E1CE
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Aug 2026 20:06:18 +0000 (UTC)
Received: from [2001:748:400:1319::5] (helo=sub7.mail.fnrz.de)
 by mout3.mail.fnrz.de with esmtpa (ID viktor.jaegerskuepper@freenet.de) (port
 25) (Exim 4.98.2 #2) id 1wrLJz-000000086Hs-2L8m;
 Tue, 04 Aug 2026 22:01:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=freenet.de; 
 s=mjaymdexmjqk;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:
 References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID; bh=j2d2pTMf45eKxufIgL+O4DpxhnwMfdGG0Me4sDxn7Qk=; 
 b=UA3MjWE5S684xmeRy1roLIld+o0kk1vmQw9W7n8rCzGf98wrckc0Zg/VhDawZ8PHfU0LTuAb/ag
 vNOsUAziHTRlyhCk5eN/ktxM72O9LBTsCsdsXCr9TnxY2gna2JJtxno2GMum1mh0bnh4FKMDvrMKL
 0dES+GvBJ9D+HSDF15pGm3/LN4diRFuWjMC3qqh0s7uoOgPDxCLxlKxKoQlu46dJDSuOuaxIGbV0W
 dLtxWKNYkyI3UC/sdqGQ1FPfLSQD7QZ5k9JS6/UShW4q1Tnkp/HdiR8j+q6cXY7owqrKoMBVe1qyY
 Blq9lMS7U5kc25/3Ak72NhhULOJG9ZTalkWg==;
Authentication-Results: freenet.de;
 iprev=fail smtp.remote-ip=2a02:8071:a85:f020:a1c3:53a:dda6:6958;
 auth=pass (PLAIN) smtp.auth=viktor.jaegerskuepper@freenet.de
Received: from [2a02:8071:a85:f020:a1c3:53a:dda6:6958] (port=38804
 helo=[127.0.0.1])
 by sub7.mail.fnrz.de with esmtpsa (ID viktor.jaegerskuepper@freenet.de)
 (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (port 465) (Exim
 4.98.2 #2) id 1wrLJz-00000000nse-1hYG;
 Tue, 04 Aug 2026 22:01:07 +0200
Message-ID: <98b592c8-33d2-4467-b4f4-9d317acfcc3a@freenet.de>
Date: Tue, 4 Aug 2026 22:01:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Fix crash in
 hwss_set_output_transfer_func()
Content-Language: en-US
To: =?UTF-8?Q?Timur_Krist=C3=B3f?= <timur.kristof@gmail.com>
References: <20260803124121.16912-1-timur.kristof@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, Natalie Vock <nat@pixelcluster.dev>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Alex Hung <alex.hung@amd.com>,
 Tomasz Siemek <tomasz.siemek@amd.com>, Wayne Lin <Wayne.Lin@amd.com>,
 amd-gfx@lists.freedesktop.org
From: =?UTF-8?B?VmlrdG9yIErDpGdlcnNrw7xwcGVy?=
 <viktor_jaegerskuepper@freenet.de>
In-Reply-To: <20260803124121.16912-1-timur.kristof@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-FN-MUUID: 1785873667039842C07D45O
X-Scan-TS: Tue, 04 Aug 2026 22:01:07 +0200
X-Mailman-Approved-At: Wed, 05 Aug 2026 07:25:06 +0000
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

On 8/3/26 14:41, Timur Kristóf wrote:
> The pipe_ctx->plane_res.hubp pointer is NULL on all DCE
> hardware, which causes a kernel NULL pointer dereference
> on all Vega and older GPUs.
> 
> Let's add a simple NULL check.
> 
> Fixes: f879f53407f0 ("drm/amd/display: Refactor DPP_SET_OUTPUT_TRANSFER_FUNC to drop pipe_ctx")
> Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
> Cc: Tomasz Siemek <tomasz.siemek@amd.com>

I've tested this patch (applied to amd-staging-drm-next) because I
observed the crash during my tests for
https://gitlab.freedesktop.org/drm/amd/-/work_items/5557 and I confirm
that the patch fixes the crash.

Tested-by: Viktor Jägersküpper <viktor_jaegerskuepper@freenet.de>

> ---
>  drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> index 11411fa94665..5495e493b2eb 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
> @@ -1900,7 +1900,8 @@ void hwss_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx)
>  				.xfm = pipe_ctx->plane_res.xfm,
>  				.dpp = pipe_ctx->plane_res.dpp,
>  				.mpc = dc->res_pool->mpc,
> -				.mpcc_id = pipe_ctx->plane_res.hubp->inst,
> +				.mpcc_id = pipe_ctx->plane_res.hubp ?
> +						pipe_ctx->plane_res.hubp->inst : 0,
>  				.is_top_pipe = resource_is_pipe_type(pipe_ctx, OPP_HEAD),
>  				.stream = pipe_ctx->stream,
>  			}
