Return-Path: <SRS0=PfTh=NJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E8A2C4338F
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 14:43:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0994A610CB
	for <amd-gfx@archiver.kernel.org>; Wed, 18 Aug 2021 14:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0994A610CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F62F6E824;
	Wed, 18 Aug 2021 14:43:00 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E493A6E819
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Aug 2021 14:42:58 +0000 (UTC)
Received: by mail-wm1-x32d.google.com with SMTP id
 j12-20020a05600c1c0c00b002e6d80c902dso1930227wms.4
 for <amd-gfx@lists.freedesktop.org>; Wed, 18 Aug 2021 07:42:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Ao/txIf+B/fs8hVU8p8+wKHGKAFHZhPcsLRdwWlfgzI=;
 b=Tkdi57qQfUCWCNfV1Jsh1/nuuUbxyj2J9c9tnv7PsQrKD3xCYHCosyb5NNTJvtvWh+
 vpmHKRqVC3G55Iu2wnwEVayH31PazvfoCqrE3ZhVIhShc15fnriFydcpGCZ6ut7sTIyA
 /75UQWGw8UPNovDBnQ7cLdlM5Pqn+bxTA06/M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Ao/txIf+B/fs8hVU8p8+wKHGKAFHZhPcsLRdwWlfgzI=;
 b=ijVjOu0vFGqCkJ0EgbpxwWeqCJVrYFFaynBSrX0ptXBiprFXMiIjWIr+mSHUg1zX5W
 LmfQ02AcweasxMAke9S7yiYqCWsmfBHd6fESS0JH55UXbSyWRvAM2uwhMUBUbQ8CCNUZ
 vssWbCLylQT9r6ghJGJ5VcSx0aDRha95Q8ispa7neCQUhx9HyXXafHWsOJ4EKEYRPsOq
 cGcVEInE4V3eGThO1U7uWlDnf7R0w1kHbW7IqXA/Wyif99JOzH03UHDfYZrggOOX9jwD
 IKQ16eFD9juXLwPlm2xzaEu+VymDjPh/o8Oj+RvAGmuOu4YrYMQBywSCcndlVfyiQYxb
 qewg==
X-Gm-Message-State: AOAM532Ykx23+GDJpRleaJrBFtm0gAUPg9MxZJeke33H7XJGiZqx3DWN
 cSwsMaWnqQpWq/tkN4MAGJ/TCg==
X-Google-Smtp-Source: ABdhPJy1S82Qc/lIA56oS3TCfFRVU4kvkmeHJv/xBt7ufLq2aF+BJDJkFdkHZVgZlc/nJNGtOdDkcg==
X-Received: by 2002:a7b:cc16:: with SMTP id f22mr8755498wmh.99.1629297777431; 
 Wed, 18 Aug 2021 07:42:57 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id w9sm45605wmc.19.2021.08.18.07.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Aug 2021 07:42:56 -0700 (PDT)
Date: Wed, 18 Aug 2021 16:42:55 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Cc: Daniel Vetter <daniel@ffwll.ch>, Alex Deucher <alexdeucher@gmail.com>,
 Jingwen Chen <Jingwen.Chen2@amd.com>,
 Maling list - DRI developers <dri-devel@lists.freedesktop.org>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "monk.liu" <monk.liu@amd.com>, Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH v2] Revert "drm/scheduler: Avoid accessing freed bad job."
Message-ID: <YR0cb43Wv8jGiIbb@phenom.ffwll.local>
References: <20210818112114.1417685-1-Jingwen.Chen2@amd.com>
 <CADnq5_OApvH1Jo2VzJBHewHB_LXgg1WzUHvTBvrNYnbYdFAWhQ@mail.gmail.com>
 <69cbf5bd-42c2-be55-a604-43f4ebba159d@amd.com>
 <YR0Z7qtEti2hwZ7i@phenom.ffwll.local>
 <b92c62f2-7b1c-d4d8-cb84-1b5ccc3e4bb1@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b92c62f2-7b1c-d4d8-cb84-1b5ccc3e4bb1@amd.com>
X-Operating-System: Linux phenom 5.10.0-7-amd64 
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

