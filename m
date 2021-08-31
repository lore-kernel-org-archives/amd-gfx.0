Return-Path: <SRS0=0crs=NW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92439C4320E
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 12:59:08 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63E7561041
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 12:59:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 63E7561041
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E01F989B62;
	Tue, 31 Aug 2021 12:59:07 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AEAF89B62
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Aug 2021 12:59:06 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id d26so27660578wrc.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Aug 2021 05:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GjgE1dFQ4edJ2v2xHPe4TXgqcSr49ue1mbAkTOPjv74=;
 b=ZUYsZ29QMPbBf9l6ZMTp2RIE2kWanliC4hDcCXgqRstqmgseZ0sa9W5ZCxLvGP6Xle
 SUx3I5xd2A0O540+fiR5g1scFuFE+at0mUdj6arosfSdwnfrBDyk+5oKWA0DX0J+GIBB
 5lmBzRGEaRDyhZ7Is8Nd6i2j0mkXPFAEDEfhw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GjgE1dFQ4edJ2v2xHPe4TXgqcSr49ue1mbAkTOPjv74=;
 b=M/DQNu0F8tGGF/Znc7dZr+O4Q9CtPCL8rBjyRzVlWBk+um2QafF0fXZMMXyaJX96Wz
 oJaCQBcJqOYjnHkvD4VOuy9By0y+riDrRX8KhtyxK1oSJ/bmkGLwH5gQ4+jkdvUlbt8v
 ubgg5rzGckUxztkz5EYcaTuWST2TRdWucJxLGGR5JGOh2hP6xSoeJnLbQTpwd4WHw4zB
 1mxiE2bGp4FJh7F9UMa3KKLpX7Yr43CNjG+ARfPRkGCmiI/jxSS4llZi9xNKhtxC9vFk
 xC5cMlZgOPPYnov/K5UUvDtE4vmPLdWhJhsnmvxGQN7zEpwTo5jnsZRNP+oemmvfrEqH
 Lzww==
X-Gm-Message-State: AOAM530mo5kbWPzCkBbOyyWj+JkEjslwYkxGxITvfefL++y6zqBmyYiL
 J2nKM2437j0IbnN7mYRycNI5bpDH0UXLLg==
X-Google-Smtp-Source: ABdhPJxfFSaHSLUaelLcEP0tNYSLCg+cj/6FLyt9gjCnVBmviUCT0iX/bUurdbH7SReQ9bw/ZIy/aQ==
X-Received: by 2002:a5d:456d:: with SMTP id a13mr31454642wrc.364.1630414744978; 
 Tue, 31 Aug 2021 05:59:04 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id j207sm2665547wmj.40.2021.08.31.05.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Aug 2021 05:59:04 -0700 (PDT)
Date: Tue, 31 Aug 2021 14:59:02 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Monk Liu <Monk.Liu@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 jingwen chen <jingwen.chen@amd.com>
Subject: Re: [PATCH 2/2] drm/sched: serialize job_timeout and scheduler
Message-ID: <YS4nlkpjeitiwFy1@phenom.ffwll.local>
References: <1630406139-19621-1-git-send-email-Monk.Liu@amd.com>
 <1630406139-19621-2-git-send-email-Monk.Liu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630406139-19621-2-git-send-email-Monk.Liu@amd.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
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

Can we please have some actual commit message here, with detailed
explanation of the race/bug/whatever, how you fix it and why this is the
best option?

On Tue, Aug 31, 2021 at 06:35:39PM +0800, Monk Liu wrote:
> tested-by: jingwen chen <jingwen.chen@amd.com>
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> Signed-off-by: jingwen chen <jingwen.chen@amd.com>
> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 24 ++++--------------------
>  1 file changed, 4 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index ecf8140..894fdb24 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -319,19 +319,17 @@ static void drm_sched_job_timedout(struct work_struct *work)
>  	sched = container_of(work, struct drm_gpu_scheduler, work_tdr.work);
>  
>  	/* Protects against concurrent deletion in drm_sched_get_cleanup_job */
> +	if (!__kthread_should_park(sched->thread))

This is a __ function, i.e. considered internal, and it's lockless atomic,
i.e. unordered. And you're not explaining why this works.

Iow it's probably buggy, and an just unconditionally parking the kthread
is probably the right thing to do. If it's not the right thing to do,
there's a bug here for sure.
-Daniel

> +		kthread_park(sched->thread);
> +
>  	spin_lock(&sched->job_list_lock);
>  	job = list_first_entry_or_null(&sched->pending_list,
>  				       struct drm_sched_job, list);
>  
>  	if (job) {
> -		/*
> -		 * Remove the bad job so it cannot be freed by concurrent
> -		 * drm_sched_cleanup_jobs. It will be reinserted back after sched->thread
> -		 * is parked at which point it's safe.
> -		 */
> -		list_del_init(&job->list);
>  		spin_unlock(&sched->job_list_lock);
>  
> +		/* vendor's timeout_job should call drm_sched_start() */
>  		status = job->sched->ops->timedout_job(job);
>  
>  		/*
> @@ -393,20 +391,6 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
>  	kthread_park(sched->thread);
>  
>  	/*
> -	 * Reinsert back the bad job here - now it's safe as
> -	 * drm_sched_get_cleanup_job cannot race against us and release the
> -	 * bad job at this point - we parked (waited for) any in progress
> -	 * (earlier) cleanups and drm_sched_get_cleanup_job will not be called
> -	 * now until the scheduler thread is unparked.
> -	 */
> -	if (bad && bad->sched == sched)
> -		/*
> -		 * Add at the head of the queue to reflect it was the earliest
> -		 * job extracted.
> -		 */
> -		list_add(&bad->list, &sched->pending_list);
> -
> -	/*
>  	 * Iterate the job list from later to  earlier one and either deactive
>  	 * their HW callbacks or remove them from pending list if they already
>  	 * signaled.
> -- 
> 2.7.4
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
