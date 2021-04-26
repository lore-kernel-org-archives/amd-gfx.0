Return-Path: <SRS0=K+jV=JX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43319C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 06:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB59861027
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 06:49:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB59861027
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A55A89FC0;
	Mon, 26 Apr 2021 06:49:16 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B6A189FC0
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 06:49:15 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id ja3so6876849ejc.9
 for <amd-gfx@lists.freedesktop.org>; Sun, 25 Apr 2021 23:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=qXq+w1lEkDI7dVZMQDYXa/JSwTcgXlJBhIvbj7vIkX0=;
 b=q8lA0+eCBd2vz0+b4XC/7LhrbWsYGHOxF5zU0Y2xyYFxiB3TVUJgRyUYayqPZE9/di
 MFOz/H4mJj4b+FwR1dH/+eHBNEL9bSugtJRac6tn6hGCVajJaGglgqB/gPpdmGOdImFZ
 af8bqspyY6WSjI/vvrGn0HZV/3bMJHCmG17ywpPEarQ5yC0V6Dy1jc8HuJ1x+M6jgAcg
 IEwRRLFNxNo7OebmnDenlXKQcGrH1Y1egt7EvSVf0seU1GkrURIrylC8JkpMm/qo3VwW
 ff3k6h1J+Lu51p6MfW/7COwKWZwSB00QH++I6C1IoijoHVe6pniUJc3zq+isHcpKaZZu
 6Kiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=qXq+w1lEkDI7dVZMQDYXa/JSwTcgXlJBhIvbj7vIkX0=;
 b=WoNnvp0u6MhWUSLab8BTR3TfRIAVIqKCLNhBEN7Xxei+O4V6BHbhozTfXq7c5PHD8Q
 vgeFJN8faWMBVrSrLb6/tenuu5uo3glfZK1n+Qh549jFj6lDsaZYX7VqB/IyEheqGQ30
 SWga5E37OllMbkiLkfBymUfPWca8YW0vi7aGOjbmOvSNMnzqQrezSr00myMa7eM549CD
 gGST5nxdRdu9PaljTTpgzY8E2vmorNVwNeVZfbml5o5OE5Ew+OeOlskLzGWeLFtiwQqe
 P+mwSGK0ely0TwGQYSuzdj9VnT3q4rAkwa3uN7rK250RbhnPurMWfIRiEoINNfY7S2Zo
 quvA==
X-Gm-Message-State: AOAM5314gebQZ0zlanr0I6vm9vcgGV3LnD4NdDyjvOdVYtqwltdyBWQG
 f0oyP4Xlhpxr6uW+Nu2FnZxtzqrFxeg=
X-Google-Smtp-Source: ABdhPJxM73OmuOiqgVHYi+U/dVUMVzmW4QjpBV6tBt6Y577N0rP5TQKYSj/zZD+mdPxSpQquLlUP4Q==
X-Received: by 2002:a17:906:e118:: with SMTP id
 gj24mr6007440ejb.205.1619419753823; 
 Sun, 25 Apr 2021 23:49:13 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:ddf1:e741:577e:9eb2?
 ([2a02:908:1252:fb60:ddf1:e741:577e:9eb2])
 by smtp.gmail.com with ESMTPSA id 9sm10690894ejv.73.2021.04.25.23.49.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Apr 2021 23:49:13 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track
To: Alex Deucher <Alexander.Deucher@amd.com>
References: <20210426062701.39732-1-Roy.Sun@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8b8ec884-5b0b-3409-b7b0-be7da43e3e71@gmail.com>
Date: Mon, 26 Apr 2021 08:49:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <20210426062701.39732-1-Roy.Sun@amd.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, Roy Sun <Roy.Sun@amd.com>,
 David M Nieto <david.nieto@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hey Alex,

any objections that we merge those two patches through drm-misc-next?

Thanks,
Christian.

Am 26.04.21 um 08:27 schrieb Roy Sun:
> Update the timestamp of scheduled fence on HW
> completion of the previous fences
>
> This allow more accurate tracking of the fence
> execution in HW
>
> Signed-off-by: David M Nieto <david.nieto@amd.com>
> Signed-off-by: Roy Sun <Roy.Sun@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 92d8de24d0a1..f8e39ab0c41b 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -515,7 +515,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_scheduler *sched)
>   EXPORT_SYMBOL(drm_sched_resubmit_jobs);
>   
>   /**
> - * drm_sched_resubmit_jobs_ext - helper to relunch certain number of jobs from mirror ring list
> + * drm_sched_resubmit_jobs_ext - helper to relaunch certain number of jobs from pending list
>    *
>    * @sched: scheduler instance
>    * @max: job numbers to relaunch
> @@ -671,7 +671,7 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sched)
>   static struct drm_sched_job *
>   drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
>   {
> -	struct drm_sched_job *job;
> +	struct drm_sched_job *job, *next;
>   
>   	/*
>   	 * Don't destroy jobs while the timeout worker is running  OR thread
> @@ -690,6 +690,14 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
>   	if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
>   		/* remove job from pending_list */
>   		list_del_init(&job->list);
> We just need to record the scheduled time of the next job. So we
> need not to check the rest job.
> +		/* account for the next fence in the queue */
> +		next = list_first_entry_or_null(&sched->pending_list,
> +				struct drm_sched_job, list);
> +		if (next && test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
> +			&job->s_fence->finished.flags)) {
> +			next->s_fence->scheduled.timestamp =
> +				job->s_fence->finished.timestamp;
> +		}
>   	} else {
>   		job = NULL;
>   		/* queue timeout for next job */

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
