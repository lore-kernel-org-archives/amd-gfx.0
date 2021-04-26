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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C328C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 16:08:14 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F101B61157
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 16:08:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F101B61157
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D9646E169;
	Mon, 26 Apr 2021 16:08:13 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com
 [IPv6:2a00:1450:4864:20::629])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 151556E169
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 16:08:12 +0000 (UTC)
Received: by mail-ej1-x629.google.com with SMTP id ja3so9370430ejc.9
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 09:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=zEoGPfBicQbZ3tvzP7qKNPIBKkDsDpsxBHI765hMwOs=;
 b=m3mRG0+Tv92topGhAagFRs3jVhAIBFENQJsKvehw2Hz9pP8dRNlqCuCBc5jbTgzKlV
 P3BkqePlPLE12z84TsDcl+qHbsCvCYZdea5rlSciMrDGZbcxKVQH/Z2h9q5Hv7+C+dv9
 BjtDfx2/GSLN9TvThZmGTqYc81fer/uoOw1N8Hqrv9+/Ndu5t7pvE2ltssmsL2YkfXlT
 QdJBOPF7mTL4AfTTL5RVI8x5xIiYKGHbgCA02VoBq/5QOqPVNrg446ZmdugGSe4rW1pK
 ja3CHZVTdNRbKYbwP9TOeLZ534kW1uvhhnXfF8qpI//lo0UevrlzL2quiFITGBlgoJpY
 nULA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=zEoGPfBicQbZ3tvzP7qKNPIBKkDsDpsxBHI765hMwOs=;
 b=URI24Aukk8iroOJWApxxiJoFRRQ7bbzaowKHiqhrVvGIVCXkradCQuvYocXNrdCfmT
 ulUUEbBnpi4MZ0G28Hn433M5cMqmPTPxQBVNHO+dOZULpn5xjLzfGIlCWNiFzh67Bkhp
 Wv4SBG23km59I0EtVNj/EUqabBsfP7sNKpW0ulURPdI+1ttpaaxrAIZXXTnl8DPxPlHp
 tXFQ0vf0A3cLmi7DW3OctDm0tgBQ/wghJcIrI8QKDDyOFJkBi4u56ccKmm+NkQT9ecPO
 HPEqSecs3JDt8doAsEjHt8VDDcOqiA/GIMLUrPbBe1upYnAgfXAeJN07cKE5ck8VB+BZ
 LkPA==
X-Gm-Message-State: AOAM531kX5zAKYAvFuRfs8tFU6InFP5/f8IifNbNItQMmKx+EGISuWB2
 /Hkr0/5BUz9z9MyDp2/Vc0I=
X-Google-Smtp-Source: ABdhPJxTlwP03e0EwbYKgWw7yfWfYcgBNQNnJKh/hTi3KjlaUg9z1nIChdNYH0lIpo/3c2QsZ+/SMw==
X-Received: by 2002:a17:906:2596:: with SMTP id
 m22mr19700755ejb.175.1619453290815; 
 Mon, 26 Apr 2021 09:08:10 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:5ea3:9669:f6c0:78b?
 ([2a02:908:1252:fb60:5ea3:9669:f6c0:78b])
 by smtp.gmail.com with ESMTPSA id j16sm213609edt.39.2021.04.26.09.08.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Apr 2021 09:08:10 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track
To: "Wang, Kevin(Yang)" <Kevin1.Wang@amd.com>, "Sun, Roy" <Roy.Sun@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20210426062701.39732-1-Roy.Sun@amd.com>
 <MN2PR12MB3022E9D72A4816C9A693F591A2429@MN2PR12MB3022.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <134211da-08ff-d652-b01b-2ef513a6dba8@gmail.com>
Date: Mon, 26 Apr 2021 18:08:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <MN2PR12MB3022E9D72A4816C9A693F591A2429@MN2PR12MB3022.namprd12.prod.outlook.com>
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
Cc: "Nieto, David M" <David.Nieto@amd.com>
Content-Type: multipart/mixed; boundary="===============0649115471=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============0649115471==
Content-Type: multipart/alternative;
 boundary="------------26723EFC46D8F59C564F2532"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------26723EFC46D8F59C564F2532
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit



