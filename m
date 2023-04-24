Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5041EC77B61
	for <amd-gfx@archiver.kernel.org>; Mon, 24 Apr 2023 10:07:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6A3F10E46D;
	Mon, 24 Apr 2023 10:07:06 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E64C510E46D
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 10:07:04 +0000 (UTC)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-506b2a08877so7219891a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 24 Apr 2023 03:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1682330820; x=1684922820;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fkpRSicF/6Uu1UMINNsUi7fMiwEEAA5/q0M/aB/C1hQ=;
 b=LsDgSNRjWXa42l2xARKSuvgIqS/TaU3VBjhoHCYeBVNOHNfpGI4Ya1diaavSzbJgti
 7jPUCe+m9PN7hVu+cDlArw1Yy+AYInNtPXqfrIDcVzALAvxL6CadosoceCnI8U2yfM2z
 Y84ZrgR7OwohS74VTmIOU2KMG0yhNkT0ADqonLNEDn6b6LR8j3TgKHyoHJKgmlvVjmV5
 JhJQiYbEN0Y/Lgu80kS7eHuPFtyL3rS6TFEgkDPDBewGzf9hVmVI/s6ZdH2YsJNqU72q
 XWFTDWJSiRBFerpnsVcGsrhNDSEZmWH35UBeayKo6YUZg5Z0dOAW3BoonLm48JmlIx2l
 NJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682330820; x=1684922820;
 h=in-reply-to:from:references:cc:to:content-language:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fkpRSicF/6Uu1UMINNsUi7fMiwEEAA5/q0M/aB/C1hQ=;
 b=ZtofF0LQZiEUf3rAjt6M2pMeHmw97favHaDYqiKjdwaKE0eN+cmXUeonjCsESuVj1V
 deG3vmetJnCv4P0RNUj1tn5D7VppLP+7kiIsXMPAs7zz5B4Au5Z6zsQm6dg6XZ8ZVWBi
 NBMB68AJG0Ij7R1UlitHR2nNMCz+oW4b9zA3qy++u21OPTmZge7yIoNPoHoTckki9pFn
 zGEuAVNojHPSH73Xbybxy0uj6xhNaY5vFOyCjL788ncKc6eX0B7hkB4botSJiMMIoYoh
 F2IndqXpasjahHD4nUiYOYVgK5LQWBj1gTnC0JK9gCddcCLvmjLphNwGYF93539iYENM
 Zt1g==
X-Gm-Message-State: AAQBX9fkzpRikU1SxyI9OnKl2MFhGLt2fzmyJmzQhvktJyxvOxFWU6Uj
 ysnTejjkGE5kuRF8gc4a46g=
X-Google-Smtp-Source: AKy350bmiTjZKl35r9xuBl/oO2BCoZVjMcWVz7YCGzCwR/eTOat/qZv7dkeIuC/lyzxo4Pn49nN5rQ==
X-Received: by 2002:aa7:d7c7:0:b0:4fc:709f:7abd with SMTP id
 e7-20020aa7d7c7000000b004fc709f7abdmr11823668eds.2.1682330820506; 
 Mon, 24 Apr 2023 03:07:00 -0700 (PDT)
Received: from [192.168.178.21] (p4fc2092b.dip0.t-ipconnect.de. [79.194.9.43])
 by smtp.gmail.com with ESMTPSA id
 f12-20020a50ee8c000000b00504ae3a5adfsm4617340edr.2.2023.04.24.03.06.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Apr 2023 03:07:00 -0700 (PDT)
Content-Type: multipart/alternative;
 boundary="------------nMLCOJMSgp02psV7S2NUx0u0"
Message-ID: <7cb2b22f-eec6-567b-dc1d-76adb9959ed5@gmail.com>
Date: Mon, 24 Apr 2023 12:06:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/8] drm/scheduler: properly forward fence errors
Content-Language: en-US
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20230420115752.31470-1-christian.koenig@amd.com>
 <3d5dc70c-982a-8d86-cab2-f205c90c869d@amd.com>
 <99c31d32-05e2-70bc-c6fc-216eb2832d14@gmail.com>
 <BL1PR12MB5144DF199535F1DC66F981F4F7609@BL1PR12MB5144.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
