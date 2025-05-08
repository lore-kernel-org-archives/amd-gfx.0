Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D995DC3ABBE
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 09:51:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8964810E37B;
	Thu,  8 May 2025 09:51:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="khmxbKta";
	dkim-atps=neutral
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C2A710E37B
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 09:51:43 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-7c5b8d13f73so103961485a.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 May 2025 02:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746697903; x=1747302703; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VY6dQk0C7GhlCVGctU9yONnVqsod2WR/DN8syTnFbKY=;
 b=khmxbKtaArzRXE3PRm5qPAgLH3mOteJhXVbFFsxewps8KgbvEfGXuBbHFGhNVu0Up1
 00wv9aR77noABU+ecEUt6QXStdFfRTNxnpEZUc3gfUtThclqvZk1LARPB3BB4TwrACeV
 DB9u2WjZwxZZ9V+emFc3uco6JUn47g6tguDxa2o82nizD00Zv1dH0Suuhvj8j9DCmb6j
 eeC7eNhMUjlc85I6WrbgpHUaPLGpVTV5WtNZew8cWTSltu8JbF4L9LZm0i3Aqh6j4DsD
 4PX+ARWqUTN1780zAjatCCvrlt30bemnhfJXegFZLNnrZksXk5rB1ctoeDqqnO5wul9g
 kSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746697903; x=1747302703;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VY6dQk0C7GhlCVGctU9yONnVqsod2WR/DN8syTnFbKY=;
 b=LGopCQilJdSosFy9VbJLyW6jslxe7DuG57YIOGhLisDeOI0RfvB1uF3ZfE373jUCDl
 YyeHDhxMjzSlM1dFdEnhDDcW8++CJTEPhJeAA+zXtzEHRv1kS6hVPTkwYzWurorUMI/j
 wOPWQLnYk2VRHCjnDDV6EmTSUehVPgvA0PfjHha0QJFnnDEZ4XWw/pc5CYfwiFjcUvTX
 GAjHSlOR9rTF25rsj3/9GsAmTQisGJ9D+r5ZfVBk2Ka6zvVQIic9PgKObWUuknYaFe2m
 e7us5nMIu1Of5aUpx4UODObmPhx8j9Z4fFdyCNTgDjnh95uBnof0zulswAhbuamqox30
 iAfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/AMxzCePZvfHLDdVNXOc5WEU7qpdq0JafRS/aJfq1o/9ez5aouPwur7mKh84b1WQ2vXFbspSZ@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwuxTJAcLzZf6t9yVA4tMP9Allsn9FgxrDgkRW0JGRBjDwvozWL
 /VPTsP9Iv+KmGtNLSFLzE0ah3fXvsC/tE1iuALhf/pmBCHDrwg5s
X-Gm-Gg: ASbGnctoY6vuMTIQrn2ThV1xbhu7G/w61dKPn81JjII6wQHizR9JJOCayw+zUTtGVXZ
 YPpmFliT7YE6LUwasNbxo55AAIG2rsMYHXeETkQE0+fCQzfzRBvpWCWxgmiHiCjDgQgb9Mt9dik
 QbHz3AsNzg7yLkD4fyP5GbIexNy0QDgWyN4O6QxbjgIoPIE7BsDnjASCKOaCSd7kE6s7dcpuk8n
 6Gzj557vqsc6R6ILms3ysRgl5NqDOY0N93AypmwExslNAWI5326NElkw5/8tBslSE7Ejeiw1/RM
 hG4CbtiNu/V496VMILPw2+BA0kyXtd7ia6em0LDiyAFJHJEBpg==
X-Google-Smtp-Source: AGHT+IFPmdNKQKOQFonydGpDfxAEqSew9khCkBKKWDbJ9pE5CFruX7S52sz60cdWyz75bldaeFy8Xw==
X-Received: by 2002:a05:620a:4456:b0:7ca:cd88:9b33 with SMTP id
 af79cd13be357-7ccf9e2370emr346712985a.28.1746697902641; 
 Thu, 08 May 2025 02:51:42 -0700 (PDT)
Received: from [192.168.1.100] ([32.220.111.111])
 by smtp.googlemail.com with ESMTPSA id
 af79cd13be357-7caf752b64csm336678285a.47.2025.05.08.02.51.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 02:51:42 -0700 (PDT)
