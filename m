Return-Path: <SRS0=K+jV=JX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B893C433B4
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 19:40:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBF4B6135D
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 19:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF4B6135D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CAAB89E35;
	Mon, 26 Apr 2021 19:40:27 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D796089E35
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 19:40:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1t/d/qcR6cI0cN/ymMTShJzIdkHJBo9almk+8A+CZvkvH9EWr1N56b7JNMYzUby6YV19yHpZNa0Md4d/kpSWFlp5dcJ4VL8KaqmtSvHVnJqbUftN3Mm8e2EA7zpVlfmVshwfT7GPx6+fMJ+tTLiy56GrHdcXr6K5JQwgQk3avuZKBkX+HrE3xq3pCse6Brant7GyPgWuoo5M+FSefloBrVZInV8SOmCvbk92GFIcPxrBgNw7HOpNtcG8dZZ/Ze4tIIwilJ0/F2yh9+DDIesSFesAg4R2mDu+nLGFwmj98rFU8HOc3sgHoRpCobKyhEXBoB0heY23vI6tYCdoVtu/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjIXhyGy65npe9Lk6bfFo5ThV7xj+7OJeTaLdr2ZTi0=;
 b=K5ZVtnf9aPk3N9ox3tP/fLg4ovq2Cq7qT3Z4HJu7PjefukgekGvCIN9lYwFnZACC4YY7G5Jc/tPKBIbWWApzzGFtgHkgLEHHynGOhzwMHwnwoDqeN8I4axTF55L6CkW80YoJNcYylhlVA0nTLyEIxbctGOvo4bV7T+lBMr6LL+9nHjGoIzL8cH8kZU2kKP03wlRAgJ4iJwdIcXoWU3AKIWZUlRICVIxR+VRlF+5JhTfMWxMkvoEYSupZu0of1P9jTWmJFd0VimXswT3aGACGPyHvVgWAzTaR0vMlk4qSL/fJVjxU0R3l1wDh5MtAAB7GMalmj8y/lU2PIP982XoncQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AjIXhyGy65npe9Lk6bfFo5ThV7xj+7OJeTaLdr2ZTi0=;
 b=opq2d4ZaB3vzLwY60h0/RT2UXuyY71q7ecByel9DB8aYI0dC5gXI9KYG+ijyuKUX5Iuyxu4KylMfVVpAiTKsxji0MZwjA1Tb+4S7/yz7zZAo2iiE/hUJ/AfY2+6qfLGPjDSSW9FsfVfEkBz8QkDD7i+XAdxjVa8UHSlx3Z41TCM=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB3871.namprd12.prod.outlook.com (2603:10b6:208:16a::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Mon, 26 Apr
 2021 19:40:25 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%7]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 19:40:24 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Thread-Topic: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Thread-Index: AQHXOmUt+yIB0uN3xU+WV+JUDZ9yXKrGW78AgADS2y+AAAPrVQ==
Date: Mon, 26 Apr 2021 19:40:24 +0000
Message-ID: <MN2PR12MB44884F5635594C3F53D3F865F7429@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210426062701.39732-1-Roy.Sun@amd.com>,
 <8b8ec884-5b0b-3409-b7b0-be7da43e3e71@gmail.com>,
 <MN2PR12MB4488F5277BF26669E8D8673BF7429@MN2PR12MB4488.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB4488F5277BF26669E8D8673BF7429@MN2PR12MB4488.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-26T19:40:24.115Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f29e2f5-f893-4a29-9e13-08d908eb2329
