Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B6B3C77B61
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Mar 2023 08:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B19C210ED4E;
	Thu, 30 Mar 2023 08:59:11 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20623.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::623])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1487B10ED4E
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Mar 2023 08:59:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T6gtrLFspxhO6JZFs9pLjqRz19YkSHJkQSISNhXe5qy5sfxqTecem0lTC8XZ3kaKlZWyShzbwLlp70i0tdQ32rOjvJxrmBn9BlPR8CLDhEYbE71Ufizy7X0cJy2sma63TvYyDexzrOXqw/aR3GjiOimLMRQhyCwQ/Z3R8ubhx/KnMx9gq/yqFJ3EzPIiRKCRPFB1JXhDFKQg8H3gC1HySbm6rEmvfBbj3hceurYvFOpX5VpknNNhD7fMszr88wjgyOrkiM4oxEzy1SPK5CqpebARWj0pLul6ILwGHQ99iKuQP5s9Wu3h/o2knlEkuPe2GoTDPPse4w1AqLreSNyqrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KxYpXaMjGUO+2LoTgAitX3ZBLl4Kdyk4LLbHMFfycfw=;
 b=gESUGVa5SK0YVEWRrCp/9YvQV6zKKGLMwf7ZidXCPhQJrztLEj2Opi2g9bOH0DjCzJz/JHiqpy3B+KqVvQSv/dIyhP8nHO41Qqw5NkuFqJnBW6NlsqGVXqE2WWAUvo6IxprUC7QqrMjE5S6zeLgsqLI71qLQ7wxwdJRwiMAw57iBV4pX+VgBirvmlZ5xgBNF8kQO1h96vLLeN6V3cvMNnDUs//xfYPEadEwHUkffl45WUyRe5Jo/B6pMLa1s3yQHJmriH6sSWq8LKPyZSkpg6nOkoqgxc5+9vesnrIXLlQ69NiqhjFB/bajhRKzjUI+piljgLq1TfLGUBcR2PKzjNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KxYpXaMjGUO+2LoTgAitX3ZBLl4Kdyk4LLbHMFfycfw=;
 b=UMX0NM6f6vid3s74793h2k4NOguAlWRMMd2YC/cwZZREYrXFgTs1ZaieUKMcIHuTMu22Kt+DX2Nrxffi8n0/LltT02Ex8XF/vajkwn9WpLdb9NWXeEk25i/5dqWcXhw+IG5N2/DW6mkmvQnJPUh0eTVEUKXjyg1U/CCcFiU8C8k=
