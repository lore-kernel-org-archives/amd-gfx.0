Return-Path: <SRS0=YjM5=4P=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EC4C3F2C0
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35F7B2469F
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2020 21:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PXo+qDR+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35F7B2469F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEE026ED4C;
	Thu, 27 Feb 2020 21:56:51 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22C996E980
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2020 21:56:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzo0kJ3pU0OxS4YHYmXjuTkmiK0wpBs8IrsBd2liTAmk46NwYXE1z3FRV/c7B8CSSx+B6dJMPRudkblLCzQCz9Kqbn/SuxJfM1QfqSPQb3cyy+lb7S2r9N6y6I46YqT/liAVLxzYsA/e2AB+coo8aLSn35ZqauF65iK5DkZX17Cg4VF8Yx0YZnGFvHTu1Pt23KBxArW0W+xTkuS3L8rLU12tKz/E/mgJAtdg+xJPnCMKAN3MT+qmm3zaufttryOQr2rehdsspzUdTrl0iqdqeTz5cROYPBAMtTlgJ0bWK3MDDCrKSlfvH8U++41nWfc/oWCiaZNYregvpIHaGHEz0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYJ6TcvMhCnO8aTC9pfpgT79ogg27p6ZQRvdQtw8egw=;
 b=H1pNJA+gSxsRKlE2FZEiMWGHUPJL/jWUdXtlKUcUCnDc52/08Sz6aDTmWJLF1wxqpJaXgUw3QjRa/evg9j/bB1qzdF8a7H+jbrp5dD4ZGGniW6BRgOaRFDOHalBP61O2Jyz4k6aMCqDLW6uQfT5k1QnXhvPvmLu3K7aNa/aUk4KWaloVFW3/DrNbhMXc7cYKSpoAbs+0jAGVjSp3XhI4dzKCa7tjpjIhUh2pmSPxKU0zJkohbDiZCV0hAhisFfW/L3105i2HYcAusAw7ZG3I2fQOsyZ5wJLka+0wPUHbixW2+bCkR2lDYCUWneGbct1C/9tk22DqEjd8euqZObO2gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RYJ6TcvMhCnO8aTC9pfpgT79ogg27p6ZQRvdQtw8egw=;
 b=PXo+qDR+dJTRHmK7C5S2TsmvRrBuxBaKhc5AmojszeUekmIiQe5EwOEjJdjTcz8u4/Q37mclVgnEfnxUf3M/XT5uBd1Xhn7TzsCWc/1KL+50VMWnLjA6wT7ZK5VfU1XVL9tRG4VyLcLodMHAIvEEua+G/yzPrdMTUWtEe2DbFLY=
Received: from DM5PR12MB2376.namprd12.prod.outlook.com (2603:10b6:4:b9::11) by
 DM5PR12MB1755.namprd12.prod.outlook.com (2603:10b6:3:107::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Thu, 27 Feb 2020 21:56:48 +0000
Received: from DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904]) by DM5PR12MB2376.namprd12.prod.outlook.com
 ([fe80::ac12:6413:cd14:4904%4]) with mapi id 15.20.2750.021; Thu, 27 Feb 2020
 21:56:47 +0000
From: "Das, Nirmoy" <Nirmoy.Das@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, Nirmoy Das <nirmoy.aiemd@gmail.com>
Subject: Re: [RFC PATCH 1/4] drm/amdgpu: set compute queue priority at mqd_init
Thread-Topic: [RFC PATCH 1/4] drm/amdgpu: set compute queue priority at
 mqd_init
Thread-Index: AQHV7bYS2RrDgds0rEG/DEPaQz/4Uagvk86AgAAAp4CAAAE1CQ==
Date: Thu, 27 Feb 2020 21:56:47 +0000
Message-ID: <DM5PR12MB23768ECB654CBBA02C6624DF8BEB0@DM5PR12MB2376.namprd12.prod.outlook.com>
References: <20200227214012.3383-1-nirmoy.das@amd.com>
 <CADnq5_M160ircPyE7WQJ+64bQr1kMJNt0d7OAjNdu--kzOj8-Q@mail.gmail.com>,
 <CADnq5_PmmnKKNbHJa-ZqUGuaUZtDvdASMAuZ0X-wMNssKuA7pw@mail.gmail.com>