Message-ID: <1db948ed-b2e4-422d-a182-6aea8462c275@gmail.com>
Date: Thu, 8 May 2025 05:51:41 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] drm/amd/display: Defer BW-optimization-blocked DRR
 adjustments
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Ray Wu <ray.wu@amd.com>,
 Leo Li <sunpeng.li@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>,
 Fangzhi Zuo <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20250507024242.1928299-1-ray.wu@amd.com>
 <20250507024242.1928299-6-ray.wu@amd.com>
Content-Language: en-US
From: John Olender <john.olender@gmail.com>
In-Reply-To: <20250507024242.1928299-6-ray.wu@amd.com>
Content-Type: text/plain; charset=UTF-8
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

On 5/6/25 10:34 PM, Ray Wu wrote:
> From: John Olender <john.olender@gmail.com>
> 
> [Why & How]
> Instead of dropping DRR updates, defer them. This fixes issues where
> monitor continues to see incorrect refresh rate after VRR was turned off
> by userspace.
> 
> Fixes: 32953485c558 ("drm/amd/display: Do not update DRR while BW optimizations pending")
> Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3546
> 
> Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
> Signed-off-by: John Olender <john.olender@gmail.com>
> Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Signed-off-by: Ray Wu <ray.wu@amd.com>

Thank you for reviewing and revising the original patch.  This commit
message is a clear improvement over the original.

I do have a concern about the debug print clean up though.  Please see
below.

> ---
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  2 ++
>  drivers/gpu/drm/amd/display/dc/core/dc.c          | 13 ++++++++++---
>  2 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 36c16030fca9..5a38748703b3 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -374,6 +374,8 @@ get_crtc_by_otg_inst(struct amdgpu_device *adev,
>  static inline bool is_dc_timing_adjust_needed(struct dm_crtc_state *old_state,
>  					      struct dm_crtc_state *new_state)
>  {
> +	if (new_state->stream->adjust.timing_adjust_pending)
> +		return true;
>  	if (new_state->freesync_config.state ==  VRR_STATE_ACTIVE_FIXED)
>  		return true;
>  	else if (amdgpu_dm_crtc_vrr_active(old_state) != amdgpu_dm_crtc_vrr_active(new_state))
> diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
> index 528e6fd546c5..6ec22c0d5b97 100644
> --- a/drivers/gpu/drm/amd/display/dc/core/dc.c
> +++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
> @@ -441,9 +441,15 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
>  	 * Don't adjust DRR while there's bandwidth optimizations pending to
>  	 * avoid conflicting with firmware updates.
>  	 */
> -	if (dc->ctx->dce_version > DCE_VERSION_MAX)
> -		if (dc->optimized_required || dc->wm_optimized_required)
> +	if (dc->ctx->dce_version > DCE_VERSION_MAX) {
> +		if (dc->optimized_required || dc->wm_optimized_required) {
> +			if (!stream->adjust.timing_adjust_pending) {
> +				stream->adjust.timing_adjust_pending = true;
> +				DC_LOG_DEBUG("%s: deferring DRR update\n", __func__);
> +			}
>  			return false;
> +		}
> +	}

Printing the start of a string of blocked updates without also printing
the end can result in misleading debug messages.

The original patch got around this by spamming out a debug print for
every blocked update.  Not ideal, but it let me to keep the focus of the
patch on the fix itself.

If the spam from the original patch is too much and adding an end
message is too messy, please consider removing the debug message entirely.

Thanks,
John

>  
>  	dc_exit_ips_for_hw_access(dc);
>  
> @@ -3241,7 +3247,8 @@ static void copy_stream_update_to_stream(struct dc *dc,
>  
>  	if (update->crtc_timing_adjust) {
>  		if (stream->adjust.v_total_min != update->crtc_timing_adjust->v_total_min ||
> -			stream->adjust.v_total_max != update->crtc_timing_adjust->v_total_max)
> +			stream->adjust.v_total_max != update->crtc_timing_adjust->v_total_max ||
> +			stream->adjust.timing_adjust_pending)
>  			update->crtc_timing_adjust->timing_adjust_pending = true;
>  		stream->adjust = *update->crtc_timing_adjust;
>  		update->crtc_timing_adjust->timing_adjust_pending = false;

