Return-Path: <SRS0=0crs=NW=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DD3C432BE
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 14:03:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 428E8600CD
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Aug 2021 14:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 428E8600CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0CFA89BAE;
	Tue, 31 Aug 2021 14:03:37 +0000 (UTC)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D68089BF5
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Aug 2021 14:03:37 +0000 (UTC)
Received: by mail-wr1-x42d.google.com with SMTP id d26so28012352wrc.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Aug 2021 07:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=06uLh/LerTKW7N9aJQacbCqa4SbGSUiczdfVSnFq9TY=;
 b=Nd09bB+nM8FXA3XLER9R/+vOHKkE7PjGgnYuzIutdoP5O+mLst5Swc8PgMBfAdiMLl
 QicgYDiZCj0DvNq08gTuMfxc0QuzGJjcu1PQIBp9nlHksg5cPDQ1qCXWoFYtO44c6JAN
 +vBJAsGANtbHdwS1lcufbETsr32v8h+QzhSh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=06uLh/LerTKW7N9aJQacbCqa4SbGSUiczdfVSnFq9TY=;
 b=tiFBqMf/EnGieC+gxVWo6JbHlaT/gqvWwmFNUrmvzgzhbC/EccFl8KmbJG5i0qTCsz
 qnau6f2qV8hsYlsaq3OZclksXtphFT0aiFFgv4mgyaCyPkMKcsZxfNexOuGMhE5fN1Jn
 8x9mQ6+mz3VI57m4Zse9Anld3fE6NZjy1Wci0a9/yVUkE7ZFECLZoNXc3SbvJ64tDRp3
 4wD9bKWhA4icbAGwZM+CtvfXuN7lJUz/jM2WkX/NW48owdNwO73DmoFT4i3kfx3bpyxP
 soU8BHTlaDOn3sLqtd3UxgNE7v4UnkkQPtRCqrDxVnLZuOgZbgKUNPdM0aqDuQXv+l5e
 OczA==
X-Gm-Message-State: AOAM533kePhYyABV2iY1dnXeOg/zrgRRGLH11b4Xh7veTFd0jYCmwxiq
 rceyNtw7u7M+KzRwzj0mB4zeNQ==
X-Google-Smtp-Source: ABdhPJxzF0VkWonK+Ia276V1pqC0u0sROiCA57523MvRBQ5CfkRFsFluMm9/lPhJPHvBLxSaYKTYbQ==
X-Received: by 2002:adf:eb02:: with SMTP id s2mr31564197wrn.294.1630418615584; 
 Tue, 31 Aug 2021 07:03:35 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id h16sm18537538wre.52.2021.08.31.07.03.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Aug 2021 07:03:34 -0700 (PDT)
Date: Tue, 31 Aug 2021 16:03:32 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: Monk Liu <Monk.Liu@amd.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, jingwen chen <jingwen.chen@amd.com>
Subject: Re: [PATCH 2/2] drm/sched: serialize job_timeout and scheduler
Message-ID: <YS42tI6qAUb3yqOk@phenom.ffwll.local>
References: <1630406139-19621-1-git-send-email-Monk.Liu@amd.com>
 <1630406139-19621-2-git-send-email-Monk.Liu@amd.com>
 <29be989b-c2a5-69b3-f0b8-2df52f50047f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29be989b-c2a5-69b3-f0b8-2df52f50047f@amd.com>
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

On Tue, Aug 31, 2021 at 09:53:36AM -0400, Andrey Grodzovsky wrote:
> It's says patch [2/2] but i can't find patch 1
> 
> On 2021-08-31 6:35 a.m., Monk Liu wrote:
> > tested-by: jingwen chen <jingwen.chen@amd.com>
> > Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> > Signed-off-by: jingwen chen <jingwen.chen@amd.com>
> > ---
> >   drivers/gpu/drm/scheduler/sched_main.c | 24 ++++--------------------
> >   1 file changed, 4 insertions(+), 20 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> > index ecf8140..894fdb24 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -319,19 +319,17 @@ static void drm_sched_job_timedout(struct work_struct *work)
> >   	sched = container_of(work, struct drm_gpu_scheduler, work_tdr.work);
> >   	/* Protects against concurrent deletion in drm_sched_get_cleanup_job */
> > +	if (!__kthread_should_park(sched->thread))
> > +		kthread_park(sched->thread);
> > +
> 
> 
> As mentioned before, without serializing against other TDR handlers from
> other
> schedulers you just race here against them, e.g. you parked it now but
> another
> one in progress will unpark it as part of calling  drm_sched_start for other
> rings[1]
> Unless I am missing something since I haven't found patch [1/2]
> 
> [1] - https://elixir.bootlin.com/linux/latest/source/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c#L5041

You need to have your own wq and run all your tdr work on the same wq if
your reset has any cross-engine impact.

See

https://dri.freedesktop.org/docs/drm/gpu/drm-mm.html#c.drm_sched_backend_ops

for the ->timeout_job callback docs. I thought I brought this up already?
-Daniel

> 
> Andrey
> 
> 
> >   	spin_lock(&sched->job_list_lock);
> >   	job = list_first_entry_or_null(&sched->pending_list,
> >   				       struct drm_sched_job, list);
> >   	if (job) {
> > -		/*
> > -		 * Remove the bad job so it cannot be freed by concurrent
> > -		 * drm_sched_cleanup_jobs. It will be reinserted back after sched->thread
> > -		 * is parked at which point it's safe.
> > -		 */
> > -		list_del_init(&job->list);
> >   		spin_unlock(&sched->job_list_lock);
> > +		/* vendor's timeout_job should call drm_sched_start() */
> >   		status = job->sched->ops->timedout_job(job);
> >   		/*
> > @@ -393,20 +391,6 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
> >   	kthread_park(sched->thread);
> >   	/*
> > -	 * Reinsert back the bad job here - now it's safe as
> > -	 * drm_sched_get_cleanup_job cannot race against us and release the
> > -	 * bad job at this point - we parked (waited for) any in progress
> > -	 * (earlier) cleanups and drm_sched_get_cleanup_job will not be called
> > -	 * now until the scheduler thread is unparked.
> > -	 */
> > -	if (bad && bad->sched == sched)
> > -		/*
> > -		 * Add at the head of the queue to reflect it was the earliest
> > -		 * job extracted.
> > -		 */
> > -		list_add(&bad->list, &sched->pending_list);
> > -
> > -	/*
> >   	 * Iterate the job list from later to  earlier one and either deactive
> >   	 * their HW callbacks or remove them from pending list if they already
> >   	 * signaled.

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
