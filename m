Return-Path: <SRS0=Den1=MP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AB9C4338F
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 08:38:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FA5F60E77
	for <amd-gfx@archiver.kernel.org>; Fri, 23 Jul 2021 08:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6FA5F60E77
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36E576F9E1;
	Fri, 23 Jul 2021 08:38:31 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 217506F9E1
 for <amd-gfx@lists.freedesktop.org>; Fri, 23 Jul 2021 08:38:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vte3YWm2BEMjKc4kypjlK03Q9KPFAZMMm+kTdPWCvcGjoj077/BJD9KVpDg6NMu8ntdRRpKUztca06asEVqKqijIUQe66p+mGOyRCACGkFfgssLpuAmYfUzNFXZsXdgSfXkdLrsXQQVQik23BQUOuGDD+CGJ/QTTL8q9kmT02P6tUCh3y3MCbl5zSc+0nnwHBEXVpqgilwkUE4JXmnxjGDZSxxSRjna4m5MqqKB7UKF96vMOjQF6KBiALSgunt3oBDFJJK6c528Iifku8IwrMTw1mOBlB1ZKqeiysvT6IkZzZnldWpDQLNQR/ZGn2jBDnGwnuyh5FSefMzhID9OBvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYqiKgd5KBcEZfI7glWpiU6OnFKOrPfUKzY3QADQ3ME=;
 b=ljgKn7r63uYMMl/1DhDi+bBsIbach0ZFTuzu7wXlTJBbjWopdh91IUjzLJFJoU1/ET9a/b66NoSPkr1ukuosN7duHxSzKVxaaLt8+sa+Z7N5qtx8eMAWABQboLoc3n+g6tSDZI+7oD0hfA2y4tblTs3XWI9kF1VCfGFntYHXOVGSdLM8CFrUtDiyuBSNiIEl+FeT9D8Xrr6tjnjNfiMGU6FSXDICAcH802SEnvOkRdJPKX0UmVRcjKMZDfJ/LR1sM2dnks4E0juc9Kkf4YY6yMGCq2smqaDJjHE+vo6L5UrEcaRXRpapTiGSzoJ43xNzFjjPIm98rltG6VvLS5MQOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zYqiKgd5KBcEZfI7glWpiU6OnFKOrPfUKzY3QADQ3ME=;
 b=5FCZjJ+KKv6FiW1ioazs0AZtSPxi0ETKEwN1pvQlxnhjk4paI1MJjzZ7W5v+zfPqpeGLjVU0mhRCmXTamF3wu3j6vIcGULKfaPXENcbk19I1EbwOhEuQ2gKgA/OmkyT+kS8q26+v0kByQd3TxDVFRagnsOapq9FFe+9FYVENYLs=
Received: from BL1PR12MB5269.namprd12.prod.outlook.com (2603:10b6:208:30b::20)
 by BL0PR12MB5540.namprd12.prod.outlook.com (2603:10b6:208:1cb::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4352.24; Fri, 23 Jul
 2021 08:38:28 +0000
Received: from BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::d9d7:2d92:acc3:e3c3]) by BL1PR12MB5269.namprd12.prod.outlook.com
 ([fe80::d9d7:2d92:acc3:e3c3%3]) with mapi id 15.20.4352.029; Fri, 23 Jul 2021
 08:38:28 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Chen, JingWen" <JingWen.Chen2@amd.com>,
 =?iso-8859-1?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>,
 "Grodzovsky, Andrey" <Andrey.Grodzovsky@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm: add tdr support for embeded hw_fence
Thread-Topic: [PATCH 2/2] drm: add tdr support for embeded hw_fence
Thread-Index: AQHXfd6St35ofpmzk0K5R0hkdKUtH6tNpjmAgAErZICAAEMgAIAAG5sAgAAGUQCAAObFAIAACY8AgAAZI1A=
Date: Fri, 23 Jul 2021 08:38:27 +0000
Message-ID: <BL1PR12MB526914AB5B18D118D803F66E84E59@BL1PR12MB5269.namprd12.prod.outlook.com>
References: <20210721031352.413888-1-Jingwen.Chen2@amd.com>
 <20210721031352.413888-2-Jingwen.Chen2@amd.com>
 <36f53a64-2d9c-947b-a5fb-21d9fc06c5e4@amd.com>
 <20210722104525.okcnb43goxg6uqej@wayne-build>
 <0699ff85-4aec-0e33-711b-665307fbbc24@amd.com>
 <9dacfe83-da10-9806-81e0-70077dedce9f@gmail.com>
 <20210722164704.age63nzbviqg4y7v@wayne-build>
 <37b6c44f-2fa7-c507-7b77-13608285b362@gmail.com>
 <20210723070714.6h5pmxjebopv4zge@wayne-build>