In-Reply-To: <CADnq5_PmmnKKNbHJa-ZqUGuaUZtDvdASMAuZ0X-wMNssKuA7pw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-27T21:54:54.1687641Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Privileged
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Nirmoy.Das@amd.com; 
x-originating-ip: [93.229.60.161]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 14f87913-17a7-4ec6-d20e-08d7bbcff167
x-ms-traffictypediagnostic: DM5PR12MB1755:|DM5PR12MB1755:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR12MB17551FE72BBE64FDF034BD038BEB0@DM5PR12MB1755.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-forefront-prvs: 03264AEA72
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(199004)(189003)(30864003)(110136005)(54906003)(316002)(5660300002)(86362001)(76116006)(6506007)(66946007)(478600001)(53546011)(81166006)(9686003)(81156014)(91956017)(45080400002)(4326008)(2906002)(966005)(55016002)(52536014)(186003)(8936002)(71200400001)(66476007)(33656002)(64756008)(66446008)(8676002)(66556008)(26005)(7696005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1755;
 H:DM5PR12MB2376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tsv+UFgL/eo2116sfoRt/MNvyqEzuCGKeY2G7T2Y8KpYLl4Rp1nLw+s7UINBjFazZVn0wwpHclv88bkMowhuO3zSmM3zRLbu6HGwt4C8tWuty5gw3E+GCa7wKciEWrIA5mZ96ais2N4RyfxRyQW0rcJUO7rvlxMVOjbUc2vpJiKm9wH5jSwUm2Lbogwhh+9ACKAx5ybJcE3mdcUuFnS79i3fj+YXXRax9V6AwQqJ4uNqzHouJlR72OE+EmyvV2Tpy4qJ58wWvPDIowd1aAVFlCRlO9TM5YfvTVeNQcQgI9dcpSDvsIKsX4qP4ea1FATtBNBSRCr6Z0+U5Ho3JXtUcxkqm/1lozZn+V+FPtzfx+Sp9DmN4H7FMkLy36e8RDUReXF7YdYNH/Ebgs+SygximJPlO3lc5DPWXOfWweQ9HMV3zTUekpiDwxqrw/Og1A7PKpSue08WPJgfesMMM9ByzJ/RHoMweGVRSRJun9vwSMV6t2vYUZCNcNWOF/Kav906C3UvIF4yv2n6isAObGjOMw==
x-ms-exchange-antispam-messagedata: sRiuXflAxTTAGAkJIdjC0pQ++2f0CL5XRJRBpAfeuGORJK9htOyQK1SiNzpT3SZQKovkYqWNdhtIg8YLFCsqJj2EOw6G3JAyY/5ZOxbEPqQiSecXk382uNwWCN2jmW6uUGB5W6Z1hfhV+Hc9OZ95Bw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14f87913-17a7-4ec6-d20e-08d7bbcff167
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2020 21:56:47.7133 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LrXHoK2+rVgjHpzkJohfnDZHX8yKVlB+HXM7Wzh8vu8xUjLdZbxfv/fsjhbPU2Cvg0gHM3tdVZk2Pco3rJ4CZA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1755
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Huang,
 Ray" <Ray.Huang@amd.com>, "Koenig, Christian" <Christian.Koenig@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============0279050626=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0279050626==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DM5PR12MB23768ECB654CBBA02C6624DF8BEB0DM5PR12MB2376namp_"

--_000_DM5PR12MB23768ECB654CBBA02C6624DF8BEB0DM5PR12MB2376namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

Yes I missed gfx_v10_0.c. I will resend a updated one tomorrow.

Regards,
Nirmoy
Get Outlook for Android<https://aka.ms/ghei36>
________________________________
From: Alex Deucher <alexdeucher@gmail.com>
Sent: Thursday, February 27, 2020 10:50:35 PM
To: Nirmoy Das <nirmoy.aiemd@gmail.com>
Cc: amd-gfx list <amd-gfx@lists.freedesktop.org>; Deucher, Alexander <Alexa=
nder.Deucher@amd.com>; Huang, Ray <Ray.Huang@amd.com>; Das, Nirmoy <Nirmoy.=
Das@amd.com>; Koenig, Christian <Christian.Koenig@amd.com>
Subject: Re: [RFC PATCH 1/4] drm/amdgpu: set compute queue priority at mqd_=
init

On Thu, Feb 27, 2020 at 4:48 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Thu, Feb 27, 2020 at 4:37 PM Nirmoy Das <nirmoy.aiemd@gmail.com> wrote=
:
> >
> > We were changing compute ring priority while rings were being used
> > before every job submission which is not recommended. This patch
> > sets compute queue priority at mqd initialization for gfx8 and gfx9.
> >
> > Policy: Enable high priority compute queues only if gpu has >1 MEC, if
> > so PIPE0 and PIPE1 will be in high priority.
>
> I think we still want high priority queues on even when there is only
> one MEC.  It might work better on multi-MEC chips, but it should still
> work on single MEC chips.
>
> >
> > high/normal priority compute sched list are generated from set of high/=
normal
> > priority compute queues. At context creation, entity of compute queue
> > get a sched list from high or normal priority depending on ctx->priorit=
y
> >
> > Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  4 ----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c  | 19 +++++++++++++++----
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c  | 14 ++++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h  | 12 ++++++++++++
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c  |  6 ------
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |  1 +
> >  drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c    | 23 ++++++++++++++++++++---
> >  drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c    | 20 ++++++++++++++++++++

Also, can you add a patch for gfx_v10_0.c?

Alex

> >  8 files changed, 82 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/a=
md/amdgpu/amdgpu_cs.c
> > index f397ff97b4e4..8304d0c87899 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> > @@ -1205,7 +1205,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_pars=
er *p,
> >         struct amdgpu_fpriv *fpriv =3D p->filp->driver_priv;
> >         struct drm_sched_entity *entity =3D p->entity;
> >         enum drm_sched_priority priority;
> > -       struct amdgpu_ring *ring;
> >         struct amdgpu_bo_list_entry *e;
> >         struct amdgpu_job *job;
> >         uint64_t seq;
> > @@ -1258,9 +1257,6 @@ static int amdgpu_cs_submit(struct amdgpu_cs_pars=
er *p,
> >         priority =3D job->base.s_priority;
> >         drm_sched_entity_push_job(&job->base, entity);
> >
> > -       ring =3D to_amdgpu_ring(entity->rq->sched);
> > -       amdgpu_ring_priority_get(ring, priority);
> > -
> >         amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
> >
> >         ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence=
);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_ctx.c
> > index 94a6c42f29ea..a1742b1d4f9c 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> > @@ -85,8 +85,14 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx =
*ctx, const u32 hw_ip, const
> >                         num_scheds =3D 1;
> >                         break;
> >                 case AMDGPU_HW_IP_COMPUTE:
> > -                       scheds =3D adev->gfx.compute_sched;
> > -                       num_scheds =3D adev->gfx.num_compute_sched;
> > +                       if (priority > DRM_SCHED_PRIORITY_NORMAL &&
> > +                           adev->gfx.num_compute_sched_high) {
> > +                               scheds =3D adev->gfx.compute_sched_high=
;
> > +                               num_scheds =3D adev->gfx.num_compute_sc=
hed_high;
> > +                       } else {
> > +                               scheds =3D adev->gfx.compute_sched;
> > +                               num_scheds =3D adev->gfx.num_compute_sc=
hed;
> > +                       }
> >                         break;
> >                 case AMDGPU_HW_IP_DMA:
> >                         scheds =3D adev->sdma.sdma_sched;
> > @@ -638,8 +644,13 @@ void amdgpu_ctx_init_sched(struct amdgpu_device *a=
dev)
> >         }
> >
> >         for (i =3D 0; i < adev->gfx.num_compute_rings; i++) {
> > -               adev->gfx.compute_sched[i] =3D &adev->gfx.compute_ring[=
i].sched;
> > -               adev->gfx.num_compute_sched++;
> > +               if (!adev->gfx.compute_ring[i].high_priority) {
> > +                       adev->gfx.compute_sched[adev->gfx.num_compute_s=
ched++] =3D
> > +                               &adev->gfx.compute_ring[i].sched;
> > +               } else {
> > +                       adev->gfx.compute_sched_high[adev->gfx.num_comp=
ute_sched_high++] =3D
> > +                               &adev->gfx.compute_ring[i].sched;
> > +               }
> >         }
> >
> >         for (i =3D 0; i < adev->sdma.num_instances; i++) {
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.c
> > index 7403588684b3..bdea5d44edf4 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> > @@ -192,6 +192,20 @@ static bool amdgpu_gfx_is_multipipe_capable(struct=
 amdgpu_device *adev)
> >         return adev->gfx.mec.num_mec > 1;
> >  }
> >
> > +bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *a=
dev,
> > +                                              int queue)
> > +{
> > +       bool multipipe_policy =3D amdgpu_gfx_is_multipipe_capable(adev)=
;
> > +
> > +       /* only enable high priority queue if more than 1 MEC.
> > +        * When multipipe_policy is true amdgpu gets queue 0,1 from eac=
h pipe of
> > +        * 1st MEC. Policy: make queue 0 of each pipe as high priority =
compute queue */
> > +       if (multipipe_policy && queue =3D=3D 0)
> > +               return true;
> > +
> > +       return false;
> > +}
> > +
> >  void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
> >  {
> >         int i, queue, pipe, mec;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_gfx.h
> > index 37ba05b63b2a..13ee0ea66c6f 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h
> > @@ -41,6 +41,14 @@
> >  #define AMDGPU_MAX_GFX_QUEUES KGD_MAX_QUEUES
> >  #define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES
> >
> > +#define AMDGPU_GFX_PIPE_PRIO_LOW    0
> > +#define AMDGPU_GFX_PIPE_PRIO_NORMAL 1
> > +#define AMDGPU_GFX_PIPE_PRIO_HIGH   2
> > +
> > +#define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM  0
> > +#define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM  15
> > +
> > +
> >  struct amdgpu_mec {
> >         struct amdgpu_bo        *hpd_eop_obj;
> >         u64                     hpd_eop_gpu_addr;
> > @@ -281,7 +289,9 @@ struct amdgpu_gfx {
> >         unsigned                        num_gfx_rings;
> >         struct amdgpu_ring              compute_ring[AMDGPU_MAX_COMPUTE=
_RINGS];
> >         struct drm_gpu_scheduler        *compute_sched[AMDGPU_MAX_COMPU=
TE_RINGS];
> > +       struct drm_gpu_scheduler        *compute_sched_high[AMDGPU_MAX_=
COMPUTE_RINGS];
> >         uint32_t                        num_compute_sched;
> > +       uint32_t                        num_compute_sched_high;
> >         unsigned                        num_compute_rings;
> >         struct amdgpu_irq_src           eop_irq;
> >         struct amdgpu_irq_src           priv_reg_irq;
> > @@ -363,6 +373,8 @@ void amdgpu_gfx_bit_to_mec_queue(struct amdgpu_devi=
ce *adev, int bit,
> >                                  int *mec, int *pipe, int *queue);
> >  bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *adev, int m=
ec,
> >                                      int pipe, int queue);
> > +bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu_device *a=
dev,
> > +                                              int queue);
> >  int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev, int me,
> >                                int pipe, int queue);
> >  void amdgpu_gfx_bit_to_me_queue(struct amdgpu_device *adev, int bit,
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/=
amd/amdgpu/amdgpu_job.c
> > index d42be880a236..4981e443a884 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> > @@ -117,12 +117,10 @@ void amdgpu_job_free_resources(struct amdgpu_job =
*job)
> >
> >  static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
> >  {
> > -       struct amdgpu_ring *ring =3D to_amdgpu_ring(s_job->sched);
> >         struct amdgpu_job *job =3D to_amdgpu_job(s_job);
> >
> >         drm_sched_job_cleanup(s_job);
> >
> > -       amdgpu_ring_priority_put(ring, s_job->s_priority);
> >         dma_fence_put(job->fence);
> >         amdgpu_sync_free(&job->sync);
> >         amdgpu_sync_free(&job->sched_sync);
> > @@ -143,7 +141,6 @@ int amdgpu_job_submit(struct amdgpu_job *job, struc=
t drm_sched_entity *entity,
> >                       void *owner, struct dma_fence **f)
> >  {
> >         enum drm_sched_priority priority;
> > -       struct amdgpu_ring *ring;
> >         int r;
> >
> >         if (!f)
> > @@ -158,9 +155,6 @@ int amdgpu_job_submit(struct amdgpu_job *job, struc=
t drm_sched_entity *entity,
> >         priority =3D job->base.s_priority;
> >         drm_sched_entity_push_job(&job->base, entity);
> >
> > -       ring =3D to_amdgpu_ring(entity->rq->sched);
> > -       amdgpu_ring_priority_get(ring, priority);
> > -
> >         return 0;
> >  }
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm=
/amd/amdgpu/amdgpu_ring.h
> > index 24caff085d00..34fcd467f18d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> > @@ -222,6 +222,7 @@ struct amdgpu_ring {
> >         struct mutex            priority_mutex;
> >         /* protected by priority_mutex */
> >         int                     priority;
> > +       bool                    high_priority;
> >
> >  #if defined(CONFIG_DEBUG_FS)
> >         struct dentry *ent;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v8_0.c
> > index e63f98b2d389..4260becd569b 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> > @@ -4426,6 +4426,23 @@ static int gfx_v8_0_deactivate_hqd(struct amdgpu=
_device *adev, u32 req)
> >         return r;
> >  }
> >
> > +static void gfx_v8_0_mqd_set_priority(struct amdgpu_ring *ring, struct=
 vi_mqd *mqd)
> > +{
> > +       struct amdgpu_device *adev =3D ring->adev;
> > +
> > +       if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE) {
> > +               if (amdgpu_gfx_is_high_priority_compute_queue(adev, rin=
g->queue)) {
> > +                       mqd->cp_hqd_pipe_priority =3D AMDGPU_GFX_PIPE_P=
RIO_HIGH;
> > +                       ring->high_priority =3D true;
> > +                       mqd->cp_hqd_queue_priority =3D
> > +                               AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
> > +                       mqd->cp_hqd_quantum =3D RREG32(mmCP_HQD_QUANTUM=
);
>
> I think we can move this back to mqd_init().  It needs to be set up
> for both low and high priority queues.
>
> > +               }
> > +               else
> > +                       ring->high_priority =3D false;
> > +       }
> > +}
> > +
> >  static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)
> >  {
> >         struct amdgpu_device *adev =3D ring->adev;
> > @@ -4549,9 +4566,6 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *=
ring)
> >         /* defaults */
> >         mqd->cp_hqd_eop_rptr =3D RREG32(mmCP_HQD_EOP_RPTR);
> >         mqd->cp_hqd_eop_wptr =3D RREG32(mmCP_HQD_EOP_WPTR);
> > -       mqd->cp_hqd_pipe_priority =3D RREG32(mmCP_HQD_PIPE_PRIORITY);
> > -       mqd->cp_hqd_queue_priority =3D RREG32(mmCP_HQD_QUEUE_PRIORITY);
> > -       mqd->cp_hqd_quantum =3D RREG32(mmCP_HQD_QUANTUM);
> >         mqd->cp_hqd_ctx_save_base_addr_lo =3D RREG32(mmCP_HQD_CTX_SAVE_=
BASE_ADDR_LO);
> >         mqd->cp_hqd_ctx_save_base_addr_hi =3D RREG32(mmCP_HQD_CTX_SAVE_=
BASE_ADDR_HI);
> >         mqd->cp_hqd_cntl_stack_offset =3D RREG32(mmCP_HQD_CNTL_STACK_OF=
FSET);
> > @@ -4563,6 +4577,9 @@ static int gfx_v8_0_mqd_init(struct amdgpu_ring *=
ring)
> >         mqd->cp_hqd_eop_wptr_mem =3D RREG32(mmCP_HQD_EOP_WPTR_MEM);
> >         mqd->cp_hqd_eop_dones =3D RREG32(mmCP_HQD_EOP_DONES);
> >
> > +       /* set static priority for a queue/ring */
> > +       gfx_v8_0_mqd_set_priority(ring, mqd);
> > +
> >         /* map_queues packet doesn't need activate the queue,
> >          * so only kiq need set this field.
> >          */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/am=
d/amdgpu/gfx_v9_0.c
> > index 4135e4126e82..85a54849abd1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> > @@ -3310,6 +3310,23 @@ static void gfx_v9_0_kiq_setting(struct amdgpu_r=
ing *ring)
> >         WREG32_SOC15_RLC(GC, 0, mmRLC_CP_SCHEDULERS, tmp);
> >  }
> >
> > +static void gfx_v9_0_mqd_set_priority(struct amdgpu_ring *ring, struct=
 v9_mqd *mqd)
