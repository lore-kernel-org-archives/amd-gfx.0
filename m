Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B5CC43334
	for <amd-gfx@archiver.kernel.org>; Tue,  7 Jun 2022 20:20:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2BC810E329;
	Tue,  7 Jun 2022 20:20:46 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2056.outbound.protection.outlook.com [40.107.96.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D854310E329
 for <amd-gfx@lists.freedesktop.org>; Tue,  7 Jun 2022 20:20:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BANUDjR+J+9+nyLWtsWO6Cmu0OdvXa4ZGuBivSW2rMH8y4OD/rOyW280+gG2LgGwV48n0Q6+wnkLTFTiYO2t9mf3QMpbmcABB3SLQZ0O3LhfxQPwp3CS9sKzchnBDuMN6ayAJ0WQ9rdJfFpgGpV3LwJus9IUemKNQUMBMzL/HrRW/5L8xP8/ZKigs6jgCk8eGmk1qTBz1mqMdxZsiUp5ueb4BB1eZcVlPokYnr4g0G7UYigS+jPE2ZaLReXYJu05ToY+hiVG+uMjxPHWTrBre/P8guIv8EN5Zw2ouaOVx29ruGuHrruocDWZr4pDcHCKS++0PoPqYfBLCR+HBNSgBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6iSZm+9SrlmpQwph6piSh2p4alU+bMZa8xpSYhrymM=;
 b=UcJo9gkoLPD3+jIgND4yvoatHpkBdFuMuQhYtBg4nJjZAfSpW6bVV1CaWY2RwJSlixsC/ngEri2Gc7LGqOLrhLIMOjE4TfOiUTHXl+nMa9JlG+jhZ0UYaHS6DFqbrSvzqHiywQO2L7LxNASksIWArZKU05gISYfEMVKXNiP1jaSYS5IuyfYCIez5niRBd+Gnk1SCl+2rJIYY63zzfie7cNIwQDEDLvqty476N+jYMJqsL7M2IsFR2Orzt68hzPpVvJo3lrw/ZrZllhcl0cvk8aEaRXMfqSat62fabFgIopgCzqdaO3aY9dWGQIruGr6aB9oHPiSQ1VZRoGWKqbelDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6iSZm+9SrlmpQwph6piSh2p4alU+bMZa8xpSYhrymM=;
 b=pZHvTgfNVicpLmFKXG7t5CqtT/T/cuZ81JrHldrwlH1LYUJkkeyl7/nbT8jEilFGngriYYJmmvci1xq49Uy5dfxF7tbIs6dxwEuJkJ/Bz3rq5ur+dWf7bSIQBO+vpvfJ1FKOgY01VY34faBqiobF31Avi1dWRypQYKgmtKSPk9U=
Received: from CH2PR12MB3927.namprd12.prod.outlook.com (2603:10b6:610:2d::13)
 by DM6PR12MB5566.namprd12.prod.outlook.com (2603:10b6:5:20d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Tue, 7 Jun
 2022 20:20:42 +0000
Received: from CH2PR12MB3927.namprd12.prod.outlook.com
 ([fe80::bc7f:3b0b:7c5e:687b]) by CH2PR12MB3927.namprd12.prod.outlook.com
 ([fe80::bc7f:3b0b:7c5e:687b%6]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 20:20:42 +0000
From: "Dong, Ruijing" <Ruijing.Dong@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, =?iso-8859-1?Q?Christian_K=F6nig?=
 <ckoenig.leichtzumerken@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: fix limiting AV1 to the first instance on VCN3
Thread-Topic: [PATCH] drm/amdgpu: fix limiting AV1 to the first instance on
 VCN3
Thread-Index: AQHYdzOnkR4wq2bb/0Wm98Z7o6lbNK09lrsAgAAAuACAACDygIAAAOgAgAav8KA=
Date: Tue, 7 Jun 2022 20:20:42 +0000
Message-ID: <CH2PR12MB3927CE81E4A14A41359DC1FB95A59@CH2PR12MB3927.namprd12.prod.outlook.com>
References: <20220603102106.149508-1-christian.koenig@amd.com>
 <cd4958ab-897e-d8b0-76bb-0f6045a542d3@amd.com>
 <5f7710f2-7d66-e48f-dab8-c99177743c92@gmail.com>
 <CADnq5_NS49jdkQuXK58CdfShNW9j1q4HwXtBZtqJ2m3MACD8uA@mail.gmail.com>
 <CADnq5_OEsnjhmp_g0zXjNjAfv=0uN2jq79wTMtxnae_OYjUEjw@mail.gmail.com>
In-Reply-To: <CADnq5_OEsnjhmp_g0zXjNjAfv=0uN2jq79wTMtxnae_OYjUEjw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=3ab375e0-fe22-4bb2-83bd-021c0ceaa43f;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2022-06-07T20:18:59Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d834f42-0cce-441c-2bb5-08da48c3321c
x-ms-traffictypediagnostic: DM6PR12MB5566:EE_
x-microsoft-antispam-prvs: <DM6PR12MB5566C72A01ED40B3ADB2C04795A59@DM6PR12MB5566.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: taltIcTgF7is5zAUSsSia0xiinCiGrPr88TG1xE14br534/Zc+QITBvGPRrI0JyzXizd39d28rYP0a21JxakG8Rvag2FYVMYUwrBtnzfqRbCiKC3ZHjPqLFe5mNhuG0M2oEIVpTP/T+ThQGa2ZyVllrTXLs/ABHmCIoxyAi4KGibDyDau+62Oa4Mx3LS4UWiC4MT+6qaBIcB7WnggGiQvN0H+sYO8IlK1VRyKg+oSzbnps21prA79YI8QJ+4GhfLyTZjhH75FIFPVjS1vXsDNrmZQ8uEg61W2pQATwDy3e3KZDoZKl45o/vUjLxfAAPR1BTeZrPkQmM4I50sd/Qikos+mH009K22xLY+J3R3BCEqRZTrWzFMl7MWtnXGqYYOmIQ/+SkLtzjNtC+EtnXwgJ9z28D/wfJwcMfn1vkUfHSX5bgiR3ROcautdrgxjWPQUQZM5419BCzvdu8f81fXVFi+pOzmDSqNT+cthGzSffTLFA7x/QcaoXGI1E4ENZ6hu/aF8z9nF2cl9XhdwSMkX4jE/zu2Sr7CXcRzyAocGlSC+13kcT+zTCjHnYhPnk648gdDiEwUwBAb0UdpRkWQCL0svPNjUteQYdPI3DjaO83Ij6uXg5iLC9QhzvIto9KcCwIlqGVnJ06mWXtxHfA474Nwwzb61pr4oboTNwcbtwhNeRZ5yzFQOWnoJLDh+RpcyLTuIlu8SJXJeRPhlz/QAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3927.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(4326008)(8936002)(8676002)(2906002)(45080400002)(122000001)(5660300002)(38070700005)(66556008)(66476007)(76116006)(66446008)(66946007)(64756008)(316002)(83380400001)(55016003)(33656002)(86362001)(52536014)(38100700002)(966005)(508600001)(66574015)(54906003)(53546011)(110136005)(71200400001)(6506007)(26005)(7696005)(9686003)(186003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?d0M+x/kY0kV/+xNPOKa2ayoLGOU95NbvMrTAJpBA5Bld3BsEp1ggIkavv6?=
 =?iso-8859-1?Q?DQRgThylycdh08bBoa4l3/hX0ZtbBJStPH61UU6gkKfMK84tu85i2zEgWd?=
 =?iso-8859-1?Q?hwPkDBrtZABAUjFJ0/ny/lidbE3isCB6sw0LtCGzyEJm0mZlDBa/eiujZz?=
 =?iso-8859-1?Q?VlYv+Kg/4aS/MH8bi+4iT/4aPvj0MF682TdNhleAFoYv5+8gozZYZK4mpP?=
 =?iso-8859-1?Q?fushUfThQiZX5gEL7xilORrZlVQsEkzjlZjTGYMg4Cqgk6E52zUl7FD6Mr?=
 =?iso-8859-1?Q?ZU0l4/XZvWVwWBn3Lpz6mp5GwFYeS2Xgh7d3ozqfoeahP7PF8TAk4BApGB?=
 =?iso-8859-1?Q?1H2fJWKNRCVDDSMQTknak3d42ZUMaFk+nHcsxB9tuP6vjJ6bDYYG7VotoG?=
 =?iso-8859-1?Q?5bxem8M4NdRmO1M8d13JlmgyglHtF1YyGQf2SOFUPU+c4dyBpwOr2g91M9?=
 =?iso-8859-1?Q?1ubQ1ZL4jjNVJ4P9DMeFSljdCCz/SArrIXDMgmfMsuNLSdeG2bdFL4be/c?=
 =?iso-8859-1?Q?Ww3ZL9hDtdiWgriMDrxpVeH0FfdEfi1oW6c49Zbkl3ur7PkXlqFcre30T4?=
 =?iso-8859-1?Q?rt6dhdpy19oTbokiFBGBWvUBM9vkcfxWUoh9gkMBokJSeVA4notIfAP0rt?=
 =?iso-8859-1?Q?D6VhEO81RZhGn0/OZzKv/jYlMbdgmWNxr3WzlVDhmEGQmIYzTJaKDxxsRy?=
 =?iso-8859-1?Q?w5U1HiBIw1nD5ZrCY4hPj47pwxkcfccC6sbSibqdY7hhGLrxyZIoHomj/w?=
 =?iso-8859-1?Q?D7JElbX1tstdT7TmdKAfyf/yWv5Bz4WqMHfEHkknt5i42MdbjVM6XTQuqV?=
 =?iso-8859-1?Q?fCLI3x9hs/d3aHObFXzZlKg/wuOLpJSkOWSmGzdFK9h+Bk4bhmVz7fka+r?=
 =?iso-8859-1?Q?cysXq8RYZ13EDu8JOiEE3rKbei8/9eRv+g1tOHtKBGoLttD311LJI+ux9r?=
 =?iso-8859-1?Q?KeJJfV5udHHj/FMquKpuSRPB9aDUi4EeJtrTW5AuIArF2TPCM+abNwWsFT?=
 =?iso-8859-1?Q?uiumROif3jqgmT0Mj6RxIRGXV+qp4aAA/HWWrBKaMNmZEGnv0aGp8XiLYM?=
 =?iso-8859-1?Q?CpJbCOIwkskDdLejIOx6x08tsLDpzPnq25//3RDBWCBDPDO6IuGFbiJF0L?=
 =?iso-8859-1?Q?Fb9OpYEOtJG8AQ8dEZud/Xv8xOvs9lQ6CUfRmAW3GjJLzrRcd4Munfs667?=
 =?iso-8859-1?Q?Kt2clVkOJqiuBk9VHpEP4Zn6c04fBsBGGhrvjvfSKFDqyOKvFXeUQaXsMn?=
 =?iso-8859-1?Q?qH+ZFxBOuOe/eoR5B26+M19USVuUt4KSU9PHje4wNMga8o27kMhGwB1pYH?=
 =?iso-8859-1?Q?wlT3wqFGVOaY56ZMDS1V2cTm3Ae5daLdw8zI8xFDwh+Au/AqxlGLg2gBMv?=
 =?iso-8859-1?Q?7PNR4dFPvK0/JmMP2iCxD/fUKwjeukKjrQ+HXx2mzuQ+HoNAAPA1J/iGXB?=
 =?iso-8859-1?Q?Jgc6PkQ/81GpnLUeZgTQbv9HpjK6JW5EdEkKXhZA8HT5BV0V4cUPTwOAD9?=
 =?iso-8859-1?Q?j9aykDlhJVw4m+n4oODQtMmiWwYXcrNIM7Di4v9h8+lk60D+uzc9U4KLy9?=
 =?iso-8859-1?Q?DgYvQAIaMUkb2UzaH7L8ycU5kR0PWA2jCD2ffeiW6796FH4b0h2tAxR6si?=
 =?iso-8859-1?Q?IWwT15POj+C5T7hcuDHnkqr2RQqFrbtWjdmjpHDmzMHtsBf7RVr8G+J/56?=
 =?iso-8859-1?Q?MJFxEbLq83r1A2p99w10gkYF++YOsinybySOT9QYPbjh5jFTRR9izxJNa0?=
 =?iso-8859-1?Q?17AiaxWS+JoxSWRTd2y6UeMnVo75R/LjTUKda0Msnu4azO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3927.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d834f42-0cce-441c-2bb5-08da48c3321c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2022 20:20:42.2563 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q8l5WHVw51ZcKGaymSTrQle6cyhzl5BTkaI/2IN3Wa5OULRAJZc+y79ovVBJVteN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB5566
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
Cc: "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - General]

I can see for VCN4, AV1 dec/enc also need to limit to the first instance.

Thanks,
Ruijing

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deu=
cher
Sent: Friday, June 3, 2022 10:12 AM
To: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com>
Cc: Pelloux-Prayer, Pierre-Eric <Pierre-eric.Pelloux-prayer@amd.com>; amd-g=
fx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH] drm/amdgpu: fix limiting AV1 to the first instance on =
VCN3

Do the other uvd/vce/vcn ring parse functions need a similar fix?

Alex


On Fri, Jun 3, 2022 at 10:08 AM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Fri, Jun 3, 2022 at 8:10 AM Christian K=F6nig
> <ckoenig.leichtzumerken@gmail.com> wrote:
> >
> > Am 03.06.22 um 14:08 schrieb Pierre-Eric Pelloux-Prayer:
> > > Hi Christian,
> > >
> > > The patch is: Tested-by: Pierre-Eric Pelloux-Prayer
> > > <pierre-eric.pelloux-prayer@amd.com>
> > >
> > > Could you add a reference to https://nam11.safelinks.protection.outlo=
ok.com/?url=3Dhttps%3A%2F%2Fgitlab.freedesktop.org%2Fdrm%2Famd%2F-%2Fissues=
%2F2037&amp;data=3D05%7C01%7CRuijing.Dong%40amd.com%7C5ba73dfe91ba47e21dd60=
8da456b0609%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637898623221806051=
%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haW=
wiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DWgIZD299Xe0XVG%2Ftb2rn14njS%2F=
gHIhtIHIDAZ2Fj40k%3D&amp;reserved=3D0 in the commit message?
> >
> > Sure, can you also give me an rb or acked-by so that I can push it?
>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
>
> >
> > Thanks,
> > Christian.
> >
> > >
> > > Thanks,
> > > Pierre-Eric
> > >
> > > On 03/06/2022 12:21, Christian K=F6nig wrote:
> > >> The job is not yet initialized here.
> > >>
> > >> Signed-off-by: Christian K=F6nig <christian.koenig@amd.com>
> > >> Fixes: 1027d5d791b7 ("drm/amdgpu: use job and ib structures
> > >> directly in CS parsers")
> > >> ---
> > >>   drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c | 17 +++++++----------
> > >>   1 file changed, 7 insertions(+), 10 deletions(-)
> > >>
> > >> diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > >> b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > >> index 3cabceee5f57..39405f0db824 100644
> > >> --- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > >> +++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
> > >> @@ -1761,23 +1761,21 @@ static const struct amdgpu_ring_funcs vcn_v3=
_0_dec_sw_ring_vm_funcs =3D {
> > >>      .emit_reg_write_reg_wait =3D amdgpu_ring_emit_reg_write_reg_wai=
t_helper,
> > >>   };
> > >>
> > >> -static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p,
> > >> -                            struct amdgpu_job *job)
> > >> +static int vcn_v3_0_limit_sched(struct amdgpu_cs_parser *p)
> > >>   {
> > >>      struct drm_gpu_scheduler **scheds;
> > >>
> > >>      /* The create msg must be in the first IB submitted */
> > >> -    if (atomic_read(&job->base.entity->fence_seq))
> > >> +    if (atomic_read(&p->entity->fence_seq))
> > >>              return -EINVAL;
> > >>
> > >>      scheds =3D p->adev->gpu_sched[AMDGPU_HW_IP_VCN_DEC]
> > >>              [AMDGPU_RING_PRIO_DEFAULT].sched;
> > >> -    drm_sched_entity_modify_sched(job->base.entity, scheds, 1);
> > >> +    drm_sched_entity_modify_sched(p->entity, scheds, 1);
> > >>      return 0;
> > >>   }
> > >>
> > >> -static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdg=
pu_job *job,
> > >> -                        uint64_t addr)
> > >> +static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, uint64_t
> > >> +addr)
> > >>   {
> > >>      struct ttm_operation_ctx ctx =3D { false, false };
> > >>      struct amdgpu_bo_va_mapping *map; @@ -1848,7 +1846,7 @@
> > >> static int vcn_v3_0_dec_msg(struct amdgpu_cs_parser *p, struct amdgp=
u_job *job,
> > >>              if (create[0] =3D=3D 0x7 || create[0] =3D=3D 0x10 || cr=
eate[0] =3D=3D 0x11)
> > >>                      continue;
> > >>
> > >> -            r =3D vcn_v3_0_limit_sched(p, job);
> > >> +            r =3D vcn_v3_0_limit_sched(p);
> > >>              if (r)
> > >>                      goto out;
> > >>      }
> > >> @@ -1862,7 +1860,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(str=
uct amdgpu_cs_parser *p,
> > >>                                         struct amdgpu_job *job,
> > >>                                         struct amdgpu_ib *ib)
> > >>   {
> > >> -    struct amdgpu_ring *ring =3D to_amdgpu_ring(job->base.sched);
> > >> +    struct amdgpu_ring *ring =3D
> > >> + to_amdgpu_ring(p->entity->rq->sched);
> > >>      uint32_t msg_lo =3D 0, msg_hi =3D 0;
> > >>      unsigned i;
> > >>      int r;
> > >> @@ -1881,8 +1879,7 @@ static int vcn_v3_0_ring_patch_cs_in_place(str=
uct amdgpu_cs_parser *p,
> > >>                      msg_hi =3D val;
> > >>              } else if (reg =3D=3D PACKET0(p->adev->vcn.internal.cmd=
, 0) &&
> > >>                         val =3D=3D 0) {
> > >> -                    r =3D vcn_v3_0_dec_msg(p, job,
> > >> -                                         ((u64)msg_hi) << 32 | msg_=
lo);
> > >> +                    r =3D vcn_v3_0_dec_msg(p, ((u64)msg_hi) << 32
> > >> + | msg_lo);
> > >>                      if (r)
> > >>                              return r;
> > >>              }
> > >>
> >
