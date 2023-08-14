Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C86C001DB
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Aug 2023 11:47:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6DD1D10E1AC;
	Mon, 14 Aug 2023 11:47:41 +0000 (UTC)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 021F610E1AC
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Aug 2023 11:47:39 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-31768ce2e81so3804041f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Aug 2023 04:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692013658; x=1692618458;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S1r3EMFBAgd0J34hofroD+Z+dNcSfcxVw4vLp3BnQ+0=;
 b=HtRuKtYpZcuuIvX1r5OeCNSkMPqDsUc5UOOdPh4pkpldjml95On+BL11Xt1jp8tO1u
 IGXs1evokTBWeSH42x9Dn/0kFIoZ3Q+CkamCybShzP7px6iRPPaQvlAHMgq8QLD9qVjR
 ixXI4lwWMuQKrevhOnokBR2qyrPeprXLpn5GgX2S3pe8gaClw4G0kRbXla/WGXHUWcQc
 KApPLHiDYF4Co+HS+XE4mn1jBWae/TZ3a9gqpqLNq+Jr+n6ksTZLImyKXMHntn6ImW/v
 bK6dONodEgdcxCt0cVsTipv/5+F+mtXVyw1Qodl8rddkLngQPxvxxGsdvRfazW5tKTRb
 Bt/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692013658; x=1692618458;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S1r3EMFBAgd0J34hofroD+Z+dNcSfcxVw4vLp3BnQ+0=;
 b=gj4VclC9pAmPGMjXf3aMiv/enNfumfwfACvCULzv9yGEQZR8OhemoYfxeEsPOssonN
 l4Ey83WBI0Im/5tmFje//TfvbW90EuZ+NH/s0tyhaVV5JfyejNqqgA4YEiP+uVzUccRZ
 gO8yqqZWatrEoKpUrPLTGv+LI6fe3FNA8L9VmUWYhHqXCFJsESCpp59Fy5Ts3bIF29On
 olaKuQUHNJl5uy7sm/BedaiIcxRDLLEhRiwmXlyjygcN6pZPLlBYywUsF1ieGodOdKeA
 O2aY8xoXZ2tkpK61ceZT9ddJ993VbbQBvHyumzOie+RUHmHp28NVHNormtAsEKRsUl5P
 xZPg==
X-Gm-Message-State: AOJu0YzcKwEs2rWwMIXp0O7zlfsnpAQjFqwPuItxf3hAhHwkNi2EcB+P
 mcTGpRkFO13sF6zSOSPOyfQ=
X-Google-Smtp-Source: AGHT+IHy86L2IieFKl7xMgG5bIkQI5GgPyL9p6iUF3z/Y/ersWKgNcwEagJO1xPVdveB+tn8S02uWQ==
X-Received: by 2002:a5d:4391:0:b0:317:6175:95fd with SMTP id
 i17-20020a5d4391000000b00317617595fdmr7510044wrq.43.1692013658054; 
 Mon, 14 Aug 2023 04:47:38 -0700 (PDT)
Received: from ?IPV6:2a00:e180:15dd:7200:9d2f:13e2:542c:d8b4?
 ([2a00:e180:15dd:7200:9d2f:13e2:542c:d8b4])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a5d4690000000b00313de682eb3sm14089174wrq.65.2023.08.14.04.47.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Aug 2023 04:47:37 -0700 (PDT)
Message-ID: <c0b5feaf-d3c8-038b-2b8f-3eda05e15f09@gmail.com>
Date: Mon, 14 Aug 2023 13:47:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drm/amd/display: Fix unnecessary conversion to bool in
 'amdgpu_dm_setup_replay'
Content-Language: en-US
To: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Harry Wentland <harry.wentland@amd.com>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
References: <20230813083616.519118-1-srinivasan.shanmugam@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20230813083616.519118-1-srinivasan.shanmugam@amd.com>
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
Cc: amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 13.08.23 um 10:36 schrieb Srinivasan Shanmugam:
> Fixes the following coccicheck:
>
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c:94:102-107: WARNING: conversion to bool not needed here
> drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c:102:72-77: WARNING: conversion to bool not needed here
>
> Cc: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
> Cc: Harry Wentland <harry.wentland@amd.com>
> Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
> Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
> index 32d3086c4cb7..5ce542b1f860 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_replay.c
> @@ -91,7 +91,7 @@ bool amdgpu_dm_setup_replay(struct dc_link *link, struct amdgpu_dm_connector *ac
>   	pr_config.replay_supported = true;
>   	pr_config.replay_power_opt_supported = 0;
>   	pr_config.replay_enable_option |= pr_enable_option_static_screen;
> -	pr_config.replay_timing_sync_supported = aconnector->max_vfreq >= 2 * aconnector->min_vfreq ? true : false;
> +	pr_config.replay_timing_sync_supported = aconnector->max_vfreq >= 2 * aconnector->min_vfreq;
>   
>   	if (!pr_config.replay_timing_sync_supported)
>   		pr_config.replay_enable_option &= ~pr_enable_option_general_ui;
> @@ -99,7 +99,7 @@ bool amdgpu_dm_setup_replay(struct dc_link *link, struct amdgpu_dm_connector *ac
>   	debug_flags = (union replay_debug_flags *)&pr_config.debug_flags;
>   	debug_flags->u32All = 0;
>   	debug_flags->bitfields.visual_confirm =
> -		link->ctx->dc->debug.visual_confirm == VISUAL_CONFIRM_REPLAY ? true : false;
> +		link->ctx->dc->debug.visual_confirm == VISUAL_CONFIRM_REPLAY;
>   
>   	link->replay_settings.replay_feature_enabled = true;
>   

