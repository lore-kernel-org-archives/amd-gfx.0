Return-Path: <SRS0=1eED=JZ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A4FC433B4
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 09:06:44 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42491613B1
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Apr 2021 09:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42491613B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A013E6E156;
	Wed, 28 Apr 2021 09:06:43 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E5246E156
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 09:06:41 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id u3so14833871eja.12
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Apr 2021 02:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=CFgmmN5GfQyM7QcDyAI04KzEC3fMC8Xko2cr1E2naXI=;
 b=ma7/ndcBW3C72/CvVb/BlagpHpVkah3TfukGmbq8cY/ZLWcCS7CWm49r7ImXyPy/M4
 mxOEYtE+PJIKB2qy3Kl0r5lZTDtMe8HKDh/I3fS0McqaSngbC7Gr7sE3Me061UUY6w+6
 MT+4gomGm51g68oqT6jFmy2ABGsz3NQJGTx3f9fZo8tHLgPynFA7DrXpQ5JX+gBmuW1G
 vk9H67X8x5Y3wEQer/E07CsqzWQHDLKTummP4AphMgIFUDZZuKo0sznDJ3ZSaNA2azof
 CiZIzpob/zAG0pIeIddwMVuwv/cDVrrqlHdZsZYF5/8UcDNpjyUn6ACQ+b51d1D3+n6n
 BSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=CFgmmN5GfQyM7QcDyAI04KzEC3fMC8Xko2cr1E2naXI=;
 b=eCBsQzPDdJyRTbqi3H7mdxaXOApYwLrLOaBt567IF64V2yHtGn9jm4M9xalXPP7tZM
 sQ3/b5DcwgQ2WasOcJuHY7p8i4epenS96IMN77vSOOGH+xICpEiAqD6f/iO/HjmYo3u7
 XgbJ6XfwMEQ2wNbX9G/CSYfmd/UQht+gUAuaC3IZ/EzGfpCZpWOYS97xlc3ZL2IWmZ4S
 34eG7KFf0iBZL+wFswBHwpNgnXoWRIc6IVwWW5CJQn1d9hMfl7uc+hoTmo9Hn7SdS/Hh
 q6EVrHxIOILferKB0Q51y0TEmXjT/dtmDk+9fPZoKMU6vtL/IpXthX3EDcUFaQjEO//y
 +C2w==
X-Gm-Message-State: AOAM530xkdWiJdjLH7OTfoeMahEBgRMchxg1TWzSZX9ghnJLrF5cLXrP
 7ZHWFpwrzYYbjbb1JUB6WSE=
X-Google-Smtp-Source: ABdhPJx9HjhaAxUXY37ihpsn6UL2XUIbB8ItXbJ/sqVbvGIfR66SORvDi8DHqzLxLG34K8JNO1RrMA==
X-Received: by 2002:a17:906:60d6:: with SMTP id
 f22mr27623679ejk.177.1619600800173; 
 Wed, 28 Apr 2021 02:06:40 -0700 (PDT)
Received: from ?IPv6:2a02:908:1252:fb60:3f0d:4946:a7a8:ad7c?
 ([2a02:908:1252:fb60:3f0d:4946:a7a8:ad7c])
 by smtp.gmail.com with ESMTPSA id g17sm577729edv.47.2021.04.28.02.06.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Apr 2021 02:06:39 -0700 (PDT)
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track
To: "Deng, Emily" <Emily.Deng@amd.com>,
 "Deucher, Alexander" <Alexander.Deucher@amd.com>
References: <20210426062701.39732-1-Roy.Sun@amd.com>
 <8b8ec884-5b0b-3409-b7b0-be7da43e3e71@gmail.com>
 <MN2PR12MB4488F5277BF26669E8D8673BF7429@MN2PR12MB4488.namprd12.prod.outlook.com>
 <MN2PR12MB44884F5635594C3F53D3F865F7429@MN2PR12MB4488.namprd12.prod.outlook.com>
 <df0aa92d-87b9-7c27-f06f-9e1a10cead5d@gmail.com>
 <MN2PR12MB44880E0C0FA8C75D7E28884AF7429@MN2PR12MB4488.namprd12.prod.outlook.com>
 <BY5PR12MB41150F5816B764A3E619AB4F8F409@BY5PR12MB4115.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <8529a53a-66ed-60a1-9ae4-279524e5a57f@gmail.com>