> > +{
> > +       struct amdgpu_device *adev =3D ring->adev;
> > +
> > +       if (ring->funcs->type =3D=3D AMDGPU_RING_TYPE_COMPUTE) {
> > +               if (amdgpu_gfx_is_high_priority_compute_queue(adev, rin=
g->queue)) {
> > +                       mqd->cp_hqd_pipe_priority =3D AMDGPU_GFX_PIPE_P=
RIO_HIGH;
> > +                       ring->high_priority =3D true;
> > +                       mqd->cp_hqd_queue_priority =3D
> > +                               AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM;
> > +                       mqd->cp_hqd_quantum =3D RREG32(mmCP_HQD_QUANTUM=
);
>
> Same comment here.
>
> Alex
>
> > +               }
> > +               else
> > +                       ring->high_priority =3D false;
> > +       }
> > +}
> > +
> >  static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)
> >  {
> >         struct amdgpu_device *adev =3D ring->adev;
> > @@ -3446,6 +3463,9 @@ static int gfx_v9_0_mqd_init(struct amdgpu_ring *=
ring)
> >         tmp =3D REG_SET_FIELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE=
, 3);
> >         mqd->cp_hqd_ib_control =3D tmp;
> >
> > +       /* set static priority for a queue/ring */
> > +       gfx_v9_0_mqd_set_priority(ring, mqd);
> > +
> >         /* map_queues packet doesn't need activate the queue,
> >          * so only kiq need set this field.
> >          */
> > --
> > 2.25.0
> >
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flis=
ts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cnirm=
oy.das%40amd.com%7C9cd63275980e426c420808d7bbcf1b33%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637184370519368178&amp;sdata=3DqvENGcFENLfXkn3HiA0yeG=
wo1N0dU2meZm51kD%2FdjsE%3D&amp;reserved=3D0