x-ms-traffictypediagnostic: MN2PR12MB3871:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3871EC31DE4B3529EA874940F7429@MN2PR12MB3871.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RbgNOBCWO906PMF3kB3W/ymCkqZhj2YkY19VTBM0AFzPskhR7TxcHDZl/OygvxJ/JWLy46FmmHXaWY8Eepicyv3/n75qBcQYVZcKJIagAW1exHhKbskov4lyJpaOQg1zwTG9G/dIv5I+bND0dOx3t6u443CIObvwnz6QmVa0GzzH0LyoCM6IqUqmuQtvQKD56KHLo1vyTxH6w+FspoIfXcmmcGSBKEo+b9J1Of0kSIHtXQ2zDCYO+BMr3PNQjFWLwJey6pwcYbMvY4pqXHT28unI1tjUWErMZ0Pm7BGD39ohfOqtrrQQhlJeQrjAgmIInj9LdCWyL8iaH1P/WNiOzAnfx0fPJdIj1kuRTgko8P9cXVoDdXDEHGRE5nZdVPzU/JYja3Lk0xUJm/3FbsxokVo+herILs2vzK8nwAD1VkI499acanDt1ZofxTufyL7h35Zj5bt06Qaiv8R9KDer3XxiD5R/FmpmO+5pp70QJBG7fo4PssLYAHTVBC+Fb5saNsvmUrDqXsBu3+Q9LA8fWZWTLaawa/NFQBF+hHBfvEAuN/S/wHYfCxk4+sFVzlwt6+X0fvE7hPjmlNE35Q8eyj8F7CrBDh16IZFtLboGbGU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(136003)(39850400004)(376002)(396003)(38100700002)(86362001)(83380400001)(33656002)(316002)(186003)(19627405001)(66556008)(66476007)(7696005)(76116006)(122000001)(66574015)(6506007)(8676002)(8936002)(66946007)(71200400001)(6916009)(53546011)(2940100002)(55016002)(64756008)(9686003)(66446008)(2906002)(5660300002)(52536014)(26005)(478600001)(4326008)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?6GN4RH/Y1uNboIqW91IbUgQU+D7wx6UM6vXyhqnccrWc3rW0bM1okWlkDt?=
 =?iso-8859-1?Q?o9tj8UMqIR9QbiOXzM3z97fv8tdWhZgyH4OzogviqmheySYp4rQkZ+Zlt2?=
 =?iso-8859-1?Q?Xgc6oKZXGpGz7uJUQTfKVl+4X3+syiW10SPkYArNgJZcxSOadTOgVECdr/?=
 =?iso-8859-1?Q?TxyTkjV0no/DLPADBwC8898Sla5alZXi014Xxdn+L0XBptbxIoK9XdjXsN?=
 =?iso-8859-1?Q?RkbwmF0oUCWUhtBhYP2cWE/KHBwJMr2In1a+fedcu/qi9iF6fqkK5jHxQH?=
 =?iso-8859-1?Q?5vrnE6VwbgCn++ki5lIdjOmzxU0OIpXr0Wr6ssGLdX18reqzYNTHeG+6ZR?=
 =?iso-8859-1?Q?5k6Qu45QuXVo+4uOLudrlG2Vlu4NcpeHuNbGLdELPUSz3aFSq7Cj2MBHXd?=
 =?iso-8859-1?Q?qtlx42buDEeCneEgO+bi3TeYm8OrrFe9SnB4F7cn2R+xe15ExB9hxgHg0q?=
 =?iso-8859-1?Q?lrEgGWDBsVvATSJVFjGsVSd0RahXsEoPpu/P7oCE/qBtSuzePQzF3lsOWp?=
 =?iso-8859-1?Q?pOW0nN+FVEsVHG4UfcypcxzPZUq2OzqjbAQ6yy+4T6hIwhy/hd5NolgqUM?=
 =?iso-8859-1?Q?yRSpHT1CZXLoOKKljm43Oiuh19kzyeV7HyzYGI9kKDj/c7Qx4/KK6MLFsJ?=
 =?iso-8859-1?Q?eKrZo0agIL8InKE8769R/Deobg3gEmtAHJuKLDGtPf8UiuTjWGBwMn8xAk?=
 =?iso-8859-1?Q?+NDPnUkzahsrZkx9dB3jGfIrn296XvrfmiusUdC8+qnqkcxe+UZ2mwDCvW?=
 =?iso-8859-1?Q?LeHYIGLIOczjsJ1Xzv0vJyL6roj7QqmObNrwlADl2srYUJthNApkavkyZL?=
 =?iso-8859-1?Q?Twm+ILaPAzx935vHSeMRrdyGVJ+zrJXhBe3AkEGiKoXAtEQnocgcjQ+GWi?=
 =?iso-8859-1?Q?MZOlJNg5TJbbTTBfWdsgcnInSj3vrG5PNocDuJR+9MxlN3JamRqQuIqIz2?=
 =?iso-8859-1?Q?LEswNfWF+qktvWgviaRjD2XaH4miEURhi0LkAPeNds8wGDe9sJAaKhgF0W?=
 =?iso-8859-1?Q?sn8Z6fJKsC/c+ROjoBHSSLMn+Na+hKhaDEvBqUgKwgSeKo1TrpD69AjGDa?=
 =?iso-8859-1?Q?uPNHDARmOiVgxtGsuEFHbKmDwDk/bHNNWkiADCtsP28i58COKEhYHuarLe?=
 =?iso-8859-1?Q?2dIXQFNfDzYYr3aT4OnQnKN581qAgynZ6fXcknchSRw44/3v9qTOC2Odrd?=
 =?iso-8859-1?Q?3IighWeT6Sk96NKgjtiwNVOnwHmTr+fd7zDjUoGj5FJ5mWXUFtSDfz2lcd?=
 =?iso-8859-1?Q?EaX8aSHWNqkTyFZIEEeF/3urBp/WwFytgJ6lQjvPiTgTilNxvXXm4pXqcG?=
 =?iso-8859-1?Q?RXlnDyHL9QUl1RyzKKm1C4CD4bSGM3G/gKsjWLZQScezHzbMY9bBtyfFDK?=
 =?iso-8859-1?Q?mzk/trLnXR?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f29e2f5-f893-4a29-9e13-08d908eb2329
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 19:40:24.8180 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xOE4e78cH3/V0QFTBugViRL4w2AX8ix/rtr+49m/aua9dMZp11nAfgh+CsxWelddaoPAwpPPAOaSw3C2P6FQdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3871
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
Content-Type: multipart/mixed; boundary="===============1910874521=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1910874521==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44884F5635594C3F53D3F865F7429MN2PR12MB4488namp_"

