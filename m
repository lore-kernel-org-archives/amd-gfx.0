Return-Path: <SRS0=9a13=H5=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02603C433E0
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Feb 2021 16:07:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95C5964EC6
	for <amd-gfx@archiver.kernel.org>; Sat, 27 Feb 2021 16:07:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95C5964EC6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08C0D6E09C;
	Sat, 27 Feb 2021 16:07:49 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A90B6E09C
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Feb 2021 16:07:47 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id s8so14784082edd.5
 for <amd-gfx@lists.freedesktop.org>; Sat, 27 Feb 2021 08:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language;
 bh=c+nvz5E3S6cSqGZrLxD4Gs02fmJZV+gLXIKYerEy31Y=;
 b=FbpozByRWq7QcENzp+NjgL4cLOH1jixrw6I+fVmnewPFHvocjR/p5MJU6mAD8PNfjQ
 juyZRaG/lRTjZ9hHQHTN11MjrNRMYgYr0YYvYWUxbrnXrXr38CMgJjwRg4OrxcMk9Xq1
 k8OifIRLHz9jZHQcPu/afwjO8Lg4hG4JKdMKUKFvnxjbKursKnXbc795lkuvmOiIKfk3
 RsiFORgoWKspWTdabC3nd/loTjRJ63+8LRbcjSlOT8FJJRfmE4oduHnLm2NARuVXbfA3
 JO1R68FlbQit82FASyoUypu1g3WjOsyEQobLBG2eqlZYf2IEM0Xdgf+NGBSXD2qEO/6B
 Rwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language;
 bh=c+nvz5E3S6cSqGZrLxD4Gs02fmJZV+gLXIKYerEy31Y=;
 b=Kurc3Z3xpS/b4oAhZLVXZDlsK9nzhxacZx2SpoHm173KmHCDhGLH5hEBACF8WwrGqh
 jqgsCUhiZjXOV0yMj6DGP+yI1xE571PzxpZrRnNyD85/RQ2wifiZX9f6TI7Yl8TFBLJL
 JCnRxG1hSA4ZXIBFTlvdi0MaBxmEDQ9nXCFoVmpfaljxuKfc8VYIflj1ST9y32uip7xa
 77vUsEHvLrLIvf/+fGNweg2g5QOl4JlCAqX+VbYTDrJ7w4RAqq4ImosMnR3cmsPodH+A
 wPuKls3h/ZpHjbMuRI872NqhITavYekU4cVNMqmN3oDX2E3WNGxgIOTTXW9pbeaOLH1a
 8eCQ==
X-Gm-Message-State: AOAM531IXweuP3hwI498eX2lfCDLPd3MPcbLSmJSuwBydW6Ckc0kVHxj
 a1+08rihAhUMXY5LtLXE10s=
X-Google-Smtp-Source: ABdhPJwjzG0AdYDAo0nhldAAoOXvAEp8nUKaTbh2k9xMCcwcC1Y2ckANP1INSgGgJ3aK+LQ0XTu+7w==
X-Received: by 2002:aa7:c80d:: with SMTP id a13mr8795370edt.87.1614442066248; 
 Sat, 27 Feb 2021 08:07:46 -0800 (PST)
Received: from ?IPv6:2a02:908:1252:fb60:2178:7ac5:73a0:2a4e?
 ([2a02:908:1252:fb60:2178:7ac5:73a0:2a4e])
 by smtp.gmail.com with ESMTPSA id l6sm5916842edw.90.2021.02.27.08.07.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Feb 2021 08:07:45 -0800 (PST)
Subject: =?UTF-8?B?UmU6IOWbnuWkjTogW1JGQ10gYSBuZXcgYXBwcm9hY2ggdG8gZGV0ZWN0?=
 =?UTF-8?Q?_which_ring_is_the_real_black_sheep_upon_TDR_reported?=
To: "Liu, Monk" <Monk.Liu@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <DM5PR12MB1708D28565B445EABA872A3B849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
 <f65d8f80-a283-933a-82bb-97b415689460@amd.com>
 <DM5PR12MB17086F07E3EAC0C9CA03B94D849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
 <DM5PR12MB17084EADC1B4C8603C864E84849D9@DM5PR12MB1708.namprd12.prod.outlook.com>
 <60210231-7153-784a-d4d9-759a5b8b2180@amd.com>
 <DM5PR12MB1708E521038AD046F45943AE849C9@DM5PR12MB1708.namprd12.prod.outlook.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>
Message-ID: <99c3300b-45ad-5f38-0189-e94fac35299e@gmail.com>
Date: Sat, 27 Feb 2021 17:07:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <DM5PR12MB1708E521038AD046F45943AE849C9@DM5PR12MB1708.namprd12.prod.outlook.com>
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
Cc: "Zhang, Andy" <Andy.Zhang@amd.com>, "Chen, Horace" <Horace.Chen@amd.com>,
 "Zhang, Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: multipart/mixed; boundary="===============1488791926=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This is a multi-part message in MIME format.
--===============1488791926==
Content-Type: multipart/alternative;
 boundary="------------44D5FD16904ACCE2A35D1140"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------44D5FD16904ACCE2A35D1140
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 27.02.21 um 04:50 schrieb Liu, Monk:
>
> [AMD Official Use Only - Internal Distribution Only]
>
>
> the code I pasted is to illustrate why the innocent job is already 
> taken out in the mirror list thus my suggested proposal won’t work 
> unless we don’t delete the job in sched_job_timeout() routine, and the 
> problem you stated is with my understanding also kind of related with 
> my suggested solution – the job removing from list should be handled 
> by driver instead of scheduler .
>