In-Reply-To: <20210723070714.6h5pmxjebopv4zge@wayne-build>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=true;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-07-23T08:38:24Z; 
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD Official Use
 Only-AIP 2.0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ActionId=f557d37c-5f18-450e-8487-c0f51ce084cc;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 51705b1e-2a61-432c-ad50-08d94db53e5f
x-ms-traffictypediagnostic: BL0PR12MB5540:
x-ld-processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB5540A9C91AC88EB5F7B554A284E59@BL0PR12MB5540.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D/JDa2JeTx0SrCwzPYRUGGiPIOLCTQuPMqBpDnd+QOPJISPXNMUI2jDlOuxVDSTYpnJg8X+rkSPA59QBzbJ9n+Q2Oi86IBNukkfGeNpnHXOR32GLc8QNYiylJ7hp53QgWtweGeheoGShUx6bD0Sv1S/8vrrBQReJKGPVv11dAO6TlX+2Vc7k13OHJEc77T4dVQ6RRvDzbb+eTr/qcgRVZTy3gU4bQa6a3RcwrcZlDpgaq+LatetU8BAGz72u34Q72vKI4Fwyw51N4cdABh5ClfUtkC6AbGOr1lnkNDFCF0AlhhwPV9rnjrzbKUxej/sg5cfYLZYKDQP4X3dTUj9soxOh1D34g3s8KU5mqeqAtbtXYPGTABewLbelHFt7W27tPjeVrYo3YHLGzxGTet75Lb2oCcI7SXIABGldzwznL1YdJzqoAfPB575QtRPlg+R0W5crb7KPKdOhgyCKxlVFrFpcYcdWFVzwTnkWV35V3Z6ynzZWZ8pFyxdmAxQ5QFUCskLxWbTc+KBEy9kMNpCV2FtRh88SfvHbNHEIDTkdyR5DBhzw8/gPfQmuOq9bbnzvmGXm5gFS0d17A1GyPArdgUxpIERze4pbdb/TxPBFIKOU9etNcYcF5IeM26UWcgkVUQmTsbH7xPjtxrNfc7MYeXif0bL9fchK3SeoHPDZGaPa56oUmGCNoyLlQp5AjIieIvMxMtsphIBK0poVomg+Tw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5269.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(4326008)(2906002)(66574015)(5660300002)(54906003)(110136005)(86362001)(7696005)(30864003)(8936002)(508600001)(83380400001)(8676002)(26005)(6506007)(53546011)(71200400001)(186003)(316002)(66556008)(66946007)(52536014)(66446008)(76116006)(64756008)(66476007)(55016002)(9686003)(33656002)(38100700002)(122000001)(38070700004);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?GyM93TbF9WzWQAEGDWboaAAZvcOCZHu8782bzR0ukb5GM/RiOkhcUiwZww?=
 =?iso-8859-1?Q?9vwDgFZhK7qaq/2Sc2w1wSOOWifeFApiuqqT6avvR7PLfjFl2VcIF0p8sN?=
 =?iso-8859-1?Q?6fGauDh3ElPgMT10Lk/gjE622fpCdSgnw9gJdLH0Y+HmOMrPfBKxpMoFuS?=
 =?iso-8859-1?Q?mzElalXiH4gKXRIde+OPUlvplkEBLNfehZNycosCFRKAnyV8jm2TCMygoy?=
 =?iso-8859-1?Q?QO1Ayjft4X6QjX3yOiP9JtbCgbjGAeem+1laxIKfGl4+2QfohnLRwpmidf?=
 =?iso-8859-1?Q?rT72uyfQfaDDO0Ho35E0hml5lyQO6pc8v4CHfEVlIW7uilS0dUvcE2Nck8?=
 =?iso-8859-1?Q?plYxF/OlDeTCWokcL0CrMi2kr5naDOCifMvQAuILpz+KxQIs9k6OS8kIOa?=
 =?iso-8859-1?Q?mZ3t+ArY7AbvsvviEVfgD8bufEjxBZzloD+ef/yPByRWaRgB1jpv/JUxj8?=
 =?iso-8859-1?Q?ymqpAgOXEvfOYA7DU/wT3xIMgBUq5v7EwaHorXcGp/0jOGn8yC8DxyFoCj?=
 =?iso-8859-1?Q?vEZ4u+Jv+HN7u4R96+fBbOF4RuzsSl26AVlIHXbw51LFbHYisWMvCQMTcw?=
 =?iso-8859-1?Q?rU53JfWZ+ACrU0Esq61UE1n65jYem1ebSzsaScQ/ZLGRKVuDfawsgYxJNd?=
 =?iso-8859-1?Q?gJFxCfrqxPvaCdLnSCKxb2tow2aIAHEDAekthh6VNiOlHGK2Hbj30/eYtJ?=
 =?iso-8859-1?Q?6AQXtz3SSG65JDgIsbrQA7cwS7+6PL63u8fcQiOlzG135qfYttph8EcjNx?=
 =?iso-8859-1?Q?aywDB909uRzLr2JnTsgWvAwmGMMtLcU6rYTFZZI2KFosKHHV6J94A3Lt9S?=
 =?iso-8859-1?Q?j3I1ztUCsBHE1b4H2fnl4qYlHR9HQdTlBD+ypbk7eL3v7n7EdaecUEhYiX?=
 =?iso-8859-1?Q?pN5ucQT3oP+8GcUhM/CKU91ChcJ3w9ztdenNfHi+KFNZrVLBp+kMAS5RQF?=
 =?iso-8859-1?Q?TuuriSWEWuidLB/EAiGen6HoAlK79MKFLxDRxO1tBDN2ylrS7toiSyU/jL?=
 =?iso-8859-1?Q?yJ5agK5pbvz8Ql0cR08IhJif/oJZH4fk5LQTmmnWmF5NPe6UJloUMEBWNh?=
 =?iso-8859-1?Q?kqPEuRKxA/FMHHjkQ6pbGHvb00GN7RlezaUsZd7Kzl9crD1ommXSs+3CCb?=
 =?iso-8859-1?Q?IWtYqQxIca1drkwDjcmfrdluzA/+3Sbvd2Ip8rUfyY8rLc4MH9jMtpwked?=
 =?iso-8859-1?Q?sfU4mwKgMrqEQi7lQAspuiYHH3DzM0TDHcxwupUgsw2L5d65yK7Bv44VI6?=
 =?iso-8859-1?Q?z27LLepSGhoi4ar2T4+UBLKDSQaLb4xa6//1piTO373TRfSYGFfQV/Ql8Q?=
 =?iso-8859-1?Q?stpu+5+JKxwn+zkfgb/kyk3iDzbuAplhUJ62MWB1ZVi5Lr6Zdkl10uqXZp?=
 =?iso-8859-1?Q?McZBUraDJG?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5269.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51705b1e-2a61-432c-ad50-08d94db53e5f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2021 08:38:27.8183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Uok33GgKthNnR9pzl0P+pB6LYGCM2y6n0dza+RosHpg351OD9he/L2zgym3u12LT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5540
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
Cc: "Chen, Horace" <Horace.Chen@amd.com>, "Zhang,
 Jack \(Jian\)" <Jack.Zhang1@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only]