Received: from SN1PR12MB2445.namprd12.prod.outlook.com (2603:10b6:802:31::24)
 by DM4PR12MB6087.namprd12.prod.outlook.com (2603:10b6:8:b1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.35; Thu, 30 Mar
 2023 08:59:08 +0000
Received: from SN1PR12MB2445.namprd12.prod.outlook.com
 ([fe80::977a:52f:acf1:55f9]) by SN1PR12MB2445.namprd12.prod.outlook.com
 ([fe80::977a:52f:acf1:55f9%6]) with mapi id 15.20.6254.020; Thu, 30 Mar 2023
 08:59:07 +0000
From: "Liu, HaoPing (Alan)" <HaoPing.Liu@amd.com>
To: "Tuikov, Luben" <Luben.Tuikov@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
Thread-Topic: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset
Thread-Index: AQHZYL+u0CSWOl4FhUCX0abAnaoJla8O+0KAgAPcdUA=
Date: Thu, 30 Mar 2023 08:59:07 +0000
Message-ID: <SN1PR12MB2445C6C12FC1824D4A14124DF58E9@SN1PR12MB2445.namprd12.prod.outlook.com>
References: <20230327152028.2939908-1-HaoPing.Liu@amd.com>
 <aff27f2a-a878-be69-fb06-74f2063997f9@amd.com>
In-Reply-To: <aff27f2a-a878-be69-fb06-74f2063997f9@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-03-30T08:59:04Z; 
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=4f447fd6-2264-4287-93e3-291488ffc6fd;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=1
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_enabled: true
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_setdate: 2023-03-30T08:59:04Z
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_method: Standard
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_name: General
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_actionid: d8940f72-6b59-4769-a149-46f051b96d66
msip_label_4342314e-0df4-4b58-84bf-38bed6170a0f_contentbits: 0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN1PR12MB2445:EE_|DM4PR12MB6087:EE_
x-ms-office365-filtering-correlation-id: aa17a2ed-2ff8-411f-be6b-08db30fd0501
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ogB4eyqKtDKuYo1vyGmxbBQGTzP5pGAGmUSVKBZLCBreeShgf9gxI60X5bEp0eY2MPSQ4GdOIcF+NTssLBzpo2FFdErtbium29LIOvA8fZ8hKvn3h/CBwZ+OsJ9NlqtOvARHHJ8fAr+DDu+T8afmPOuSPEXZwQ056GnjNc3hZcQ/2CLv2chcv/i8MiXc/iYFC/LH+8hPQDkpySoIt8TnlJcwQ96KtHb74eU3SjgAv1qYiYM8K8c80PIFWXFdyTYn5XiKS1p28MEInNOakBF7vsLzkiIrFbaaEISaOzGa5rpAiJCCD4k2LQroxEjPKNIzAr4Lel8jkmjnjAcmWZ9iJF8HW0bbzo1s3IY7nmFbBzCNRwVb8ZpxfJNeoR8l71xjRDxdGoBV7e2v6wWa6LppbgHAlsihe2pZKY21yGjfi8VHhfnLfatmcsLoO1lfPu+uL1fX1rL07bNlx2Za3jJqw/nX9Ev2Y4A/AWrVQUsSp5SH0/qpGDkrCErMu05ethTQrjqgfGDxQQEMQPzKGQ2e13cE1uiLygjKND3OMxdsXM7kGE+VjkerYl9t5KcV+/z6girVwSIj77EVAfozDlwY+d3AsdyV1BW0fHg9V2ZptQn2KmaaQr0nWJIdXJAyWkjd
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2445.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(366004)(136003)(451199021)(478600001)(38070700005)(86362001)(110136005)(26005)(7696005)(6506007)(316002)(53546011)(9686003)(38100700002)(71200400001)(66946007)(76116006)(66556008)(64756008)(66446008)(66476007)(186003)(122000001)(4326008)(33656002)(83380400001)(41300700001)(55016003)(8676002)(2906002)(8936002)(52536014)(5660300002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ar6Q2R1Xbykh4nKSvVwlEJuGw7/GGklLq52KuPCmvAQPw0NwMjsX8peSjSnR?=
 =?us-ascii?Q?mBy5aUyuJhDb/ILzMvpjx3qtV69AdrySpOqc349NLhLHrfEFigMZWf3aD80Q?=
 =?us-ascii?Q?L75/xRHzQXLthdYevSYWIttP3Y3afc5qn/47jySkUJ910iT/sVHmDzkCJ3VF?=
 =?us-ascii?Q?r8umkRf5i9fHmMssYqagqjCQwyZfGBHT/ubB2vqqHPbbpTTflyIn9RpeL34X?=
 =?us-ascii?Q?TY/04mYf6IGXwoWaEwNkEzXZZjBOyYv4ZASn2ma+1Bfe814J1/9hRvOOctWX?=
 =?us-ascii?Q?lOSgpcBLH4SO3vpTnBCb5Unul4w2oEMmXeQEPqSco6J5ehzAPBcjCbMeeaBQ?=
 =?us-ascii?Q?cNNH+oyDBfjTKrVVIQshYr351LEkA0lNkqaB3SYsMZ9BCJgTbSFZfS+mqEvT?=
 =?us-ascii?Q?r4vi9YMzh07bmIo+Ji//RbjwwaOCU7JeHOJhCjy7ih9SbDv7VSI0GYLRN6gA?=
 =?us-ascii?Q?qQFMS2vuMdzugyAO8q71OQNEdQjef1Z3SJRtfS1WX44xWramDCrZSZf9P/CT?=
 =?us-ascii?Q?l6scGTpSaFWGF3CneUSe5DU65mL6iQtivlThCBoE9iCQBBgLjEuO86flWNlB?=
 =?us-ascii?Q?YuxNPFL9eNhq3mRNCZ7IJ+jyepEifyKlgDgja+iG12/wB1MImKjluMkhFG/k?=
 =?us-ascii?Q?EJAWgIUaRVCApUC0wSONGHBC44A9zgmglFS3gv+K+0WS41NbuugO+e2qkAMj?=
 =?us-ascii?Q?sAB7PcntdqVDD98CkcSkMrm9x0Kj26L4uB5Q9pji1d1vNML8Y+gm7MTJrsxB?=
 =?us-ascii?Q?ThpWcOxQJX/qO2R3ipEwujfxp1BqBaqWVCOi/+w4zZmneF8UWYZsSfe6TwJ1?=
 =?us-ascii?Q?dpLWRcRae8RjnkL8lzMNX9rVlcLae+wKS/ECBUJxbHuYKME5S3L+sw4gZUC+?=
 =?us-ascii?Q?LM9Xmz6M9ZYrucNAUZC1UhU2tfkJJUBn377/8mi+mhzG0E734VNp4dU6ZI6k?=
 =?us-ascii?Q?BA4j641c74V1N6ln2D0C1DeowJk+9JhPvNfBGcidqEPg5HXipjGtSuOJdpLk?=
 =?us-ascii?Q?GrnqUq2YYerJaUwqWiyCH22RVuUX63SfJRjYAe9EH/tPpfiuQBGLpJdun4s6?=
 =?us-ascii?Q?DcwF+R4XjjE//vvAlJdK1IpOsOK/VJppP7GlmkWG43+ufT+0DEPsMjPf+ixo?=
 =?us-ascii?Q?L9Dzb/CPH/RDKIyPTpWv4XYUXYG1MJU7KiUfPIFmVza5D8Yr/v43FDp+62jZ?=
 =?us-ascii?Q?W5+0wjqpkD+KLXWmXxCILbeduP4c9U5XrWVZyoFyDiaYnkvOFTsjG474AI/z?=
 =?us-ascii?Q?A3t06sT1vDxu4cKYNPT1pNrOeyuvRnCwSCWrsYIKgkvrkq4tRaZ01xsFKmM4?=
 =?us-ascii?Q?Pf9tEfTCNRhOQ/vI5TJ/giy+m2C5jgdLJuU6ncmGNdb6kEvRsYq09oYptVgv?=
 =?us-ascii?Q?PTlUGt3fknSgXUD9WK2T1GV/UhhIOj5yBx3LSAuIRsTb1/mb91oVk8dlbzq6?=
 =?us-ascii?Q?KYkOf8UcWiylhsZIcs9cDoO+/rZJ+afskcAy2rjaYkwsdZh+poKAsjc+FHgJ?=
 =?us-ascii?Q?Glqs3p9Flr7lDkKJ7btmSw9gt2qgGNdkGrxXCj6JlbhoEJVEUjudd5QCJFAY?=
 =?us-ascii?Q?Tjy7P7hZWyxzXgR1hTk=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SN1PR12MB2445C6C12FC1824D4A14124DF58E9SN1PR12MB2445namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa17a2ed-2ff8-411f-be6b-08db30fd0501
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2023 08:59:07.1417 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PvM+2PAoVYxFKMFCPQTo4J07Fl+Z8P47KKJ/INvQgYuynKdHhKx4MAOOyLLeDWDwIhL0WLq86lmKnliF+VMf2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6087
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
Cc: "Lakha, Bhawanpreet" <Bhawanpreet.Lakha@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_SN1PR12MB2445C6C12FC1824D4A14124DF58E9SN1PR12MB2445namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]


Hi, Luben



Thanks for the review. Please see inline.



Best Regards,

Alan



-----Original Message-----
From: Tuikov, Luben <Luben.Tuikov@amd.com>
Sent: Tuesday, March 28, 2023 3:00 AM
To: Liu, HaoPing (Alan) <HaoPing.Liu@amd.com>; amd-gfx@lists.freedesktop.or=
g
Cc: Lakha, Bhawanpreet <Bhawanpreet.Lakha@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset



Hi,



That's a good fix. Some questions and comments below:



On 2023-03-27 11:20, Alan Liu wrote:

> [Why]

> After gpu-reset, sometimes the driver would fail to enable vblank irq,

> causing flip_done timed out and the desktop freezed.

>

> During gpu-reset, we will disable and enable vblank irq in

> dm_suspend() and dm_resume(). Later on in

> amdgpu_irq_gpu_reset_resume_helper(), we will check irqs' refcount and de=
cide to enable or disable the irqs again.

>

> However, we have 2 sets of API for controling vblank irq, one is

> dm_vblank_get/put() and another is amdgpu_irq_get/put(). Each API has

> its own refcount and flag to store the state of vblank irq, and they

> are not synchronized.



Is it possible to reconcile controlling VBlank IRQ to a single refcount?



In struct drm_vblank_crtc, we have "enabled" and "refcount" to store vblank=
 irq state, and in struct amdgpu_irq_src we have "enabled_types" as the ref=
count for each irq in dm layer.

To reconcile vblank irq to a single refcount, my idea is to remove enabled =
and refcount from struct drm_vblank_crtc, and add a callback function like =
vblank_irq_enabled() to drm_crtc_funcs.

Drm layer can use this function to check the state or refcount of vblank ir=
q from dm layer. But it may be dangerous because it is a change to drm laye=
r. Do you have any comments?



>

> In drm we use the first API to control vblank irq but in

> amdgpu_irq_gpu_reset_resume_helper() we use the second set of API.

>

> The failure happens when vblank irq was enabled by dm_vblank_get()

> before gpu-reset, we have vblank->enabled true. However, during

> gpu-reset, in amdgpu_irq_gpu_reset_resume_helper(), vblank irq's state

> checked from

> amdgpu_irq_update() is DISABLED. So finally it will disable vblank irq

> again. After gpu-reset, if there is a cursor plane commit, the driver

> will try to enable vblank irq by calling drm_vblank_enable(), but the

> vblank->enabled is still true, so it fails to turn on vblank irq and

> causes flip_done can't be completed in vblank irq handler and desktop

> become freezed.

>

> [How]

> Combining the 2 vblank control APIs by letting drm's API finally calls

> amdgpu_irq's API, so the irq's refcount and state of both APIs can be

> synchronized. Also add a check to prevent refcount from being less

> then

> 0 in amdgpu_irq_put().

>

> Signed-off-by: Alan Liu <HaoPing.Liu@amd.com<mailto:HaoPing.Liu@amd.com>>

> ---

>  drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c            |  3 +++

>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 14

> ++++++++++----

>  2 files changed, 13 insertions(+), 4 deletions(-)

>

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c

> b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c

> index a6aef488a822..1b66003657e2 100644

> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c

> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c

> @@ -597,6 +597,9 @@ int amdgpu_irq_put(struct amdgpu_device *adev, struct=
 amdgpu_irq_src *src,

>            if (!src->enabled_types || !src->funcs->set)

>                           return -EINVAL;

>

> +         if (!amdgpu_irq_enabled(adev, src, type))

> +                       return 0;

> +

>            if (atomic_dec_and_test(&src->enabled_types[type]))

>                           return amdgpu_irq_update(adev, src, type);

>

> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c

> b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c

> index dc4f37240beb..e04f846b0b19 100644

> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c

> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c

> @@ -146,7 +146,7 @@ static void vblank_control_worker(struct

> work_struct *work)

>

>  static inline int dm_set_vblank(struct drm_crtc *crtc, bool enable)

> {

> -          enum dc_irq_source irq_source;

> +         int irq_type;

>            struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(crtc);

>            struct amdgpu_device *adev =3D drm_to_adev(crtc->dev);

>            struct dm_crtc_state *acrtc_state =3D to_dm_crtc_state(crtc->s=
tate);

> @@ -169,10 +169,16 @@ static inline int dm_set_vblank(struct drm_crtc *cr=
tc, bool enable)

>            if (rc)

>                           return rc;

>

> -          irq_source =3D IRQ_TYPE_VBLANK + acrtc->otg_inst;

> +         irq_type =3D amdgpu_display_crtc_idx_to_irq_type(adev,

> +acrtc->crtc_id);

> +

> +         if (enable)

> +                       rc =3D amdgpu_irq_get(adev, &adev->crtc_irq, irq_=
type);

> +

> +         else



There's an unnecessary empty line before the "else". It's a good idea to ru=
n patches through scripts/checkpatch.pl.



Thanks, will use the tool next time.



> +                       rc =3D amdgpu_irq_put(adev, &adev->crtc_irq, irq_=
type);

>

> -          if (!dc_interrupt_set(adev->dm.dc, irq_source, enable))

> -                        return -EBUSY;

> +         if (rc)

> +                       return rc;

>

>  skip:

>            if (amdgpu_in_reset(adev))



--

Regards,

Luben



--_000_SN1PR12MB2445C6C12FC1824D4A14124DF58E9SN1PR12MB2445namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:PMingLiU;
	panose-1:2 1 6 1 0 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@PMingLiU";
	panose-1:2 1 6 1 0 1 1 1 1 1;}
/* Style Definitions */
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0cm;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-compose;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:612.0pt 792.0pt;
	margin:72.0pt 72.0pt 72.0pt 72.0pt;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<p class=3D"msipheaderdf3d92d6" align=3D"Left" style=3D"margin:0"><span sty=
le=3D"font-size:10.0pt;font-family:Arial;color:#0000FF">[AMD Official Use O=
nly - General]</span></p>
<br>
<div class=3D"WordSection1">
<p class=3D"MsoPlainText">Hi, Luben<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Thanks for the review. Please see <span style=3D"=
color:#00B050">
inline</span>.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Best Regards,<o:p></o:p></p>
<p class=3D"MsoPlainText">Alan<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">-----Original Message-----<br>
From: Tuikov, Luben &lt;Luben.Tuikov@amd.com&gt; <br>
Sent: Tuesday, March 28, 2023 3:00 AM<br>
To: Liu, HaoPing (Alan) &lt;HaoPing.Liu@amd.com&gt;; amd-gfx@lists.freedesk=
top.org<br>
Cc: Lakha, Bhawanpreet &lt;Bhawanpreet.Lakha@amd.com&gt;<br>
Subject: Re: [PATCH] drm/amdgpu: Fix desktop freezed after gpu-reset<o:p></=
o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Hi,<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">That's a good fix. Some questions and comments be=
low:<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">On 2023-03-27 11:20, Alan Liu wrote:<o:p></o:p></=
p>
<p class=3D"MsoPlainText">&gt; [Why]<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; After gpu-reset, sometimes the driver would =
fail to enable vblank irq,
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; causing flip_done timed out and the desktop =
freezed.<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; During gpu-reset, we will disable and enable=
 vblank irq in
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; dm_suspend() and dm_resume(). Later on in <o=
:p></o:p></p>
<p class=3D"MsoPlainText">&gt; amdgpu_irq_gpu_reset_resume_helper(), we wil=
l check irqs' refcount and decide to enable or disable the irqs again.<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; However, we have 2 sets of API for controlin=
g vblank irq, one is<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; dm_vblank_get/put() and another is amdgpu_ir=
q_get/put(). Each API has
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; its own refcount and flag to store the state=
 of vblank irq, and they
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; are not synchronized.<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">Is it possible to reconcile controlling VBlank IR=
Q to a single refcount?<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#00B050">In struct drm_vblan=
k_crtc, we have &#8220;enabled&#8221; and &#8220;refcount&#8221; to store v=
blank irq state, and in struct amdgpu_irq_src we have &#8220;enabled_types&=
#8221; as the refcount for each irq in dm layer.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"color:#00B050">To reconcile vblank=
 irq to a single refcount, my idea is to remove enabled and refcount from s=
truct drm_vblank_crtc, and add a callback function like vblank_irq_enabled(=
) to drm_crtc_funcs.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"color:#00B050">Drm layer can use t=
his function to check the state or refcount of vblank irq from dm layer. Bu=
t it may be dangerous because it is a change to drm layer. Do you have any =
comments?</span><o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:black"><o:p>&nbsp;</o:p></sp=
an></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; In drm we use the first API to control vblan=
k irq but in<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; amdgpu_irq_gpu_reset_resume_helper() we use =
the second set of API.<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; The failure happens when vblank irq was enab=
led by dm_vblank_get()
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; before gpu-reset, we have vblank-&gt;enabled=
 true. However, during
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; gpu-reset, in amdgpu_irq_gpu_reset_resume_he=
lper(), vblank irq's state
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; checked from<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; amdgpu_irq_update() is DISABLED. So finally =
it will disable vblank irq
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; again. After gpu-reset, if there is a cursor=
 plane commit, the driver
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; will try to enable vblank irq by calling drm=
_vblank_enable(), but the<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; vblank-&gt;enabled is still true, so it fail=
s to turn on vblank irq and<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; causes flip_done can't be completed in vblan=
k irq handler and desktop
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; become freezed.<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; [How]<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Combining the 2 vblank control APIs by letti=
ng drm's API finally calls
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; amdgpu_irq's API, so the irq's refcount and =
state of both APIs can be
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; synchronized. Also add a check to prevent re=
fcount from being less
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; then<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; 0 in amdgpu_irq_put().<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; Signed-off-by: Alan Liu &lt;<a href=3D"mailt=
o:HaoPing.Liu@amd.com"><span style=3D"color:windowtext;text-decoration:none=
">HaoPing.Liu@amd.com</span></a>&gt;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; ---<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_irq.=
c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;=
 3 +++<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; .../gpu/drm/amd/display/amdgpu_dm/amdg=
pu_dm_crtc.c | 14
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; ++++++++++----<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; 2 files changed, 13 insertions(+), 4 d=
eletions(-)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdg=
pu_irq.c <o:p>
</o:p></p>
<p class=3D"MsoPlainText">&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c<o:=
p></o:p></p>
<p class=3D"MsoPlainText">&gt; index a6aef488a822..1b66003657e2 100644<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.=
c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.=
c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; @@ -597,6 +597,9 @@ int amdgpu_irq_put(struc=
t amdgpu_device *adev, struct amdgpu_irq_src *src,<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (!src-&gt;enabled_types || !src-&gt;funcs-&gt;set)<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (!amdgpu_irq_enabled(adev, src, type))<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp; return 0;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (atomic_dec_and_test(&amp;src-&gt;enabled_types[type]))=
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return amdgpu_irq_update(adev, src, type);<=
o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; diff --git a/drivers/gpu/drm/amd/display/amd=
gpu_dm/amdgpu_dm_crtc.c
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; b/drivers/gpu/drm/amd/display/amdgpu_dm/amdg=
pu_dm_crtc.c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; index dc4f37240beb..e04f846b0b19 100644<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">&gt; --- a/drivers/gpu/drm/amd/display/amdgpu_dm/=
amdgpu_dm_crtc.c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/=
amdgpu_dm_crtc.c<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; @@ -146,7 +146,7 @@ static void vblank_contr=
ol_worker(struct
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; work_struct *work)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; &nbsp;static inline int dm_set_vblank(struct=
 drm_crtc *crtc, bool enable)&nbsp;
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; {<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; enum dc_irq_source irq_source;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; int irq_type;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct amdgpu_crtc *acrtc =3D to_amdgpu_crtc(crtc);<o:p></=
o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct amdgpu_device *adev =3D drm_to_adev(crtc-&gt;dev);<=
o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; struct dm_crtc_state *acrtc_state =3D to_dm_crtc_state(crt=
c-&gt;state);
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; @@ -169,10 +169,16 @@ static inline int dm_s=
et_vblank(struct drm_crtc *crtc, bool enable)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (rc)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return rc;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; irq_source =3D IRQ_TYPE_VBLANK + acrtc-&gt;otg_inst;<o:p></o:p>=
</p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; irq_type =3D amdgpu_display_crtc_idx_to_irq_type(adev,
<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +acrtc-&gt;crtc_id);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (enable)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; rc =3D amdgpu_irq_get(adev, &amp;adev-&gt;crtc_irq, irq_type=
);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; else<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">There's an unnecessary empty line before the &quo=
t;else&quot;. It's a good idea to run patches through scripts/checkpatch.pl=
.<o:p></o:p></p>
<p class=3D"MsoPlainText"><span style=3D"color:#00B050"><o:p>&nbsp;</o:p></=
span></p>
<p class=3D"MsoPlainText"><span style=3D"color:#00B050">Thanks, will use th=
e tool next time.<o:p></o:p></span></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; rc =3D amdgpu_irq_put(adev, &amp;adev-&gt;crtc_irq, irq_type=
);<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; if (!dc_interrupt_set(adev-&gt;dm.dc, irq_source, enable))<o:p>=
</o:p></p>
<p class=3D"MsoPlainText">&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; return -EBUSY;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp; if (rc)<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; return rc;<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; <o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; skip:<o:p></o:p></p>
<p class=3D"MsoPlainText">&gt;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; if (amdgpu_in_reset(adev))<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoPlainText">--<o:p></o:p></p>
<p class=3D"MsoPlainText">Regards,<o:p></o:p></p>
<p class=3D"MsoPlainText">Luben<o:p></o:p></p>
<p class=3D"MsoPlainText"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_SN1PR12MB2445C6C12FC1824D4A14124DF58E9SN1PR12MB2445namp_--
