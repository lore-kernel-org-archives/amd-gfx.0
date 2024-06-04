Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C83C25B78
	for <amd-gfx@archiver.kernel.org>; Tue,  4 Jun 2024 14:22:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F348610E493;
	Tue,  4 Jun 2024 14:22:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D5Kl5nwx";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 232D510E493
 for <amd-gfx@lists.freedesktop.org>; Tue,  4 Jun 2024 14:22:18 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-42147970772so6953715e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 04 Jun 2024 07:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1717510936; x=1718115736; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=c48IIGpCOY2vC2yaa97wIZtG0vRwlfKfW3z8IZUGT/8=;
 b=D5Kl5nwxBKW7TouvTmyKEaqSZhldnlSHHPUUt6HaMopbPlC9NJBC3Li1IF11vEv2Qz
 RrJ3KHMPduiS+WbIbXSj2beCd1VPzb/2e+mlKc8YXhajg7xg7x7U6sgO0Kw5A+Gx3E3M
 OuCKXNkjN80BbWXRY3hPaJ2LjppIBgrBtbxRDfmLIpnNicpsdkfrEfNbUHk9cKsyvZ2p
 c9RuBOKM5nOy1yTNT3SIK+Iwa2xiubatEcLZvb6j3AHuaHFLnTpRAiBwJJCebGBPi8lJ
 oYHKToVMjLL5XBJUg8izH3mnFxF5S/D0JnVrfUREBkoRn0hIREKWkcfteY0kxv2425fG
 sDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717510936; x=1718115736;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c48IIGpCOY2vC2yaa97wIZtG0vRwlfKfW3z8IZUGT/8=;
 b=RsRzVTrCnRaZ/ti6vLVeukYEIU3Tn1xCmISCFxkDpMm9wqqzLGRTTqEwLI6or7zfuI
 tRrRPLKrsUvkWeSJtSD8soVLLpHoFOHj0D744gW8fgsT9RMSVdJmQSbiT9eeSPKKd2DE
 3IlH2YjCCZocuGBmQA0eGApjzS8Cm6xt2AjwfGURsdNrK0Aza0o9CFD8dhreSgndleSw
 uk+oRGxpEeFwHOwbifZJqD/EHzjQsNy63vph8HMf66r6Y98PB2NDo34zu8eENK86/5fw
 LBOxJtofC9ABYRamld0ze1BjNqFA7HTzuBUDucdL3ctqDWeZmVOhjlHajee1n11NGMDK
 nPIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUChWqzoEBy4/wu7HH/lPohlfHv0wHXzpI1hQtuKDcpLoigiovXCmFcgsWEU1Hshbxm3/weW4r2MMqWe5c6ATeSZqtHGQBFNGYoaJXvLA==
X-Gm-Message-State: AOJu0YzpFbf8UY8+DXr0mQGVYIvOhuZQsDt/j7V+UthDKpmJSM0zMnjs
 8Fxx/p/ZRdFWSm3c6iUgACIngf/xdOC8jaMIEmP1+zZzK5aaPG2U
X-Google-Smtp-Source: AGHT+IFA98Y8AZQJjwp2+RgFfhjSL1XOwSEUfS70wzbCxu+GL0QQC4dX3GmhCqlSKbPIuPE88GdYjQ==
X-Received: by 2002:a05:600c:4fc8:b0:421:182d:9232 with SMTP id
 5b1f17b1804b1-4212e0619b0mr117999365e9.18.1717510935986; 
 Tue, 04 Jun 2024 07:22:15 -0700 (PDT)
Received: from [10.254.108.81] (munvpn.amd.com. [165.204.72.6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4212b8a4f83sm157132035e9.29.2024.06.04.07.22.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jun 2024 07:22:15 -0700 (PDT)
Message-ID: <9830fdd9-c738-4b9f-9ecb-2ed83a855243@gmail.com>
Date: Tue, 4 Jun 2024 16:22:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: use GFP_ATOMIC for bounding box
To: Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: George Zhang <george.zhang@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com
References: <20240604135015.479910-1-alexander.deucher@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <20240604135015.479910-1-alexander.deucher@amd.com>
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

Am 04.06.24 um 15:50 schrieb Alex Deucher:
> This can be called in atomic context.  Should fix:
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

That most likely only papers over the real problem and is not a valid fix.

The question is why is that an atomic context?  If the function is used 
under a spinlock then this might indeed be the right fix.

If it's because of floating point operation then that here won't work 
either.

In that case the only real fix is to avoid the allocation altogether.

Regards,
Christian.

>
> Fixes: 88c61827cedc ("drm/amd/display: dynamically allocate dml2_configuration_options structures")
> Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
> Cc: George Zhang <george.zhang@amd.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: harry.wentland@amd.com
> Cc: sunpeng.li@amd.com
> Cc: Rodrigo.Siqueira@amd.com
> ---
>   drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c  | 2 +-
>   .../gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c    | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> index 0f11d7c8791c..3fe0d5334145 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
> @@ -2009,7 +2009,7 @@ static void dcn32_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw
>   {
>   	struct dml2_configuration_options *dml2_opt;
>   
> -	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_KERNEL);
> +	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_ATOMIC);
>   	if (!dml2_opt)
>   		return;
>   
> diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> index 07ca6f58447d..a61cf5741275 100644
> --- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> +++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
> @@ -1583,7 +1583,7 @@ static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *b
>   {
>   	struct dml2_configuration_options *dml2_opt;
>   
> -	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_KERNEL);
> +	dml2_opt = kmemdup(&dc->dml2_options, sizeof(dc->dml2_options), GFP_ATOMIC);
>   	if (!dml2_opt)
>   		return;
>   

