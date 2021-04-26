Return-Path: <SRS0=K+jV=JX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A26EC433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 19:48:07 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B16FB611C1
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 19:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B16FB611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 415826E874;
	Mon, 26 Apr 2021 19:48:06 +0000 (UTC)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C2406E874
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 19:48:04 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id j28so3143057edy.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 12:48:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=NVYTMlZvx6gWpUyMVB9A4JZO0p2F07dlTQBGbsx8WsA=;
 b=bxttjwjS1Sz/N5ud6vSOlFVjcSAyeVO3UhCV8YlMprfCJt9TCEx44z26prCeKTm0uT
 P5gIq94TxvyfFB/08TlmAH085ECz+B8Oongbi5iz1RhQKbgvtAINjjin10kiZMQjKh5U
 xiFVK1Thz8Sme3I4eFYaUoEeamjte4hzbXKT5Tgc2oaf5kfE+kT04u2bIIQNpCoM9aqG
 Oj2C02zQFxFxDSotblOW2YInJqith3UIKHtuYzLZkioibVLNaZ4DtXJFbv3D76SkE/Ro
 VPod6sTQ2pJ7kHz/gtJYl1tS5TvOk2kfXAhBdELiI/rjEksFeb3iNwS2uLS7eCn0F5fL
 cgRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=NVYTMlZvx6gWpUyMVB9A4JZO0p2F07dlTQBGbsx8WsA=;
 b=asJFL4grbzhj2N2LIEniRZswjd+S+6qb/P3f/S7sJ8fI2mzlLz2+rdEP2koVrHDXSp
 ovmp8+7KMpct3rvJRBj7JZXS3C2QlUZurYZf7opZdibwiaGybtKfL2r6iSt2/FHVYZQY
 076w9X/NFhWj8QW4xQ4pE+uX8WW/JhWqxBXAMiOccYY83SWTDNU9sCfQbcQCiY6dGsLl
 9RGgm+pOqE81IhGRHVQXuhoXM+nixf00K9d+iueB3G77Lcr12L1snxPJaMogxXrugK/X
 R/1EkwLShQte33VaFh7pep8Qd+PpPyFcfW1/sR+7Vm4FW7g0y5S1jZHMcJI09KPnzkax
 lAuA==
X-Gm-Message-State: AOAM531BihYdctl9C65Ln/ayY/ToOPQ3X9g35c6OqEpJhHMBV4wU3DiY
 k8u68DVQ7IcOjk1jhvDB9E4=
X-Google-Smtp-Source: ABdhPJwQs4toi1hqZmnXkhh0e/Q9rT1fcUtVvN2h1zszbVRx9XD+luxZAZ2Q7vcvTBp2PyQBJf+yZA==
X-Received: by 2002:a50:fb19:: with SMTP id d25mr350829edq.340.1619466483185; 
 Mon, 26 Apr 2021 12:48:03 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:341f:e41b:d3f1:a3b5?
 ([2a02:908:1252:fb60:341f:e41b:d3f1:a3b5])
 by smtp.gmail.com with ESMTPSA id n21sm6523856ejx.74.2021.04.26.12.48.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Apr 2021 12:48:02 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210426062701.39732-1-Roy.Sun@amd.com>
 <8b8ec884-5b0b-3409-b7b0-be7da43e3e71@gmail.com>
 <MN2PR12MB4488F5277BF26669E8D8673BF7429@MN2PR12MB4488.namprd12.prod.outlook.com>
 <MN2PR12MB44884F5635594C3F53D3F865F7429@MN2PR12MB4488.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <df0aa92d-87b9-7c27-f06f-9e1a10cead5d@gmail.com>
Date: Mon, 26 Apr 2021 21:48:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB44884F5635594C3F53D3F865F7429@MN2PR12MB4488.namprd12.prod.outlook.com>
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
Cc: "Sun, Roy" <Roy.Sun@amd.com>, amd-gfx list <amd-gfx@lists.freedesktop.org>,
 "Nieto, David M" <David.Nieto@amd.com>
Content-Type: multipart/mixed; boundary="===============0698558184=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0698558184==
Content-Type: multipart/alternative;
 boundary="------------9831C8A7D380672D9ACF188E"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------9831C8A7D380672D9ACF188E
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

