Return-Path: <SRS0=K+jV=JX=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,PDS_BAD_THREAD_QP_64,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C72C433ED
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 19:51:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42505613B2
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Apr 2021 19:51:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42505613B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C62E36E875;
	Mon, 26 Apr 2021 19:51:49 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760040.outbound.protection.outlook.com [40.107.76.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32DF56E875
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Apr 2021 19:51:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8qUNbdsbePdLatevybFSNMRlz81a0ij7xSA45HsQVWorODOEF5yoDMxBGOA1ICRC3F15p22fo//gAscsdLJVCgRhZMXJra6ccvuF19c2qxiLf8NvnyqYMrRHu3i1b7jE1Y70XjxkRB23MxNQEA4oCtqpL8XKbd3Na21tS7rpD6DgluJc/cwXEbKekkEBbNXOrun+p5TI9BcqJ/CA5xjnCc7jBjtwFA9ClFMvOCNPbG2hvMLEJBeD/W3dh2F5jWCaUGRDse5WVOOAs/aA9jgtzxFGbK3XnjZ05EEAk8IL7q1Vgc/UtZDh8x3h606ZGR2Tx8ZBHrEmXkfQIlPbBMeyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZ7ywWx3Z0Dzt+7zwrSvcKhWw5+z2WpqabddoNxMnTk=;
 b=iESL02T/z+5HFkcYzYp+j6dIYrw9Svh5GgDdbzWWCREbRpmArEeFDJrSynj5AGESnyhyQIPjrAA5n4SrwbFzj2q7BOePNJ24N/aDOAi1G//iHtnAv+z1RG4K2tVpa7xC5pYz72LIKYvKYJHjGSNG+J01JIFpVosUAd40Bo3OjbU552wPzR5n4g3fjHJGeb8zPkLIB/dahOv2Pp5LxW4E+2FisWk62WVzPIlBTCpU/rzUKIXpoMA9irZHdPT+MFBMAs06RHl3n4IQHc+t1XpezuOGYg5r/sBW1cqvBI14cspLY+Hj710VWMRX06zTQlJDz+8TYgozQG2FDjO7FlZwFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MZ7ywWx3Z0Dzt+7zwrSvcKhWw5+z2WpqabddoNxMnTk=;
 b=BVONgoaYxTJ+dILNDERyBfzTzDYeldM8T80bryLC7V242qSzoxbyWSb/40FyEz8GwuNzlT/h/P2tZ2ViDL6C5s/oXJoxa89YsogySmV1qXPrgjYxW4fOEgpvaQnhzIvxbtnsgqvZ7n8wBeYFP3nGJ7jYmdK/H/tIveT5uFNqHVQ=
Received: from MN2PR12MB4488.namprd12.prod.outlook.com (2603:10b6:208:24e::19)
 by MN2PR12MB4437.namprd12.prod.outlook.com (2603:10b6:208:26f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.20; Mon, 26 Apr
 2021 19:51:46 +0000
Received: from MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e]) by MN2PR12MB4488.namprd12.prod.outlook.com
 ([fe80::3d98:cefb:476c:c36e%7]) with mapi id 15.20.4065.027; Mon, 26 Apr 2021
 19:51:45 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Thread-Topic: [PATCH 1/2] drm/scheduler: Change scheduled fence track
Thread-Index: AQHXOmUt+yIB0uN3xU+WV+JUDZ9yXKrGW78AgADS2y+AAAPrVYAAAtGAgAAA4Fc=
Date: Mon, 26 Apr 2021 19:51:45 +0000
Message-ID: <MN2PR12MB44880E0C0FA8C75D7E28884AF7429@MN2PR12MB4488.namprd12.prod.outlook.com>
References: <20210426062701.39732-1-Roy.Sun@amd.com>
 <8b8ec884-5b0b-3409-b7b0-be7da43e3e71@gmail.com>
 <MN2PR12MB4488F5277BF26669E8D8673BF7429@MN2PR12MB4488.namprd12.prod.outlook.com>
 <MN2PR12MB44884F5635594C3F53D3F865F7429@MN2PR12MB4488.namprd12.prod.outlook.com>,
 <df0aa92d-87b9-7c27-f06f-9e1a10cead5d@gmail.com>