--_000_DM5PR12MB23768ECB654CBBA02C6624DF8BEB0DM5PR12MB2376namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
</head>
<body>
<p style=3D"font-family:Arial;font-size:10pt;color:#0078D7;margin:15pt;" al=
ign=3D"Left">
[AMD Official Use Only - Internal Distribution Only]<br>
</p>
<br>
<div>
<div style=3D"color: rgb(33, 33, 33); background-color: rgb(255, 255, 255);=
 text-align: left;" dir=3D"auto">
Yes I missed&nbsp;<span style=3D"font-family: -apple-system, HelveticaNeue;=
 font-size: 14.6667px; text-align: start; display: inline !important;">gfx_=
v10_0.c. I will resend a updated one tomorrow.&nbsp;</span></div>
<div id=3D"ms-outlook-mobile-signature" dir=3D"auto" style=3D"text-align: l=
eft;">
<div dir=3D"auto" style=3D"text-align: left;"><br>
</div>
<div dir=3D"auto" style=3D"text-align: left;">Regards,&nbsp;</div>
<div dir=3D"auto" style=3D"text-align: left;">Nirmoy&nbsp;</div>
Get <a href=3D"https://aka.ms/ghei36">Outlook for Android</a></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Alex Deucher &lt;alex=
deucher@gmail.com&gt;<br>
<b>Sent:</b> Thursday, February 27, 2020 10:50:35 PM<br>
<b>To:</b> Nirmoy Das &lt;nirmoy.aiemd@gmail.com&gt;<br>
<b>Cc:</b> amd-gfx list &lt;amd-gfx@lists.freedesktop.org&gt;; Deucher, Ale=
xander &lt;Alexander.Deucher@amd.com&gt;; Huang, Ray &lt;Ray.Huang@amd.com&=
gt;; Das, Nirmoy &lt;Nirmoy.Das@amd.com&gt;; Koenig, Christian &lt;Christia=
n.Koenig@amd.com&gt;<br>
<b>Subject:</b> Re: [RFC PATCH 1/4] drm/amdgpu: set compute queue priority =
at mqd_init</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">On Thu, Feb 27, 2020 at 4:48 PM Alex Deucher &lt;a=
lexdeucher@gmail.com&gt; wrote:<br>
&gt;<br>
&gt; On Thu, Feb 27, 2020 at 4:37 PM Nirmoy Das &lt;nirmoy.aiemd@gmail.com&=
gt; wrote:<br>
&gt; &gt;<br>
&gt; &gt; We were changing compute ring priority while rings were being use=
d<br>
&gt; &gt; before every job submission which is not recommended. This patch<=
br>
&gt; &gt; sets compute queue priority at mqd initialization for gfx8 and gf=
x9.<br>
&gt; &gt;<br>
&gt; &gt; Policy: Enable high priority compute queues only if gpu has &gt;1=
 MEC, if<br>