My concern is more to get this tested from more people than just AMD.

Christian.

Am 26.04.21 um 21:40 schrieb Deucher, Alexander:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> That said, it would be easier for me to merge through the AMD tree 
> since a relatively big AMD feature depends on it.  Not sure how much 
> conflict potential there is if this goes through the AMD tree.
>
> Alex
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Deucher, Alexander <Alexander.Deucher@amd.com>
> *Sent:* Monday, April 26, 2021 3:24 PM
> *To:* Christian König <ckoenig.leichtzumerken@gmail.com>
> *Cc:* amd-gfx list <amd-gfx@lists.freedesktop.org>; Sun, Roy 
> <Roy.Sun@amd.com>; Nieto, David M <David.Nieto@amd.com>
> *Subject:* Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> No objections from me.
>
> Thanks!
>
> Alex
>
> ------------------------------------------------------------------------
> *From:* Christian König <ckoenig.leichtzumerken@gmail.com>
> *Sent:* Monday, April 26, 2021 2:49 AM
> *To:* Deucher, Alexander <Alexander.Deucher@amd.com>
> *Cc:* Nieto, David M <David.Nieto@amd.com>; Sun, Roy 
> <Roy.Sun@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>
> *Subject:* Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track
> Hey Alex,
>
> any objections that we merge those two patches through drm-misc-next?
>
> Thanks,
> Christian.
>
> Am 26.04.21 um 08:27 schrieb Roy Sun:
> > Update the timestamp of scheduled fence on HW
> > completion of the previous fences
> >
> > This allow more accurate tracking of the fence
> > execution in HW
> >
> > Signed-off-by: David M Nieto <david.nieto@amd.com>
> > Signed-off-by: Roy Sun <Roy.Sun@amd.com>
> > ---
> >   drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++++++--
> >   1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c 
> b/drivers/gpu/drm/scheduler/sched_main.c
> > index 92d8de24d0a1..f8e39ab0c41b 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -515,7 +515,7 @@ void drm_sched_resubmit_jobs(struct 
> drm_gpu_scheduler *sched)
> >   EXPORT_SYMBOL(drm_sched_resubmit_jobs);
> >
> >   /**
> > - * drm_sched_resubmit_jobs_ext - helper to relunch certain number 
> of jobs from mirror ring list
> > + * drm_sched_resubmit_jobs_ext - helper to relaunch certain number 
> of jobs from pending list
> >    *
> >    * @sched: scheduler instance
> >    * @max: job numbers to relaunch
> > @@ -671,7 +671,7 @@ drm_sched_select_entity(struct drm_gpu_scheduler 
> *sched)
> >   static struct drm_sched_job *
> >   drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
> >   {
> > -     struct drm_sched_job *job;
> > +     struct drm_sched_job *job, *next;
> >
> >        /*
> >         * Don't destroy jobs while the timeout worker is running  OR 
> thread
> > @@ -690,6 +690,14 @@ drm_sched_get_cleanup_job(struct 
> drm_gpu_scheduler *sched)
> >        if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
> >                /* remove job from pending_list */
> > list_del_init(&job->list);
> > We just need to record the scheduled time of the next job. So we
> > need not to check the rest job.
> > +             /* account for the next fence in the queue */
> > +             next = list_first_entry_or_null(&sched->pending_list,
> > +                             struct drm_sched_job, list);
> > +             if (next && test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
> > + &job->s_fence->finished.flags)) {
> > + next->s_fence->scheduled.timestamp =
> > + job->s_fence->finished.timestamp;
> > +             }
> >        } else {
> >                job = NULL;
> >                /* queue timeout for next job */
>


--------------9831C8A7D380672D9ACF188E
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body>
    My concern is more to get this tested from more people than just
    AMD.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 26.04.21 um 21:40 schrieb Deucher,
      Alexander:<br>
    </div>
    <blockquote type="cite"
cite="mid:MN2PR12MB44884F5635594C3F53D3F865F7429@MN2PR12MB4488.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <style type="text/css" style="display:none;">P {margin-top:0;margin-bottom:0;}</style>
      <p
        style="font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;"
        align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          That said, it would be easier for me to merge through the AMD
          tree since a relatively big AMD feature depends on it.  Not
          sure how much conflict potential there is if this goes through
          the AMD tree.<br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          Alex</div>
        <div style="font-family: Calibri, Arial, Helvetica, sans-serif;
          font-size: 12pt; color: rgb(0, 0, 0);">
          <br>
        </div>
        <hr style="display:inline-block;width:98%" tabindex="-1">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b>
            amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on
            behalf of Deucher, Alexander
            <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
            <b>Sent:</b> Monday, April 26, 2021 3:24 PM<br>
            <b>To:</b> Christian König
            <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
            <b>Cc:</b> amd-gfx list
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Sun, Roy
            <a class="moz-txt-link-rfc2396E" href="mailto:Roy.Sun@amd.com">&lt;Roy.Sun@amd.com&gt;</a>; Nieto, David M
            <a class="moz-txt-link-rfc2396E" href="mailto:David.Nieto@amd.com">&lt;David.Nieto@amd.com&gt;</a><br>
            <b>Subject:</b> Re: [PATCH 1/2] drm/scheduler: Change
            scheduled fence track</font>
          <div> </div>
        </div>
        <style type="text/css" style="display:none">p
	{margin-top:0;
	margin-bottom:0}</style>
        <div dir="ltr">
          <p style="font-family:Arial; font-size:11pt; color:#0078D7;
            margin:5pt" align="Left">
            [AMD Official Use Only - Internal Distribution Only]<br>
          </p>
          <br>
          <div>
            <p style="font-family:Arial; font-size:11pt; color:#0078D7;
              margin:5pt" align="Left">
              [AMD Official Use Only - Internal Distribution Only]<br>
            </p>
            <br>
            <div>
              <div
                style="font-family:Calibri,Arial,Helvetica,sans-serif;
                font-size:12pt; color:rgb(0,0,0)">
                No objections from me.</div>
              <div
                style="font-family:Calibri,Arial,Helvetica,sans-serif;
                font-size:12pt; color:rgb(0,0,0)">
                <br>
              </div>
              <div
                style="font-family:Calibri,Arial,Helvetica,sans-serif;
                font-size:12pt; color:rgb(0,0,0)">
                Thanks!</div>
              <div
                style="font-family:Calibri,Arial,Helvetica,sans-serif;
                font-size:12pt; color:rgb(0,0,0)">
                <br>
              </div>
              <div
                style="font-family:Calibri,Arial,Helvetica,sans-serif;
                font-size:12pt; color:rgb(0,0,0)">
                Alex</div>
              <div
                style="font-family:Calibri,Arial,Helvetica,sans-serif;
                font-size:12pt; color:rgb(0,0,0)">
                <br>
              </div>
              <hr tabindex="-1" style="display:inline-block; width:98%">
              <div id="x_divRplyFwdMsg" dir="ltr"><font
                  style="font-size:11pt" face="Calibri, sans-serif"
                  color="#000000"><b>From:</b> Christian König
                  <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                  <b>Sent:</b> Monday, April 26, 2021 2:49 AM<br>
                  <b>To:</b> Deucher, Alexander
                  <a class="moz-txt-link-rfc2396E" href="mailto:Alexander.Deucher@amd.com">&lt;Alexander.Deucher@amd.com&gt;</a><br>
                  <b>Cc:</b> Nieto, David M <a class="moz-txt-link-rfc2396E" href="mailto:David.Nieto@amd.com">&lt;David.Nieto@amd.com&gt;</a>;
                  Sun, Roy <a class="moz-txt-link-rfc2396E" href="mailto:Roy.Sun@amd.com">&lt;Roy.Sun@amd.com&gt;</a>; amd-gfx list
                  <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH 1/2] drm/scheduler: Change
                  scheduled fence track</font>
                <div> </div>
              </div>
              <div class="x_BodyFragment"><font size="2"><span
                    style="font-size:11pt">
                    <div class="x_PlainText">Hey Alex,<br>
                      <br>
                      any objections that we merge those two patches
                      through drm-misc-next?<br>
                      <br>
                      Thanks,<br>
                      Christian.<br>
                      <br>
                      Am 26.04.21 um 08:27 schrieb Roy Sun:<br>
                      &gt; Update the timestamp of scheduled fence on HW<br>
                      &gt; completion of the previous fences<br>
                      &gt;<br>
                      &gt; This allow more accurate tracking of the
                      fence<br>
                      &gt; execution in HW<br>
                      &gt;<br>
                      &gt; Signed-off-by: David M Nieto
                      <a class="moz-txt-link-rfc2396E" href="mailto:david.nieto@amd.com">&lt;david.nieto@amd.com&gt;</a><br>
                      &gt; Signed-off-by: Roy Sun
                      <a class="moz-txt-link-rfc2396E" href="mailto:Roy.Sun@amd.com">&lt;Roy.Sun@amd.com&gt;</a><br>
                      &gt; ---<br>
                      &gt;   drivers/gpu/drm/scheduler/sched_main.c | 12
                      ++++++++++--<br>
                      &gt;   1 file changed, 10 insertions(+), 2
                      deletions(-)<br>
                      &gt;<br>
                      &gt; diff --git
                      a/drivers/gpu/drm/scheduler/sched_main.c
                      b/drivers/gpu/drm/scheduler/sched_main.c<br>
                      &gt; index 92d8de24d0a1..f8e39ab0c41b 100644<br>
                      &gt; --- a/drivers/gpu/drm/scheduler/sched_main.c<br>
                      &gt; +++ b/drivers/gpu/drm/scheduler/sched_main.c<br>
                      &gt; @@ -515,7 +515,7 @@ void
                      drm_sched_resubmit_jobs(struct drm_gpu_scheduler
                      *sched)<br>
                      &gt;   EXPORT_SYMBOL(drm_sched_resubmit_jobs);<br>
                      &gt;   <br>
                      &gt;   /**<br>
                      &gt; - * drm_sched_resubmit_jobs_ext - helper to
                      relunch certain number of jobs from mirror ring
                      list<br>
                      &gt; + * drm_sched_resubmit_jobs_ext - helper to
                      relaunch certain number of jobs from pending list<br>
                      &gt;    *<br>
                      &gt;    * @sched: scheduler instance<br>
                      &gt;    * @max: job numbers to relaunch<br>
                      &gt; @@ -671,7 +671,7 @@
                      drm_sched_select_entity(struct drm_gpu_scheduler
                      *sched)<br>
                      &gt;   static struct drm_sched_job *<br>
                      &gt;   drm_sched_get_cleanup_job(struct
                      drm_gpu_scheduler *sched)<br>
                      &gt;   {<br>
                      &gt; -     struct drm_sched_job *job;<br>
                      &gt; +     struct drm_sched_job *job, *next;<br>
                      &gt;   <br>
                      &gt;        /*<br>
                      &gt;         * Don't destroy jobs while the
                      timeout worker is running  OR thread<br>
                      &gt; @@ -690,6 +690,14 @@
                      drm_sched_get_cleanup_job(struct drm_gpu_scheduler
                      *sched)<br>
                      &gt;        if (job &amp;&amp;
                      dma_fence_is_signaled(&amp;job-&gt;s_fence-&gt;finished))
                      {<br>
                      &gt;                /* remove job from
                      pending_list */<br>
                      &gt;               
                      list_del_init(&amp;job-&gt;list);<br>
                      &gt; We just need to record the scheduled time of
                      the next job. So we<br>
                      &gt; need not to check the rest job.<br>
                      &gt; +             /* account for the next fence
                      in the queue */<br>
                      &gt; +             next =
                      list_first_entry_or_null(&amp;sched-&gt;pending_list,<br>
                      &gt; +                             struct
                      drm_sched_job, list);<br>
                      &gt; +             if (next &amp;&amp;
                      test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,<br>
                      &gt; +                    
                      &amp;job-&gt;s_fence-&gt;finished.flags)) {<br>
                      &gt; +                    
                      next-&gt;s_fence-&gt;scheduled.timestamp =<br>
                      &gt; +                            
                      job-&gt;s_fence-&gt;finished.timestamp;<br>
                      &gt; +             }<br>
                      &gt;        } else {<br>
                      &gt;                job = NULL;<br>
                      &gt;                /* queue timeout for next job
                      */<br>
                      <br>
                    </div>
                  </span></font></div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------9831C8A7D380672D9ACF188E--

--===============0698558184==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0698558184==--