Date: Wed, 28 Apr 2021 11:06:38 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <BY5PR12MB41150F5816B764A3E619AB4F8F409@BY5PR12MB4115.namprd12.prod.outlook.com>
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
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>, "Sun, Roy" <Roy.Sun@amd.com>,
 "Nieto, David M" <David.Nieto@amd.com>
Content-Type: multipart/mixed; boundary="===============2142800290=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============2142800290==
Content-Type: multipart/alternative;
 boundary="------------73150BC57CCE78D8A277C4FD"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------73150BC57CCE78D8A277C4FD
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Well none. As I said I will push this upstream through drm-misc-next.

Christian.

Am 28.04.21 um 10:32 schrieb Deng, Emily:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> Hi Alex and Christian,
>
> What extra work Roy need to do about this patch? And fdinfo?
>
> Best wishes
>
> Emily Deng
>
> *From:* amd-gfx <amd-gfx-bounces@lists.freedesktop.org> *On Behalf Of 
> *Deucher, Alexander
> *Sent:* Tuesday, April 27, 2021 3:52 AM
> *To:* Christian König <ckoenig.leichtzumerken@gmail.com>
> *Cc:* Sun, Roy <Roy.Sun@amd.com>; amd-gfx list 
> <amd-gfx@lists.freedesktop.org>; Nieto, David M <David.Nieto@amd.com>
> *Subject:* Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track
>
> [AMD Official Use Only - Internal Distribution Only]
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Fair point. Either way works for me.
>
> Alex
>
> ------------------------------------------------------------------------
>
> *From:*Christian König <ckoenig.leichtzumerken@gmail.com 
> <mailto:ckoenig.leichtzumerken@gmail.com>>
> *Sent:* Monday, April 26, 2021 3:48 PM
> *To:* Deucher, Alexander <Alexander.Deucher@amd.com 
> <mailto:Alexander.Deucher@amd.com>>
> *Cc:* amd-gfx list <amd-gfx@lists.freedesktop.org 
> <mailto:amd-gfx@lists.freedesktop.org>>; Sun, Roy <Roy.Sun@amd.com 
> <mailto:Roy.Sun@amd.com>>; Nieto, David M <David.Nieto@amd.com 
> <mailto:David.Nieto@amd.com>>
> *Subject:* Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track
>
> My concern is more to get this tested from more people than just AMD.
>
> Christian.
>
> Am 26.04.21 um 21:40 schrieb Deucher, Alexander:
>
>     [AMD Official Use Only - Internal Distribution Only]
>
>     That said, it would be easier for me to merge through the AMD tree
>     since a relatively big AMD feature depends on it.  Not sure how
>     much conflict potential there is if this goes through the AMD tree.
>
>     Alex
>
>     ------------------------------------------------------------------------
>
>     *From:*amd-gfx <amd-gfx-bounces@lists.freedesktop.org>
>     <mailto:amd-gfx-bounces@lists.freedesktop.org> on behalf of
>     Deucher, Alexander <Alexander.Deucher@amd.com>
>     <mailto:Alexander.Deucher@amd.com>
>     *Sent:* Monday, April 26, 2021 3:24 PM
>     *To:* Christian König <ckoenig.leichtzumerken@gmail.com>
>     <mailto:ckoenig.leichtzumerken@gmail.com>
>     *Cc:* amd-gfx list <amd-gfx@lists.freedesktop.org>
>     <mailto:amd-gfx@lists.freedesktop.org>; Sun, Roy <Roy.Sun@amd.com>
>     <mailto:Roy.Sun@amd.com>; Nieto, David M <David.Nieto@amd.com>
>     <mailto:David.Nieto@amd.com>
>     *Subject:* Re: [PATCH 1/2] drm/scheduler: Change scheduled fence
>     track
>
>     [AMD Official Use Only - Internal Distribution Only]
>
>     [AMD Official Use Only - Internal Distribution Only]
>
>     No objections from me.
>
>     Thanks!
>
>     Alex
>
>     ------------------------------------------------------------------------
>
>     *From:*Christian König <ckoenig.leichtzumerken@gmail.com>
>     <mailto:ckoenig.leichtzumerken@gmail.com>
>     *Sent:* Monday, April 26, 2021 2:49 AM
>     *To:* Deucher, Alexander <Alexander.Deucher@amd.com>
>     <mailto:Alexander.Deucher@amd.com>
>     *Cc:* Nieto, David M <David.Nieto@amd.com>
>     <mailto:David.Nieto@amd.com>; Sun, Roy <Roy.Sun@amd.com>
>     <mailto:Roy.Sun@amd.com>; amd-gfx list
>     <amd-gfx@lists.freedesktop.org> <mailto:amd-gfx@lists.freedesktop.org>
>     *Subject:* Re: [PATCH 1/2] drm/scheduler: Change scheduled fence
>     track
>
>     Hey Alex,
>
>     any objections that we merge those two patches through drm-misc-next?
>
>     Thanks,
>     Christian.
>
>     Am 26.04.21 um 08:27 schrieb Roy Sun:
>     > Update the timestamp of scheduled fence on HW
>     > completion of the previous fences
>     >
>     > This allow more accurate tracking of the fence
>     > execution in HW
>     >
>     > Signed-off-by: David M Nieto <david.nieto@amd.com>
>     <mailto:david.nieto@amd.com>
>     > Signed-off-by: Roy Sun <Roy.Sun@amd.com> <mailto:Roy.Sun@amd.com>
>     > ---
>     > drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++++++--
>     >   1 file changed, 10 insertions(+), 2 deletions(-)
>     >
>     > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
>     b/drivers/gpu/drm/scheduler/sched_main.c
>     > index 92d8de24d0a1..f8e39ab0c41b 100644
>     > --- a/drivers/gpu/drm/scheduler/sched_main.c
>     > +++ b/drivers/gpu/drm/scheduler/sched_main.c
>     > @@ -515,7 +515,7 @@ void drm_sched_resubmit_jobs(struct
>     drm_gpu_scheduler *sched)
>     > EXPORT_SYMBOL(drm_sched_resubmit_jobs);
>     >
>     >   /**
>     > - * drm_sched_resubmit_jobs_ext - helper to relunch certain
>     number of jobs from mirror ring list
>     > + * drm_sched_resubmit_jobs_ext - helper to relaunch certain
>     number of jobs from pending list
>     >    *
>     >    * @sched: scheduler instance
>     >    * @max: job numbers to relaunch
>     > @@ -671,7 +671,7 @@ drm_sched_select_entity(struct
>     drm_gpu_scheduler *sched)
>     >   static struct drm_sched_job *
>     > drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
>     >   {
>     > -     struct drm_sched_job *job;
>     > +     struct drm_sched_job *job, *next;
>     >
>     >        /*
>     >         * Don't destroy jobs while the timeout worker is running
>     OR thread
>     > @@ -690,6 +690,14 @@ drm_sched_get_cleanup_job(struct
>     drm_gpu_scheduler *sched)
>     >        if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
>     >                /* remove job from pending_list */
>     > list_del_init(&job->list);
>     > We just need to record the scheduled time of the next job. So we
>     > need not to check the rest job.
>     > +             /* account for the next fence in the queue */
>     > +             next = list_first_entry_or_null(&sched->pending_list,
>     > + struct drm_sched_job, list);
>     > +             if (next && test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
>     > + &job->s_fence->finished.flags)) {
>     > + next->s_fence->scheduled.timestamp =
>     > + job->s_fence->finished.timestamp;
>     > +             }
>     >        } else {
>     >                job = NULL;
>     >                /* queue timeout for next job */
>


--------------73150BC57CCE78D8A277C4FD
Content-Type: text/html; charset=windows-1252
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html;
      charset=windows-1252">
  </head>
  <body>
    Well none. As I said I will push this upstream through
    drm-misc-next.<br>
    <br>
    Christian.<br>
    <br>
    <div class="moz-cite-prefix">Am 28.04.21 um 10:32 schrieb Deng,
      Emily:<br>
    </div>
    <blockquote type="cite"
cite="mid:BY5PR12MB41150F5816B764A3E619AB4F8F409@BY5PR12MB4115.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html;
        charset=windows-1252">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]-->
      <style>@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}span.EmailStyle20
	{mso-style-type:personal-reply;
	font-family:"Calibri",sans-serif;
	color:windowtext;}.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}div.WordSection1
	{page:WordSection1;}</style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext="edit" spidmax="1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext="edit">