On Wed, Aug 18, 2021 at 10:36:32AM -0400, Andrey Grodzovsky wrote:
> 
> On 2021-08-18 10:32 a.m., Daniel Vetter wrote:
> > On Wed, Aug 18, 2021 at 10:26:25AM -0400, Andrey Grodzovsky wrote:
> > > On 2021-08-18 10:02 a.m., Alex Deucher wrote:
> > > 
> > > > + dri-devel
> > > > 
> > > > Since scheduler is a shared component, please add dri-devel on all
> > > > scheduler patches.
> > > > 
> > > > On Wed, Aug 18, 2021 at 7:21 AM Jingwen Chen <Jingwen.Chen2@amd.com> wrote:
> > > > > [Why]
> > > > > for bailing job, this commit will delete it from pending list thus the
> > > > > bailing job will never have a chance to be resubmitted even in advance
> > > > > tdr mode.
> > > > > 
> > > > > [How]
> > > > > after embeded hw_fence into amdgpu_job is done, the race condition that
> > > > > this commit tries to work around is completely solved.So revert this
> > > > > commit.
> > > > > This reverts commit 135517d3565b48f4def3b1b82008bc17eb5d1c90.
> > > > > v2:
> > > > > add dma_fence_get/put() around timedout_job to avoid concurrent delete
> > > > > during processing timedout_job
> > > > > 
> > > > > Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> > > > > ---
> > > > >    drivers/gpu/drm/scheduler/sched_main.c | 23 +++++------------------
> > > > >    1 file changed, 5 insertions(+), 18 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> > > > > index a2a953693b45..f9b9b3aefc4a 100644
> > > > > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > > > > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > > > > @@ -314,6 +314,7 @@ static void drm_sched_job_timedout(struct work_struct *work)
> > > > >    {
> > > > >           struct drm_gpu_scheduler *sched;
> > > > >           struct drm_sched_job *job;
> > > > > +       struct dma_fence *fence;
> > > > >           enum drm_gpu_sched_stat status = DRM_GPU_SCHED_STAT_NOMINAL;
> > > > > 
> > > > >           sched = container_of(work, struct drm_gpu_scheduler, work_tdr.work);
> > > > > @@ -325,11 +326,10 @@ static void drm_sched_job_timedout(struct work_struct *work)
> > > > > 
> > > > >           if (job) {
> > > > >                   /*
> > > > > -                * Remove the bad job so it cannot be freed by concurrent
> > > > > -                * drm_sched_cleanup_jobs. It will be reinserted back after sched->thread
> > > > > -                * is parked at which point it's safe.
> > > > > +                * Get job->s_fence->parent here to avoid concurrent delete during
> > > > > +                * processing timedout_job
> > > > >                    */
> > > > > -               list_del_init(&job->list);
> > > > > +               fence = dma_fence_get(job->s_fence->parent);
> > > 
> > > While this is true for amdgpu, it has no meaning for other drivers for whom
> > > we haven't
> > > done the refactoring of embedding HW fence (parent) into the job structure.
> > > In fact thinking
> > > about it, unless you do the HW fence embedding for all the drivers using the
> > > scheduler you cannot
> > > revert this patch or you will just break them.
> > btw, why did you do that embedding? I do still have my patches with
> > dma_fence annotations floating around, but my idea at least was to fix
> > that issue with a mempool, not with embeddeding. What was the motivation
> > for embedding the wh fence?
> > -Daniel
> 
> 
> The motivation was 2 fold, avoid memory allocation during jobs submissions
> (HW fence allocation) because as Christian explained this leads to deadlock
> with
> mm code during evictions due to memory pressure (Christian can clarify if I
> messed

Yeah that's the exact same thing I've chased with my dma_fence
annotations, but thus far zero to none interested in getting it sorted. I
think it'd be good to have some cross-driver agreement on how this should
be solved before someone just charges ahead ...

> this explanation). Second is to exactly revert this patch because while it
> solved the issue
> described in the patch it created another with drivers who baildc out early
> during TDR handling
> for various reason and the job would just leak because it was already
> removed form pending list.

Can't we reinsert it before we restart the scheduler thread? It might need
a separate list for that due to the lockless queue tricks. Or am I
thinking about the wrong kind of "we lost the job"?
-Danile

> 
> Andrey
> 
> 
> > 
> > 
> > > Andrey
> > > 
> > > 
> > > > >                   spin_unlock(&sched->job_list_lock);
> > > > > 
> > > > >                   status = job->sched->ops->timedout_job(job);
> > > > > @@ -342,6 +342,7 @@ static void drm_sched_job_timedout(struct work_struct *work)
> > > > >                           job->sched->ops->free_job(job);
> > > > >                           sched->free_guilty = false;
> > > > >                   }
> > > > > +               dma_fence_put(fence);
> > > > >           } else {
> > > > >                   spin_unlock(&sched->job_list_lock);
> > > > >           }
> > > > > @@ -392,20 +393,6 @@ void drm_sched_stop(struct drm_gpu_scheduler *sched, struct drm_sched_job *bad)
> > > > > 
> > > > >           kthread_park(sched->thread);
> > > > > 
> > > > > -       /*
> > > > > -        * Reinsert back the bad job here - now it's safe as
> > > > > -        * drm_sched_get_cleanup_job cannot race against us and release the
> > > > > -        * bad job at this point - we parked (waited for) any in progress
> > > > > -        * (earlier) cleanups and drm_sched_get_cleanup_job will not be called
> > > > > -        * now until the scheduler thread is unparked.
> > > > > -        */
> > > > > -       if (bad && bad->sched == sched)
> > > > > -               /*
> > > > > -                * Add at the head of the queue to reflect it was the earliest
> > > > > -                * job extracted.
> > > > > -                */
> > > > > -               list_add(&bad->list, &sched->pending_list);
> > > > > -
> > > > >           /*
> > > > >            * Iterate the job list from later to  earlier one and either deactive
> > > > >            * their HW callbacks or remove them from pending list if they already
> > > > > --
> > > > > 2.25.1
> > > > > 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