&gt; &gt; so PIPE0 and PIPE1 will be in high priority.<br>
&gt;<br>
&gt; I think we still want high priority queues on even when there is only<=
br>
&gt; one MEC.&nbsp; It might work better on multi-MEC chips, but it should =
still<br>
&gt; work on single MEC chips.<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; high/normal priority compute sched list are generated from set of=
 high/normal<br>
&gt; &gt; priority compute queues. At context creation, entity of compute q=
ueue<br>
&gt; &gt; get a sched list from high or normal priority depending on ctx-&g=
t;priority<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Nirmoy Das &lt;nirmoy.das@amd.com&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c&nbsp;&nbsp; |&nbsp; =
4 ----<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c&nbsp; | 19 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c&nbsp; | 14 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h&nbsp; | 12 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_job.c&nbsp; |&nbsp; 6 ---=
---<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |&nbsp; 1 &#43;<br=
>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp;&nbsp;&nbsp; | 2=
3 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;---<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp;&nbsp; | 2=
0 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;<br>
<br>
Also, can you add a patch for gfx_v10_0.c?<br>
<br>
Alex<br>
<br>
&gt; &gt;&nbsp; 8 files changed, 82 insertions(&#43;), 17 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu=
/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; &gt; index f397ff97b4e4..8304d0c87899 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; &gt; @@ -1205,7 &#43;1205,6 @@ static int amdgpu_cs_submit(struct amdg=
pu_cs_parser *p,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_fpr=
iv *fpriv =3D p-&gt;filp-&gt;driver_priv;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_sched_=
entity *entity =3D p-&gt;entity;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum drm_sched_pr=
iority priority;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring;<b=
r>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo_=
list_entry *e;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job=
 *job;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t seq;<br>
&gt; &gt; @@ -1258,9 &#43;1257,6 @@ static int amdgpu_cs_submit(struct amdg=
pu_cs_parser *p,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priority =3D job-=
&gt;base.s_priority;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_entity_=
push_job(&amp;job-&gt;base, entity);<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D to_amdgpu_ring(ent=
ity-&gt;rq-&gt;sched);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_priority_get(ri=
ng, priority);<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_vm_move_to=
_lru_tail(p-&gt;adev, &amp;fpriv-&gt;vm);<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ttm_eu_fence_buff=
er_objects(&amp;p-&gt;ticket, &amp;p-&gt;validated, p-&gt;fence);<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_ctx.c<br>
&gt; &gt; index 94a6c42f29ea..a1742b1d4f9c 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c<br>
&gt; &gt; @@ -85,8 &#43;85,14 @@ static int amdgpu_ctx_init_entity(struct a=
mdgpu_ctx *ctx, const u32 hw_ip, const<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; num_scheds =3D 1;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_HW_IP_COMPUTE:<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scheds=
 =3D adev-&gt;gfx.compute_sched;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_sc=
heds =3D adev-&gt;gfx.num_compute_sched;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if=
 (priority &gt; DRM_SCHED_PRIORITY_NORMAL &amp;&amp;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.num_compute_sched_high) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scheds =3D adev-&gt;gfx.compu=
te_sched_high;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_scheds =3D adev-&gt;gfx.n=
um_compute_sched_high;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } =
else {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; scheds =3D adev-&gt;gfx.compu=
te_sched;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_scheds =3D adev-&gt;gfx.n=
um_compute_sched;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<=
br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; break;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case AMDGPU_HW_IP_DMA:<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; scheds =3D adev-&gt;sdma.sdma_sched;<br>
&gt; &gt; @@ -638,8 &#43;644,13 @@ void amdgpu_ctx_init_sched(struct amdgpu=
_device *adev)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &=
lt; adev-&gt;gfx.num_compute_rings; i&#43;&#43;) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.compute_sched[i] =3D &amp;adev-&gt;gfx.co=
mpute_ring[i].sched;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.num_compute_sched&#43;&#43;;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gfx.compute_ring[i].high_priority) {=
<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ad=
ev-&gt;gfx.compute_sched[adev-&gt;gfx.num_compute_sched&#43;&#43;] =3D<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.compute_rin=
g[i].sched;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; } else {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ad=
ev-&gt;gfx.compute_sched_high[adev-&gt;gfx.num_compute_sched_high&#43;&#43;=
] =3D<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;adev-&gt;gfx.compute_rin=
g[i].sched;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (i =3D 0; i &=
lt; adev-&gt;sdma.num_instances; i&#43;&#43;) {<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_gfx.c<br>
&gt; &gt; index 7403588684b3..bdea5d44edf4 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c<br>
&gt; &gt; @@ -192,6 &#43;192,20 @@ static bool amdgpu_gfx_is_multipipe_capa=
ble(struct amdgpu_device *adev)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return adev-&gt;g=
fx.mec.num_mec &gt; 1;<br>
&gt; &gt;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; &#43;bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu=
_device *adev,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int queue)<br>
&gt; &gt; &#43;{<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool multipipe_policy =
=3D amdgpu_gfx_is_multipipe_capable(adev);<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* only enable high pri=
ority queue if more than 1 MEC.<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * When multipipe_=
policy is true amdgpu gets queue 0,1 from each pipe of<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * 1st MEC. Policy=
: make queue 0 of each pipe as high priority compute queue */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (multipipe_policy &a=
mp;&amp; queue =3D=3D 0)<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; return true;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return false;<br>
&gt; &gt; &#43;}<br>
&gt; &gt; &#43;<br>
&gt; &gt;&nbsp; void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device =
*adev)<br>
&gt; &gt;&nbsp; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i, queue, pip=
e, mec;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_gfx.h<br>
&gt; &gt; index 37ba05b63b2a..13ee0ea66c6f 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.h<br>
&gt; &gt; @@ -41,6 &#43;41,14 @@<br>
&gt; &gt;&nbsp; #define AMDGPU_MAX_GFX_QUEUES KGD_MAX_QUEUES<br>
&gt; &gt;&nbsp; #define AMDGPU_MAX_COMPUTE_QUEUES KGD_MAX_QUEUES<br>
&gt; &gt;<br>
&gt; &gt; &#43;#define AMDGPU_GFX_PIPE_PRIO_LOW&nbsp;&nbsp;&nbsp; 0<br>
&gt; &gt; &#43;#define AMDGPU_GFX_PIPE_PRIO_NORMAL 1<br>
&gt; &gt; &#43;#define AMDGPU_GFX_PIPE_PRIO_HIGH&nbsp;&nbsp; 2<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;#define AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM&nbsp; 0<br>
&gt; &gt; &#43;#define AMDGPU_GFX_QUEUE_PRIORITY_MAXIMUM&nbsp; 15<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;<br>
&gt; &gt;&nbsp; struct amdgpu_mec {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_bo&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *hpd_eop_obj;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; u64&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; hpd_eop_gpu_addr;<br>
&gt; &gt; @@ -281,7 &#43;289,9 @@ struct amdgpu_gfx {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_gfx_rings;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_rin=
g&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp; compute_ring[AMDGPU_MAX_COMPUTE_RINGS];<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gpu_sc=
heduler&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *compute_sched[AMDGPU_MAX=
_COMPUTE_RINGS];<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct drm_gpu_schedule=
r&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *compute_sched_high[AMDGPU_MAX_=
COMPUTE_RINGS];<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_compute_sched;<b=
r>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_compute_sched_high;<br=
>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; num_compute_rings;<b=
r>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq=
_src&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; eop_irq;<b=
r>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_irq=
_src&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priv_reg_i=
rq;<br>
&gt; &gt; @@ -363,6 &#43;373,8 @@ void amdgpu_gfx_bit_to_mec_queue(struct a=
mdgpu_device *adev, int bit,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int *mec, int *pi=
pe, int *queue);<br>
&gt; &gt;&nbsp; bool amdgpu_gfx_is_mec_queue_enabled(struct amdgpu_device *=
adev, int mec,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; int pipe, int queue);<br>
&gt; &gt; &#43;bool amdgpu_gfx_is_high_priority_compute_queue(struct amdgpu=
_device *adev,<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int queue);<br=
>
&gt; &gt;&nbsp; int amdgpu_gfx_me_queue_to_bit(struct amdgpu_device *adev, =
int me,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int pipe, int queue);<br>
&gt; &gt;&nbsp; void amdgpu_gfx_bit_to_me_queue(struct amdgpu_device *adev,=
 int bit,<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gp=
u/drm/amd/amdgpu/amdgpu_job.c<br>
&gt; &gt; index d42be880a236..4981e443a884 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c<br>
&gt; &gt; @@ -117,12 &#43;117,10 @@ void amdgpu_job_free_resources(struct a=
mdgpu_job *job)<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; static void amdgpu_job_free_cb(struct drm_sched_job *s_job)=
<br>
&gt; &gt;&nbsp; {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring =
=3D to_amdgpu_ring(s_job-&gt;sched);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_job=
 *job =3D to_amdgpu_job(s_job);<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_job_cle=
anup(s_job);<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_priority_put(ri=
ng, s_job-&gt;s_priority);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dma_fence_put(job=
-&gt;fence);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sync_free(=
&amp;job-&gt;sync);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_sync_free(=
&amp;job-&gt;sched_sync);<br>
&gt; &gt; @@ -143,7 &#43;141,6 @@ int amdgpu_job_submit(struct amdgpu_job *=
job, struct drm_sched_entity *entity,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void *ow=
ner, struct dma_fence **f)<br>
&gt; &gt;&nbsp; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; enum drm_sched_pr=
iority priority;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_ring *ring;<b=
r>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int r;<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!f)<br>
&gt; &gt; @@ -158,9 &#43;155,6 @@ int amdgpu_job_submit(struct amdgpu_job *=
job, struct drm_sched_entity *entity,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priority =3D job-=
&gt;base.s_priority;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; drm_sched_entity_=
push_job(&amp;job-&gt;base, entity);<br>
&gt; &gt;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ring =3D to_amdgpu_ring(ent=
ity-&gt;rq-&gt;sched);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_ring_priority_get(ri=
ng, priority);<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; &gt;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/g=
pu/drm/amd/amdgpu/amdgpu_ring.h<br>
&gt; &gt; index 24caff085d00..34fcd467f18d 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h<br>
&gt; &gt; @@ -222,6 &#43;222,7 @@ struct amdgpu_ring {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct mutex&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priority_mute=
x;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* protected by p=
riority_mutex */<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; priority;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; high_priority;<br>
&gt; &gt;<br>
&gt; &gt;&nbsp; #if defined(CONFIG_DEBUG_FS)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct dentry *en=
t;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/=
drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; &gt; index e63f98b2d389..4260becd569b 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; &gt; @@ -4426,6 &#43;4426,23 @@ static int gfx_v8_0_deactivate_hqd(str=
uct amdgpu_device *adev, u32 req)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return r;<br>
&gt; &gt;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; &#43;static void gfx_v8_0_mqd_set_priority(struct amdgpu_ring *ri=
ng, struct vi_mqd *mqd)<br>
&gt; &gt; &#43;{<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *a=
dev =3D ring-&gt;adev;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;funcs-&gt;=
type =3D=3D AMDGPU_RING_TYPE_COMPUTE) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_gfx_is_high_priority_compute_queue(adev=
, ring-&gt;queue)) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mq=
d-&gt;cp_hqd_pipe_priority =3D AMDGPU_GFX_PIPE_PRIO_HIGH;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ri=
ng-&gt;high_priority =3D true;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mq=
d-&gt;cp_hqd_queue_priority =3D<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GFX_QUEUE_PRIORITY_MAX=
IMUM;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mq=
d-&gt;cp_hqd_quantum =3D RREG32(mmCP_HQD_QUANTUM);<br>
&gt;<br>
&gt; I think we can move this back to mqd_init().&nbsp; It needs to be set =
up<br>
&gt; for both low and high priority queues.<br>
&gt;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ri=
ng-&gt;high_priority =3D false;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;}<br>
&gt; &gt; &#43;<br>
&gt; &gt;&nbsp; static int gfx_v8_0_mqd_init(struct amdgpu_ring *ring)<br>
&gt; &gt;&nbsp; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_dev=
ice *adev =3D ring-&gt;adev;<br>
&gt; &gt; @@ -4549,9 &#43;4566,6 @@ static int gfx_v8_0_mqd_init(struct amd=
gpu_ring *ring)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* defaults */<br=
>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_eo=
p_rptr =3D RREG32(mmCP_HQD_EOP_RPTR);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_eo=
p_wptr =3D RREG32(mmCP_HQD_EOP_WPTR);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_pipe_priorit=
y =3D RREG32(mmCP_HQD_PIPE_PRIORITY);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_queue_priori=
ty =3D RREG32(mmCP_HQD_QUEUE_PRIORITY);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_quantum =3D =
RREG32(mmCP_HQD_QUANTUM);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_ct=
x_save_base_addr_lo =3D RREG32(mmCP_HQD_CTX_SAVE_BASE_ADDR_LO);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_ct=
x_save_base_addr_hi =3D RREG32(mmCP_HQD_CTX_SAVE_BASE_ADDR_HI);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_cn=
tl_stack_offset =3D RREG32(mmCP_HQD_CNTL_STACK_OFFSET);<br>
&gt; &gt; @@ -4563,6 &#43;4577,9 @@ static int gfx_v8_0_mqd_init(struct amd=
gpu_ring *ring)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_eo=
p_wptr_mem =3D RREG32(mmCP_HQD_EOP_WPTR_MEM);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_eo=
p_dones =3D RREG32(mmCP_HQD_EOP_DONES);<br>
&gt; &gt;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set static priority =
for a queue/ring */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v8_0_mqd_set_priori=
ty(ring, mqd);<br>
&gt; &gt; &#43;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* map_queues pac=
ket doesn't need activate the queue,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * so only k=
iq need set this field.<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/=
drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &gt; index 4135e4126e82..85a54849abd1 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &gt; @@ -3310,6 &#43;3310,23 @@ static void gfx_v9_0_kiq_setting(struc=
t amdgpu_ring *ring)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15_RLC(=
GC, 0, mmRLC_CP_SCHEDULERS, tmp);<br>
&gt; &gt;&nbsp; }<br>
&gt; &gt;<br>
&gt; &gt; &#43;static void gfx_v9_0_mqd_set_priority(struct amdgpu_ring *ri=
ng, struct v9_mqd *mqd)<br>
&gt; &gt; &#43;{<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_device *a=
dev =3D ring-&gt;adev;<br>
&gt; &gt; &#43;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ring-&gt;funcs-&gt;=
type =3D=3D AMDGPU_RING_TYPE_COMPUTE) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; if (amdgpu_gfx_is_high_priority_compute_queue(adev=
, ring-&gt;queue)) {<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mq=
d-&gt;cp_hqd_pipe_priority =3D AMDGPU_GFX_PIPE_PRIO_HIGH;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ri=
ng-&gt;high_priority =3D true;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mq=
d-&gt;cp_hqd_queue_priority =3D<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; AMDGPU_GFX_QUEUE_PRIORITY_MAX=
IMUM;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mq=
d-&gt;cp_hqd_quantum =3D RREG32(mmCP_HQD_QUANTUM);<br>
&gt;<br>
&gt; Same comment here.<br>
&gt;<br>
&gt; Alex<br>
&gt;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; else<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ri=
ng-&gt;high_priority =3D false;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; &gt; &#43;}<br>
&gt; &gt; &#43;<br>
&gt; &gt;&nbsp; static int gfx_v9_0_mqd_init(struct amdgpu_ring *ring)<br>
&gt; &gt;&nbsp; {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; struct amdgpu_dev=
ice *adev =3D ring-&gt;adev;<br>
&gt; &gt; @@ -3446,6 &#43;3463,9 @@ static int gfx_v9_0_mqd_init(struct amd=
gpu_ring *ring)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tmp =3D REG_SET_F=
IELD(tmp, CP_HQD_IB_CONTROL, MIN_IB_AVAIL_SIZE, 3);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mqd-&gt;cp_hqd_ib=
_control =3D tmp;<br>
&gt; &gt;<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* set static priority =
for a queue/ring */<br>
&gt; &gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gfx_v9_0_mqd_set_priori=
ty(ring, mqd);<br>
&gt; &gt; &#43;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* map_queues pac=
ket doesn't need activate the queue,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; * so only k=
iq need set this field.<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; &gt; --<br>
&gt; &gt; 2.25.0<br>
&gt; &gt;<br>
&gt; &gt; _______________________________________________<br>
&gt; &gt; amd-gfx mailing list<br>
&gt; &gt; amd-gfx@lists.freedesktop.org<br>
&gt; &gt; <a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3D=
https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;=
data=3D02%7C01%7Cnirmoy.das%40amd.com%7C9cd63275980e426c420808d7bbcf1b33%7C=
3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637184370519368178&amp;amp;sdata=
=3DqvENGcFENLfXkn3HiA0yeGwo1N0dU2meZm51kD%2FdjsE%3D&amp;amp;reserved=3D0">
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cnirm=
oy.das%40amd.com%7C9cd63275980e426c420808d7bbcf1b33%7C3dd8961fe4884e608e11a=
82d994e183d%7C0%7C0%7C637184370519368178&amp;amp;sdata=3DqvENGcFENLfXkn3HiA=
0yeGwo1N0dU2meZm51kD%2FdjsE%3D&amp;amp;reserved=3D0</a><br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB23768ECB654CBBA02C6624DF8BEB0DM5PR12MB2376namp_--

--===============0279050626==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0279050626==--