Hi Christian =


How about this way:

#define AMDGPU_DMA_FENCE_FLAG_INSIDE_JOB  DMA_FENCE_FLAG_USER_BITS

And we can use  AMDGPU_DMA_FENCE_FLAG_INSIDE_JOB instead of DMA_FENCE_FLAG_=
USER_BITS everywhere

Thanks =


------------------------------------------
Monk Liu | Cloud-GPU Core team
------------------------------------------

-----Original Message-----
From: Jingwen Chen <Jingwen.Chen2@amd.com> =

Sent: Friday, July 23, 2021 3:07 PM
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>; Grodzovsky, Andre=
y <Andrey.Grodzovsky@amd.com>; amd-gfx@lists.freedesktop.org
Cc: Chen, Horace <Horace.Chen@amd.com>; Liu, Monk <Monk.Liu@amd.com>; Zhang=
, Jack (Jian) <Jack.Zhang1@amd.com>
Subject: Re: [PATCH 2/2] drm: add tdr support for embeded hw_fence

On Fri Jul 23, 2021 at 08:33:02AM +0200, Christian K=F6nig wrote:
> Am 22.07.21 um 18:47 schrieb Jingwen Chen:
> > On Thu Jul 22, 2021 at 06:24:28PM +0200, Christian K=F6nig wrote:
> > > Am 22.07.21 um 16:45 schrieb Andrey Grodzovsky:
> > > > On 2021-07-22 6:45 a.m., Jingwen Chen wrote:
> > > > > On Wed Jul 21, 2021 at 12:53:51PM -0400, Andrey Grodzovsky wrote:
> > > > > > On 2021-07-20 11:13 p.m., Jingwen Chen wrote:
> > > > > > > [Why]
> > > > > > > After embeded hw_fence to amdgpu_job, we need to add tdr =

