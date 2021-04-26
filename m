Return-Path: <SRS0=K+jV=JX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32741C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 19:24:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DED95611C1
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 19:24:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED95611C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D2716E86F;
	Mon, 26 Apr 2021 19:24:09 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam07on2081.outbound.protection.outlook.com [40.107.95.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF5D96E86F
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 19:24:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I9Lxq/DcyX+c1XaotznyH7Sl7+qMCmlFygJPXAgw5rEshTJBtgtp0gpWfoE8O+M+qs3BouaJjgQ/49r0S8qCfjflfmRROf39e4uh5Q7/AZ8pCb/A2k1iX8gWdkCoJ6HUR9y1s2JwEwJ0gHiF8KeagZW/1kGDXPUEO80mu8GsvjgL/dSaQwXhY+ls1b+NDe11bmdIvvmvHB/WcIuph6Ejp3WehQyifpZk3dzew8gpt2aYWh8LQ2+yauERKgRAFdWUPnDIlZYRCEGpXv+c1NogyZnd9FTRcA2gSdJWi1MQGp+tpED5Y0S1jc9zDZRrz57eh85vUoOP4n2cvOSIbFBnrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3PpNaoAE7VvDInaVPKyblPFyfXdIzQVz7hKQiv7q+M=;
 b=lUk8yduyP2e32J0L8/WoQeJa0sEjoooq2KtEO96DkPiJRdkVz74PfHeW4VG+ZL24EgMPKa56dJfCcMhw4/6DZU9/DF0QFjvnLDnQMj2fKVghoZ3+MKkHvlnwIEc4OVufXPs+ui/NsKCGnTgviNltjXYldE0hcJcfutcFc+9JLdHPVxVYjbHmMYWlmu1S8HUI2VHQy9bXeVKwVw61W7a/gg9KWL9b4BOqJu6K0jTy/NSMegdYD5tRp1Yqshqt2ERAitudYCvM6pYqOBFBzlBWdp//I4B/jZekxu68ezWmhebEhqVtvBFRo5Un7qpqc+9yPf2nGmx/vEldGixrjLL+0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3PpNaoAE7VvDInaVPKyblPFyfXdIzQVz7hKQiv7q+M=;
 b=l31f3mF9UXenuCeFHgxIeNhQ1PnE/HT2Tsf0IekriHOM4zYqJCmkzuEGGxwOB+V3BddZYYFPOUt2yU4ifknm2DhhdUJDZusZfoqGaSC/veV+NK0uL/4ZT5hYwDuaPw1iztIGEZNBCBOvzo0nJS/yQhfIQT+/HdoagxQvXasD60o=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by BL0PR12MB2371.namprd12.prod.outlook.com (2603:10b6:207:3e::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.23; Mon, 26 Apr
 2021 19:24:07 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%7]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 19:24:06 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Thread-Topic: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Thread-Index: AQHXOmUt+yIB0uN3xU+WV+JUDZ9yXKrGW78AgADS2y8=
Date: Mon, 26 Apr 2021 19:24:06 +0000
Message-ID: <MN2PR12MB4488F5277BF26669E8D8673BF7429@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210426062701.39732-1-Roy.Sun@amd.com>,
 <8b8ec884-5b0b-3409-b7b0-be7da43e3e71@gmail.com>
In-Reply-To: <8b8ec884-5b0b-3409-b7b0-be7da43e3e71@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-26T19:24:06.186Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90874819-cdb8-4a1b-cd9f-08d908e8dc34
x-ms-traffictypediagnostic: BL0PR12MB2371:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB237125907D13C2335006683FF7429@BL0PR12MB2371.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1388;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VvNIHR8caG9qe01rXWI64afj4lnFmgLZaB83DW5T1rjFxxUn3+eadZqJTZ/dGFg6+mF3EAKgNRADU1y4f7rRNVIeeEKHByulPo2y4HVw+CFNkcGCxaFdbjiYzLBZ1PR43HYNQGJevi91EzDb2qUad+A+twb75XwFT05vTm+YNIb6LT1o1nFhg5ZnyKT17qsmyofar1X0Fu+NPItGSxQUztCABnTrcjdDmIZEBaFVHHMRXEyq2biotaPzpivVCdkClBULlUxN4Tj9a8nGv+JSiVRJRgalkm4LqyD1lni3cWEzwpN0odNkfLchJ22R+VVoNjNUrQAMk1lkgnEkyWRE7MIq3lw5/KdSOh0v5LIeSFNywijQCPb7GJ9uP/8XygdcIqwoAoIm2JsedW63V8zDyXWBGA3prjd71ufvaAeXf4CqYziGmCGczyTlg5mhZO+8mTuUzJlICrLGnzysa0hWKDHQ3egjLd9T2cwyU5s5IPEOk9SOXFq1KzLDc0KV5sak9MvYDlBoXz4hF2gNXECX43uJtt+cSJNwpkIwpxb3G3nOTyu/QE7ZpMxTgemylvz/46Ue9lhCIfIfzBBZz/ovYrgxmojivVMRvNZ4P3+83Rw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(376002)(396003)(366004)(39840400004)(136003)(346002)(66574015)(54906003)(26005)(66446008)(66556008)(76116006)(66946007)(71200400001)(316002)(52536014)(8936002)(64756008)(66476007)(86362001)(6916009)(19627405001)(83380400001)(4326008)(8676002)(6506007)(53546011)(7696005)(55016002)(9686003)(5660300002)(2906002)(33656002)(122000001)(186003)(38100700002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?chYOHPLJnWxpH3mDqvfan55mPtw+rUAOnLW4MBLJsdX9JfNzZUA0bbXrsb?=
 =?iso-8859-1?Q?+dz0CjBvWJDBQFBQupM917EGM0TRreuZ4pGhpHs3hz0oq730zLfXi7rdas?=
 =?iso-8859-1?Q?rQ27oKD6N0/7+6jC95zoxhoqJ92z5XigVbPNowXIQkkI7wpuXWGjBDrBwR?=
 =?iso-8859-1?Q?GOMR/IgPtq4nG6MoQSxXoQxViLUrAYfu62SfPDdFEsDWj1Yh2Zrne9KIPE?=
 =?iso-8859-1?Q?UZqhzxr1GwvOhZewnAaMF34LVBGDoLe18i1FgaBIFSoBHV6UlWL33iNwuE?=
 =?iso-8859-1?Q?b87RL0Rhnfmf7jFh7JtixeiWwKZleH1hAciNoQXW4YMyQll55lLam9fnQP?=
 =?iso-8859-1?Q?8geCSTFr7acgsW+IGbiziIOsxdBrQsxB7uKBikDFxdIfzzTR4VcGOagBRO?=
 =?iso-8859-1?Q?1DFB2+tJ1U8NqIcUhK/08aOJk/miBjG3sEYIetLMMKOBQyAHFN/60jkBUx?=
 =?iso-8859-1?Q?qoW6gfW5DX2kDh2q80uK8XM60QS67fq87WbmohHNqPpTQncDprYcHXAvLm?=
 =?iso-8859-1?Q?MrYFmHmhoszgTZc+Zf6wjQZBUmi/NyYRtancLFcFItu+MaeFF1itgPSFNo?=
 =?iso-8859-1?Q?NF5KBHKc+imq9dayntU7BPviOjaSh72eevTGh6I8UHuNnKxBmoYBtLa23I?=
 =?iso-8859-1?Q?ITydqm8WQ5S5AO1ybrqOOzSamxKQaKTVaeFYd0fc+3MpQCr9hXz5fnFaz9?=
 =?iso-8859-1?Q?38kXexRg42ozxBqgtHBGAwWAS3wES4i2sLBjAEF5GDoMqfFZekEh5xDyIn?=
 =?iso-8859-1?Q?wek7KuiRGeZi9b/cEDViaUKJ2NdgnqE6ZUqZreUSYfvKDAw8dNJNQlxswz?=
 =?iso-8859-1?Q?M8Y3c0G1yhrE6XwjFtmowvisVz/ibXFg/YaAEN+cF0wFfX7SxfupacQtn8?=
 =?iso-8859-1?Q?XYz1bLS5arCdkWaPM/XHIEjwC+RRiImxo8uzxXCQ6K3tnR7wBjZF50AW0j?=
 =?iso-8859-1?Q?s/EoZPzY69iiFA+EPYaObxRS5/uqxy8gd/HDEw+VZEcEfysKRvJyRJ8SgI?=
 =?iso-8859-1?Q?eRsu/w4AiqJXbg02GgqvOqk1kI7ikmYYcQDz9jOguWZT7W1RFQetBgxIo6?=
 =?iso-8859-1?Q?Grd8Aid9Ev4Rbw5PE2okpT8HgQE/Pr2BmDDorC8S3AfDn6STEOh+Hu3/wi?=
 =?iso-8859-1?Q?N+A5WNiocRzdwRYeLMXc2jj0Jd9BL/u+mxz2qA6eRzJjiE3PLke38Hwz/m?=
 =?iso-8859-1?Q?xPGZT7oZekLlPuQTZOoelgiMMPGkGQOLM+++sIjGdY3FSZ+6dr7P3BMnjH?=
 =?iso-8859-1?Q?VwT9rcZ01/HnZFrUR+JH0wGcjsN5rT7tYsHhUkgwG3eTLFi/3uVGrhOCKk?=
 =?iso-8859-1?Q?PYXVC9RC0WRh1CTcIcIX23eRV6aM+d4dtJXIUn20ApGXHk3KzHrk7KsnmI?=
 =?iso-8859-1?Q?Cqy4yExNP2?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90874819-cdb8-4a1b-cd9f-08d908e8dc34
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 19:24:06.8453 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UpPV4/zUgdFAYZj6pkfcJAckd9vfgBEPYKrdldvgr5og1/9vi0+aXDwowTociSJGwU5VMuTKBL84TRhhkNRGxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2371
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
Content-Type: multipart/mixed; boundary="===============1956985991=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1956985991==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4488F5277BF26669E8D8673BF7429MN2PR12MB4488namp_"

--_000_MN2PR12MB4488F5277BF26669E8D8673BF7429MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

No objections from me.

Thanks!

Alex

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Monday, April 26, 2021 2:49 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Nieto, David M <David.Nieto@amd.com>; Sun, Roy <Roy.Sun@amd.com>; amd-g=
fx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track

Hey Alex,

any objections that we merge those two patches through drm-misc-next?

Thanks,
Christian.

Am 26.04.21 um 08:27 schrieb Roy Sun:
> Update the timestamp of scheduled fence on HW
> completion of the previous fences
>
> This allow more accurate tracking of the fence
> execution in HW
>
> Signed-off-by: David M Nieto <david.nieto@amd.com>
> Signed-off-by: Roy Sun <Roy.Sun@amd.com>
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/sch=
eduler/sched_main.c
> index 92d8de24d0a1..f8e39ab0c41b 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -515,7 +515,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_scheduler=
 *sched)
>   EXPORT_SYMBOL(drm_sched_resubmit_jobs);
>
>   /**
> - * drm_sched_resubmit_jobs_ext - helper to relunch certain number of job=
s from mirror ring list
> + * drm_sched_resubmit_jobs_ext - helper to relaunch certain number of jo=
bs from pending list
>    *
>    * @sched: scheduler instance
>    * @max: job numbers to relaunch
> @@ -671,7 +671,7 @@ drm_sched_select_entity(struct drm_gpu_scheduler *sch=
ed)
>   static struct drm_sched_job *
>   drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)
>   {
> -     struct drm_sched_job *job;
> +     struct drm_sched_job *job, *next;
>
>        /*
>         * Don't destroy jobs while the timeout worker is running  OR thre=
ad
> @@ -690,6 +690,14 @@ drm_sched_get_cleanup_job(struct drm_gpu_scheduler *=
sched)
>        if (job && dma_fence_is_signaled(&job->s_fence->finished)) {
>                /* remove job from pending_list */
>                list_del_init(&job->list);
> We just need to record the scheduled time of the next job. So we
> need not to check the rest job.
> +             /* account for the next fence in the queue */
> +             next =3D list_first_entry_or_null(&sched->pending_list,
> +                             struct drm_sched_job, list);
> +             if (next && test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
> +                     &job->s_fence->finished.flags)) {
> +                     next->s_fence->scheduled.timestamp =3D
> +                             job->s_fence->finished.timestamp;
> +             }
>        } else {
>                job =3D NULL;
>                /* queue timeout for next job */


--_000_MN2PR12MB4488F5277BF26669E8D8673BF7429MN2PR12MB4488namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:11pt;color:#0078D7;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
No objections from me.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Thanks!</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Monday, April 26, 2021 2:49 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Nieto, David M &lt;David.Nieto@amd.com&gt;; Sun, Roy &lt;Roy.Sun=
@amd.com&gt;; amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Hey Alex,<br>
<br>
any objections that we merge those two patches through drm-misc-next?<br>
<br>
Thanks,<br>
Christian.<br>
<br>
Am 26.04.21 um 08:27 schrieb Roy Sun:<br>
&gt; Update the timestamp of scheduled fence on HW<br>
&gt; completion of the previous fences<br>
&gt;<br>
&gt; This allow more accurate tracking of the fence<br>
&gt; execution in HW<br>
&gt;<br>
&gt; Signed-off-by: David M Nieto &lt;david.nieto@amd.com&gt;<br>
&gt; Signed-off-by: Roy Sun &lt;Roy.Sun@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++++++--<b=
r>
&gt;&nbsp;&nbsp; 1 file changed, 10 insertions(+), 2 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/=
scheduler/sched_main.c<br>
&gt; index 92d8de24d0a1..f8e39ab0c41b 100644<br>
&gt; --- a/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt; +++ b/drivers/gpu/drm/scheduler/sched_main.c<br>
&gt; @@ -515,7 +515,7 @@ void drm_sched_resubmit_jobs(struct drm_gpu_schedu=
ler *sched)<br>
&gt;&nbsp;&nbsp; EXPORT_SYMBOL(drm_sched_resubmit_jobs);<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; /**<br>
&gt; - * drm_sched_resubmit_jobs_ext - helper to relunch certain number of =
jobs from mirror ring list<br>
&gt; + * drm_sched_resubmit_jobs_ext - helper to relaunch certain number of=
 jobs from pending list<br>
&gt;&nbsp;&nbsp;&nbsp; *<br>
&gt;&nbsp;&nbsp;&nbsp; * @sched: scheduler instance<br>
&gt;&nbsp;&nbsp;&nbsp; * @max: job numbers to relaunch<br>
&gt; @@ -671,7 +671,7 @@ drm_sched_select_entity(struct drm_gpu_scheduler *=
sched)<br>
&gt;&nbsp;&nbsp; static struct drm_sched_job *<br>
&gt;&nbsp;&nbsp; drm_sched_get_cleanup_job(struct drm_gpu_scheduler *sched)=
<br>
&gt;&nbsp;&nbsp; {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job *job, *next;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /*<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * Don't destroy jobs w=
hile the timeout worker is running&nbsp; OR thread<br>
&gt; @@ -690,6 +690,14 @@ drm_sched_get_cleanup_job(struct drm_gpu_schedule=
r *sched)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (job &amp;&amp; dma_fence=
_is_signaled(&amp;job-&gt;s_fence-&gt;finished)) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* remove job from pending_list */<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; list_del_init(&amp;job-&gt;list);<br>
&gt; We just need to record the scheduled time of the next job. So we<br>
&gt; need not to check the rest job.<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; /* account for the next fence in the queue */<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; next =3D list_first_entry_or_null(&amp;sched-&gt;pending_list,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_job, list);<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; if (next &amp;&amp; test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;job-&gt;s_fence-&g=
t;finished.flags)) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; next-&gt;s_fence-&gt;sc=
heduled.timestamp =3D<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; job-&gt;s_fence-&gt;finished.timestamp;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; job =3D NULL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /* queue timeout for next job */<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_MN2PR12MB4488F5277BF26669E8D8673BF7429MN2PR12MB4488namp_--

--===============1956985991==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1956985991==--
