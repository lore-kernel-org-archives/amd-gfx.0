Return-Path: <SRS0=x6gI=KI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53EF6C433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 08:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3BCC61106
	for <amd-gfx@archiver.kernel.org>; Thu, 13 May 2021 08:11:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3BCC61106
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D3726E85F;
	Thu, 13 May 2021 08:11:39 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 654396E85F
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 08:11:38 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id i13so96472edb.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 May 2021 01:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=krg2ETWfavKn6K6/flxRZnkx7wWu/idP7vPIcLctMYo=;
 b=BjiOZMqwzKIX+dr7PgMuAiMhlRjyp6XIzc+2rRE9zAlZnZwoUw76JzSKt89hHzxbSI
 Oba3vdo7NndhkQrV4WJcXhTWdO21TAxpT0ZWsgB88OamhS78e5cjotkml6oVJ7H6Pwki
 zLbZFgKsEU3J7oyRbEdhUm0p1CXxlHAALkOGs57z3Zzp5ofDXbQQL45NTSZWWOiKyxVB
 Fzf9V2STZzZmdEImRh7q0EokXwRrpcrDYxmV66BCCT01DMcRhJUW8K7L/J+LE2YMaqwX
 7YOq/sd4z2OYVtyijeo0aIGzQySna5T/X7CmdJQt9z4a5bWvM2dq/ZqMAxiRd97ImVFQ
 /6CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=krg2ETWfavKn6K6/flxRZnkx7wWu/idP7vPIcLctMYo=;
 b=UfloFpwtfXMCkG/AUBxc/LpEOIkZMC5XmOxSOQftcmOu0Lle242TbShqLZ+epGgIjq
 XA9X+FsVlBS+DdATly07R3F/Qe4A/3uf9U9jwwKpUJOO5WsRmlguweLgpOFSfsZ87c/a
 UnsMXh4Pwfa+EA+SBn52ef8D+G9bk21jAWuvjxEKwbl0EoZT8GCw1skkPhKgsvH7EVi1
 C+zlxVE0aipFNqMiuw+X2RvwLtNlDnOdNbK2Ak3NI6tlsaiRGEKW+tPYjAzNLAV2S0jQ
 +SpwXZpdG4AmltSQPIFbXkPrpiJcc1VYkd7+aQNytMQ8NZbSPMKACZ6W0pFFyIHesrhi
 EA4Q==
X-Gm-Message-State: AOAM531uD4a5GYBiYTTyqgv26EJsKa5QjXC3MAhvyTOAC44dANPSZOoG
 vxzcmWLsO0DZ7jRVb90hn18SmvDwu9I=
X-Google-Smtp-Source: ABdhPJzLnlbd1U2rpEcRV8m9Rz+xnJj1Yu15Jl8nHrj91rgZDNHFGRyubQqqrkEzU4uh91Xsyqw49w==
X-Received: by 2002:a05:6402:128f:: with SMTP id
 w15mr2719076edv.354.1620893497135; 
 Thu, 13 May 2021 01:11:37 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:1e3f:7b0a:2eb9:c6dc?
 ([2a02:908:1252:fb60:1e3f:7b0a:2eb9:c6dc])
 by smtp.gmail.com with ESMTPSA id y17sm1415315ejc.79.2021.05.13.01.11.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 May 2021 01:11:36 -0700 (PDT)
Subject: Re: [PATCH 2/2] drm/amdgpu: fix fence calculation
To: David M Nieto <david.nieto@amd.com>, amd-gfx@lists.freedesktop.org
References: <f689c523-c60a-a0d2-ca6a-5dcb043ffc91@gmail.com>
 <20210512194527.7687-1-david.nieto@amd.com>
 <20210512194527.7687-2-david.nieto@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <a5c987b3-e2bf-7c80-3362-fe3e6cb1d44c@gmail.com>
Date: Thu, 13 May 2021 10:11:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210512194527.7687-2-david.nieto@amd.com>
Content-Language: en-US
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 12.05.21 um 21:45 schrieb David M Nieto:
> The proper metric for fence utilization over several
> contexts is an harmonic mean, but such calculation is
> prohibitive in kernel space, so the code approximates it.
>
> Because the approximation diverges when one context has a
> very small ratio compared with the other context, this change
> filter out ratios smaller that 0.01%
>
> Signed-off-by: David M Nieto <david.nieto@amd.com>
> Change-Id: I5b6e0ce5f489a5f55855d35354a6a3653e9d613b

Looks good to me now, but the automated tools complain about "DOS line 
endings" plus a couple of other nit picks and won't let me push it :)

Please use the checkpatch.pl script found in the Linux kernel to fix 
those errors and resend.

Thanks,
Christian.

> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 17 +++++++++++++++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  1 +
>   2 files changed, 16 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 9036c93b4a0c..b919615e6644 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -652,12 +652,14 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
>   	mutex_destroy(&mgr->lock);
>   }
>   
> -void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entity *centity,
> +static void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx, struct amdgpu_ctx_entity *centity,
>   		ktime_t *total, ktime_t *max)
>   {
>   	ktime_t now, t1;
>   	uint32_t i;
>   
> +	*total = *max = 0;
> +
>   	now = ktime_get();
>   	for (i = 0; i < amdgpu_sched_jobs; i++) {
>   		struct dma_fence *fence;
> @@ -703,11 +705,22 @@ ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
>   	idp = &mgr->ctx_handles;
>   	mutex_lock(&mgr->lock);
>   	idr_for_each_entry(idp, ctx, id) {
> +		ktime_t ttotal, tmax;
> +
>   		if (!ctx->entities[hwip][idx])
>   			continue;
>   
>   		centity = ctx->entities[hwip][idx];
> -		amdgpu_ctx_fence_time(ctx, centity, &total, &max);
> +		amdgpu_ctx_fence_time(ctx, centity, &ttotal, &tmax);
> +
> +		/* Harmonic mean approximation diverges for very small
> +		 * values. If ratio < 0.01% ignore
> +		 */
> +		if (AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(tmax, ttotal))
> +			continue;
> +
> +		total = ktime_add(total, ttotal);
> +		max = ktime_after(tmax, max) ? tmax : max;
>   	}
>   
>   	mutex_unlock(&mgr->lock);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> index 10dcf59a5c6b..3541dfb059ec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
> @@ -30,6 +30,7 @@ struct drm_file;
>   struct amdgpu_fpriv;
>   
>   #define AMDGPU_MAX_ENTITY_NUM 4
> +#define AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(max, total) (max > 16384ULL*total)
>   
>   struct amdgpu_ctx_entity {
>   	uint64_t		sequence;

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
