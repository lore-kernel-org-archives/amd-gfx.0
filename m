Return-Path: <SRS0=FOdb=NQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215D8C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 06:31:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC884613A7
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Aug 2021 06:31:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DC884613A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 436BD6E151;
	Wed, 25 Aug 2021 06:31:46 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3132D6E151
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Aug 2021 06:31:44 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id g138so14210204wmg.4
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Aug 2021 23:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-transfer-encoding:content-language;
 bh=MV7C6QBTtytgqyej7np2RW4rfsUg7xWrATaGfFtkd1I=;
 b=fapmg0+XBtlVquaA3hAGn9uc8+PLiw/9yp1tnig8TiL+fvrtxOxP/jC7VgVTjfMk4A
 ygpbQTfVQTGZuxvSKYoGgt6UvBF8P3jWtWpE3UvajJt+PpyPIohBmdyjEBT7lNTZOnSY
 a6MfNy7D0GzVHt9bTOW4NOtCJnllftWePINVU3SY3tHiSFAJmmQ/Luur4B1wg1lK6mzQ
 XwqFnKBRnsVludbhYBkLJNb61eJR13WFpkC/yaBA7GDhQjQSbAo4M4ABLmwWOdCZGnMI
 pRjxlRhUnWIcjHeWcFoplOcZsiTFeRMLP49eR8Rn4Zm4k+3ofy5GtMbBLxdaalHI3vC0
 129Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=MV7C6QBTtytgqyej7np2RW4rfsUg7xWrATaGfFtkd1I=;
 b=Q5GQBEqsa33FzhV+AIDzSiD2sO6JDZ1LwU7e7bBiHejBlRKWJ5UMIF+Ve2BdOupTGl
 1wTCyfQf/A6lBhHuyov8jmpSD2PZaUjLPuyYGhsDpqu9v9hb1084eAUUegd7A7CJk771
 paYBxPDY66ivGgEecTDmTMoir1lGQKaafSwA9zZKd9mcU6iwfChZtkPfbrGQyqiu42oM
 gYogvtEseiHoJ1x51NEilEm0j5ZRmc+oD5u3Nsq9UVezGo/w+yAxQIvTb5BkEXmmcJv9
 xrc42u0kx3DftU7eDgnY9L5Oc6NwcX4yJvG4yZjnqakg7QvgmUepLGywrSutL/RjNIt1
 H4/Q==
X-Gm-Message-State: AOAM5307DGMwGlV6IMcX1jMUdjcTpIc8XSQS755UwTGCCRlc0utWgs7I
 W5q5mtPpFZ8Yqq83SK8nfQoF+3VIrZS76QHZ
X-Google-Smtp-Source: ABdhPJzVdRmoRlu8bwLtJq5TGwhfuTfxqbrS4ro/FeddX5HVQOHa5D0AXYJsLaim2zgnRSgtHQEyVA==
X-Received: by 2002:a05:600c:2e46:: with SMTP id
 q6mr354052wmf.93.1629873102750; 
 Tue, 24 Aug 2021 23:31:42 -0700 (PDT)
Received: from [192.168.178.21] (p5b0ea1b5.dip0.t-ipconnect.de.
 [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id r4sm3945107wmq.10.2021.08.24.23.31.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Aug 2021 23:31:42 -0700 (PDT)
Subject: Re: [PATCH] drm/sched: fix the bug of time out calculation(v2)
To: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org
References: <1629864857-4252-1-git-send-email-Monk.Liu@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <1ef452fc-1f76-8dda-1c74-c540576fe6c6@gmail.com>
Date: Wed, 25 Aug 2021 08:31:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <1629864857-4252-1-git-send-email-Monk.Liu@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Well NAK to that approach. First of all your bug analyses is incorrect.

The timeout started by queue_delayed_work() in drm_sched_start_timeout() 
is paired with the cancel_delayed_work() in drm_sched_get_cleanup_job().

So you must have something else going on here.

Then please don't use mod_delayed_work(), instead always cancel it and 
restart it.

Regards,
Christian.

Am 25.08.21 um 06:14 schrieb Monk Liu:
> the original logic is wrong that the timeout will not be retriggerd
> after the previous job siganled, and that lead to the scenario that all
> jobs in the same scheduler shares the same timeout timer from the very
> begining job in this scheduler which is wrong.
>
> we should modify the timer everytime a previous job signaled.
>
> v2:
> further cleanup the logic, and do the TDR timer cancelling if the signaled job
> is the last one in its scheduler.
>
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 29 ++++++++++++++++++++---------
>   1 file changed, 20 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index a2a9536..8c102ac 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -305,8 +305,17 @@ static void drm_sched_job_begin(struct drm_sched_job *s_job)
>   	struct drm_gpu_scheduler *sched = s_job->sched;
>   
>   	spin_lock(&sched->job_list_lock);
> -	list_add_tail(&s_job->list, &sched->pending_list);
> -	drm_sched_start_timeout(sched);
> +	if (list_empty(&sched->pending_list)) {
> +		list_add_tail(&s_job->list, &sched->pending_list);
> +		drm_sched_start_timeout(sched);
> +	} else {
> +		/* the old jobs in pending list are not finished yet
> +		 * no need to restart TDR timer here, it is already
> +		 * handled by drm_sched_get_cleanup_job
> +		 */
> +		list_add_tail(&s_job->list, &sched->pending_list);
> +	}
> +
>   	spin_unlock(&sched->job_list_lock);
>   }
>   
> @@ -693,17 +702,22 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
>   	if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
>   		/* remove job from pending_list */
>   		list_del_init(&job->list);
> +
>   		/* make the scheduled timestamp more accurate */
>   		next = list_first_entry_or_null(&sched->pending_list,
>   						typeof(*next), list);
> -		if (next)
> +		if (next) {
> +			/* if we still have job in pending list we need modify the TDR timer */
> +			mod_delayed_work(system_wq, &sched->work_tdr, sched->timeout);
>   			next->s_fence->scheduled.timestamp =
>   				job->s_fence->finished.timestamp;
> +		} else {
> +			/* cancel the TDR timer if no job in pending list */
> +			cancel_delayed_work(&sched->work_tdr);
> +		}
>   
>   	} else {
>   		job = NULL;
> -		/* queue timeout for next job */
> -		drm_sched_start_timeout(sched);
>   	}
>   
>   	spin_unlock(&sched->job_list_lock);
> @@ -791,11 +805,8 @@ static int drm_sched_main(void *param)
>   					  (entity = drm_sched_select_entity(sched))) ||
>   					 kthread_should_stop());
>   
> -		if (cleanup_job) {
> +		if (cleanup_job)
>   			sched->ops->free_job(cleanup_job);
> -			/* queue timeout for next job */
> -			drm_sched_start_timeout(sched);
> -		}
>   
>   		if (!entity)
>   			continue;

