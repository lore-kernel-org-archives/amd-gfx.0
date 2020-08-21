Return-Path: <SRS0=r7JW=B7=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9383C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 09:01:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FB15208DB
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Aug 2020 09:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tpg2dtXO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB15208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32C266EAA1;
	Fri, 21 Aug 2020 09:01:49 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C2F46EAA1
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 09:01:48 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id c15so1220156wrs.11
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Aug 2020 02:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=reply-to:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding:content-language;
 bh=EqwbVtdv0WpykUgTZMjexr7MwLbGa2XD26yTHMRISu0=;
 b=tpg2dtXOqRmjbn+Ti1agx+KjewYA3/M3yHFIJUcXHSu7y4MYqaQzEBawWEV3wAiYeM
 BjQJbhi4AmHA8/NDBxboZ+p/CCgkFM5ZtqPJeTkIryvW6MjIiYOYvYuhtFpBbUUyf7ZQ
 SAJ9SVbSvfuSERHsf6knZfPRU+M7L/qphjD8Kmoi6WVRz2RF+DxRWWTAO+m4DLGh5VUM
 tueGX3EGA918iiyLuBFJewUXstZ63VO4uy9J1sUZovobugwRDMqjHGGKBARxX1Ue5qX9
 VAk8hjPP6HWHriWM+eiq88tx+Lps93UfD8PqgwI/l5b6yJ9cdwaJmqFpcfxl1qZ6LAno
 OZNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=EqwbVtdv0WpykUgTZMjexr7MwLbGa2XD26yTHMRISu0=;
 b=HA2icWDDNVr/UfPVKsYQ8PQf1zJakhoByVvFVHEXmrOAHCljUFpIgdu6gHvIA5qtNi
 o1NuT089N1f6SevJX8rKV8WDcMrxPhRqexPTbOCpz7YCzt9BLReR9sDW/HaT/XCuR0/n
 awelg/C/bGcKujtiYmq/LmdQ9wN7/f8l9wYhLZhHeyDNu8/ZiXmYlZOPf5n/nynIXhZF
 ACjT8YwcBr5yKISeudX+ijJsaCFAGgkeYortV+qUGhjSu0CkNaik1Sx/6//Up/9ygO1e
 +odEhdIkEbwpoXaY+vuBoXAN4bADZMRY3fqR6qfwmwVfmzAqcRoXG6D5PgqeMjwD7tKs
 7Y8Q==
X-Gm-Message-State: AOAM5336h43oswSBFPEWJV8Sx4/vX5EbPLVdrN/2juJVIM5MXOApJXkM
 GUzRJkt3AZ2RlyvPJOW7JHivH1bCn0M=
X-Google-Smtp-Source: ABdhPJwEyCf8CJR4/t/HegS2edoU35+AIKGuf9cZOCYH5ng4QTXc7TvsnY3FDkHP82bD2FR/d7OX/A==
X-Received: by 2002:a5d:460c:: with SMTP id t12mr1885775wrq.334.1598000506782; 
 Fri, 21 Aug 2020 02:01:46 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7?
 ([2a02:908:1252:fb60:be8a:bd56:1f94:86e7])
 by smtp.gmail.com with ESMTPSA id x14sm3469410wmj.37.2020.08.21.02.01.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Aug 2020 02:01:46 -0700 (PDT)
Subject: Re: [PATCH] drm/amdgpu: skip scheduling IBs when GPU recovery
To: Dennis Li <Dennis.Li@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com, felix.kuehling@amd.com, Hawking.Zhang@amd.com,
 christian.koenig@amd.com
References: <20200821085716.17887-1-Dennis.Li@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <0c97b54d-5ed7-666b-d2a9-6a46fe3972df@gmail.com>
Date: Fri, 21 Aug 2020 11:01:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821085716.17887-1-Dennis.Li@amd.com>
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
Reply-To: christian.koenig@amd.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 21.08.20 um 10:57 schrieb Dennis Li:
> If GPU begin to do recovery, skip scheduling IBs. Otherwise
> GPU recovery randomly fail.

NAK, this is prevented by stopping the scheduler during GPU recovery.

If you see jobs submitted to the hardware while we recover the GPU then 
the scheduler is re-started to early.

Regards,
Christian.

>
> Signed-off-by: Dennis Li <Dennis.Li@amd.com>
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index dcfe8a3b03ff..054d7b0357fd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -212,6 +212,7 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   	struct dma_fence *fence = NULL, *finished;
>   	struct amdgpu_job *job;
>   	int r = 0;
> +	int locked;
>   
>   	job = to_amdgpu_job(sched_job);
>   	finished = &job->base.s_fence->finished;
> @@ -220,6 +221,10 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   
>   	trace_amdgpu_sched_run_job(job);
>   
> +	locked = down_read_trylock(&ring->adev->reset_sem);
> +	if (!locked)
> +		dma_fence_set_error(finished, -ECANCELED);/* skip IB as well if GPU recovery */
> +
>   	if (job->vram_lost_counter != atomic_read(&ring->adev->vram_lost_counter))
>   		dma_fence_set_error(finished, -ECANCELED);/* skip IB as well if VRAM lost */
>   
> @@ -231,6 +236,10 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   		if (r)
>   			DRM_ERROR("Error scheduling IBs (%d)\n", r);
>   	}
> +
> +	if (locked)
> +		up_read(&ring->adev->reset_sem);
> +
>   	/* if gpu reset, hw fence will be replaced here */
>   	dma_fence_put(job->fence);
>   	job->fence = dma_fence_get(fence);

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