Yes, exactly that's my thinking as well.

> let make scheduler’s duty clear and simple : the sched_job_timeout() 
> only get notification when a sched_job timedout but it doesn’t judge 
>  if the leading job in mirror list should be blamed , all those 
> checking should be left to driver to take action.
>

Need to get a detailed look, but it sounds correct as well.

> >>If we do this we should probably make it configurable as a module 
> parameter.
>
> That’s ok,  maybe we can reuse the existed parm “gpu_recovery”, extend 
> it with:
>
> l0 – no recovery initiated after job timeout
>
> l1 – legacy TDR behave
>
> l2 – enhanced TDR behave (the one suggested here)
>

Yes, something like that should work. Key point is we had a couple of 
people who already suggested to optimize the reset routine so that it 
doesn't take so long.

So far I pushed back on this because the reset routine isn't something I 
would optimize for speed. But when it starts to take something like 10 
seconds instead of halve a second because you had an extra long running 
compute job we will certainly see complains.

Regards,
Christian.

> *发件人:*Koenig, Christian <Christian.Koenig@amd.com>
> *发送时间:*2021年2月26日20:05
> *收件人:*Liu, Monk <Monk.Liu@amd.com>; amd-gfx@lists.freedesktop.org
> *抄送:*Zhang, Andy <Andy.Zhang@amd.com>; Chen, Horace 
> <Horace.Chen@amd.com>; Zhang, Jack (Jian) <Jack.Zhang1@amd.com>
> *主题:*Re: [RFC] a new approach to detect which ring is the real black 
> sheep upon TDR reported
>
> Yeah that is exactly the stuff which doesn't works at all. We got 
> feedback for multiple people that this whole approach of tying the job 
> to the tdr was not a good idea at all.
>
> What we should do instead is to have a pointer in the scheduler fence 
> to which job it belongs. Freeing up the job when the scheduler fence 
> is signaled is then job of the driver and not the scheduler any more.
>
> The scheduler then gives the scheduler fence to the driver when a 
> timeout is detected and the driver can do the rest of the handling all 
> by itself.
>
> But this problem is orthogonal to the suggested solution here.
>
>
>     do you have a better solution or idea we review it as another
>     candidate RFC ?
>
>
> I don't see much other option either. We could do something like only 
> allowing one application at a time to use the gfx/compute block, but 
> that would be even worse.
>
> If we do this we should probably make it configurable as a module 
> parameter.
>
> Regards,
> Christian.
>
> Am 26.02.21 um 12:57 schrieb Liu, Monk:
>
>     [AMD Official Use Only - Internal Distribution Only]
>
>     static void drm_sched_job_timedout(struct work_struct *work)
>
>     279 {
>
>     280     struct drm_gpu_scheduler *sched;
>
>     281     struct drm_sched_job *job;
>
>     282
>
>     283     sched = container_of(work, struct drm_gpu_scheduler,
>     work_tdr.work);
>
>     284
>
>     285     /* Protects against concurrent deletion in
>     drm_sched_get_cleanup_job */
>
>     *286 spin_lock(&sched->job_list_lock);*
>
>     *287     job = list_first_entry_or_null(&sched->ring_mirror_list,*
>
>     *288 struct drm_sched_job, node);*
>
>     *289*
>
>     *290     if (job) {*
>
>     *291         /**
>
>     *292          * Remove the bad job so it cannot be freed by
>     concurrent*
>
>     *293          * drm_sched_cleanup_jobs. It will be reinserted back
>     after sched->thread*
>
>     *294          * is parked at which point it's safe.*
>
>     *295          */*
>
>     *296 list_del_init(&job->node);*
>
>     *297 spin_unlock(&sched->job_list_lock);*
>
>     *298*
>
>     *299 job->sched->ops->timedout_job(job);*
>
>     Thanks
>
>     ------------------------------------------
>
>     Monk Liu | Cloud-GPU Core team
>
>     ------------------------------------------
>
>     *From:*Liu, Monk
>     *Sent:* Friday, February 26, 2021 7:54 PM
>     *To:* Koenig, Christian <Christian.Koenig@amd.com>
>     <mailto:Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org
>     <mailto:amd-gfx@lists.freedesktop.org>
>     *Cc:* Zhang, Andy <Andy.Zhang@amd.com>
>     <mailto:Andy.Zhang@amd.com>; Chen, Horace <Horace.Chen@amd.com>
>     <mailto:Horace.Chen@amd.com>; Zhang, Jack (Jian)
>     <Jack.Zhang1@amd.com> <mailto:Jack.Zhang1@amd.com>
>     *Subject:* RE: [RFC] a new approach to detect which ring is the
>     real black sheep upon TDR reported
>
>     [AMD Official Use Only - Internal Distribution Only]
>
>     See in line
>
>     Thanks
>
>     ------------------------------------------
>
>     Monk Liu | Cloud-GPU Core team
>
>     ------------------------------------------
>
>     *From:*Koenig, Christian <Christian.Koenig@amd.com
>     <mailto:Christian.Koenig@amd.com>>
>     *Sent:* Friday, February 26, 2021 3:58 PM
>     *To:* Liu, Monk <Monk.Liu@amd.com <mailto:Monk.Liu@amd.com>>;
>     amd-gfx@lists.freedesktop.org <mailto:amd-gfx@lists.freedesktop.org>
>     *Cc:* Zhang, Andy <Andy.Zhang@amd.com
>     <mailto:Andy.Zhang@amd.com>>; Chen, Horace <Horace.Chen@amd.com
>     <mailto:Horace.Chen@amd.com>>; Zhang, Jack (Jian)
>     <Jack.Zhang1@amd.com <mailto:Jack.Zhang1@amd.com>>
>     *Subject:* Re: [RFC] a new approach to detect which ring is the
>     real black sheep upon TDR reported
>
>     Hi Monk,
>
>     in general an interesting idea, but I see two major problems with
>     that:
>
>     1. It would make the reset take much longer.
>
>     2. Things get often stuck because of timing issues, so a guilty
>     job might pass perfectly when run a second time.
>
>     [ML] but the innocent ring already reported a TDR, and the drm
>     sched logic already deleted this “sched_job” in its mirror list,
>     thus you don’t have chance to re-submit it again after reset,
>     that’s the major problem here.
>
>     Apart from that the whole ring mirror list turned out to be a
>     really bad idea. E.g. we still struggle with object life time
>     because the concept doesn't fit into the object model of the GPU
>     scheduler under Linux.
>
>     We should probably work on this separately and straighten up the
>     job destruction once more and keep the recovery information in the
>     fence instead.
>
>     [ML] we claim to our customer that no innocent process will be
>     dropped or cancelled, and our current logic works for the most
>     time, but only when there are different process running on
>     gfx/computes rings then we would run into the tricky situation I
>     stated here, and the proposal is the only way I can figure out so
>     far, do you have a better solution or idea we review it as another
>     candidate RFC ? Be note that we raised this proposal is because we
>     do hit our trouble and we do need to resolve it …. So even a not
>     perfect solution is still better than just cancel the innocent job
>     (and their context/process)
>
>     Thanks !
>
>
>     Regards,
>     Christian.
>
>     Am 26.02.21 um 06:58 schrieb Liu, Monk:
>
>         [AMD Public Use]
>
>         Hi all
>
>         NAVI2X  project hit a really hard to solve issue now, and it
>         is turned out to be a general headache of our TDR mechanism ,
>         check below scenario:
>
>          1. There is a job1 running on compute1 ring at timestamp
>          2. There is a job2 running on gfx ring at timestamp
>          3. Job1 is the guilty one, and job1/job2 were scheduled to
>             their rings at almost the same timestamp
>          4. After 2 seconds we receive two TDR reporting from both GFX
>             ring and compute ring
>          5. *Current scheme is that in drm scheduler all the head jobs
>             of those two rings are considered “bad job” and taken away
>             from the mirror list *
>          6. The result is both the real guilty job (job1) and the
>             innocent job (job2) were all deleted from mirror list, and
>             their corresponding contexts were also treated as
>             guilty*(so the innocent process remains running is not
>             secured)*
>
>         **
>
>         But by our wish the ideal case is TDR mechanism can detect
>         which ring is the guilty ring and the innocent ring can
>         resubmits all its pending jobs:
>
>          1. Job1 to be deleted from compute1 ring’s mirror list
>          2. Job2 is kept and resubmitted later and its belonging
>             process/context are even not aware of this TDR at all
>
>         Here I have a proposal tend to achieve above goal and it rough
>         procedure is :
>
>          1. Once any ring reports a TDR, the head job is **not**
>             treated as “bad job”, and it is **not** deleted from the
>             mirror list in drm sched functions
>          2. In vendor’s function (our amdgpu driver here):
>
>               * reset GPU
>               * repeat below actions on each RINGS * one by one *:
>
>         1.take the head job and submit it on this ring
>
>         2.see if it completes, if not then this job is the real “bad job”
>
>         3. take it away from mirror list if this head job is “bad job”
>
>               * After above iteration on all RINGS, we already clears
>                 all the bad job(s)
>
>          3. Resubmit all jobs from each mirror list to their
>             corresponding rings (this is the existed logic)
>
>         The idea of this is to use “serial” way to re-run and re-check
>         each head job of each RING, in order to take out the real
>         black sheep and its guilty context.
>
>         P.S.: we can use this approaches only on GFX/KCQ ring reports
>         TDR , since those rings are intermutually affected to each
>         other. For SDMA ring timeout it definitely proves the head job
>         on SDMA ring is really guilty.
>
>         Thanks
>
>         ------------------------------------------
>
>         Monk Liu | Cloud-GPU Core team
>
>         ------------------------------------------
>
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx


--------------44D5FD16904ACCE2A35D1140
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    Am 27.02.21 um 04:50 schrieb Liu, Monk:<br>
    <blockquote type="cite"
cite="mid:DM5PR12MB1708E521038AD046F45943AE849C9@DM5PR12MB1708.namprd12.prod.outlook.com">
      <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
      <meta name="Generator" content="Microsoft Word 15 (filtered
        medium)">
      <style><!--
/* Font Definitions */
@font-face
	{font-family:Wingdings;
	panose-1:5 0 0 0 0 0 0 0 0 0;}
@font-face
	{font-family:宋体;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:等线;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@等线";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"\@宋体";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0cm;
	margin-right:0cm;
	margin-bottom:0cm;
	margin-left:36.0pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheader251902e5, li.msipheader251902e5, div.msipheader251902e5
	{mso-style-name:msipheader251902e5;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
p.msipheadera92f4c5c, li.msipheadera92f4c5c, div.msipheadera92f4c5c
	{mso-style-name:msipheadera92f4c5c;
	mso-margin-top-alt:auto;
	margin-right:0cm;
	mso-margin-bottom-alt:auto;
	margin-left:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:等线;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:503861270;
	mso-list-type:hybrid;
	mso-list-template-ids:1492292582 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:1279491622;
	mso-list-type:hybrid;
	mso-list-template-ids:-1736673670 67698703 67698689 67698703 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level2
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;
	font-family:Symbol;}
@list l1:level3
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2
	{mso-list-id:1593588455;
	mso-list-type:hybrid;
	mso-list-template-ids:-696075286 67698689 67698691 67698693 67698689 67698691 67698693 67698689 67698691 67698693;}
@list l2:level1
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:21.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level2
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:42.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level3
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:63.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level4
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:84.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level5
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:105.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level6
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:126.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level7
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:147.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level8
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:168.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l2:level9
	{mso-level-number-format:bullet;
	mso-level-text:;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:189.0pt;
	text-indent:-21.0pt;
	font-family:Wingdings;}
@list l3
	{mso-list-id:1655448059;
	mso-list-type:hybrid;
	mso-list-template-ids:-1584207202 67698703 67698713 67698715 67698703 67698713 67698715 67698703 67698713 67698715;}
@list l3:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l3:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l3:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l3:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l3:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l3:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l3:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l3:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-18.0pt;}
@list l3:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0cm;}
ul
	{margin-bottom:0cm;}
--></style><!--[if gte mso 9]><xml>
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
          <p class="MsoNormal"><span
              style="font-size:10.5pt;font-family:等线" lang="EN-US">the
              code I pasted is to illustrate why the innocent job is
              already taken out in the mirror list thus my suggested
              proposal won’t work unless we don’t delete the job in
              sched_job_timeout() routine, and the problem you stated is
              with my understanding also kind of related with my
              suggested solution – the job removing from list should be
              handled by driver instead of scheduler .</span></p>
        </div>
      </div>
    </blockquote>
    <br>
    Yes, exactly that's my thinking as well.<br>
    <br>
    <blockquote type="cite"
cite="mid:DM5PR12MB1708E521038AD046F45943AE849C9@DM5PR12MB1708.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span
              style="font-size:10.5pt;font-family:等线" lang="EN-US"><o:p></o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:10.5pt;font-family:等线" lang="EN-US"><o:p> </o:p></span><span
              style="font-size:10.5pt;font-family:等线" lang="EN-US">let
              make scheduler’s duty clear and simple : the
              sched_job_timeout() only get notification when a sched_job
              timedout but it doesn’t judge  if the leading job in
              mirror list should be blamed , all those checking should
              be left to driver to take action.</span></p>
        </div>
      </div>
    </blockquote>
    <br>
    Need to get a detailed look, but it sounds correct as well.<br>
    <br>
    <blockquote type="cite"
cite="mid:DM5PR12MB1708E521038AD046F45943AE849C9@DM5PR12MB1708.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <p class="MsoNormal"><span
              style="font-size:10.5pt;font-family:等线" lang="EN-US"><o:p></o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:10.5pt;font-family:等线" lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:10.5pt;font-family:等线" lang="EN-US">&gt;&gt;</span><span
              lang="EN-US"> If we do this we should probably make it
              configurable as a module parameter.<o:p></o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:10.5pt;font-family:等线" lang="EN-US">That’s
              ok,  maybe we can reuse the existed parm “gpu_recovery”,
              extend it with:<o:p></o:p></span></p>
          <p class="MsoListParagraph"
            style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l2
            level1 lfo6">
            <!--[if !supportLists]--><span
              style="font-size:10.5pt;font-family:Wingdings"
              lang="EN-US"><span style="mso-list:Ignore">l<span
                  style="font:7.0pt &quot;Times New Roman&quot;"> 
                </span></span></span><!--[endif]--><span
              style="font-size:10.5pt;font-family:等线" lang="EN-US">0 –
              no recovery initiated after job timeout<o:p></o:p></span></p>
          <p class="MsoListParagraph"
            style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l2
            level1 lfo6">
            <!--[if !supportLists]--><span
              style="font-size:10.5pt;font-family:Wingdings"
              lang="EN-US"><span style="mso-list:Ignore">l<span
                  style="font:7.0pt &quot;Times New Roman&quot;"> 
                </span></span></span><!--[endif]--><span
              style="font-size:10.5pt;font-family:等线" lang="EN-US">1 –
              legacy TDR behave
              <o:p></o:p></span></p>
          <p class="MsoListParagraph"
            style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l2
            level1 lfo6">
            <!--[if !supportLists]--><span
              style="font-size:10.5pt;font-family:Wingdings"
              lang="EN-US"><span style="mso-list:Ignore">l<span
                  style="font:7.0pt &quot;Times New Roman&quot;"> 
                </span></span></span><!--[endif]--><span
              style="font-size:10.5pt;font-family:等线" lang="EN-US">2 –
              enhanced TDR behave (the one suggested here)</span></p>
        </div>
      </div>
    </blockquote>
    <br>
    Yes, something like that should work. Key point is we had a couple
    of people who already suggested to optimize the reset routine so
    that it doesn't take so long.<br>
    <br>
    So far I pushed back on this because the reset routine isn't
    something I would optimize for speed. But when it starts to take
    something like 10 seconds instead of halve a second because you had
    an extra long running compute job we will certainly see complains.<br>
    <br>
    Regards,<br>
    Christian.<br>
    <br>
    <blockquote type="cite"
cite="mid:DM5PR12MB1708E521038AD046F45943AE849C9@DM5PR12MB1708.namprd12.prod.outlook.com">
      <div>
        <div class="WordSection1">
          <p class="MsoListParagraph"
            style="margin-left:21.0pt;text-indent:-21.0pt;mso-list:l2
            level1 lfo6"><span style="font-size:10.5pt;font-family:等线"
              lang="EN-US"><o:p></o:p></span></p>
          <p class="MsoNormal"><span
              style="font-size:10.5pt;font-family:等线" lang="EN-US"><o:p> </o:p></span></p>
          <div>
            <div style="border:none;border-top:solid #E1E1E1
              1.0pt;padding:3.0pt 0cm 0cm 0cm">
              <p class="MsoNormal"><b><span style="font-family:等线">发件人<span
                      lang="EN-US">:</span></span></b><span
                  style="font-family:等线" lang="EN-US"> Koenig, Christian
                  <a class="moz-txt-link-rfc2396E" href="mailto:Christian.Koenig@amd.com">&lt;Christian.Koenig@amd.com&gt;</a>
                  <br>
                </span><b><span style="font-family:等线">发送时间<span
                      lang="EN-US">:</span></span></b><span
                  style="font-family:等线" lang="EN-US"> 2021</span><span
                  style="font-family:等线">年<span lang="EN-US">2</span>月<span
                    lang="EN-US">26</span>日<span lang="EN-US"> 20:05<br>
                  </span><b>收件人<span lang="EN-US">:</span></b><span
                    lang="EN-US"> Liu, Monk <a class="moz-txt-link-rfc2396E" href="mailto:Monk.Liu@amd.com">&lt;Monk.Liu@amd.com&gt;</a>;
                    <a class="moz-txt-link-abbreviated" href="mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.org</a><br>
                  </span><b>抄送<span lang="EN-US">:</span></b><span
                    lang="EN-US"> Zhang, Andy
                    <a class="moz-txt-link-rfc2396E" href="mailto:Andy.Zhang@amd.com">&lt;Andy.Zhang@amd.com&gt;</a>; Chen, Horace
                    <a class="moz-txt-link-rfc2396E" href="mailto:Horace.Chen@amd.com">&lt;Horace.Chen@amd.com&gt;</a>; Zhang, Jack (Jian)
                    <a class="moz-txt-link-rfc2396E" href="mailto:Jack.Zhang1@amd.com">&lt;Jack.Zhang1@amd.com&gt;</a><br>
                  </span><b>主题<span lang="EN-US">:</span></b><span
                    lang="EN-US"> Re: [RFC] a new approach to detect
                    which ring is the real black sheep upon TDR reported<o:p></o:p></span></span></p>
            </div>
          </div>
          <p class="MsoNormal"><span lang="EN-US"><o:p> </o:p></span></p>
          <p class="MsoNormal"><span lang="EN-US">Yeah that is exactly
              the stuff which doesn't works at all. We got feedback for
              multiple people that this whole approach of tying the job
              to the tdr was not a good idea at all.<br>
              <br>
              What we should do instead is to have a pointer in the
              scheduler fence to which job it belongs. Freeing up the
              job when the scheduler fence is signaled is then job of
              the driver and not the scheduler any more.<br>
              <br>
              The scheduler then gives the scheduler fence to the driver
              when a timeout is detected and the driver can do the rest
              of the handling all by itself.<br>
              <br>
              But this problem is orthogonal to the suggested solution
              here.<br>
              <br>
              <br>
            </span><span style="font-size:12.0pt" lang="EN-US"><o:p></o:p></span></p>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="MsoNormal"><span lang="EN-US">do you have a better
                solution or idea we review it as another candidate RFC ?<o:p></o:p></span></p>
          </blockquote>
          <p class="MsoNormal" style="margin-bottom:12.0pt"><span
              lang="EN-US"><br>
              I don't see much other option either. We could do
              something like only allowing one application at a time to
              use the gfx/compute block, but that would be even worse.<br>
              <br>
              If we do this we should probably make it configurable as a
              module parameter.<br>
              <br>
              Regards,<br>
              Christian.<o:p></o:p></span></p>
          <div>
            <p class="MsoNormal"><span lang="EN-US">Am 26.02.21 um 12:57
                schrieb Liu, Monk:<o:p></o:p></span></p>
          </div>
          <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
            <p class="msipheadera92f4c5c" style="margin:0cm"><span
                style="font-family:&quot;Arial&quot;,sans-serif;color:#0078D7"
                lang="EN-US">[AMD Official Use Only - Internal
                Distribution Only]</span><span lang="EN-US"><o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">static void
                drm_sched_job_timedout(struct work_struct *work)<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">279 {<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">280     struct
                drm_gpu_scheduler *sched;<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">281     struct
                drm_sched_job *job;<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">282<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">283     sched =
                container_of(work, struct drm_gpu_scheduler,
                work_tdr.work);<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">284<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">285     /* Protects
                against concurrent deletion in drm_sched_get_cleanup_job
                */<o:p></o:p></span></p>
            <p class="MsoNormal"><b><span lang="EN-US">286    
                  spin_lock(&amp;sched-&gt;job_list_lock);</span></b><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="MsoNormal"><b><span lang="EN-US">287     job =
                  list_first_entry_or_null(&amp;sched-&gt;ring_mirror_list,</span></b><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="MsoNormal"><b><span lang="EN-US">288                       
                  struct drm_sched_job, node);</span></b><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="MsoNormal"><b><span lang="EN-US">289</span></b><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="MsoNormal"><b><span lang="EN-US">290     if (job)
                  {</span></b><span lang="EN-US"><o:p></o:p></span></p>
            <p class="MsoNormal"><b><span lang="EN-US">291         /*</span></b><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="MsoNormal"><b><span lang="EN-US">292          *
                  Remove the bad job so it cannot be freed by concurrent</span></b><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="MsoNormal"><b><span lang="EN-US">293          *
                  drm_sched_cleanup_jobs. It will be reinserted back
                  after sched-&gt;thread</span></b><span lang="EN-US"><o:p></o:p></span></p>
            <p class="MsoNormal"><b><span lang="EN-US">294          * is
                  parked at which point it's safe.</span></b><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="MsoNormal"><b><span lang="EN-US">295          */</span></b><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="MsoNormal"><b><span lang="EN-US">296        
                  list_del_init(&amp;job-&gt;node);</span></b><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="MsoNormal"><b><span lang="EN-US">297        
                  spin_unlock(&amp;sched-&gt;job_list_lock);</span></b><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="MsoNormal"><b><span lang="EN-US">298</span></b><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="MsoNormal"><b><span lang="EN-US">299        
                  job-&gt;sched-&gt;ops-&gt;timedout_job(job);</span></b><span
                lang="EN-US"><o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <div>
              <p class="MsoNormal"><span lang="EN-US">Thanks <o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">------------------------------------------<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">Monk Liu |
                  Cloud-GPU Core team<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">------------------------------------------<o:p></o:p></span></p>
            </div>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0cm 0cm 0cm">
                <p class="MsoNormal"><b><span lang="EN-US">From:</span></b><span
                    lang="EN-US"> Liu, Monk
                    <br>
                    <b>Sent:</b> Friday, February 26, 2021 7:54 PM<br>
                    <b>To:</b> Koenig, Christian <a
                      href="mailto:Christian.Koenig@amd.com"
                      moz-do-not-send="true">&lt;Christian.Koenig@amd.com&gt;</a>;
                    <a href="mailto:amd-gfx@lists.freedesktop.org"
                      moz-do-not-send="true">amd-gfx@lists.freedesktop.org</a><br>
                    <b>Cc:</b> Zhang, Andy <a
                      href="mailto:Andy.Zhang@amd.com"
                      moz-do-not-send="true">&lt;Andy.Zhang@amd.com&gt;</a>;
                    Chen, Horace
                    <a href="mailto:Horace.Chen@amd.com"
                      moz-do-not-send="true">&lt;Horace.Chen@amd.com&gt;</a>;
                    Zhang, Jack (Jian)
                    <a href="mailto:Jack.Zhang1@amd.com"
                      moz-do-not-send="true">&lt;Jack.Zhang1@amd.com&gt;</a><br>
                    <b>Subject:</b> RE: [RFC] a new approach to detect
                    which ring is the real black sheep upon TDR reported<o:p></o:p></span></p>
              </div>
            </div>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <p class="msipheadera92f4c5c" style="margin:0cm"><span
                style="font-family:&quot;Arial&quot;,sans-serif;color:#0078D7"
                lang="EN-US">[AMD Official Use Only - Internal
                Distribution Only]</span><span lang="EN-US"><o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US">See in line<o:p></o:p></span></p>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <div>
              <p class="MsoNormal"><span lang="EN-US">Thanks <o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">------------------------------------------<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">Monk Liu |
                  Cloud-GPU Core team<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">------------------------------------------<o:p></o:p></span></p>
            </div>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <div>
              <div style="border:none;border-top:solid #E1E1E1
                1.0pt;padding:3.0pt 0cm 0cm 0cm">
                <p class="MsoNormal"><b><span lang="EN-US">From:</span></b><span
                    lang="EN-US"> Koenig, Christian &lt;<a
                      href="mailto:Christian.Koenig@amd.com"
                      moz-do-not-send="true">Christian.Koenig@amd.com</a>&gt;
                    <br>
                    <b>Sent:</b> Friday, February 26, 2021 3:58 PM<br>
                    <b>To:</b> Liu, Monk &lt;<a
                      href="mailto:Monk.Liu@amd.com"
                      moz-do-not-send="true">Monk.Liu@amd.com</a>&gt;; <a
                      href="mailto:amd-gfx@lists.freedesktop.org"
                      moz-do-not-send="true">
                      amd-gfx@lists.freedesktop.org</a><br>
                    <b>Cc:</b> Zhang, Andy &lt;<a
                      href="mailto:Andy.Zhang@amd.com"
                      moz-do-not-send="true">Andy.Zhang@amd.com</a>&gt;;
                    Chen, Horace &lt;<a
                      href="mailto:Horace.Chen@amd.com"
                      moz-do-not-send="true">Horace.Chen@amd.com</a>&gt;;
                    Zhang, Jack (Jian) &lt;<a
                      href="mailto:Jack.Zhang1@amd.com"
                      moz-do-not-send="true">Jack.Zhang1@amd.com</a>&gt;<br>
                    <b>Subject:</b> Re: [RFC] a new approach to detect
                    which ring is the real black sheep upon TDR reported<o:p></o:p></span></p>
              </div>
            </div>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            <p class="MsoNormal" style="margin-bottom:12.0pt"><span
                lang="EN-US">Hi Monk,<br>
                <br>
                in general an interesting idea, but I see two major
                problems with that:<br>
                <br>
                1. It would make the reset take much longer.<br>
                <br>
                2. Things get often stuck because of timing issues, so a
                guilty job might pass perfectly when run a second time.<o:p></o:p></span></p>
            <p class="MsoNormal" style="margin-bottom:12.0pt"><span
                lang="EN-US">[ML] but the innocent ring already reported
                a TDR, and the drm sched logic already deleted this
                “sched_job” in its mirror list, thus you don’t have
                chance to re-submit it again after reset, that’s the
                major problem here.<br>
                <br>
                Apart from that the whole ring mirror list turned out to
                be a really bad idea. E.g. we still struggle with object
                life time because the concept doesn't fit into the
                object model of the GPU scheduler under Linux.<br>
                <br>
                We should probably work on this separately and
                straighten up the job destruction once more and keep the
                recovery information in the fence instead.<o:p></o:p></span></p>
            <p class="MsoNormal" style="margin-bottom:12.0pt"><span
                lang="EN-US">[ML] we claim to our customer that no
                innocent process will be dropped or cancelled, and our
                current logic works for the most time, but only when
                there are different process running on gfx/computes
                rings then we would run into the tricky situation I
                stated here, and the proposal is the only way I can
                figure out so far, do you have a better solution or idea
                we review it as another candidate RFC ? Be note that we
                raised this proposal is because we do hit our trouble
                and we do need to resolve it …. So even a not perfect
                solution is still better than just cancel the innocent
                job (and their context/process)<o:p></o:p></span></p>
            <p class="MsoNormal" style="margin-bottom:12.0pt"><span
                lang="EN-US">Thanks ! <o:p>
                </o:p></span></p>
            <p class="MsoNormal" style="margin-bottom:12.0pt"><span
                lang="EN-US"><br>
                Regards,<br>
                Christian.<o:p></o:p></span></p>
            <div>
              <p class="MsoNormal"><span lang="EN-US">Am 26.02.21 um
                  06:58 schrieb Liu, Monk:<o:p></o:p></span></p>
            </div>
            <blockquote style="margin-top:5.0pt;margin-bottom:5.0pt">
              <p class="msipheader251902e5" style="margin:0cm"><span
style="font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:#317100"
                  lang="EN-US">[AMD Public Use]</span><span lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">Hi all<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">NAVI2X  project
                  hit a really hard to solve issue now, and it is turned
                  out to be a general headache of our TDR mechanism ,
                  check below scenario:<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
              <ol style="margin-top:0cm" type="1" start="1">
                <li class="MsoListParagraph"
                  style="margin-left:0cm;mso-list:l0 level1 lfo1"><span
                    lang="EN-US">There is a job1 running on compute1
                    ring at timestamp
                    <o:p></o:p></span></li>
                <li class="MsoListParagraph"
                  style="margin-left:0cm;mso-list:l0 level1 lfo1"><span
                    lang="EN-US">There is a job2 running on gfx ring at
                    timestamp<o:p></o:p></span></li>
                <li class="MsoListParagraph"
                  style="margin-left:0cm;mso-list:l0 level1 lfo1"><span
                    lang="EN-US">Job1 is the guilty one, and job1/job2
                    were scheduled to their rings at almost the same
                    timestamp
                    <o:p></o:p></span></li>
                <li class="MsoListParagraph"
                  style="margin-left:0cm;mso-list:l0 level1 lfo1"><span
                    lang="EN-US">After 2 seconds we receive two TDR
                    reporting from both GFX ring and compute ring<o:p></o:p></span></li>
                <li class="MsoListParagraph"
                  style="margin-left:0cm;mso-list:l0 level1 lfo1"><b><span
                      lang="EN-US">Current scheme is that in drm
                      scheduler all the head jobs of those two rings are
                      considered “bad job” and taken away from the
                      mirror list
                    </span></b><span lang="EN-US"><o:p></o:p></span></li>
                <li class="MsoListParagraph"
                  style="margin-left:0cm;mso-list:l0 level1 lfo1"><span
                    lang="EN-US">The result is both the real guilty job
                    (job1) and the innocent job (job2) were all deleted
                    from mirror list, and their corresponding contexts
                    were also treated as guilty<b> (so the innocent
                      process remains running is not secured)</b><o:p></o:p></span></li>
              </ol>
              <p class="MsoListParagraph"><b><span lang="EN-US"> </span></b><span
                  lang="EN-US"><o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">But by our wish
                  the ideal case is TDR mechanism can detect which ring
                  is the guilty ring and the innocent ring can resubmits
                  all its pending jobs:<o:p></o:p></span></p>
              <ol style="margin-top:0cm" type="1" start="1">
                <li class="MsoListParagraph"
                  style="margin-left:0cm;mso-list:l3 level1 lfo2"><span
                    lang="EN-US">Job1 to be deleted from compute1 ring’s
                    mirror list<o:p></o:p></span></li>
                <li class="MsoListParagraph"
                  style="margin-left:0cm;mso-list:l3 level1 lfo2"><span
                    lang="EN-US">Job2 is kept and resubmitted later and
                    its belonging process/context are even not aware of
                    this TDR at all
                    <o:p></o:p></span></li>
              </ol>
              <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">Here I have a
                  proposal tend to achieve above goal and it rough
                  procedure is :<o:p></o:p></span></p>
              <ol style="margin-top:0cm" type="1" start="1">
                <li class="MsoListParagraph"
                  style="margin-left:0cm;mso-list:l1 level1 lfo3"><span
                    lang="EN-US">Once any ring reports a TDR, the head
                    job is *<b>not</b>* treated as “bad job”, and it is
                    *<b>not</b>* deleted from the mirror list in drm
                    sched functions<o:p></o:p></span></li>
                <li class="MsoListParagraph"
                  style="margin-left:0cm;mso-list:l1 level1 lfo3"><span
                    lang="EN-US">In vendor’s function (our amdgpu driver
                    here):<o:p></o:p></span></li>
              </ol>
              <ol style="margin-top:0cm" type="1" start="2">
                <ul style="margin-top:0cm" type="disc">
                  <li class="MsoListParagraph"
                    style="margin-left:0cm;mso-list:l1 level2 lfo3"><span
                      lang="EN-US">reset GPU<o:p></o:p></span></li>
                  <li class="MsoListParagraph"
                    style="margin-left:0cm;mso-list:l1 level2 lfo3"><span
                      lang="EN-US">repeat below actions on each RINGS *
                      one by one *:<o:p></o:p></span></li>
                </ul>
              </ol>
              <p class="MsoListParagraph"
                style="margin-left:108.0pt;text-indent:-9.0pt;mso-list:l1
                level3 lfo3">
                <!--[if !supportLists]--><span lang="EN-US"><span
                    style="mso-list:Ignore">1.<span style="font:7.0pt
                      &quot;Times New Roman&quot;">
                    </span></span></span><!--[endif]--><span
                  lang="EN-US">take the head job and submit it on this
                  ring<o:p></o:p></span></p>
              <p class="MsoListParagraph"
                style="margin-left:108.0pt;text-indent:-9.0pt;mso-list:l1
                level3 lfo3">
                <!--[if !supportLists]--><span lang="EN-US"><span
                    style="mso-list:Ignore">2.<span style="font:7.0pt
                      &quot;Times New Roman&quot;">
                    </span></span></span><!--[endif]--><span
                  lang="EN-US">see if it completes, if not then this job
                  is the real “bad job”<o:p></o:p></span></p>
              <p class="MsoListParagraph"
                style="margin-left:108.0pt;text-indent:-9.0pt;mso-list:l1
                level3 lfo3">
                <!--[if !supportLists]--><span lang="EN-US"><span
                    style="mso-list:Ignore">3.<span style="font:7.0pt
                      &quot;Times New Roman&quot;">
                    </span></span></span><!--[endif]--><span
                  lang="EN-US"> take it away from mirror list if this
                  head job is “bad job”<o:p></o:p></span></p>
              <ol style="margin-top:0cm" type="1" start="2">
                <ul style="margin-top:0cm" type="disc">
                  <li class="MsoListParagraph"
                    style="margin-left:0cm;mso-list:l1 level2 lfo3"><span
                      lang="EN-US">After above iteration on all RINGS,
                      we already clears all the bad job(s)<o:p></o:p></span></li>
                </ul>
              </ol>
              <ol style="margin-top:0cm" type="1" start="3">
                <li class="MsoListParagraph"
                  style="margin-left:0cm;mso-list:l1 level1 lfo3"><span
                    lang="EN-US">Resubmit all jobs from each mirror list
                    to their corresponding rings (this is the existed
                    logic)<o:p></o:p></span></li>
              </ol>
              <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">The idea of this
                  is to use “serial” way to re-run and re-check each
                  head job of each RING, in order to take out the real
                  black sheep and its guilty context.<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">P.S.: we can use
                  this approaches only on GFX/KCQ ring reports TDR ,
                  since those rings are intermutually affected to each
                  other. For SDMA ring timeout it definitely proves the
                  head job on SDMA ring is really guilty.<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">Thanks <o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">------------------------------------------<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">Monk Liu |
                  Cloud-GPU Core team<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US">------------------------------------------<o:p></o:p></span></p>
              <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
            </blockquote>
            <p class="MsoNormal"><span lang="EN-US"> <o:p></o:p></span></p>
          </blockquote>
          <p class="MsoNormal"><span
              style="font-size:12.0pt;font-family:宋体" lang="EN-US"><o:p> </o:p></span></p>
        </div>
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

--------------44D5FD16904ACCE2A35D1140--

--===============1488791926==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1488791926==--