> > > > > > > support for this feature.
> > > > > > > =

> > > > > > > [How]
> > > > > > > 1. Add a resubmit_flag for resubmit jobs.
> > > > > > > 2. Clear job fence from RCU and force complete vm flush =

> > > > > > > fences in
> > > > > > >  =A0=A0=A0=A0 pre_asic_reset
> > > > > > > 3. skip dma_fence_get for resubmit jobs and add a =

> > > > > > > dma_fence_put
> > > > > > >  =A0=A0=A0=A0 for guilty jobs.
> > > > > > > =

> > > > > > > Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> > > > > > > Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> > > > > > > ---
> > > > > > >  =A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 12 =

> > > > > > > +++++++++++-
> > > > > > >  =A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c=A0 | 16 =

> > > > > > > +++++++++++-----
> > > > > > >  =A0=A0 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c=A0=A0=A0 |=A0=
 4 +++-
> > > > > > >  =A0=A0 drivers/gpu/drm/scheduler/sched_main.c=A0=A0=A0=A0 |=
=A0 1 +
> > > > > > >  =A0=A0 include/drm/gpu_scheduler.h=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 |=A0 1 +
> > > > > > >  =A0=A0 5 files changed, 27 insertions(+), 7 deletions(-)
> > > > > > > =

> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > > > index 40461547701a..fe0237f72a09 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > > > > > @@ -4382,7 +4382,7 @@ int amdgpu_device_mode1_reset(struct =

> > > > > > > amdgpu_device *adev)
> > > > > > >  =A0=A0 int amdgpu_device_pre_asic_reset(struct amdgpu_device =

> > > > > > > *adev,
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 st=
ruct amdgpu_reset_context =

> > > > > > > *reset_context)
> > > > > > >  =A0=A0 {
> > > > > > > -=A0=A0=A0 int i, r =3D 0;
> > > > > > > +=A0=A0=A0 int i, j, r =3D 0;
> > > > > > >  =A0=A0=A0=A0=A0=A0 struct amdgpu_job *job =3D NULL;
> > > > > > >  =A0=A0=A0=A0=A0=A0 bool need_full_reset =3D
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 test_bit(AMDGPU_NEED_FULL_RES=
ET, =

> > > > > > > &reset_context->flags); @@ -4406,6 +4406,16 @@ int =

> > > > > > > amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!ring || !ring->sched.thr=
ead)
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 continue;
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 /*clear job fence from fence drv to av=
oid =

> > > > > > > +force_completion
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0 *leave NULL and vm flush fence in f=
ence drv */
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 for (j =3D 0; j <=3D ring->fence_drv.n=
um_fences_mask; =

> > > > > > > +j ++) {
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 struct dma_fence *old,**pt=
r;
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ptr =3D &ring->fence_drv.f=
ences[j];
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 old =3D rcu_dereference_pr=
otected(*ptr, 1);
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (old && test_bit(DMA_FE=
NCE_FLAG_USER_BITS,
> > > > > > > &old->flags))) {
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 RCU_INIT_POINT=
ER(*ptr, NULL);
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > Is this to avoid premature job free because of dma_fence_put =

> > > > > > inside amdgpu_fence_process ?
> > > > > > I can't currently remember why but we probably want all the =

> > > > > > HW fences currently in the ring to be forced signaled - =

> > > > > > maybe better to test for DMA_FENCE_FLAG_USER_BITS inside =

> > > > > > amdgpu_fence_process and still do the signaling but not the =

> > > > > > dma_fence_put part
> > > > > > =

> > > > > > Andrey
> > > > > Hi Andrey,
> > > > > =

> > > > > This is to avoid signaling the same fence twice. If we still =

> > > > > do the signaling, then the job in the pending list will be =

> > > > > signaled first in force_completion, and later be signaled in =

> > > > > resubmit. This will go to
> > > > > BUG() in amdgpu_fence_process.
> > > > =

> > > > Oh, i see, how about just adding 'skip' flag to amdgpu_ring and =

> > > > setting it before calling amdgpu_fence_driver_force_completion =

> > > > and resetting it after, then inside =

> > > > amdgpu_fence_driver_force_completion
> > > > you can just skip the signaling part with this flag for fences =

> > > > with DMA_FENCE_FLAG_USER_BITS set Less lines of code at least.
> > > Still sounds quite a bit hacky.
> > > =

> > > I would rather suggest to completely drop the approach with =

> > > amdgpu_fence_driver_force_completion(). I could never see why we =

> > > would want that in the first place.
> > > =

> > > Regards,
> > > Christian.
> > > =

> > Hi Christian,
> > =

> > I keep the amdgpu_fence_driver_force_completion here to make sure =

> > the vm flush fence is signaled and put.
> > So the key question is whether the fence of ib test should be the =

> > first fence to be signaled after reset.
> > If it should be, it means not only fences with =

> > DMA_FENCE_FLAG_USER_BITS but also vm flush fences should be removed =

> > from RCU fence array before ib_test. Then we must do the =

> > force_completion here for vm flush fence, otherwise there will be a =

> > memory leak here as no one will signal and put it after we remove it fr=
om RCU.
> > If not, then the first fence to signal could be vm flush fence. And =

> > I'm OK with drop amdgpu_fence_driver_force_completion here.
> =

> The key problem is that amdgpu_fence_driver_force_completion() goes =

> over the RCU array and signals everything there.
> =

> What we should do instead is to go over the jobs and cleanup the ones =

> we don't want to re-submit and keep the rest.
> =

Hi Christian,

The thing is vm flush fence has no job passed to amdgpu_fence_emit, so go t=
hrough the jobs cannot help find the vm flush fence. And keep the rest fenc=
es in the RCU array will lead to signaling them in the ib_test right after =
ASIC reset. While they will be signaled again during resubmission. What I'm=
 doning here is just trying to cleanup the fences without a parent job and =
make sure the rest fences won't be signaled twice.

> And please drop any usage of DMA_FENCE_FLAG_USER_BITS. That is not =

> something which should be abused for reset handling.
> =

The DMA_FENCE_FLAG_USER_BITS here is to mark this fence has a parent job. I=
f this is not a proper usage here, do you have any suggestions about how to=
 identify whether the fence has a parent job?

Best Regards,
JingWen Chen
> Regards,
> Christian.
> =

> > =

> > =

> > Best Regards,
> > JingWen Chen
> > > > Andrey
> > > > =

> > > > =

> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 }
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* after all hw jobs are rese=
t, hw fence is =

