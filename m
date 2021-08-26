Return-Path: <SRS0=gNHI=NR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3DEC432BE
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:46:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADDE260FDC
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Aug 2021 12:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ADDE260FDC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DDEA6E83A;
	Thu, 26 Aug 2021 12:46:31 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 884FC6E838
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 12:46:29 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id mf2so5980232ejb.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Aug 2021 05:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ffwll.ch; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=c0DTn/gZFqqKIUgqNkUcsfHUyWmc+KSD/W5j4bOPTps=;
 b=LO8lp7H5krzAtKvdK8LmTRFax/kdawcvUN6EkNrS+Q5FfAnLmEMLkJpsP+LD1igd9C
 iL08POiHYm0jdaiJiFQoSwHY196JQ0P9c1/fB0FIt3JgN5+y2E3XTjsMEvqlOmGyGT7q
 NPWn3nTOqyJYU/Gy9UNCH+bQh4xTCVzbCkmic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=c0DTn/gZFqqKIUgqNkUcsfHUyWmc+KSD/W5j4bOPTps=;
 b=FEDsdgSJz3qe36NjY+cKW2z2SGVuVjqxQAp+CsyfDLlI9LejBWnENUKQIiTbqqawwy
 tRyIX3Mu6orkfBcugaT0OkrshQCEnLn7Yvwpp9QJWtwmRNcV4zq8zxRK3zEYUeQMMXzB
 DRUZI9qMCq/XRAH8758cKCDbkZL9lFgPGLiIgovNrKdNAxFmTV5RTDaaU3UKvUQ1FuWD
 vyojsWZnT2Aym6X1CLRZhWsR84paWmToKGJyJlzXpdUHAj/kLlMLy6lsRocFRH3yoL8R
 mE7AER/d/qfXu14yDRs3p1UDIQoNKjhmDpTBVCJzmzdRHjWsrKW6i6nhQq9am1iMq6iG
 0Z/w==
X-Gm-Message-State: AOAM531BoLPq/Xm5aflzmzDrDEjsd/pdL0hs/mlACQAABOX7euxsZ4RX
 KKylnimG4gFpaqVzl1J90S2MQA==
X-Google-Smtp-Source: ABdhPJwz+Sp9u8mHC0XN4h/fp4H/YM6bsFOOXPTQsn5c2N/kmZO7DCk7REanS8FVc4sD4aioxtIgiw==
X-Received: by 2002:a17:906:9a4e:: with SMTP id
 aj14mr762492ejc.84.1629981988019; 
 Thu, 26 Aug 2021 05:46:28 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
 by smtp.gmail.com with ESMTPSA id k15sm879346eji.34.2021.08.26.05.46.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Aug 2021 05:46:27 -0700 (PDT)
Date: Thu, 26 Aug 2021 14:46:25 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Christian =?iso-8859-1?Q?K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Cc: "Liu, Monk" <Monk.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH] drm/sched: fix the bug of time out calculation(v3)
Message-ID: <YSeNIe/LW7/2+7iz@phenom.ffwll.local>
References: <1629953731-14629-1-git-send-email-Monk.Liu@amd.com>
 <e000dc1a-8fe8-ea69-e16b-bf0b64d773f2@gmail.com>
 <BL1PR12MB5269107A0A927EC3D7A7B6E784C79@BL1PR12MB5269.namprd12.prod.outlook.com>
 <7ad2d73a-cabd-b85b-0483-72a2177df86e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ad2d73a-cabd-b85b-0483-72a2177df86e@gmail.com>
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

On Thu, Aug 26, 2021 at 02:37:40PM +0200, Christian König wrote:
> Am 26.08.21 um 13:55 schrieb Liu, Monk:
> > [AMD Official Use Only]
> > 
> > > > I'm not sure if the work_tdr is initialized when a maximum timeout is specified. Please double check.
> > Ok, will do
> > 
> > > > BTW: Can we please drop the "tdr" naming from the scheduler? That is just a timeout functionality and not related to recovery in any way.
> > We even do not start hardware recovery in a lot of cases now (when wave kill is successfully).
> > 
> > Umm, sounds reasonable, I can rename it to "to" with another patch
> 
> Maybe more like job_timeout or timeout_work or something into that
> direction.

Yeah that's better. TO is even worse I think than TDR, which is at least
somewhat well-known from the windows side.

Also would be good to polish the commit message a bit, there's a few typos
and confusing wording.
-Daniel

