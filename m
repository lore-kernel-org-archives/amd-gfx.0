Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42B43C27C52
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Jun 2024 09:07:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7DDF10E71A;
	Wed,  5 Jun 2024 09:07:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="V6S//nlr";
	dkim-atps=neutral
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com
 [209.85.208.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC62310E71A
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Jun 2024 09:07:18 +0000 (UTC)
Received: by mail-lj1-f181.google.com with SMTP id
 38308e7fff4ca-2e95a1f9c53so79478191fa.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Jun 2024 02:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717578437; x=1718183237; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=i6GR/CrjXOGjPhB5mzvAZ63lYu2KJM0n+UWnocEauFE=;
 b=V6S//nlrjq5tUmpeydMsa7J1zLwiYZVHZVZokdTqD4DxkOSwdB/I0aRfgycAM7+ynf
 ggfue0B3+keAcuI4iVdkFzcTOavMjmoFnQZHaj8FU9L5+guyFDocvOedc4WpST3L2KhL
 ldpWI5krlz9mCaQJpcSOAccR242uZ+DDgYxDwTdbCxOZ9O0KuTHoUWlm7/8Ke8/kgeS/
 VeIZHKp/+hOjwimu8n4h+KmZj6M7gvTMzm5fCLr6XbPEwn8xtkbLToLQvHpJON3/cWok
 MiZAIrBZ8BLCVw0GG1Z0Keyrx8fB/kZsy6D4KrHvkXh9HAkiwoyVUV48kTr20X55ph3O
 X3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717578437; x=1718183237;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i6GR/CrjXOGjPhB5mzvAZ63lYu2KJM0n+UWnocEauFE=;
 b=WxN2+O7ubPVau27CXX0xb4PVXnk1QmzNiOuObwLwc0b7n4gEzipr2R/B8/SFpGUMZJ
 5HCQ+IhvQ74mH5R0smtvQyvTgHKgaoC/Xkchoe2xDCAkI6FW9lAEqZvdA2z2/wwKoB0x
 0cpCfToZNZhrExQz/Pk7vFV9MrsCYqaVy9Z3x5TwTNz/Lu8Kv3JNtV3SZkkcC1D7C1nQ
 fXmpv1OzVGIhRjOuH9nNFDyTIY31f2SrjJjTwsHJ6b3JOvBBpbZ5h2crKSl8CrSaWXZf
 BhYtJBmevB8/37bbaYNlQZLIREiwYi8z5a0K+D4cq5ccfVhVb/DLvZUrgLY3gq1mhPpc
 I9wQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoNR38fTz/WSLyh2+rVrOCzpojaapfGtZJU99NWHYwOHo03xUs5w90d2Og5swruImO+zNS2ezHTbkuMLpIgOF1n80aRWqvGZqUrU5nJQ==
X-Gm-Message-State: AOJu0YwBlUz4+2RYP+V384m8m9nDCLDGoacIEcoEmuCRD34XmQbOnUZH
 1IIhq+x83nuH1WxWa+mxRX8tfq4NFozo0mzmWZciWZ2LbyaGIYC4
X-Google-Smtp-Source: AGHT+IFkZM+GW4FyQX6D6WGOjJzWYiVyJLzE+usSo0oIWiU7br9bvf0vcf7m6+FtRuaFi9wAKKsJrg==
X-Received: by 2002:a2e:8791:0:b0:2e5:a9e:30c1 with SMTP id
 38308e7fff4ca-2eac79dcc3cmr9921461fa.15.1717578436858; 
 Wed, 05 Jun 2024 02:07:16 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215810826csm13434785e9.17.2024.06.05.02.07.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 02:07:16 -0700 (PDT)
Message-ID: <ccdd874a-6c65-4790-a17f-92c14812b710@gmail.com>
Date: Wed, 5 Jun 2024 11:07:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: use pre-allocated temp structure for
 bounding box
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>, George Zhang
 <george.zhang@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com
References: <20240604155027.542271-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240604155027.542271-1-alexander.deucher@amd.com>
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

Am 04.06.24 um 17:50 schrieb Alex Deucher:
> This mirrors what the driver does for older DCN generations.
>
> Should fix:
>
> BUG: sleeping function called from invalid context at include/linux/sched/mm.h:306
> in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 449, name: kworker/u64:8
> preempt_count: 2, expected: 0
> RCU nest depth: 0, expected: 0
> Preemption disabled at:
> ffffffffc0ce1580>] dc_fpu_begin+0x30/0xd0 [amdgpu]
> CPU: 5 PID: 449 Comm: kworker/u64:8 Tainted: G        W          6.8.0+ #35
> Hardware name: System manufacturer System Product Name/ROG STRIX X570-E GAMING WIFI II, BIOS 4204 02/24/2022
> Workqueue: events_unbound async_run_entry_fn
>
> Fixes: 88c61827cedc ("drm/amd/display: dynamically allocate dml2_configuration_options structures")
> Suggested-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: George Zhang <george.zhang@amd.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: harry.wentland@amd.com
> Cc: sunpeng.li@amd.com
> Cc: Rodrigo.Siqueira@amd.com

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>   drivers/gpu/drm/amd/display/dc/dc.h                       | 1 +
>   .../drm/amd/display/dc/resource/dcn32/dcn32_resource.c    | 8 +++-----
>   .../drm/amd/display/dc/resource/dcn321/dcn321_resource.c  | 8 +++-----
>   3 files changed, 7 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
> index d0ed01ac460d..d843933ad731 100644
> --- a/drivers/gpu/drm/amd/display/dc/dc.h
> +++ b/drivers/gpu/drm/amd/display/dc/dc.h
> @@ -1444,6 +1444,7 @@ struct dc {
>   	} scratch;
>   
>   	struct dml2_configuration_options dml2_options;
> +	struct dml2_configuration_options dml2_tmp;
>   	enum dc_acpi_cm_power_state power_state;
>   
>   };
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> index 0f11d7c8791c..7a8aa9396dea 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> @@ -2007,11 +2007,9 @@ void dcn32_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
>   
>   static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
>   {
> -	struct dml2_configuration_options *dml2_opt;
> +	struct dml2_configuration_options *dml2_opt = &dc->dml2_tmp;
>   
> -	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_KERNEL);
> -	if (!dml2_opt)
> -		return;
> +	memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
>   
>   	DC_FP_START();
>   
> @@ -2027,7 +2025,7 @@ static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw
>   
>   	DC_FP_END();
>   
> -	kfree(dml2_opt);
> +	memcpy(&dc->dml2_options, dml2_opt, sizeof(dc->dml2_options));
>   }
>   
>   static struct resource_funcs dcn32_res_pool_funcs = {
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> index 07ca6f58447d..ef30e8632607 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> @@ -1581,11 +1581,9 @@ static struct dc_cap_funcs cap_funcs = {
>   
>   static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
>   {
> -	struct dml2_configuration_options *dml2_opt;
> +	struct dml2_configuration_options *dml2_opt = &dc->dml2_tmp;
>   
> -	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_KERNEL);
> -	if (!dml2_opt)
> -		return;
> +	memcpy(dml2_opt, &dc->dml2_options, sizeof(dc->dml2_options));
>   
>   	DC_FP_START();
>   
> @@ -1601,7 +1599,7 @@ static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
>   
>   	DC_FP_END();
>   
> -	kfree(dml2_opt);
> +	memcpy(&dc->dml2_options, dml2_opt, sizeof(dc->dml2_options));
>   }
>   
>   static struct resource_funcs dcn321_res_pool_funcs = {