<o:idmap v:ext="edit" data="1" />
</o:shapelayout></xml><![endif]-->
      <p
        style="font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;"
        align="Left">
        [AMD Official Use Only - Internal Distribution Only]<br>
      </p>
      <br>
      <div>
        <div class="WordSection1">
          <p class="MsoNormal">Hi Alex and Christian,<o:p></o:p></p>
          <p class="MsoNormal" style="text-indent:10.0pt">What extra
            work Roy need to do about this patch? And fdinfo?<o:p></o:p></p>
          <p class="MsoNormal"><o:p> </o:p></p>
          <p class="MsoNormal">Best wishes<o:p></o:p></p>
          <p class="MsoNormal">Emily Deng<o:p></o:p></p>
          <div style="border:none;border-left:solid blue
            1.5pt;padding:0in 0in 0in 4.0pt">
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0in 0in 0in">
                <p class="MsoNormal"><b>From:</b> amd-gfx
                  <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx-bounces@lists.freedesktop.org">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
                  <b>On Behalf Of </b>Deucher, Alexander<br>
                  <b>Sent:</b> Tuesday, April 27, 2021 3:52 AM<br>
                  <b>To:</b> Christian König
                  <a class="moz-txt-link-rfc2396E" href="mailto:ckoenig.leichtzumerken@gmail.com">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                  <b>Cc:</b> Sun, Roy <a class="moz-txt-link-rfc2396E" href="mailto:Roy.Sun@amd.com">&lt;Roy.Sun@amd.com&gt;</a>; amd-gfx
                  list <a class="moz-txt-link-rfc2396E" href="mailto:amd-gfx@lists.freedesktop.org">&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Nieto,
                  David M <a class="moz-txt-link-rfc2396E" href="mailto:David.Nieto@amd.com">&lt;David.Nieto@amd.com&gt;</a><br>
                  <b>Subject:</b> Re: [PATCH 1/2] drm/scheduler: Change
                  scheduled fence track<o:p></o:p></p>
              </div>
            </div>
            <p class="MsoNormal"><o:p> </o:p></p>
            <p style="margin:5.0pt"><span
                style="font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
                Official Use Only - Internal Distribution Only]<o:p></o:p></span></p>
            <p class="MsoNormal"><o:p> </o:p></p>
            <div>
              <p style="margin:5.0pt"><span
                  style="font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
                  Official Use Only - Internal Distribution Only]<o:p></o:p></span></p>
              <p class="MsoNormal"><o:p> </o:p></p>
              <div>
                <div>
                  <p class="MsoNormal"><span
                      style="font-size:12.0pt;color:black">Fair point. 
                      Either way works for me.<o:p></o:p></span></p>
                </div>
                <div>
                  <p class="MsoNormal"><span
                      style="font-size:12.0pt;color:black"><o:p> </o:p></span></p>
                </div>
                <div>
                  <p class="MsoNormal"><span
                      style="font-size:12.0pt;color:black">Alex<o:p></o:p></span></p>
                </div>
                <div class="MsoNormal" style="text-align:center"
                  align="center">
                  <hr width="98%" size="2" align="center">
                </div>
                <div id="divRplyFwdMsg">
                  <p class="MsoNormal"><b><span style="color:black">From:</span></b><span
                      style="color:black"> Christian König &lt;<a
                        href="mailto:ckoenig.leichtzumerken@gmail.com"
                        moz-do-not-send="true">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
                      <b>Sent:</b> Monday, April 26, 2021 3:48 PM<br>
                      <b>To:</b> Deucher, Alexander &lt;<a
                        href="mailto:Alexander.Deucher@amd.com"
                        moz-do-not-send="true">Alexander.Deucher@amd.com</a>&gt;<br>
                      <b>Cc:</b> amd-gfx list &lt;<a
                        href="mailto:amd-gfx@lists.freedesktop.org"
                        moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a>&gt;;
                      Sun, Roy &lt;<a href="mailto:Roy.Sun@amd.com"
                        moz-do-not-send="true">Roy.Sun@amd.com</a>&gt;;
                      Nieto, David M &lt;<a
                        href="mailto:David.Nieto@amd.com"
                        moz-do-not-send="true">David.Nieto@amd.com</a>&gt;<br>
                      <b>Subject:</b> Re: [PATCH 1/2] drm/scheduler:
                      Change scheduled fence track</span>
                    <o:p></o:p></p>
                  <div>
                    <p class="MsoNormal"> <o:p></o:p></p>
                  </div>
                </div>
                <div>
                  <p class="MsoNormal" style="margin-bottom:12.0pt">My
                    concern is more to get this tested from more people
                    than just AMD.<br>
                    <br>
                    Christian.<o:p></o:p></p>
                  <div>
                    <p class="MsoNormal">Am 26.04.21 um 21:40 schrieb
                      Deucher, Alexander:<o:p></o:p></p>
                  </div>
                  <blockquote
                    style="margin-top:5.0pt;margin-bottom:5.0pt">
                    <p style="margin:5.0pt"><span
                        style="font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
                        Official Use Only - Internal Distribution Only]<o:p></o:p></span></p>
                    <p class="MsoNormal"><o:p> </o:p></p>
                    <div>
                      <div>
                        <p class="MsoNormal"><span
                            style="font-size:12.0pt;color:black">That
                            said, it would be easier for me to merge
                            through the AMD tree since a relatively big
                            AMD feature depends on it.  Not sure how
                            much conflict potential there is if this
                            goes through the AMD tree.<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span
                            style="font-size:12.0pt;color:black"><o:p> </o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span
                            style="font-size:12.0pt;color:black">Alex<o:p></o:p></span></p>
                      </div>
                      <div>
                        <p class="MsoNormal"><span
                            style="font-size:12.0pt;color:black"><o:p> </o:p></span></p>
                      </div>
                      <div class="MsoNormal" style="text-align:center"
                        align="center">
                        <hr width="98%" size="2" align="center">
                      </div>
                      <div id="x_divRplyFwdMsg">
                        <p class="MsoNormal"><b><span
                              style="color:black">From:</span></b><span
                            style="color:black"> amd-gfx
                            <a
                              href="mailto:amd-gfx-bounces@lists.freedesktop.org"
                              moz-do-not-send="true">&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a>
                            on behalf of Deucher, Alexander
                            <a href="mailto:Alexander.Deucher@amd.com"
                              moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a><br>
                            <b>Sent:</b> Monday, April 26, 2021 3:24 PM<br>
                            <b>To:</b> Christian König <a
                              href="mailto:ckoenig.leichtzumerken@gmail.com"
                              moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                            <b>Cc:</b> amd-gfx list <a
                              href="mailto:amd-gfx@lists.freedesktop.org"
                              moz-do-not-send="true">&lt;amd-gfx@lists.freedesktop.org&gt;</a>;
                            Sun, Roy
                            <a href="mailto:Roy.Sun@amd.com"
                              moz-do-not-send="true">&lt;Roy.Sun@amd.com&gt;</a>;
                            Nieto, David M <a
                              href="mailto:David.Nieto@amd.com"
                              moz-do-not-send="true">
                              &lt;David.Nieto@amd.com&gt;</a><br>
                            <b>Subject:</b> Re: [PATCH 1/2]
                            drm/scheduler: Change scheduled fence track</span>
                          <o:p></o:p></p>
                        <div>
                          <p class="MsoNormal"> <o:p></o:p></p>
                        </div>
                      </div>
                      <div>
                        <p style="margin:5.0pt"><span
                            style="font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
                            Official Use Only - Internal Distribution
                            Only]<o:p></o:p></span></p>
                        <p class="MsoNormal"><o:p> </o:p></p>
                        <div>
                          <p style="margin:5.0pt"><span
                              style="font-family:&quot;Arial&quot;,sans-serif;color:#0078D7">[AMD
                              Official Use Only - Internal Distribution
                              Only]<o:p></o:p></span></p>
                          <p class="MsoNormal"><o:p> </o:p></p>
                          <div>
                            <div>
                              <p class="MsoNormal"><span
                                  style="font-size:12.0pt;color:black">No
                                  objections from me.<o:p></o:p></span></p>
                            </div>
                            <div>
                              <p class="MsoNormal"><span
                                  style="font-size:12.0pt;color:black"><o:p> </o:p></span></p>
                            </div>
                            <div>
                              <p class="MsoNormal"><span
                                  style="font-size:12.0pt;color:black">Thanks!<o:p></o:p></span></p>
                            </div>
                            <div>
                              <p class="MsoNormal"><span
                                  style="font-size:12.0pt;color:black"><o:p> </o:p></span></p>
                            </div>
                            <div>
                              <p class="MsoNormal"><span
                                  style="font-size:12.0pt;color:black">Alex<o:p></o:p></span></p>
                            </div>
                            <div>
                              <p class="MsoNormal"><span
                                  style="font-size:12.0pt;color:black"><o:p> </o:p></span></p>
                            </div>
                            <div class="MsoNormal"
                              style="text-align:center" align="center">
                              <hr width="98%" size="2" align="center">
                            </div>
                            <div id="x_x_divRplyFwdMsg">
                              <p class="MsoNormal"><b><span
                                    style="color:black">From:</span></b><span
                                  style="color:black"> Christian König
                                  <a
                                    href="mailto:ckoenig.leichtzumerken@gmail.com"
                                    moz-do-not-send="true">&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
                                  <b>Sent:</b> Monday, April 26, 2021
                                  2:49 AM<br>
                                  <b>To:</b> Deucher, Alexander <a
                                    href="mailto:Alexander.Deucher@amd.com"
                                    moz-do-not-send="true">&lt;Alexander.Deucher@amd.com&gt;</a><br>
                                  <b>Cc:</b> Nieto, David M <a
                                    href="mailto:David.Nieto@amd.com"
                                    moz-do-not-send="true">&lt;David.Nieto@amd.com&gt;</a>;
                                  Sun, Roy
                                  <a href="mailto:Roy.Sun@amd.com"
                                    moz-do-not-send="true">&lt;Roy.Sun@amd.com&gt;</a>;
                                  amd-gfx list <a
                                    href="mailto:amd-gfx@lists.freedesktop.org"
                                    moz-do-not-send="true">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
                                  <b>Subject:</b> Re: [PATCH 1/2]
                                  drm/scheduler: Change scheduled fence
                                  track</span>
                                <o:p></o:p></p>
                              <div>
                                <p class="MsoNormal"> <o:p></o:p></p>
                              </div>
                            </div>
                            <div>
                              <div>
                                <p class="MsoNormal"
                                  style="margin-bottom:12.0pt">Hey Alex,<br>
                                  <br>
                                  any objections that we merge those two
                                  patches through drm-misc-next?<br>
                                  <br>
                                  Thanks,<br>
                                  Christian.<br>
                                  <br>
                                  Am 26.04.21 um 08:27 schrieb Roy Sun:<br>
                                  &gt; Update the timestamp of scheduled
                                  fence on HW<br>
                                  &gt; completion of the previous fences<br>
                                  &gt;<br>
                                  &gt; This allow more accurate tracking
                                  of the fence<br>
                                  &gt; execution in HW<br>
                                  &gt;<br>
                                  &gt; Signed-off-by: David M Nieto <a
                                    href="mailto:david.nieto@amd.com"
                                    moz-do-not-send="true">&lt;david.nieto@amd.com&gt;</a><br>
                                  &gt; Signed-off-by: Roy Sun <a
                                    href="mailto:Roy.Sun@amd.com"
                                    moz-do-not-send="true">&lt;Roy.Sun@amd.com&gt;</a><br>
                                  &gt; ---<br>
                                  &gt;  
                                  drivers/gpu/drm/scheduler/sched_main.c
                                  | 12 ++++++++++--<br>
                                  &gt;   1 file changed, 10
                                  insertions(+), 2 deletions(-)<br>
                                  &gt;<br>
                                  &gt; diff --git
                                  a/drivers/gpu/drm/scheduler/sched_main.c