In-Reply-To: <df0aa92d-87b9-7c27-f06f-9e1a10cead5d@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-04-26T19:51:45.324Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Distribution
 Only; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard; 
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [192.161.79.245]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: feeab6bd-fd01-4ab4-8865-08d908ecb90e
x-ms-traffictypediagnostic: MN2PR12MB4437:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4437B10FDF9EB0F26E81414BF7429@MN2PR12MB4437.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ek+bl3GdVMEdlHDltbrm+6WdtEhqZ3EDkYt5r/dR/M/tMK2S5LNfKCILSviRN4VTRtqV3nq2rqvI7IegSIxi7ohMhuhZFSUmQenSKOScsGvxnTkrZDZ6PhDs/1djLpnNk5ThKmeJvNrzMAH+kBtXU/fl3SsSraq2EXPGxxhDN4FgqQDFMDQvPfgQ8vspK6BH4aj9/e/H0lughSpw5JUr7eeQTFuyFQh7FTfJd0jrQAh0yg3LbtgcrkB5Oyjlfdk0ES4KbrFCbyaI+BEAr1CWB4cqCqhLBDj+oNwm50oJARuJjfkMpILQBwLoeGTdcVTAwOk4CBDQf6twuVON+3TTc0FbekkqOzBFnGUyH3B+suNVXyWP6wIJS325pMjtcWD6l8aq/13BYmlcuuPQfrvjut6ZGv7Mf3x8do+c3/8aD6CoEd5x+OgPtIywbjFgVT8M90cb5iiq/7FA+LcLTzd7oan1FCmDeIL9CM1mPq1209ADMt5oUjddyEX4oDQsWOW/qsooRi8za5WhFLDs9xDqhifS7qLrWuxt5PiZh6rc70eVub1+mCX9niytwIR4ttHwy2Bps01LmW+a4a5hY6ygu+XBs5ABm42d05lwz2s4KNw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(346002)(366004)(39850400004)(136003)(376002)(19627405001)(83380400001)(26005)(316002)(6506007)(8936002)(53546011)(66574015)(7696005)(5660300002)(66946007)(54906003)(9686003)(71200400001)(6916009)(55016002)(38100700002)(33656002)(4326008)(8676002)(66476007)(66556008)(64756008)(2906002)(186003)(86362001)(122000001)(52536014)(76116006)(66446008)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?1joFxh5p1c7sgujw4dnuygZXDtd24rqyJWySL8U2epaLDP1S+Dr8BcvBdw?=
 =?iso-8859-1?Q?ew6WZcQrDk0K0NNDhAQbI8G0XO0xz/J73D0FkDeEEI6CdJ3ouMSLdja1AA?=
 =?iso-8859-1?Q?pXkK+FzcQLD9mRGidDAtuazRbgWUd340BuBm7xGQSB3nqVg0jWVYZQ44tB?=
 =?iso-8859-1?Q?r3XgL+OsbYaSlLivvekERt2fomP2uRwRe3TFj+muqblXGbJRWsftWFLzkz?=
 =?iso-8859-1?Q?72yBLA4BphtIe6joRd8NwjuHRWqFsTlpYh1Qn6WkVFtf8nmeGtnu9tJynF?=
 =?iso-8859-1?Q?YuffqkP29U+zoI60lpuVvj/MMQRMcDMtoVHUr3e6Pq6/ldCs/mpni6gI9Q?=
 =?iso-8859-1?Q?MODAdndp2c/9koG4brK2gJovM4w5qX3XrnMX6nPGm3BATLbUU7+D6B7ZGM?=
 =?iso-8859-1?Q?x+aSPm71IuEjamuwwx+wTH7ORMgAY7G7W6QszKBE1lN3/yZ1wh6Y/Tvv4h?=
 =?iso-8859-1?Q?zXFzMVmij3tzGCu56xlb+JpkEZFMhAHApWydd1Cll+xwkOpGy0qAJR9sF6?=
 =?iso-8859-1?Q?AzCHHFfC35++kuZKeL4hUdLpkH8eCGV1J+fYUDSKHgzDPccavAuxk/3T9+?=
 =?iso-8859-1?Q?0gcnIf2duDWc+kU9F7B9KRO2Ixa6zS9AK7a3jLAN4uf/zhOSNcX0z5d+Wq?=
 =?iso-8859-1?Q?ET2O3BMM4pa4xZzBrb5JlFt8dl9wo0PlBzatFtJlX2oG2cnxed+fZ06Gwi?=
 =?iso-8859-1?Q?AQk3+TqrGkPWmtlqHGdPWJ64I6o1x5mNdgME8T3uu3y9/V21guttxzB9zF?=
 =?iso-8859-1?Q?gLKVHH5W6D2A76K/RESSfC/71QLmGFU2YgDnEYHzQpvsVkGncBREmImZLU?=
 =?iso-8859-1?Q?+d6mulY88b22H7zoWGR17c8ATdfunz8fss495VPQJvwlSN1EObM1D7uamO?=
 =?iso-8859-1?Q?qPgbqCeZfkptXom3kMkwXIn+A/mpD/VXfUYwQ2lfXWRLJNv1J/itvj2K9P?=
 =?iso-8859-1?Q?X2jpYUDlU6BIBkyeOYOnA6LNZhMAwjiqcRDCHZMQC8OWANgdDQCX2hkr/e?=
 =?iso-8859-1?Q?ysgbMZo52JTXrC/YcrMpdPL7pcxcZqVlm8zi+Di+pA6W4wOaZUM4iXZxUm?=
 =?iso-8859-1?Q?JxpizoGPGMYtQ6CiiBtwxzWMl8Jz1FyEsFYJz1pQxJa+3DvCL2/KZNzvu8?=
 =?iso-8859-1?Q?PIIb15LqL5NYykAInEqb1SfO7X4zwi+3mRt1hnE2WCn8wMYmZzkzf6YzwK?=
 =?iso-8859-1?Q?CfK6AQFtv8yeEYUKJOe1xs21pNrxg9OjBWo35Mqf20leHpq4Cw7FURPFHW?=
 =?iso-8859-1?Q?dMmKFIMIFVAQZ2QvIwZEk2q8uTXspWQ4eXxpDxyzaPN6FuKta2P2ptcoVR?=
 =?iso-8859-1?Q?yc/NkfjHGdOSTetSbPnvnYwF2INOp+/35LB8lLGeq9VmfnN7XCgOjZEl+6?=
 =?iso-8859-1?Q?0vtfycnvWU?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: feeab6bd-fd01-4ab4-8865-08d908ecb90e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2021 19:51:45.8442 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SNDqbljSkJfgTMIWJlpaJ3OmKGeZ/lPU6lcx6/cmk9asvlt3032QyxBDanPfJPu+GAycxO3EFVVf/nS7wO40EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4437
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
Content-Type: multipart/mixed; boundary="===============0685976486=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0685976486==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB44880E0C0FA8C75D7E28884AF7429MN2PR12MB4488namp_"