In-Reply-To: <BL1PR12MB5144DF199535F1DC66F981F4F7609@BL1PR12MB5144.namprd12.prod.outlook.com>
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
Cc: "Tuikov, Luben" <Luben.Tuikov@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--------------nMLCOJMSgp02psV7S2NUx0u0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I've pushed the scheduler patch to drm-misc-next and the whole set to 
amd-staging-drm-next.

Christian.

Am 21.04.23 um 15:40 schrieb Deucher, Alexander:
>
> [AMD Official Use Only - General]
>
>
> Sure.  We can pull it into amd-staging-drm-next as well if we need it 
> for any customers in the short term.
>
> Alex
> ------------------------------------------------------------------------
> *From:* Christian König <ckoenig.leichtzumerken@gmail.com>
> *Sent:* Friday, April 21, 2023 9:27 AM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>; 
> Deucher, Alexander <Alexander.Deucher@amd.com>
> *Cc:* Tuikov, Luben <Luben.Tuikov@amd.com>
> *Subject:* Re: [PATCH 1/8] drm/scheduler: properly forward fence errors
> Alex can I merge that through drm-misc-next or do we really need
> amd-staging-drm-next?
>
> Christian.
>
> Am 21.04.23 um 07:22 schrieb Luben Tuikov:
> > Hi Christian,
> >
> > Thanks for working on this.
> >
> > Series is,
> > Reviewed-by: Luben Tuikov <luben.tuikov@amd.com>
> >
> > Regards,
> > Luben
> >
> > On 2023-04-20 07:57, Christian König wrote:
> >> When a hw fence is signaled with an error properly forward that to the
> >> finished fence.
> >>
> >> Signed-off-by: Christian König <christian.koenig@amd.com>
> >> ---
> >>   drivers/gpu/drm/scheduler/sched_entity.c |  4 +---
> >>   drivers/gpu/drm/scheduler/sched_fence.c  |  4 +++-
> >>   drivers/gpu/drm/scheduler/sched_main.c   | 18 ++++++++----------
> >>   include/drm/gpu_scheduler.h              |  2 +-
> >>   4 files changed, 13 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/drivers/gpu/drm/scheduler/sched_entity.c 
> b/drivers/gpu/drm/scheduler/sched_entity.c
> >> index 15d04a0ec623..eaf71fe15ed3 100644
> >> --- a/drivers/gpu/drm/scheduler/sched_entity.c
> >> +++ b/drivers/gpu/drm/scheduler/sched_entity.c
> >> @@ -144,7 +144,7 @@ static void 
> drm_sched_entity_kill_jobs_work(struct work_struct *wrk)
> >>   {
> >>       struct drm_sched_job *job = container_of(wrk, typeof(*job), 
> work);
> >>
> >> -    drm_sched_fence_finished(job->s_fence);
> >> +    drm_sched_fence_finished(job->s_fence, -ESRCH);
> >>       WARN_ON(job->s_fence->parent);
> >>       job->sched->ops->free_job(job);
> >>   }
> >> @@ -195,8 +195,6 @@ static void drm_sched_entity_kill(struct 
> drm_sched_entity *entity)
> >>       while ((job = 
> to_drm_sched_job(spsc_queue_pop(&entity->job_queue)))) {
> >>               struct drm_sched_fence *s_fence = job->s_fence;
> >>
> >> - dma_fence_set_error(&s_fence->finished, -ESRCH);
> >> -
> >> dma_fence_get(&s_fence->finished);
> >>               if (!prev || dma_fence_add_callback(prev, 
> &job->finish_cb,
> >> drm_sched_entity_kill_jobs_cb))
> >> diff --git a/drivers/gpu/drm/scheduler/sched_fence.c 
> b/drivers/gpu/drm/scheduler/sched_fence.c
> >> index 7fd869520ef2..1a6bea98c5cc 100644
> >> --- a/drivers/gpu/drm/scheduler/sched_fence.c
> >> +++ b/drivers/gpu/drm/scheduler/sched_fence.c
> >> @@ -53,8 +53,10 @@ void drm_sched_fence_scheduled(struct 
> drm_sched_fence *fence)
> >> dma_fence_signal(&fence->scheduled);
> >>   }
> >>
> >> -void drm_sched_fence_finished(struct drm_sched_fence *fence)
> >> +void drm_sched_fence_finished(struct drm_sched_fence *fence, int 
> result)
> >>   {
> >> +    if (result)
> >> + dma_fence_set_error(&fence->finished, result);
> >> dma_fence_signal(&fence->finished);
> >>   }
> >>
> >> diff --git a/drivers/gpu/drm/scheduler/sched_main.c 
> b/drivers/gpu/drm/scheduler/sched_main.c
> >> index fcd4bfef7415..649fac2e1ccb 100644
> >> --- a/drivers/gpu/drm/scheduler/sched_main.c
> >> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> >> @@ -257,7 +257,7 @@ drm_sched_rq_select_entity_fifo(struct 
> drm_sched_rq *rq)
> >>    *
> >>    * Finish the job's fence and wake up the worker thread.
> >>    */
> >> -static void drm_sched_job_done(struct drm_sched_job *s_job)
> >> +static void drm_sched_job_done(struct drm_sched_job *s_job, int 
> result)
> >>   {
> >>       struct drm_sched_fence *s_fence = s_job->s_fence;
> >>       struct drm_gpu_scheduler *sched = s_fence->sched;
> >> @@ -268,7 +268,7 @@ static void drm_sched_job_done(struct 
> drm_sched_job *s_job)
> >>       trace_drm_sched_process_job(s_fence);
> >>
> >>       dma_fence_get(&s_fence->finished);
> >> -    drm_sched_fence_finished(s_fence);
> >> +    drm_sched_fence_finished(s_fence, result);
> >>       dma_fence_put(&s_fence->finished);
> >> wake_up_interruptible(&sched->wake_up_worker);
> >>   }
> >> @@ -282,7 +282,7 @@ static void drm_sched_job_done_cb(struct 
> dma_fence *f, struct dma_fence_cb *cb)
> >>   {
> >>       struct drm_sched_job *s_job = container_of(cb, struct 
> drm_sched_job, cb);
> >>
> >> -    drm_sched_job_done(s_job);
> >> +    drm_sched_job_done(s_job, f->error);
> >>   }
> >>
> >>   /**
> >> @@ -533,12 +533,12 @@ void drm_sched_start(struct drm_gpu_scheduler 
> *sched, bool full_recovery)
> >>                       r = dma_fence_add_callback(fence, &s_job->cb,
> >>                                                 drm_sched_job_done_cb);
> >>                       if (r == -ENOENT)
> >> - drm_sched_job_done(s_job);
> >> + drm_sched_job_done(s_job, fence->error);
> >>                       else if (r)
> >> DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n",
> >>                                         r);
> >>               } else
> >> -                    drm_sched_job_done(s_job);
> >> +                    drm_sched_job_done(s_job, 0);
> >>       }
> >>
> >>       if (full_recovery) {
> >> @@ -1010,15 +1010,13 @@ static int drm_sched_main(void *param)
> >>                       r = dma_fence_add_callback(fence, &sched_job->cb,
> >>                                                 drm_sched_job_done_cb);
> >>                       if (r == -ENOENT)
> >> - drm_sched_job_done(sched_job);
> >> + drm_sched_job_done(sched_job, fence->error);
> >>                       else if (r)
> >> DRM_DEV_ERROR(sched->dev, "fence add callback failed (%d)\n",
> >>                                         r);
> >>               } else {
> >> -                    if (IS_ERR(fence))
> >> - dma_fence_set_error(&s_fence->finished, PTR_ERR(fence));
> >> -
> >> - drm_sched_job_done(sched_job);
> >> + drm_sched_job_done(sched_job, IS_ERR(fence) ?
> >> + PTR_ERR(fence) : 0);
> >>               }
> >>
> >> wake_up(&sched->job_scheduled);
> >> diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> >> index ca857ec9e7eb..5c1df6b12ced 100644
> >> --- a/include/drm/gpu_scheduler.h
> >> +++ b/include/drm/gpu_scheduler.h
> >> @@ -569,7 +569,7 @@ void drm_sched_fence_init(struct 
> drm_sched_fence *fence,
> >>   void drm_sched_fence_free(struct drm_sched_fence *fence);
> >>
> >>   void drm_sched_fence_scheduled(struct drm_sched_fence *fence);
> >> -void drm_sched_fence_finished(struct drm_sched_fence *fence);
> >> +void drm_sched_fence_finished(struct drm_sched_fence *fence, int 
> result);
> >>
> >>   unsigned long drm_sched_suspend_timeout(struct drm_gpu_scheduler 
> *sched);
> >>   void drm_sched_resume_timeout(struct drm_gpu_scheduler *sched,
>

--------------nMLCOJMSgp02psV7S2NUx0u0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    I've pushed the scheduler patch to drm-misc-next and the whole set
    to amd-staging-drm-next.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 21.04.23 um 15:40 schrieb Deucher,
      Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:BL1PR12MB5144DF199535F1DC66F981F4F7609@BL1PR12MB5144.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p
        style="font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;"
        align="Left">
        [AMD Official Use Only - General]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0); background-color:
          rgb(255, 255, 255);" class="elementToProof">
          Sure.  We can pull it into amd-staging-drm-next as well if we
          need it for any customers in the short term.</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0); background-color:
          rgb(255, 255, 255);" class="elementToProof">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0); background-color:
          rgb(255, 255, 255);" class="elementToProof">
          Alex<br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b>
            Christian König <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
            <b>Sent:</b> Friday, April 21, 2023 9:27 AM<br>
            <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
            <b>Cc:</b> Tuikov, Luben <a class="moz-txt-link-rfc2396E" href="mailto:Luben.Tuikov@amd.com">&lt;Luben.Tuikov@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH 1/8] drm/scheduler: properly
            forward fence errors</font>
          <div> </div>
        </div>
        <div class="BodyFragment"><font size="2"><span
              style="font-size:11pt;">
              <div class="PlainText">Alex can I merge that through
                drm-misc-next or do we really need
                <br>
                amd-staging-drm-next?<br>
                <br>
                Christian.<br>
                <br>
                Am 21.04.23 um 07:22 schrieb Luben Tuikov:<br>
                &gt; Hi Christian,<br>
                &gt;<br>
                &gt; Thanks for working on this.<br>
                &gt;<br>
                &gt; Series is,<br>
                &gt; Reviewed-by: Luben Tuikov
                <a class="moz-txt-link-rfc2396E" href="mailto:luben.tuikov@amd.com">&lt;luben.tuikov@amd.com&gt;</a><br>
                &gt;<br>
                &gt; Regards,<br>
                &gt; Luben<br>
                &gt;<br>
                &gt; On 2023-04-20 07:57, Christian König wrote:<br>
                &gt;&gt; When a hw fence is signaled with an error
                properly forward that to the<br>
                &gt;&gt; finished fence.<br>
                &gt;&gt;<br>
                &gt;&gt; Signed-off-by: Christian König
                <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a><br>
                &gt;&gt; ---<br>
                &gt;&gt;   drivers/gpu/drm/scheduler/sched_entity.c |  4
                +---<br>
                &gt;&gt;   drivers/gpu/drm/scheduler/sched_fence.c  |  4
                +++-<br>
                &gt;&gt;   drivers/gpu/drm/scheduler/sched_main.c   | 18
                ++++++++----------<br>
                &gt;&gt;   include/drm/gpu_scheduler.h              |  2
                +-<br>
                &gt;&gt;   4 files changed, 13 insertions(+), 15
                deletions(-)<br>
                &gt;&gt;<br>
                &gt;&gt; diff --git
                a/drivers/gpu/drm/scheduler/sched_entity.c
                b/drivers/gpu/drm/scheduler/sched_entity.c<br>
                &gt;&gt; index 15d04a0ec623..eaf71fe15ed3 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/scheduler/sched_entity.c<br>
                &gt;&gt; +++ b/drivers/gpu/drm/scheduler/sched_entity.c<br>
                &gt;&gt; @@ -144,7 +144,7 @@ static void
                drm_sched_entity_kill_jobs_work(struct work_struct *wrk)<br>
                &gt;&gt;   {<br>
                &gt;&gt;       struct drm_sched_job *job =
                container_of(wrk, typeof(*job), work);<br>
                &gt;&gt;   <br>
                &gt;&gt; -    drm_sched_fence_finished(job-&gt;s_fence);<br>
                &gt;&gt; +    drm_sched_fence_finished(job-&gt;s_fence,
                -ESRCH);<br>
                &gt;&gt;       WARN_ON(job-&gt;s_fence-&gt;parent);<br>
                &gt;&gt;       job-&gt;sched-&gt;ops-&gt;free_job(job);<br>
                &gt;&gt;   }<br>
                &gt;&gt; @@ -195,8 +195,6 @@ static void
                drm_sched_entity_kill(struct drm_sched_entity *entity)<br>
                &gt;&gt;       while ((job =
                to_drm_sched_job(spsc_queue_pop(&amp;entity-&gt;job_queue))))
                {<br>
                &gt;&gt;               struct drm_sched_fence *s_fence =
                job-&gt;s_fence;<br>
                &gt;&gt;   <br>
                &gt;&gt; -           
                dma_fence_set_error(&amp;s_fence-&gt;finished, -ESRCH);<br>
                &gt;&gt; -<br>
                &gt;&gt;              
                dma_fence_get(&amp;s_fence-&gt;finished);<br>
                &gt;&gt;               if (!prev ||
                dma_fence_add_callback(prev, &amp;job-&gt;finish_cb,<br>
                &gt;&gt;                                         
                drm_sched_entity_kill_jobs_cb))<br>
                &gt;&gt; diff --git
                a/drivers/gpu/drm/scheduler/sched_fence.c
                b/drivers/gpu/drm/scheduler/sched_fence.c<br>
                &gt;&gt; index 7fd869520ef2..1a6bea98c5cc 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/scheduler/sched_fence.c<br>
                &gt;&gt; +++ b/drivers/gpu/drm/scheduler/sched_fence.c<br>
                &gt;&gt; @@ -53,8 +53,10 @@ void
                drm_sched_fence_scheduled(struct drm_sched_fence *fence)<br>
                &gt;&gt;      
                dma_fence_signal(&amp;fence-&gt;scheduled);<br>
                &gt;&gt;   }<br>
                &gt;&gt;   <br>
                &gt;&gt; -void drm_sched_fence_finished(struct
                drm_sched_fence *fence)<br>
                &gt;&gt; +void drm_sched_fence_finished(struct
                drm_sched_fence *fence, int result)<br>
                &gt;&gt;   {<br>
                &gt;&gt; +    if (result)<br>
                &gt;&gt; +           
                dma_fence_set_error(&amp;fence-&gt;finished, result);<br>
                &gt;&gt;      
                dma_fence_signal(&amp;fence-&gt;finished);<br>
                &gt;&gt;   }<br>
                &gt;&gt;   <br>
                &gt;&gt; diff --git
                a/drivers/gpu/drm/scheduler/sched_main.c
                b/drivers/gpu/drm/scheduler/sched_main.c<br>
                &gt;&gt; index fcd4bfef7415..649fac2e1ccb 100644<br>
                &gt;&gt; --- a/drivers/gpu/drm/scheduler/sched_main.c<br>
                &gt;&gt; +++ b/drivers/gpu/drm/scheduler/sched_main.c<br>
                &gt;&gt; @@ -257,7 +257,7 @@
                drm_sched_rq_select_entity_fifo(struct drm_sched_rq *rq)<br>
                &gt;&gt;    *<br>
                &gt;&gt;    * Finish the job's fence and wake up the
                worker thread.<br>
                &gt;&gt;    */<br>
                &gt;&gt; -static void drm_sched_job_done(struct
                drm_sched_job *s_job)<br>
                &gt;&gt; +static void drm_sched_job_done(struct
                drm_sched_job *s_job, int result)<br>
                &gt;&gt;   {<br>
                &gt;&gt;       struct drm_sched_fence *s_fence =
                s_job-&gt;s_fence;<br>
                &gt;&gt;       struct drm_gpu_scheduler *sched =
                s_fence-&gt;sched;<br>
                &gt;&gt; @@ -268,7 +268,7 @@ static void
                drm_sched_job_done(struct drm_sched_job *s_job)<br>
                &gt;&gt;       trace_drm_sched_process_job(s_fence);<br>
                &gt;&gt;   <br>
                &gt;&gt;       dma_fence_get(&amp;s_fence-&gt;finished);<br>
                &gt;&gt; -    drm_sched_fence_finished(s_fence);<br>
                &gt;&gt; +    drm_sched_fence_finished(s_fence, result);<br>
                &gt;&gt;       dma_fence_put(&amp;s_fence-&gt;finished);<br>
                &gt;&gt;      
                wake_up_interruptible(&amp;sched-&gt;wake_up_worker);<br>
                &gt;&gt;   }<br>
                &gt;&gt; @@ -282,7 +282,7 @@ static void
                drm_sched_job_done_cb(struct dma_fence *f, struct
                dma_fence_cb *cb)<br>
                &gt;&gt;   {<br>
                &gt;&gt;       struct drm_sched_job *s_job =
                container_of(cb, struct drm_sched_job, cb);<br>
                &gt;&gt;   <br>
                &gt;&gt; -    drm_sched_job_done(s_job);<br>
                &gt;&gt; +    drm_sched_job_done(s_job, f-&gt;error);<br>
                &gt;&gt;   }<br>
                &gt;&gt;   <br>
                &gt;&gt;   /**<br>
                &gt;&gt; @@ -533,12 +533,12 @@ void
                drm_sched_start(struct drm_gpu_scheduler *sched, bool
                full_recovery)<br>
                &gt;&gt;                       r =
                dma_fence_add_callback(fence, &amp;s_job-&gt;cb,<br>
&gt;&gt;                                                 
                drm_sched_job_done_cb);<br>
                &gt;&gt;                       if (r == -ENOENT)<br>
                &gt;&gt; -                           
                drm_sched_job_done(s_job);<br>
                &gt;&gt; +                           
                drm_sched_job_done(s_job, fence-&gt;error);<br>
                &gt;&gt;                       else if (r)<br>
                &gt;&gt;                              
                DRM_DEV_ERROR(sched-&gt;dev, "fence add callback failed
                (%d)\n",<br>
                &gt;&gt;                                         r);<br>
                &gt;&gt;               } else<br>
                &gt;&gt; -                    drm_sched_job_done(s_job);<br>
                &gt;&gt; +                    drm_sched_job_done(s_job,
                0);<br>
                &gt;&gt;       }<br>
                &gt;&gt;   <br>
                &gt;&gt;       if (full_recovery) {<br>
                &gt;&gt; @@ -1010,15 +1010,13 @@ static int
                drm_sched_main(void *param)<br>
                &gt;&gt;                       r =
                dma_fence_add_callback(fence, &amp;sched_job-&gt;cb,<br>
&gt;&gt;                                                 
                drm_sched_job_done_cb);<br>
                &gt;&gt;                       if (r == -ENOENT)<br>
                &gt;&gt; -                           
                drm_sched_job_done(sched_job);<br>
                &gt;&gt; +                           
                drm_sched_job_done(sched_job, fence-&gt;error);<br>
                &gt;&gt;                       else if (r)<br>
                &gt;&gt;                              
                DRM_DEV_ERROR(sched-&gt;dev, "fence add callback failed
                (%d)\n",<br>
                &gt;&gt;                                         r);<br>
                &gt;&gt;               } else {<br>
                &gt;&gt; -                    if (IS_ERR(fence))<br>
                &gt;&gt; -                           
                dma_fence_set_error(&amp;s_fence-&gt;finished,
                PTR_ERR(fence));<br>
                &gt;&gt; -<br>
                &gt;&gt; -                   
                drm_sched_job_done(sched_job);<br>
                &gt;&gt; +                   
                drm_sched_job_done(sched_job, IS_ERR(fence) ?<br>
                &gt;&gt; +                                      
                PTR_ERR(fence) : 0);<br>
                &gt;&gt;               }<br>
                &gt;&gt;   <br>
                &gt;&gt;              
                wake_up(&amp;sched-&gt;job_scheduled);<br>
                &gt;&gt; diff --git a/include/drm/gpu_scheduler.h
                b/include/drm/gpu_scheduler.h<br>
                &gt;&gt; index ca857ec9e7eb..5c1df6b12ced 100644<br>
                &gt;&gt; --- a/include/drm/gpu_scheduler.h<br>
                &gt;&gt; +++ b/include/drm/gpu_scheduler.h<br>
                &gt;&gt; @@ -569,7 +569,7 @@ void
                drm_sched_fence_init(struct drm_sched_fence *fence,<br>
                &gt;&gt;   void drm_sched_fence_free(struct
                drm_sched_fence *fence);<br>
                &gt;&gt;   <br>
                &gt;&gt;   void drm_sched_fence_scheduled(struct
                drm_sched_fence *fence);<br>
                &gt;&gt; -void drm_sched_fence_finished(struct
                drm_sched_fence *fence);<br>
                &gt;&gt; +void drm_sched_fence_finished(struct
                drm_sched_fence *fence, int result);<br>
                &gt;&gt;   <br>
                &gt;&gt;   unsigned long
                drm_sched_suspend_timeout(struct drm_gpu_scheduler
                *sched);<br>
                &gt;&gt;   void drm_sched_resume_timeout(struct
                drm_gpu_scheduler *sched,<br>
                <br>
              </div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------nMLCOJMSgp02psV7S2NUx0u0--