> > > > > > > meaningless, so force_completion */
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 amdgpu_fence_driver_force_com=
pletion(ring);
> > > > > > >  =A0=A0=A0=A0=A0=A0 }
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > > > > index eecf21d8ec33..815776c9a013 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> > > > > > > @@ -156,11 +156,17 @@ int amdgpu_fence_emit(struct =

> > > > > > > amdgpu_ring *ring, struct dma_fence **f, struct amd
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 job->ring =3D ring;
> > > > > > >  =A0=A0=A0=A0=A0=A0 }
> > > > > > > -=A0=A0=A0 seq =3D ++ring->fence_drv.sync_seq;
> > > > > > > -=A0=A0=A0 dma_fence_init(fence, &amdgpu_fence_ops,
> > > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &ring->fence_drv.=
lock,
> > > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->fence_conte=
xt + ring->idx,
> > > > > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 seq);
> > > > > > > +=A0=A0=A0 if (job !=3D NULL && job->base.resubmit_flag =3D=
=3D 1) {
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 /* reinit seq for resubmitted jobs */
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 seq =3D ++ring->fence_drv.sync_seq;
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 fence->seqno =3D seq;
> > > > > > > +=A0=A0=A0 } else {
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 seq =3D ++ring->fence_drv.sync_seq;
> > > > > > Seems like you could do the above line only once above =

> > > > > > if-else as it was before
> > > > > Sure, I will modify this.
> > > > > =

> > > > > =

> > > > > Best Regards,
> > > > > JingWen Chen
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 dma_fence_init(fence, &amdgpu_fence_op=
s,
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 &ring->fence_d=
rv.lock,
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 adev->fence_co=
ntext + ring->idx,
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 seq);
> > > > > > > +=A0=A0=A0 }
> > > > > > >  =A0=A0=A0=A0=A0=A0 if (job !=3D NULL) {
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* mark this fence has a pare=
nt job */
> > > > > > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > > > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > > > > index 7c426e225b24..d6f848adc3f4 100644
> > > > > > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > > > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > > > > > > @@ -241,6 +241,7 @@ static struct dma_fence
> > > > > > > *amdgpu_job_run(struct drm_sched_job *sched_job)
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dma_fence_set_error(finished,=
 -ECANCELED);/* skip
> > > > > > > IB as well if VRAM lost */
> > > > > > >  =A0=A0=A0=A0=A0=A0 if (finished->error < 0) {
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 dma_fence_put(&job->hw_fence);
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DRM_INFO("Skip scheduling IBs=
!\n");
> > > > > > >  =A0=A0=A0=A0=A0=A0 } else {
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 r =3D amdgpu_ib_schedule(ring=
, job->num_ibs, job->ibs, job,
> > > > > > > @@ -249,7 +250,8 @@ static struct dma_fence
> > > > > > > *amdgpu_job_run(struct drm_sched_job *sched_job)
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 DRM_ERROR("Error =
scheduling IBs (%d)\n", r);
> > > > > > >  =A0=A0=A0=A0=A0=A0 }
> > > > > > > -=A0=A0=A0 dma_fence_get(fence);
> > > > > > > +=A0=A0=A0 if (!job->base.resubmit_flag)
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 dma_fence_get(fence);
> > > > > > >  =A0=A0=A0=A0=A0=A0 amdgpu_job_free_resources(job);
> > > > > > >  =A0=A0=A0=A0=A0=A0 fence =3D r ? ERR_PTR(r) : fence;
> > > > > > > diff --git a/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > b/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > index f4f474944169..5a36ab5aea2d 100644
> > > > > > > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > > > > > > @@ -544,6 +544,7 @@ void drm_sched_resubmit_jobs_ext(struct
> > > > > > > drm_gpu_scheduler *sched, int max)
> > > > > > > dma_fence_set_error(&s_fence->finished, -ECANCELED);
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dma_fence_put(s_job->s_fence-=
>parent);
> > > > > > > +=A0=A0=A0=A0=A0=A0=A0 s_job->resubmit_flag =3D 1;
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fence =3D sched->ops->run_job=
(s_job);
> > > > > > >  =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 i++;
> > > > > > > diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_sc=
heduler.h
> > > > > > > index 4ea8606d91fe..06c101af1f71 100644
> > > > > > > --- a/include/drm/gpu_scheduler.h
> > > > > > > +++ b/include/drm/gpu_scheduler.h
> > > > > > > @@ -198,6 +198,7 @@ struct drm_sched_job {
> > > > > > >  =A0=A0=A0=A0=A0=A0 enum drm_sched_priority=A0=A0=A0=A0=A0=A0=
=A0 s_priority;
> > > > > > >  =A0=A0=A0=A0=A0=A0 struct drm_sched_entity=A0=A0=A0=A0=A0=A0=
=A0=A0 *entity;
> > > > > > >  =A0=A0=A0=A0=A0=A0 struct dma_fence_cb=A0=A0=A0=A0=A0=A0=A0 =
cb;
> > > > > > > +=A0=A0=A0 int resubmit_flag;
> > > > > > >  =A0=A0 };
> > > > > > >  =A0=A0 static inline bool drm_sched_invalidate_job(struct
> > > > > > > drm_sched_job *s_job,
> =

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