--_000_MN2PR12MB44880E0C0FA8C75D7E28884AF7429MN2PR12MB4488namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Fair point.  Either way works for me.

Alex
________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Sent: Monday, April 26, 2021 3:48 PM
To: Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Sun, Roy <Roy.Sun@amd.com=
>; Nieto, David M <David.Nieto@amd.com>
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track

My concern is more to get this tested from more people than just AMD.

Christian.

Am 26.04.21 um 21:40 schrieb Deucher, Alexander:

[AMD Official Use Only - Internal Distribution Only]

That said, it would be easier for me to merge through the AMD tree since a =
relatively big AMD feature depends on it.  Not sure how much conflict poten=
tial there is if this goes through the AMD tree.

Alex

________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org><mailto:amd-gfx-bounce=
s@lists.freedesktop.org> on behalf of Deucher, Alexander <Alexander.Deucher=
@amd.com><mailto:Alexander.Deucher@amd.com>
Sent: Monday, April 26, 2021 3:24 PM
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com><mailto:ckoenig.lei=
chtzumerken@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org><mailto:amd-gfx@lists.freed=
esktop.org>; Sun, Roy <Roy.Sun@amd.com><mailto:Roy.Sun@amd.com>; Nieto, Dav=
id M <David.Nieto@amd.com><mailto:David.Nieto@amd.com>
Subject: Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track


[AMD Official Use Only - Internal Distribution Only]


[AMD Official Use Only - Internal Distribution Only]

No objections from me.

Thanks!

Alex

________________________________
From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com><mailto:ckoenig.l=
eichtzumerken@gmail.com>
Sent: Monday, April 26, 2021 2:49 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com><mailto:Alexander.Deucher=
@amd.com>
Cc: Nieto, David M <David.Nieto@amd.com><mailto:David.Nieto@amd.com>; Sun, =
Roy <Roy.Sun@amd.com><mailto:Roy.Sun@amd.com>; amd-gfx list <amd-gfx@lists.=
freedesktop.org><mailto:amd-gfx@lists.freedesktop.org>
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
> Signed-off-by: David M Nieto <david.nieto@amd.com><mailto:david.nieto@amd=
.com>
> Signed-off-by: Roy Sun <Roy.Sun@amd.com><mailto:Roy.Sun@amd.com>
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



