Return-Path: <SRS0=opbO=4I=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2926AC11D05
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 14:46:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDDD1207FD
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Feb 2020 14:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="nDD7S/oZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDDD1207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A03C6EDA8;
	Thu, 20 Feb 2020 14:46:32 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2088.outbound.protection.outlook.com [40.107.244.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CFA966EDA8
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Feb 2020 14:46:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAP7FTvDZw8K2uUxeB4cgCXZNzZRJdz8AasvnSCI/IZc9zMaZqti9PezbslimjLIKTkvNxs3F3YGjN0Qi/fxNO6EZ5ZZpJmapuszLZjY39s4kDk5o5aJDGngj12DXS98NUXyNaikJ6w4BbIsRgSIM7eHKDEKSQQ0UBhStmbxoUdaLzrazVO5nYBhiZ7tK9jzB1fqrAOE+mvwQDxw93kyDCeW74cZfuK2wp4pfCbnv9TPQhCy1Bwkwc3zNrF+B3W3esRl1atargO53wx3GXcQdnhpFIrtee0LlPQaYgFET+dRhb/2VOVHrdmYqKj0GnXH+DibsXlQPOi0ahDiVeaYmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gy4zhDBGL5CSd9UBcwbXLOFzmqUSO1E7GqLxOEMqKY0=;
 b=gRD2m2XVS0ZCHQcEgzogGUy1u/JjXmS7/kFen86oCQgxXL1h6DcpmlOwoEbZkP5ixDSFIUkXx2U2z6Nj4lSBBPgOZp5iOQCjE0Gr2P28deVyNBzfQzxqTPvfnwEgg7oxVqWu/T5k26maD+4tmtVvlxxMeNMZLvskVFyY9otqWapHZ5aIEozgOQfWSsQmMKBMUF/F0uGO6v4Jg0NPCQcGT260RYzYjzkvB9iuYWz5vulY/jZ7g/kA3GP4HVD2Ii2/A9vIEI8JVnPlaaWDzvZ8jNULNi+egEEfdkrb3ajdb3tUwVrSGdiZcXOm4w2JvmnVrRpm0WNAXE7NsMsh/0mbUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gy4zhDBGL5CSd9UBcwbXLOFzmqUSO1E7GqLxOEMqKY0=;
 b=nDD7S/oZa8ZDyS31p/HKwKpyB4MUFm+46cBi/0Z+azxr3wDGEbPi7E0O5MuP5bVVEQjtB2/h2Z0HE+T2O+iR93hqV/AIxKS9IURMo0djCfomZvEz52nZ9MEgRzhbeLXvY+76LLW5zGKD+zI2veGe4uHCiPwmH0KRyai5unHQ+2I=
Received: from MN2PR12MB3376.namprd12.prod.outlook.com (20.178.240.148) by
 MN2PR12MB4582.namprd12.prod.outlook.com (20.180.246.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.17; Thu, 20 Feb 2020 14:46:30 +0000
Received: from MN2PR12MB3376.namprd12.prod.outlook.com
 ([fe80::61bc:e52b:bdcf:4f9b]) by MN2PR12MB3376.namprd12.prod.outlook.com
 ([fe80::61bc:e52b:bdcf:4f9b%4]) with mapi id 15.20.2729.032; Thu, 20 Feb 2020
 14:46:30 +0000
From: "He, Jacob" <Jacob.He@amd.com>
To: "Zhou, David(ChunMing)" <David1.Zhou@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
Thread-Topic: [PATCH] drm/amdgpu: Add a chunk ID for spm trace
Thread-Index: AQHV5w2DvZzJMh9mOEKuDtk7HI5K26giWh+AgAD+jICAAIeEWoAARXox
Date: Thu, 20 Feb 2020 14:46:29 +0000
Message-ID: <MN2PR12MB3376E699E0A85E8065D3E72D9B130@MN2PR12MB3376.namprd12.prod.outlook.com>
References: <20200219101506.16779-1-jacob.he@amd.com>
 <e2fea4f5-0eea-75b5-9cd7-68b603629d8d@gmail.com>,
 <MWHPR12MB1406B3418562F0692572C511B4130@MWHPR12MB1406.namprd12.prod.outlook.com>,
 <MN2PR12MB337663C5CCF3D53744FD377D9B130@MN2PR12MB3376.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB337663C5CCF3D53744FD377D9B130@MN2PR12MB3376.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=True;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-20T02:13:46.0000000Z;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal
 Use Only -
 Unrestricted; MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jacob.He@amd.com; 
x-originating-ip: [180.167.199.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 37c9b162-4de1-4490-7f8e-08d7b613abe8
x-ms-traffictypediagnostic: MN2PR12MB4582:|MN2PR12MB4582:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB4582A805A2CBCBC9ABC403399B130@MN2PR12MB4582.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:200;
x-forefront-prvs: 031996B7EF
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(64756008)(66556008)(66446008)(66476007)(66574012)(186003)(33656002)(71200400001)(5660300002)(66946007)(316002)(52536014)(26005)(2906002)(110136005)(478600001)(966005)(2940100002)(76116006)(55016002)(81166006)(81156014)(7696005)(91956017)(86362001)(8936002)(6506007)(53546011)(8676002)(9686003)(45080400002);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB4582;
 H:MN2PR12MB3376.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DSKJoQh8MMAzMEn+d8wjmzn1qge8BWgLkhxHVhTowKuDL99O8rhxMTFuREobHwlGDgV6f5UA5thZWoLdmp98FkRqbU8E/fVR9rsZ6kO6BLXKBwAuJYMno97+bry2jWSdOyGccULD2n2H17WJ34mKJdm2lHcIZlt2Q+JbtO/Tqjdte46Za9gGf4f4VbFmD8UmmZIdzNABqM9PojxFJVgrysbb5ljp2rKND+JQks2fbXkVyHInriGAzmbUlCHCM0XkwcjGO2xSIeeB1eJq+hYjvEd4GGPHR9bcaHX2XGcYYQmOnVdGcng3YciEhZQnqdsXo4pNnFVFrdPnocXUYbGdJflo2esil4gLGzePhzUWC1LkIIAiPS4QnIoYDLo71B32/Z2B7thcIbpptg+y33H5xt5jgKlnxVV8MmMGtuYdysrlHin/P6vRku9KBRgIVZyTbPBFMMRcCaRPuSl5vi8gWTMvtxt8wjaVd0k4eQF2ySz+2kpkP2FAiRa/40qhzpeUSO3rwBDobPVRPWgbFrLQYA==
x-ms-exchange-antispam-messagedata: DEn/A10uzpfVwH/IkV6b0WJMaMBr8j8AM0P403scuVUzJZ+fzsgjD/Uc3Q6ArwLpuUQj5l9MkWFsaouLOhpyzCnWdCKdEIE/lQka8zMUG9Cl2kErMQ49UVlUHQLh3B6SWv1KAmyOgQV8P1DUsCmShw==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37c9b162-4de1-4490-7f8e-08d7b613abe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2020 14:46:29.9280 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: phE1ehD+w7QvN4lb7FtC5mkOW25zvDrzfSNB01JP6WHX64WjOosUOjQwam9t1G9k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4582
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
Content-Type: multipart/mixed; boundary="===============0240720532=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============0240720532==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB3376E699E0A85E8065D3E72D9B130MN2PR12MB3376namp_"

--_000_MN2PR12MB3376E699E0A85E8065D3E72D9B130MN2PR12MB3376namp_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

amdgpu_vm_reserve_vmid doesn=92t return the reserved vmid back to user spac=
e. There is no chance for user mode driver to update RLC_SPM_VMID.

Thanks
Jacob

From: He, Jacob<mailto:Jacob.He@amd.com>
Sent: Thursday, February 20, 2020 6:20 PM
To: Zhou, David(ChunMing)<mailto:David1.Zhou@amd.com>; Koenig, Christian<ma=
ilto:Christian.Koenig@amd.com>; amd-gfx@lists.freedesktop.org<mailto:amd-gf=
x@lists.freedesktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace

Looks like amdgpu_vm_reserve_vmid could work, let me have a try to update t=
he RLC_SPM_VMID with pm4 packets in UMD.

Thanks
Jacob

From: Zhou, David(ChunMing)<mailto:David1.Zhou@amd.com>
Sent: Thursday, February 20, 2020 10:13 AM
To: Koenig, Christian<mailto:Christian.Koenig@amd.com>; He, Jacob<mailto:Ja=
cob.He@amd.com>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedes=
ktop.org>
Subject: RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace

[AMD Official Use Only - Internal Distribution Only]

Christian is right here, that will cause many problems for simply using VMI=
D in kernel.
We already have an pair interface for RGP, I think you can use it instead o=
f involving additional kernel change.
amdgpu_vm_reserve_vmid/ amdgpu_vm_unreserve_vmid.

-David

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Christia=
n K=F6nig
Sent: Wednesday, February 19, 2020 7:03 PM
To: He, Jacob <Jacob.He@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace

Am 19.02.20 um 11:15 schrieb Jacob He:
> [WHY]
> When SPM trace enabled, SPM_VMID should be updated with the current
> vmid.
>
> [HOW]
> Add a chunk id, AMDGPU_CHUNK_ID_SPM_TRACE, so that UMD can tell us
> which job should update SPM_VMID.
> Right before a job is submitted to GPU, set the SPM_VMID accordingly.
>
> [Limitation]
> Running more than one SPM trace enabled processes simultaneously is
> not supported.

Well there are multiple problems with that patch.

First of all you need to better describe what SPM tracing is in the commit =
message.

Then the updating of mmRLC_SPM_MC_CNTL must be executed asynchronously on t=
he ring. Otherwise we might corrupt an already executing SPM trace.

And you also need to make sure to disable the tracing again or otherwise we=
 run into a bunch of trouble when the VMID is reused.

You also need to make sure that IBs using the SPM trace are serialized with=
 each other, e.g. hack into amdgpu_ids.c file and make sure that only one V=
MID at a time can have that attribute.

Regards,
Christian.

>
> Change-Id: Ic932ef6ac9dbf244f03aaee90550e8ff3a675666
> Signed-off-by: Jacob He <jacob.he@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c  |  7 +++++++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  | 10 +++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |  1 +
>   drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c  | 15 ++++++++++++++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c   |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c   |  3 ++-
>   drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c   | 15 ++++++++++++++-
>   8 files changed, 48 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index f9fa6e104fef..3f32c4db5232 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -113,6 +113,7 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_par=
ser *p, union drm_amdgpu_cs
>        uint32_t uf_offset =3D 0;
>        int i;
>        int ret;
> +     bool update_spm_vmid =3D false;
>
>        if (cs->in.num_chunks =3D=3D 0)
>                return 0;
> @@ -221,6 +222,10 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_pa=
rser *p, union drm_amdgpu_cs
>                case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
>                        break;
>
> +             case AMDGPU_CHUNK_ID_SPM_TRACE:
> +                     update_spm_vmid =3D true;
> +                     break;
> +
>                default:
>                        ret =3D -EINVAL;
>                        goto free_partial_kdata;
> @@ -231,6 +236,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_par=
ser *p, union drm_amdgpu_cs
>        if (ret)
>                goto free_all_kdata;
>
> +     p->job->need_update_spm_vmid =3D update_spm_vmid;
> +
>        if (p->ctx->vram_lost_counter !=3D p->job->vram_lost_counter) {
>                ret =3D -ECANCELED;
>                goto free_all_kdata;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index cae81914c821..36faab12b585 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -156,9 +156,13 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, uns=
igned num_ibs,
>                return -EINVAL;
>        }
>
> -     if (vm && !job->vmid) {
> -             dev_err(adev->dev, "VM IB without ID\n");
> -             return -EINVAL;
> +     if (vm) {
> +             if (!job->vmid) {
> +                     dev_err(adev->dev, "VM IB without ID\n");
> +                     return -EINVAL;
> +             } else if (adev->gfx.rlc.funcs->update_spm_vmid && job->nee=
d_update_spm_vmid) {
> +                     adev->gfx.rlc.funcs->update_spm_vmid(adev, job->vmi=
d);
> +             }
>        }
>
>        alloc_size =3D ring->funcs->emit_frame_size + num_ibs * diff --git
> a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 2e2110dddb76..4582536961c7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -52,6 +52,7 @@ struct amdgpu_job {
>        bool                    vm_needs_flush;
>        uint64_t                vm_pd_addr;
>        unsigned                vmid;
> +     bool                    need_update_spm_vmid;
>        unsigned                pasid;
>        uint32_t                gds_base, gds_size;
>        uint32_t                gws_base, gws_size;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> index d3d4707f2168..52509c254cbd 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h
> @@ -126,6 +126,7 @@ struct amdgpu_rlc_funcs {
>        void (*stop)(struct amdgpu_device *adev);
>        void (*reset)(struct amdgpu_device *adev);
>        void (*start)(struct amdgpu_device *adev);
> +     void (*update_spm_vmid)(struct amdgpu_device *adev, unsigned vmid);
>   };
>
>   struct amdgpu_rlc {
> diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> index 5e9fb0976c6c..91eb788d6229 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
> @@ -4214,6 +4214,18 @@ static int gfx_v10_0_update_gfx_clock_gating(struc=
t amdgpu_device *adev,
>        return 0;
>   }
>
> +static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev,
> +unsigned vmid) {
> +     u32 data;
> +
> +     data =3D RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
> +
> +     data &=3D ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
> +     data |=3D (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) <<
> +RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
> +
> +     WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data); }
> +
>   static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs =3D {
>        .is_rlc_enabled =3D gfx_v10_0_is_rlc_enabled,
>        .set_safe_mode =3D gfx_v10_0_set_safe_mode, @@ -4224,7 +4236,8 @@
> static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs =3D {
>        .resume =3D gfx_v10_0_rlc_resume,
>        .stop =3D gfx_v10_0_rlc_stop,
>        .reset =3D gfx_v10_0_rlc_reset,
> -     .start =3D gfx_v10_0_rlc_start
> +     .start =3D gfx_v10_0_rlc_start,
> +     .update_spm_vmid =3D gfx_v10_0_update_spm_vmid
>   };
>
>   static int gfx_v10_0_set_powergating_state(void *handle, diff --git
> a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> index 8f20a5dd44fe..b24fc55cf13a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
> @@ -4221,7 +4221,8 @@ static const struct amdgpu_rlc_funcs gfx_v7_0_rlc_f=
uncs =3D {
>        .resume =3D gfx_v7_0_rlc_resume,
>        .stop =3D gfx_v7_0_rlc_stop,
>        .reset =3D gfx_v7_0_rlc_reset,
> -     .start =3D gfx_v7_0_rlc_start
> +     .start =3D gfx_v7_0_rlc_start,
> +     .update_spm_vmid =3D NULL
>   };
>
>   static int gfx_v7_0_early_init(void *handle) diff --git
> a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> index fa245973de12..66640d2b6b37 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
> @@ -5600,7 +5600,8 @@ static const struct amdgpu_rlc_funcs iceland_rlc_fu=
ncs =3D {
>        .resume =3D gfx_v8_0_rlc_resume,
>        .stop =3D gfx_v8_0_rlc_stop,
>        .reset =3D gfx_v8_0_rlc_reset,
> -     .start =3D gfx_v8_0_rlc_start
> +     .start =3D gfx_v8_0_rlc_start,
> +     .update_spm_vmid =3D NULL
>   };
>
>   static void gfx_v8_0_update_medium_grain_clock_gating(struct
> amdgpu_device *adev, diff --git
> a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> index 9b7ff783e9a5..df872f949f68 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
> @@ -4704,6 +4704,18 @@ static int gfx_v9_0_update_gfx_clock_gating(struct=
 amdgpu_device *adev,
>        return 0;
>   }
>
> +static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev,
> +unsigned vmid) {
> +     u32 data;
> +
> +     data =3D RREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL);
> +
> +     data &=3D ~RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK;
> +     data |=3D (vmid & RLC_SPM_MC_CNTL__RLC_SPM_VMID_MASK) <<
> +RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;
> +
> +     WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, data); }
> +
>   static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs =3D {
>        .is_rlc_enabled =3D gfx_v9_0_is_rlc_enabled,
>        .set_safe_mode =3D gfx_v9_0_set_safe_mode, @@ -4715,7 +4727,8 @@
> static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs =3D {
>        .resume =3D gfx_v9_0_rlc_resume,
>        .stop =3D gfx_v9_0_rlc_stop,
>        .reset =3D gfx_v9_0_rlc_reset,
> -     .start =3D gfx_v9_0_rlc_start
> +     .start =3D gfx_v9_0_rlc_start,
> +     .update_spm_vmid =3D gfx_v9_0_update_spm_vmid
>   };
>
>   static int gfx_v9_0_set_powergating_state(void *handle,

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Cdavid1.z=
hou%40amd.com%7C354be34ff18e4f424f6708d7b52b43b0%7C3dd8961fe4884e608e11a82d=
994e183d%7C0%7C0%7C637177069753914395&amp;sdata=3D9rSL4kgPJweuZ4EJpdqtqTxyC=
VGEkmsg6aUzbtvGFrs%3D&amp;reserved=3D0<https://nam11.safelinks.protection.o=
utlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%=
2Famd-gfx&data=3D02%7C01%7Cjacob.he%40amd.com%7C0b340cec0e2d41dd4f8c08d7b5e=
e6f65%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637177908007702357&sdata=
=3DdRtYat6X178kHA8kJgsJOfiM9XhjDpmhM7dZTZy11lk%3D&reserved=3D0>



--_000_MN2PR12MB3376E699E0A85E8065D3E72D9B130MN2PR12MB3376namp_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns:m=3D"http://schemas.microsoft.com/of=
fice/2004/12/omml" xmlns=3D"http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:DengXian;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:"\@DengXian";
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Bookman Old Style";
	panose-1:2 5 6 4 5 5 5 2 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
.MsoChpDefault
	{mso-style-type:export-only;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.WordSection1
	{page:WordSection1;}
--></style>
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">amdgpu_vm_reserve_vmid doesn=92t return the reserved=
 vmid back to user space. There is no chance for user mode driver to update=
 RLC_SPM_VMID.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Boo=
kman Old Style&quot;,serif">Thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Boo=
kman Old Style&quot;,serif">Jacob<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"mso-element:para-border-div;border:none;border-top:solid #E1E=
1E1 1.0pt;padding:3.0pt 0in 0in 0in">
<p class=3D"MsoNormal" style=3D"border:none;padding:0in"><b>From: </b><a hr=
ef=3D"mailto:Jacob.He@amd.com">He, Jacob</a><br>
<b>Sent: </b>Thursday, February 20, 2020 6:20 PM<br>
<b>To: </b><a href=3D"mailto:David1.Zhou@amd.com">Zhou, David(ChunMing)</a>=
; <a href=3D"mailto:Christian.Koenig@amd.com">
Koenig, Christian</a>; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd=
-gfx@lists.freedesktop.org</a><br>
<b>Subject: </b>RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace</p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Looks like amdgpu_vm_reserve_vmid could work, let me=
 have a try to update the RLC_SPM_VMID with pm4 packets in UMD.<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Boo=
kman Old Style&quot;,serif">Thanks<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:9.0pt;font-family:&quot;Boo=
kman Old Style&quot;,serif">Jacob<o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From: </b><a href=3D"mailto:David1.Zhou@amd.com">=
Zhou, David(ChunMing)</a><br>
<b>Sent: </b>Thursday, February 20, 2020 10:13 AM<br>
<b>To: </b><a href=3D"mailto:Christian.Koenig@amd.com">Koenig, Christian</a=
>; <a href=3D"mailto:Jacob.He@amd.com">
He, Jacob</a>; <a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lis=
ts.freedesktop.org</a><br>
<b>Subject: </b>RE: [PATCH] drm/amdgpu: Add a chunk ID for spm trace<o:p></=
o:p></p>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">[AMD Official Use Only - Internal Distribution Only]=
<br>
<br>
Christian is right here, that will cause many problems for simply using VMI=
D in kernel.<br>
We already have an pair interface for RGP, I think you can use it instead o=
f involving additional kernel change.<br>
amdgpu_vm_reserve_vmid/ amdgpu_vm_unreserve_vmid.<br>
<br>
-David<br>
<br>
-----Original Message-----<br>
From: amd-gfx &lt;amd-gfx-bounces@lists.freedesktop.org&gt; On Behalf Of Ch=
ristian K=F6nig<br>
Sent: Wednesday, February 19, 2020 7:03 PM<br>
To: He, Jacob &lt;Jacob.He@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
Subject: Re: [PATCH] drm/amdgpu: Add a chunk ID for spm trace<br>
<br>
Am 19.02.20 um 11:15 schrieb Jacob He:<br>
&gt; [WHY]<br>
&gt; When SPM trace enabled, SPM_VMID should be updated with the current <b=
r>
&gt; vmid.<br>
&gt;<br>
&gt; [HOW]<br>
&gt; Add a chunk id, AMDGPU_CHUNK_ID_SPM_TRACE, so that UMD can tell us <br=
>
&gt; which job should update SPM_VMID.<br>
&gt; Right before a job is submitted to GPU, set the SPM_VMID accordingly.<=
br>
&gt;<br>
&gt; [Limitation]<br>
&gt; Running more than one SPM trace enabled processes simultaneously is <b=
r>
&gt; not supported.<br>
<br>
Well there are multiple problems with that patch.<br>
<br>
First of all you need to better describe what SPM tracing is in the commit =
message.<br>
<br>
Then the updating of mmRLC_SPM_MC_CNTL must be executed asynchronously on t=
he ring. Otherwise we might corrupt an already executing SPM trace.<br>
<br>
And you also need to make sure to disable the tracing again or otherwise we=
 run into a bunch of trouble when the VMID is reused.<br>
<br>
You also need to make sure that IBs using the SPM trace are serialized with=
 each other, e.g. hack into amdgpu_ids.c file and make sure that only one V=
MID at a time can have that attribute.<br>
<br>
Regards,<br>
Christian.<br>
<br>
&gt;<br>
&gt; Change-Id: Ic932ef6ac9dbf244f03aaee90550e8ff3a675666<br>
&gt; Signed-off-by: Jacob He &lt;jacob.he@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c&nbsp; |&nbsp; 7 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c&nbsp; | 10 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;---<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |&nbsp; 1 &#43;<br=
>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h |&nbsp; 1 &#43;<br=
>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c&nbsp; | 15 &#43;&#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c&nbsp;&nbsp; |&nbsp; =
3 &#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c&nbsp;&nbsp; |&nbsp; =
3 &#43;&#43;-<br>
&gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c&nbsp;&nbsp; | 15 &#4=
3;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&gt;&nbsp;&nbsp; 8 files changed, 48 insertions(&#43;), 7 deletions(-)<br>
&gt;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; index f9fa6e104fef..3f32c4db5232 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c<br>
&gt; @@ -113,6 &#43;113,7 @@ static int amdgpu_cs_parser_init(struct amdgpu=
_cs_parser *p, union drm_amdgpu_cs<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t uf_offset =3D 0;<br=
>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int i;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; int ret;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bool update_spm_vmid =3D false;<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (cs-&gt;in.num_chunks =3D=
=3D 0)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt; @@ -221,6 &#43;222,10 @@ static int amdgpu_cs_parser_init(struct amdgp=
u_cs_parser *p, union drm_amdgpu_cs<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<=
br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; case AMDGPU_CHUNK_ID_SPM_TRACE:<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; update_spm_vmid =3D=
 true;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; default:<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ret =3D=
 -EINVAL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; goto fr=
ee_partial_kdata;<br>
&gt; @@ -231,6 &#43;236,8 @@ static int amdgpu_cs_parser_init(struct amdgpu=
_cs_parser *p, union drm_amdgpu_cs<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (ret)<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto free_all_kdata;<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; p-&gt;job-&gt;need_update_spm_vmid =3D u=
pdate_spm_vmid;<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (p-&gt;ctx-&gt;vram_lost_=
counter !=3D p-&gt;job-&gt;vram_lost_counter) {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ret =3D -ECANCELED;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; goto free_all_kdata;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
&gt; index cae81914c821..36faab12b585 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c<br>
&gt; @@ -156,9 &#43;156,13 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ri=
ng, unsigned num_ibs,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (vm &amp;&amp; !job-&gt;vmid) {<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; dev_err(adev-&gt;dev, &quot;VM IB without ID\n&quot;);<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; if (vm) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; if (!job-&gt;vmid) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dev_err(adev-&gt;de=
v, &quot;VM IB without ID\n&quot;);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return -EINVAL;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; } else if (adev-&gt;gfx.rlc.funcs-&gt;update_spm_vmid &amp;&amp; jo=
b-&gt;need_update_spm_vmid) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; adev-&gt;gfx.rlc.fu=
ncs-&gt;update_spm_vmid(adev, job-&gt;vmid);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; }<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; alloc_size =3D ring-&gt;func=
s-&gt;emit_frame_size &#43; num_ibs * diff --git <br>
&gt; a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
&gt; index 2e2110dddb76..4582536961c7 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h<br>
&gt; @@ -52,6 &#43;52,7 @@ struct amdgpu_job {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; vm_needs_flush;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vm_p=
d_addr;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; vmid=
;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; bool&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp; need_update_spm_vmid;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; unsigned&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pasi=
d;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gds_=
base, gds_size;<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; gws_=
base, gws_size;<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h<br>
&gt; index d3d4707f2168..52509c254cbd 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_rlc.h<br>
&gt; @@ -126,6 &#43;126,7 @@ struct amdgpu_rlc_funcs {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*stop)(struct amdgpu_d=
evice *adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*reset)(struct amdgpu_=
device *adev);<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; void (*start)(struct amdgpu_=
device *adev);<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; void (*update_spm_vmid)(struct amdgpu_de=
vice *adev, unsigned vmid);<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; struct amdgpu_rlc {<br>
&gt; diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt; index 5e9fb0976c6c..91eb788d6229 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c<br>
&gt; @@ -4214,6 &#43;4214,18 @@ static int gfx_v10_0_update_gfx_clock_gatin=
g(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;static void gfx_v10_0_update_spm_vmid(struct amdgpu_device *adev,=
 <br>
&gt; &#43;unsigned vmid) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32 data;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data =3D RREG32_SOC15(GC, 0, mmRLC_SPM_M=
C_CNTL);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data &amp;=3D ~RLC_SPM_MC_CNTL__RLC_SPM_=
VMID_MASK;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data |=3D (vmid &amp; RLC_SPM_MC_CNTL__R=
LC_SPM_VMID_MASK) &lt;&lt; <br>
&gt; &#43;RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, d=
ata); }<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs =
=3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_rlc_enabled =3D gfx_v10_=
0_is_rlc_enabled,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_safe_mode =3D gfx_v10_0=
_set_safe_mode, @@ -4224,7 &#43;4236,8 @@ <br>
&gt; static const struct amdgpu_rlc_funcs gfx_v10_0_rlc_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume =3D gfx_v10_0_rlc_re=
sume,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop =3D gfx_v10_0_rlc_stop=
,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset =3D gfx_v10_0_rlc_res=
et,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v10_0_rlc_start<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v10_0_rlc_start,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .update_spm_vmid =3D gfx_v10_0_update_sp=
m_vmid<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int gfx_v10_0_set_powergating_state(void *handle, d=
iff --git <br>
&gt; a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
&gt; index 8f20a5dd44fe..b24fc55cf13a 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c<br>
&gt; @@ -4221,7 &#43;4221,8 @@ static const struct amdgpu_rlc_funcs gfx_v7_=
0_rlc_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume =3D gfx_v7_0_rlc_res=
ume,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop =3D gfx_v7_0_rlc_stop,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset =3D gfx_v7_0_rlc_rese=
t,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v7_0_rlc_start<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v7_0_rlc_start,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .update_spm_vmid =3D NULL<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int gfx_v7_0_early_init(void *handle) diff --git <b=
r>
&gt; a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; index fa245973de12..66640d2b6b37 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c<br>
&gt; @@ -5600,7 &#43;5600,8 @@ static const struct amdgpu_rlc_funcs iceland=
_rlc_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume =3D gfx_v8_0_rlc_res=
ume,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop =3D gfx_v8_0_rlc_stop,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset =3D gfx_v8_0_rlc_rese=
t,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v8_0_rlc_start<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v8_0_rlc_start,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .update_spm_vmid =3D NULL<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static void gfx_v8_0_update_medium_grain_clock_gating(stru=
ct <br>
&gt; amdgpu_device *adev, diff --git <br>
&gt; a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c <br>
&gt; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; index 9b7ff783e9a5..df872f949f68 100644<br>
&gt; --- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c<br>
&gt; @@ -4704,6 &#43;4704,18 @@ static int gfx_v9_0_update_gfx_clock_gating=
(struct amdgpu_device *adev,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>
&gt;&nbsp;&nbsp; }<br>
&gt;&nbsp;&nbsp; <br>
&gt; &#43;static void gfx_v9_0_update_spm_vmid(struct amdgpu_device *adev, =
<br>
&gt; &#43;unsigned vmid) {<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; u32 data;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data =3D RREG32_SOC15(GC, 0, mmRLC_SPM_M=
C_CNTL);<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data &amp;=3D ~RLC_SPM_MC_CNTL__RLC_SPM_=
VMID_MASK;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; data |=3D (vmid &amp; RLC_SPM_MC_CNTL__R=
LC_SPM_VMID_MASK) &lt;&lt; <br>
&gt; &#43;RLC_SPM_MC_CNTL__RLC_SPM_VMID__SHIFT;<br>
&gt; &#43;<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; WREG32_SOC15(GC, 0, mmRLC_SPM_MC_CNTL, d=
ata); }<br>
&gt; &#43;<br>
&gt;&nbsp;&nbsp; static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs =
=3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .is_rlc_enabled =3D gfx_v9_0=
_is_rlc_enabled,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .set_safe_mode =3D gfx_v9_0_=
set_safe_mode, @@ -4715,7 &#43;4727,8 @@ <br>
&gt; static const struct amdgpu_rlc_funcs gfx_v9_0_rlc_funcs =3D {<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .resume =3D gfx_v9_0_rlc_res=
ume,<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .stop =3D gfx_v9_0_rlc_stop,=
<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; .reset =3D gfx_v9_0_rlc_rese=
t,<br>
&gt; -&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v9_0_rlc_start<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .start =3D gfx_v9_0_rlc_start,<br>
&gt; &#43;&nbsp;&nbsp;&nbsp;&nbsp; .update_spm_vmid =3D gfx_v9_0_update_spm=
_vmid<br>
&gt;&nbsp;&nbsp; };<br>
&gt;&nbsp;&nbsp; <br>
&gt;&nbsp;&nbsp; static int gfx_v9_0_set_powergating_state(void *handle,<br=
>
<br>
_______________________________________________<br>
amd-gfx mailing list<br>
amd-gfx@lists.freedesktop.org<br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01=
%7Cjacob.he%40amd.com%7C0b340cec0e2d41dd4f8c08d7b5ee6f65%7C3dd8961fe4884e60=
8e11a82d994e183d%7C0%7C0%7C637177908007702357&amp;sdata=3DdRtYat6X178kHA8kJ=
gsJOfiM9XhjDpmhM7dZTZy11lk%3D&amp;reserved=3D0">https://nam11.safelinks.pro=
tection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedesktop.org%2Fmailman%2F=
listinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Cdavid1.zhou%40amd.com%7C354be34=
ff18e4f424f6708d7b52b43b0%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C6371=
77069753914395&amp;amp;sdata=3D9rSL4kgPJweuZ4EJpdqtqTxyCVGEkmsg6aUzbtvGFrs%=
3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_MN2PR12MB3376E699E0A85E8065D3E72D9B130MN2PR12MB3376namp_--

--===============0240720532==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============0240720532==--