--_000_MN2PR12MB44884F5635594C3F53D3F865F7429MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

That said, it would be easier for me to merge through the AMD tree since a =
relatively big AMD feature depends on it.  Not sure how much conflict poten=
tial there is if this goes through the AMD tree.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> on behalf of Deucher,=
 Alexander <Alexander.Deucher@amd.com>
Sent: Monday, April 26, 2021 3:24 PM
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Sun, Roy <Roy.Sun@amd.com=
>; Nieto, David M <David.Nieto@amd.com>
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track


[AMD Official Use Only - Internal Distribution Only]


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


--_000_MN2PR12MB44884F5635594C3F53D3F865F7429MN2PR12MB4488namp_
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
That said, it would be easier for me to merge through the AMD tree since a =
relatively big AMD feature depends on it.&nbsp; Not sure how much conflict =
potential there is if this goes through the AMD tree.<br>
</div>
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
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> amd-gfx &lt;amd-gfx-b=
ounces@lists.freedesktop.org&gt; on behalf of Deucher, Alexander &lt;Alexan=
der.Deucher@amd.com&gt;<br>
<b>Sent:</b> Monday, April 26, 2021 3:24 PM<br>
<b>To:</b> Christian K=F6nig &lt;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Sun, Roy &lt=
;Roy.Sun@amd.com&gt;; Nieto, David M &lt;David.Nieto@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track=
</font>
<div>&nbsp;</div>
</div>
<style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<div dir=3D"ltr">
<p align=3D"Left" style=3D"font-family:Arial; font-size:11pt; color:#0078D7=
; margin:5pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<p align=3D"Left" style=3D"font-family:Arial; font-size:11pt; color:#0078D7=
; margin:5pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
No objections from me.</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Thanks!</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
Alex</div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
<br>
</div>
<div id=3D"x_appendonsend"></div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig &=
lt;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Monday, April 26, 2021 2:49 AM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> Nieto, David M &lt;David.Nieto@amd.com&gt;; Sun, Roy &lt;Roy.Sun=
@amd.com&gt;; amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_BodyFragment"><font size=3D"2"><span style=3D"font-size:11p=
t">
<div class=3D"x_PlainText">Hey Alex,<br>
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
</div>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB44884F5635594C3F53D3F865F7429MN2PR12MB4488namp_--

--===============1910874521==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1910874521==--