> 
> Christian.
> 
> > 
> > Thanks
> > 
> > ------------------------------------------
> > Monk Liu | Cloud-GPU Core team
> > ------------------------------------------
> > 
> > -----Original Message-----
> > From: Christian König <ckoenig.leichtzumerken@gmail.com>
> > Sent: Thursday, August 26, 2021 6:09 PM
> > To: Liu, Monk <Monk.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> > Cc: dri-devel@lists.freedesktop.org
> > Subject: Re: [PATCH] drm/sched: fix the bug of time out calculation(v3)
> > 
> > Am 26.08.21 um 06:55 schrieb Monk Liu:
> > > issue:
> > > in cleanup_job the cancle_delayed_work will cancel a TO timer even the
> > > its corresponding job is still running.
> > Yeah, that makes a lot more sense.
> > 
> > > fix:
> > > do not cancel the timer in cleanup_job, instead do the cancelling only
> > > when the heading job is signaled, and if there is a "next" job we
> > > start_timeout again.
> > > 
> > > v2:
> > > further cleanup the logic, and do the TDR timer cancelling if the
> > > signaled job is the last one in its scheduler.
> > > 
> > > v3:
> > > change the issue description
> > > remove the cancel_delayed_work in the begining of the cleanup_job
> > > recover the implement of drm_sched_job_begin.
> > > 
> > > TODO:
> > > 1)introduce pause/resume scheduler in job_timeout to serial the
> > > handling of scheduler and job_timeout.
> > > 2)drop the bad job's del and insert in scheduler due to above
> > > serialization (no race issue anymore with the serialization)
> > > 
> > > Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> > > ---
> > >    drivers/gpu/drm/scheduler/sched_main.c | 25 ++++++++++---------------
> > >    1 file changed, 10 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > > b/drivers/gpu/drm/scheduler/sched_main.c
> > > index a2a9536..ecf8140 100644
> > > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > > @@ -676,13 +676,7 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
> > >    {
> > >    	struct drm_sched_job *job, *next;
> > > -	/*
> > > -	 * Don't destroy jobs while the timeout worker is running  OR thread
> > > -	 * is being parked and hence assumed to not touch pending_list
> > > -	 */
> > > -	if ((sched->timeout != MAX_SCHEDULE_TIMEOUT &&
> > > -	    !cancel_delayed_work(&sched->work_tdr)) ||
> > > -	    kthread_should_park())
> > > +	if (kthread_should_park())
> > >    		return NULL;
> > >    	spin_lock(&sched->job_list_lock);
> > > @@ -693,17 +687,21 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
> > >    	if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
> > >    		/* remove job from pending_list */
> > >    		list_del_init(&job->list);
> > > +
> > > +		/* cancel this job's TO timer */
> > > +		cancel_delayed_work(&sched->work_tdr);
> > I'm not sure if the work_tdr is initialized when a maximum timeout is specified. Please double check.
> > 
> > BTW: Can we please drop the "tdr" naming from the scheduler? That is just a timeout functionality and not related to recovery in any way.
> > 
> > We even do not start hardware recovery in a lot of cases now (when wave kill is successfully).
> > 
> > Regards,
> > Christian.
> > 
> > >    		/* make the scheduled timestamp more accurate */
> > >    		next = list_first_entry_or_null(&sched->pending_list,
> > >    						typeof(*next), list);
> > > -		if (next)
> > > +
> > > +		if (next) {
> > >    			next->s_fence->scheduled.timestamp =
> > >    				job->s_fence->finished.timestamp;
> > > -
> > > +			/* start TO timer for next job */
> > > +			drm_sched_start_timeout(sched);
> > > +		}
> > >    	} else {
> > >    		job = NULL;
> > > -		/* queue timeout for next job */
> > > -		drm_sched_start_timeout(sched);
> > >    	}
> > >    	spin_unlock(&sched->job_list_lock);
> > > @@ -791,11 +789,8 @@ static int drm_sched_main(void *param)
> > >    					  (entity = drm_sched_select_entity(sched))) ||
> > >    					 kthread_should_stop());
> > > -		if (cleanup_job) {
> > > +		if (cleanup_job)
> > >    			sched->ops->free_job(cleanup_job);
> > > -			/* queue timeout for next job */
> > > -			drm_sched_start_timeout(sched);
> > > -		}
> > >    		if (!entity)
> > >    			continue;
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