b/drivers/gpu/drm/scheduler/sched_main.c<br>
                                  &gt; index 92d8de24d0a1..f8e39ab0c41b
                                  100644<br>
                                  &gt; ---
                                  a/drivers/gpu/drm/scheduler/sched_main.c<br>
                                  &gt; +++
                                  b/drivers/gpu/drm/scheduler/sched_main.c<br>
                                  &gt; @@ -515,7 +515,7 @@ void
                                  drm_sched_resubmit_jobs(struct
                                  drm_gpu_scheduler *sched)<br>
                                  &gt;  
                                  EXPORT_SYMBOL(drm_sched_resubmit_jobs);<br>
                                  &gt;   <br>
                                  &gt;   /**<br>
                                  &gt; - * drm_sched_resubmit_jobs_ext -
                                  helper to relunch certain number of
                                  jobs from mirror ring list<br>
                                  &gt; + * drm_sched_resubmit_jobs_ext -
                                  helper to relaunch certain number of
                                  jobs from pending list<br>
                                  &gt;    *<br>
                                  &gt;    * @sched: scheduler instance<br>
                                  &gt;    * @max: job numbers to
                                  relaunch<br>
                                  &gt; @@ -671,7 +671,7 @@
                                  drm_sched_select_entity(struct
                                  drm_gpu_scheduler *sched)<br>
                                  &gt;   static struct drm_sched_job *<br>
                                  &gt;  
                                  drm_sched_get_cleanup_job(struct
                                  drm_gpu_scheduler *sched)<br>
                                  &gt;   {<br>
                                  &gt; -     struct drm_sched_job *job;<br>
                                  &gt; +     struct drm_sched_job *job,
                                  *next;<br>
                                  &gt;   <br>
                                  &gt;        /*<br>
                                  &gt;         * Don't destroy jobs
                                  while the timeout worker is running 
                                  OR thread<br>
                                  &gt; @@ -690,6 +690,14 @@
                                  drm_sched_get_cleanup_job(struct
                                  drm_gpu_scheduler *sched)<br>
                                  &gt;        if (job &amp;&amp;
                                  dma_fence_is_signaled(&amp;job-&gt;s_fence-&gt;finished))
                                  {<br>
                                  &gt;                /* remove job from
                                  pending_list */<br>
                                  &gt;               
                                  list_del_init(&amp;job-&gt;list);<br>
                                  &gt; We just need to record the
                                  scheduled time of the next job. So we<br>
                                  &gt; need not to check the rest job.<br>
                                  &gt; +             /* account for the
                                  next fence in the queue */<br>
                                  &gt; +             next =
                                  list_first_entry_or_null(&amp;sched-&gt;pending_list,<br>
                                  &gt; +                            
                                  struct drm_sched_job, list);<br>
                                  &gt; +             if (next &amp;&amp;
                                  test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,<br>
                                  &gt; +                    
                                  &amp;job-&gt;s_fence-&gt;finished.flags))
                                  {<br>
                                  &gt; +                    
                                  next-&gt;s_fence-&gt;scheduled.timestamp
                                  =<br>
                                  &gt; +                            
                                  job-&gt;s_fence-&gt;finished.timestamp;<br>
                                  &gt; +             }<br>
                                  &gt;        } else {<br>
                                  &gt;                job = NULL;<br>
                                  &gt;                /* queue timeout
                                  for next job */<o:p></o:p></p>
                              </div>
                            </div>
                          </div>
                        </div>
                      </div>
                    </div>
                  </blockquote>
                  <p class="MsoNormal"><o:p> </o:p></p>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </blockquote>
    <br>
  </body>
</html>

--------------73150BC57CCE78D8A277C4FD--

--===============2142800290==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============2142800290==--