--_000_MN2PR12MB44880E0C0FA8C75D7E28884AF7429MN2PR12MB4488namp_
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
Fair point.&nbsp; Either way works for me.<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Alex<br>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Christian K=F6nig &lt=
;ckoenig.leichtzumerken@gmail.com&gt;<br>
<b>Sent:</b> Monday, April 26, 2021 3:48 PM<br>
<b>To:</b> Deucher, Alexander &lt;Alexander.Deucher@amd.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Sun, Roy &lt=
;Roy.Sun@amd.com&gt;; Nieto, David M &lt;David.Nieto@amd.com&gt;<br>
<b>Subject:</b> Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track=
</font>
<div>&nbsp;</div>
</div>
<div>My concern is more to get this tested from more people than just AMD.<=
br>
<br>
Christian.<br>
<br>
<div class=3D"x_moz-cite-prefix">Am 26.04.21 um 21:40 schrieb Deucher, Alex=
ander:<br>
</div>
<blockquote type=3D"cite"><style type=3D"text/css" style=3D"display:none">
<!--
p
	{margin-top:0;
	margin-bottom:0}
-->
</style>
<p align=3D"Left" style=3D"font-family:Arial; font-size:11pt; color:#0078D7=
; margin:5pt">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"font-family:Calibri,Arial,Helvetica,sans-serif; font-size:12p=
t; color:rgb(0,0,0)">
That said, it would be easier for me to merge through the AMD tree since a =
relatively big AMD feature depends on it.&nbsp; Not sure how much conflict =
potential there is if this goes through the AMD tree.<br>
</div>
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
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> amd-gfx
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:amd-gfx-bounces@lists.f=
reedesktop.org">
&lt;amd-gfx-bounces@lists.freedesktop.org&gt;</a> on behalf of Deucher, Ale=
xander <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:Alexander.Deuche=
r@amd.com">
&lt;Alexander.Deucher@amd.com&gt;</a><br>
<b>Sent:</b> Monday, April 26, 2021 3:24 PM<br>
<b>To:</b> Christian K=F6nig <a class=3D"x_moz-txt-link-rfc2396E" href=3D"m=
ailto:ckoenig.leichtzumerken@gmail.com">
&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
<b>Cc:</b> amd-gfx list <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto=
:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a>; Sun, Roy <a class=3D"x_moz-txt-l=
ink-rfc2396E" href=3D"mailto:Roy.Sun@amd.com">
&lt;Roy.Sun@amd.com&gt;</a>; Nieto, David M <a class=3D"x_moz-txt-link-rfc2=
396E" href=3D"mailto:David.Nieto@amd.com">
&lt;David.Nieto@amd.com&gt;</a><br>
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
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif=
" color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Christian K=F6nig
<a class=3D"x_moz-txt-link-rfc2396E" href=3D"mailto:ckoenig.leichtzumerken@=
gmail.com">
&lt;ckoenig.leichtzumerken@gmail.com&gt;</a><br>
<b>Sent:</b> Monday, April 26, 2021 2:49 AM<br>
<b>To:</b> Deucher, Alexander <a class=3D"x_moz-txt-link-rfc2396E" href=3D"=
mailto:Alexander.Deucher@amd.com">
&lt;Alexander.Deucher@amd.com&gt;</a><br>
<b>Cc:</b> Nieto, David M <a class=3D"x_moz-txt-link-rfc2396E" href=3D"mail=
to:David.Nieto@amd.com">
&lt;David.Nieto@amd.com&gt;</a>; Sun, Roy <a class=3D"x_moz-txt-link-rfc239=
6E" href=3D"mailto:Roy.Sun@amd.com">
&lt;Roy.Sun@amd.com&gt;</a>; amd-gfx list <a class=3D"x_moz-txt-link-rfc239=
6E" href=3D"mailto:amd-gfx@lists.freedesktop.org">
&lt;amd-gfx@lists.freedesktop.org&gt;</a><br>
<b>Subject:</b> Re: [PATCH 1/2] drm/scheduler: Change scheduled fence track=
</font>
<div>&nbsp;</div>
</div>
<div class=3D"x_x_BodyFragment"><font size=3D"2"><span style=3D"font-size:1=
1pt">
<div class=3D"x_x_PlainText">Hey Alex,<br>
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
&gt; Signed-off-by: David M Nieto <a class=3D"x_moz-txt-link-rfc2396E" href=
=3D"mailto:david.nieto@amd.com">
&lt;david.nieto@amd.com&gt;</a><br>
&gt; Signed-off-by: Roy Sun <a class=3D"x_moz-txt-link-rfc2396E" href=3D"ma=
ilto:Roy.Sun@amd.com">
&lt;Roy.Sun@amd.com&gt;</a><br>
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
</blockquote>
<br>
</div>
</div>
</body>
</html>

--_000_MN2PR12MB44880E0C0FA8C75D7E28884AF7429MN2PR12MB4488namp_--

--===============0685976486==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0685976486==--