Am 26.04.21 um 17:30 schrieb Wang, Kevin(Yang):
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
>
>
> ------------------------------------------------------------------------
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of 
> Roy Sun <Roy.Sun@amd.com>
> *Sent:* Monday, April 26, 2021 2:27 PM
> *To:* amd-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
> *Cc:* Sun, Roy <Roy.Sun@amd.com>; Nieto, David M <David.Nieto@amd.com>
> *Subject:* [PATCH 1/2] drm/scheduler: Change scheduled fence track
> Update the timestamp of scheduled fence on HW
> completion of the previous fences
>
> This allow more accurate tracking of the fence
> execution in HW
>
> Signed-off-by: David M Nieto <david.nieto@amd.com>
> Signed-off-by: Roy Sun <Roy.Sun@amd.com>
> ---
>  drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c 
> b/drivers/gpu/drm/scheduler/sched_main.c
> index 92d8de24d0a1..f8e39ab0c41b 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -515,7 +515,7 @@ void drm_sched_resubmit_jobs(struct 
> drm_gpu_scheduler *sched)
>  EXPORT_SYMBOL(drm_sched_resubmit_jobs);
>
>  /**
> - * drm_sched_resubmit_jobs_ext - helper to relunch certain number of 
> jobs from mirror ring list
> + * drm_sched_resubmit_jobs_ext - helper to relaunch certain number of 
> jobs from pending list
>   *
>   * @sched: scheduler instance
>   * @max: job numbers to relaunch
> @@ -671,7 +671,7 @@ drm_sched_select_entity(struct drm_gpu_scheduler 
> *sched)
>  static struct drm_sched_job *
>  drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
>  {
> -       struct drm_sched_job *job;
> +       struct drm_sched_job *job, *next;
>
>          /*
>           * Don't destroy jobs while the timeout worker is running  OR 
> thread
> @@ -690,6 +690,14 @@ drm_sched_get_cleanup_job(struct 
> drm_gpu_scheduler *sched)
>          if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
>                  /* remove job from pending_list */
>                  list_del_init(&job->list);
> We just need to record the scheduled time of the next job. So we
> need not to check the rest job.
>
> [kevin]:
> ok, it is fine for me with the timestamp flag check.
> Reviewed-by: Kevin Wang <kevin1.wang@amd.com>

Actually please drop that extra check.

The timestamp is guaranteed to be set on the next job or otherwise we 
wouldn't got here in the first place.

I've considered dropping the flag for quite a while and don't want any 
new users of this.

Christian.

>
> +               /* account for the next fence in the queue */
> +               next = list_first_entry_or_null(&sched->pending_list,
> +                               struct drm_sched_job, list);
> +               if (next && test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
> + &job->s_fence->finished.flags)) {
> + next->s_fence->scheduled.timestamp =
> + job->s_fence->finished.timestamp;
> +               }
>          } else {
>                  job = NULL;
>                  /* queue timeout for next job */
> -- 
> 2.31.1
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CKevin1.Wang%40amd.com%7C0cebaf8d37e144c6b82108d9087c502e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637550152295564379%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Hdiil9BC2sp2pUI1121yZWELoCQqhDqTnbr7E9oVutw%3D&amp;reserved=0 
> <https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7CKevin1.Wang%40amd.com%7C0cebaf8d37e144c6b82108d9087c502e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637550152295564379%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=Hdiil9BC2sp2pUI1121yZWELoCQqhDqTnbr7E9oVutw%3D&amp;reserved=0>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------26723EFC46D8F59C564F2532
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body>
    <br>
    <br>
    <div class="moz-cite-prefix">Am 26.04.21 um 17:30 schrieb Wang,
      Kevin(Yang):<br>
    </div>
    <blockquote type="cite"
cite="mid:MN2PR12MB3022E9D72A4816C9A693F591A2429@MN2PR12MB3022.namprd12.prod.outlook.com">
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
          <br>
        </div>
        <div style="font-family:Calibri,Arial,Helvetica,sans-serif;
          font-size:12pt; color:rgb(0,0,0)">
          <br>
        </div>
        <hr tabindex="-1" style="display:inline-block; width:98%">
        <div id="divRplyFwdMsg" dir="ltr"><font style="font-size:11pt"
            face="Calibri, sans-serif" color="#000000"><b>From:</b>
            amd-gfx <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on
            behalf of Roy Sun <a class="moz-txt-link-rfc2396E" href="mailto:Roy.Sun@amd.com">&lt;Roy.Sun@amd.com&gt;</a><br>
            <b>Sent:</b> Monday, April 26, 2021 2:27 PM<br>
            <b>To:</b> <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
            <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
            <b>Cc:</b> Sun, Roy <a class="moz-txt-link-rfc2396E" href="mailto:Roy.Sun@amd.com">&lt;Roy.Sun@amd.com&gt;</a>; Nieto, David M
            <a class="moz-txt-link-rfc2396E" href="mailto:David.Nieto@amd.com">&lt;David.Nieto@amd.com&gt;</a><br>
            <b>Subject:</b> [PATCH 1/2] drm/scheduler: Change scheduled
            fence track</font>
          <div> </div>
        </div>
        <div class="BodyFragment"><font size="2"><span
              style="font-size:11pt">
              <div class="PlainText">Update the timestamp of scheduled
                fence on HW<br>
                completion of the previous fences<br>
                <br>
                This allow more accurate tracking of the fence<br>
                execution in HW<br>
                <br>
                Signed-off-by: David M Nieto <a class="moz-txt-link-rfc2396E" href="mailto:david.nieto@amd.com">&lt;david.nieto@amd.com&gt;</a><br>
                Signed-off-by: Roy Sun <a class="moz-txt-link-rfc2396E" href="mailto:Roy.Sun@amd.com">&lt;Roy.Sun@amd.com&gt;</a><br>
                ---<br>
                 drivers/gpu/drm/scheduler/sched_main.c | 12
                ++++++++++--<br>
                 1 file changed, 10 insertions(+), 2 deletions(-)<br>
                <br>
                diff --git a/drivers/gpu/drm/scheduler/sched_main.c
                b/drivers/gpu/drm/scheduler/sched_main.c<br>
                index 92d8de24d0a1..f8e39ab0c41b 100644<br>
                --- a/drivers/gpu/drm/scheduler/sched_main.c<br>
                +++ b/drivers/gpu/drm/scheduler/sched_main.c<br>
                @@ -515,7 +515,7 @@ void drm_sched_resubmit_jobs(struct
                drm_gpu_scheduler *sched)<br>
                 EXPORT_SYMBOL(drm_sched_resubmit_jobs);<br>
                 <br>
                 /**<br>
                - * drm_sched_resubmit_jobs_ext - helper to relunch
                certain number of jobs from mirror ring list<br>
                + * drm_sched_resubmit_jobs_ext - helper to relaunch
                certain number of jobs from pending list<br>
                  *<br>
                  * @sched: scheduler instance<br>
                  * @max: job numbers to relaunch<br>
                @@ -671,7 +671,7 @@ drm_sched_select_entity(struct
                drm_gpu_scheduler *sched)<br>
                 static struct drm_sched_job *<br>
                 drm_sched_get_cleanup_job(struct drm_gpu_scheduler
                *sched)<br>
                 {<br>
                -       struct drm_sched_job *job;<br>
                +       struct drm_sched_job *job, *next;<br>
                 <br>
                         /*<br>
                          * Don't destroy jobs while the timeout worker
                is running  OR thread<br>
                @@ -690,6 +690,14 @@ drm_sched_get_cleanup_job(struct
                drm_gpu_scheduler *sched)<br>
                         if (job &amp;&amp;
                dma_fence_is_signaled(&amp;job-&gt;s_fence-&gt;finished))
                {<br>
                                 /* remove job from pending_list */<br>
                                 list_del_init(&amp;job-&gt;list);<br>
                We just need to record the scheduled time of the next
                job. So we <br>
                need not to check the rest job.</div>
              <div class="PlainText"><br>
              </div>
              <div class="PlainText">[kevin]:</div>
              <div class="PlainText">ok, it is fine for me with the
                timestamp flag check.</div>
              <div class="PlainText">Reviewed-by: Kevin Wang
                <a class="moz-txt-link-rfc2396E" href="mailto:kevin1.wang@amd.com">&lt;kevin1.wang@amd.com&gt;</a></div>
            </span></font></div>
      </div>
    </blockquote>
    <br>
    Actually please drop that extra check.<br>
    <br>
    The timestamp is guaranteed to be set on the next job or otherwise
    we wouldn't got here in the first place.<br>
    <br>
    I've considered dropping the flag for quite a while and don't want
    any new users of this.<br>
    <br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:MN2PR12MB3022E9D72A4816C9A693F591A2429@MN2PR12MB3022.namprd12.prod.outlook.com">
      <div>
        <div class="BodyFragment"><font size="2"><span
              style="font-size:11pt">
              <div class="PlainText"><br>
                +               /* account for the next fence in the
                queue */<br>
                +               next =
                list_first_entry_or_null(&amp;sched-&gt;pending_list,<br>
                +                               struct drm_sched_job,
                list);<br>
                +               if (next &amp;&amp;
                test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,<br>
                +                      
                &amp;job-&gt;s_fence-&gt;finished.flags)) {<br>
                +                      
                next-&gt;s_fence-&gt;scheduled.timestamp =<br>
                +                              
                job-&gt;s_fence-&gt;finished.timestamp;<br>
                +               }<br>
                         } else {<br>
                                 job = NULL;<br>
                                 /* queue timeout for next job */<br>
                -- <br>
                2.31.1<br>
                <br>
                _______________________________________________<br>
                amd-gfx mailing list<br>
                <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                <a
href="https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7CKevin1.Wang%40amd.com%7C0cebaf8d37e144c6b82108d9087c502e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637550152295564379%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=Hdiil9BC2sp2pUI1121yZWELoCQqhDqTnbr7E9oVutw%3D&amp;amp;reserved=0"
                  moz-do-not-send="true">https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=04%7C01%7CKevin1.Wang%40amd.com%7C0cebaf8d37e144c6b82108d9087c502e%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637550152295564379%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;amp;sdata=Hdiil9BC2sp2pUI1121yZWELoCQqhDqTnbr7E9oVutw%3D&amp;amp;reserved=0</a><br>
              </div>
            </span></font></div>
      </div>
      <br>
      <fieldset class="mimeAttachmentHeader"></fieldset>
      <pre class="moz-quote-pre" wrap="">_______________________________________________
amd-gfx mailing list
<a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a>
<a class="moz-txt-link-freetext" href="https://lists.freedesktop.org/mailman/listinfo/amd-gfx">https://lists.freedesktop.org/mailman/listinfo/amd-gfx</a>
</pre>
    </blockquote>
    <br>
  </body>
</html>

--------------26723EFC46D8F59C564F2532--

--===============0649115471==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0649115471==--
