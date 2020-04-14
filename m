Return-Path: <SRS0=Gn/P=56=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MIME_HTML_MOSTLY,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55D1C2BB1D
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 20:30:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76A472076A
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Apr 2020 20:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="XQBeLEmI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A472076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD9D26E12B;
	Tue, 14 Apr 2020 20:30:09 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89EA96E12B
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Apr 2020 20:30:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X5510kyl9/eMz+C2idUJvoP5gNyppn0/2qNKMcvCvfe4vRQUprBDkH3dnuanLMb2qkM8DSZPd7IEOhqWTgrN552SPQ+dA/1DMDyGRvUY3eZO+PYEI03hm0a6jWR25aWqJIaNhk77WGb5jUc7SkTTZq+wP9BlTuKQPiqZvLO+15ur817JxIuPUThMgUJJmKYlweTshpzxeehHB7eviOSG9o11AuqFWFXpe9Q6YVUTluyczytuQuwR5yKIBPGwbp4Pl7Z98Xu9J9c17VpBZJk5G/xiIcWlbgyt1DIEUC8HGjR+ynzbP9EfXLYlK463gc+DluW190+CIk81JLkOie/WeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCIjVyimBfLG83qM68kadZ4zDoqPLOXkOrG5/5658t8=;
 b=hCEI7kmUvDPFzvHTbc19aEM28gb6+RzaD6XEjbSWZ7OHtm/so5F/1GiAsjGNpStEAPv8SEMvqbqGqXW8OxT0ybtaahW/8wzFEZv1rRwWYVkqdNiVf+MXeRdWIH5ed5LAoTIt6htgIYNvtdRzMlgr+qjlJz2llcMS+gLvQyvadHZlWenBHR4ply1yDiELU9OIP5vt8S80QGNsL3hUnEkWUCA6lG3c3uV86boAzPMf3Ntft7u3QbSa1Y5rY9OpOU2JCjg0d+AlyHKaAhv0AqOWgFwNbOu807C0fGy5hMOoMlUHOitXAiJoEN7TUJb9Z/WqVGF9TqgIRAFxNYTPToJc6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCIjVyimBfLG83qM68kadZ4zDoqPLOXkOrG5/5658t8=;
 b=XQBeLEmIrZkZFenJ8odL/4jOWKLRLciAKySrGAl/s5vGdKQaKoVUx2zgKAW3O90NHuO6U1ekeDk/0HSuJQ+RrMIPfBbtW28C/MBCtfVHT4L0fnUT3LEU9CLiWxdhN82/bTyz/f7872SkEK3FD3B5JTpT++xk58P+7I02zsauc4w=
Received: from MN2PR12MB4518.namprd12.prod.outlook.com (2603:10b6:208:266::19)
 by MN2PR12MB3981.namprd12.prod.outlook.com (2603:10b6:208:165::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.15; Tue, 14 Apr
 2020 20:30:04 +0000
Received: from MN2PR12MB4518.namprd12.prod.outlook.com
 ([fe80::4cd:783:ca8:7af0]) by MN2PR12MB4518.namprd12.prod.outlook.com
 ([fe80::4cd:783:ca8:7af0%5]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 20:30:04 +0000
From: "Kim, Jonathan" <Jonathan.Kim@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Koenig, Christian"
 <Christian.Koenig@amd.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>
Subject: RE: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
 amdgpu_device_vram_access v2"
Thread-Topic: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
 amdgpu_device_vram_access v2"
Thread-Index: AQHWEcA9UrBaY2ldnUWtIBCEF2kBZ6h4pBqAgAAHvgCAAASbgIAAAxkAgAAAdnCAAD5rgIAAHPDw
Date: Tue, 14 Apr 2020 20:30:03 +0000
Message-ID: <MN2PR12MB4518A3D9746674DA688AD34885DA0@MN2PR12MB4518.namprd12.prod.outlook.com>
References: <20200413182026.2561-1-kent.russell@amd.com>
 <85fcb568-b0d8-b6c9-4e62-3866aa2da0c9@gmail.com>
 <DM6PR12MB3721FDB775B65C22B91D564585DA0@DM6PR12MB3721.namprd12.prod.outlook.com>
 <MN2PR12MB4488C1D9BF9C0A693860B1C1F7DA0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <146d9570-724e-423d-931e-24c96821aaae@email.android.com>
 <MN2PR12MB451836BC6F9C0F002EE1C3D685DA0@MN2PR12MB4518.namprd12.prod.outlook.com>
 <e69b430e-f4e3-c4a0-82f0-dae527cccf3d@amd.com>
In-Reply-To: <e69b430e-f4e3-c4a0-82f0-dae527cccf3d@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-04-14T20:29:57Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=c796f348-e7ff-427d-9f4e-0000a5b59491;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-04-14T20:29:57Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: f8fe23dd-2cb0-4de0-8a9d-0000c33f1d48
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Jonathan.Kim@amd.com; 
x-originating-ip: [165.204.55.211]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: a2666600-a53e-4398-9acf-08d7e0b29d7c
x-ms-traffictypediagnostic: MN2PR12MB3981:|MN2PR12MB3981:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB398190A2BBA1AE29005FD29885DA0@MN2PR12MB3981.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB4518.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(396003)(136003)(376002)(346002)(39850400004)(45080400002)(6506007)(53546011)(5660300002)(478600001)(26005)(4326008)(8936002)(316002)(186003)(33656002)(110136005)(71200400001)(54906003)(30864003)(2906002)(66574012)(86362001)(76116006)(7696005)(966005)(55016002)(66946007)(52536014)(6636002)(66476007)(81156014)(66556008)(66446008)(64756008)(8676002)(9686003)(559001)(579004);
 DIR:OUT; SFP:1101; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eZan5rGEbf4Jsi/p+znyofhFNHaD+HKtZI5XiNvHtJXVTT5zrLjoBYsBNvKtYV+nea+E5R7G54NoXOXEAwO4LOwPkOGkzAzq8fuGORWMvUXSd9jzRBc/98B3KDFVrZ16PDyGnCtbDYrupk+0s/BMnc26n84adNbIGgYKG4v1Dp3DqA11uvBHtXaVbhZHlDsQehfU+PXqXNmc6JxR6lK7aFSLYUkcy+5ETpQcGX8BJhE4HxA+vr94/VltpGcABeWiGFbKo1Q9FF+7t0XhbZV4Httzko4RMkf2OFASbtHEfImzIJUhwHTAVEF6xOap9kluvLBZLyIDX5fdwOncx0/JG0XIwTMj3xHMCEyvWoHWBFSJdjqTjS38+/1Emk14OsdSGT6+eY5CnbV+cR7UCYwsGjkAvkKn/Tv5fJLMBZygtw2Y7buhKsBjz4isvbFsbVV5EZPVpzTYgXos/rjzjGlAm3gOqnuDz5e+IYgDxSu1DM8=
x-ms-exchange-antispam-messagedata: nF6PqgQeePJV6uT6juirsAktbmFcZh/Z6XaL2utQ1BhkpJQH+qVk5U/JVpt1RjdeXwPDvjuhyBlZjqAMM+jNm0DodG2atzzWD7rC7HA8egYctGGzhO4OnSGetfJANABi/7nyGGPh0lAD7IivNOw3bA==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2666600-a53e-4398-9acf-08d7e0b29d7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 20:30:04.6566 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: v8NhrkZBPXzxVDvcMFrKkpcedQw0iGwBEgKgucfO4YKCew5MlynY7UYrSR0rLLQ0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3981
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
Cc: "Russell, Kent" <Kent.Russell@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Type: multipart/mixed; boundary="===============1058299703=="
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--===============1058299703==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_MN2PR12MB4518A3D9746674DA688AD34885DA0MN2PR12MB4518namp_"

--_000_MN2PR12MB4518A3D9746674DA688AD34885DA0MN2PR12MB4518namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - Internal Distribution Only]

If we're passing the test on the revert, then the only thing that's differe=
nt is we're not invalidating HDP and doing a copy to host anymore in amdgpu=
_device_vram_access since the function is still called in ttm access_memory=
 with BAR.

Also cwsr tests fail on Vega20 with or without the revert with the same RAS=
 error.

Thanks,

Jon

From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Tuesday, April 14, 2020 2:32 PM
To: Kim, Jonathan <Jonathan.Kim@amd.com>; Koenig, Christian <Christian.Koen=
ig@amd.com>; Deucher, Alexander <Alexander.Deucher@amd.com>
Cc: Russell, Kent <Kent.Russell@amd.com>; amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in amdgpu_=
device_vram_access v2"


I wouldn't call it premature. Revert is a usual practice when there is a se=
rious regression that isn't fully understood or root-caused. As far as I ca=
n tell, the problem has been reproduced on multiple systems, different GPUs=
, and clearly regressed to Christian's commit. I think that justifies rever=
ting it for now.

I agree with Christian that a general HDP memory access problem causing RAS=
 errors would potentially cause problems in other tests as well. For exampl=
e common operations like GART table updates, and GPUVM page table updates a=
nd PCIe peer2peer accesses in ROCm applications use HDP. But we're not seei=
ng obvious problems from those. So we need to understand what's special abo=
ut this test. I asked questions to that effect on our other email thread.

Regards,
  Felix
Am 2020-04-14 um 10:51 a.m. schrieb Kim, Jonathan:

[AMD Official Use Only - Internal Distribution Only]

I think it's premature to push this revert.

With more testing, I'm getting failures from different tests or sometimes n=
one at all on my machine.

Kent, let's continue the discussion on the original thread.

Thanks,

Jon

From: Koenig, Christian <Christian.Koenig@amd.com><mailto:Christian.Koenig@=
amd.com>
Sent: Tuesday, April 14, 2020 10:47 AM
To: Deucher, Alexander <Alexander.Deucher@amd.com><mailto:Alexander.Deucher=
@amd.com>
Cc: Russell, Kent <Kent.Russell@amd.com><mailto:Kent.Russell@amd.com>; amd-=
gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>; Kuehling, =
Felix <Felix.Kuehling@amd.com><mailto:Felix.Kuehling@amd.com>; Kim, Jonatha=
n <Jonathan.Kim@amd.com><mailto:Jonathan.Kim@amd.com>
Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in amdgpu_=
device_vram_access v2"

That's exactly my concern as well.

This looks a bit like the test creates erroneous data somehow, but there do=
esn't seems to be a RAS check in the MM data path.

And now that we use the BAR path it goes up in flames.

I just don't see how we can create erroneous data in a test case?

Christian.

Am 14.04.2020 16:35 schrieb "Deucher, Alexander" <Alexander.Deucher@amd.com=
<mailto:Alexander.Deucher@amd.com>>:

[AMD Public Use]

If this causes an issue, any access to vram via the BAR could cause an issu=
e.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Russell, Kent <Kent.Russell@amd.com<m=
ailto:Kent.Russell@amd.com>>
Sent: Tuesday, April 14, 2020 10:19 AM
To: Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd=
.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>=
 <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com<mailto:Felix.Kuehling@amd.com>>=
; Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>
Subject: RE: [PATCH] Revert "drm/amdgpu: use the BAR if possible in amdgpu_=
device_vram_access v2"

[AMD Official Use Only - Internal Distribution Only]

On VG20 or MI100, as soon as we run the subtest, we get the dmesg output be=
low, and then the kernel ends up hanging. I don't know enough about the tes=
t itself to know why this is occurring, but Jon Kim and Felix were discussi=
ng it on a separate thread when the issue was first reported, so they can h=
opefully provide some additional information.

 Kent

> -----Original Message-----
> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.=
leichtzumerken@gmail.com>>
> Sent: Tuesday, April 14, 2020 9:52 AM
> To: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>; am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
> amdgpu_device_vram_access v2"
>
> Am 13.04.20 um 20:20 schrieb Kent Russell:
> > This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.
> > The original patch causes a RAS event and subsequent kernel hard-hang
> > when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 and
> > Arcturus
> >
> > dmesg output at hang time:
> > [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!
> > amdgpu 0000:67:00.0: GPU reset begin!
> > Evicting PASID 0x8000 queues
> > Started evicting pasid 0x8000
> > qcm fence wait loop timeout expired
> > The cp might be in an unrecoverable state due to an unsuccessful
> > queues preemption Failed to evict process queues Failed to suspend
> > process 0x8000 Finished evicting pasid 0x8000 Started restoring pasid
> > 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may lost
> > due to RAS ERREVENT_ATHUB_INTERRUPT
> > amdgpu: [powerplay] Failed to send message 0x26, response 0x0
> > amdgpu: [powerplay] Failed to set soft min gfxclk !
> > amdgpu: [powerplay] Failed to upload DPM Bootup Levels!
> > amdgpu: [powerplay] Failed to send message 0x7, response 0x0
> > amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all smu
> features!
> > amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu feature=
s!
> > amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!
> > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP
> > block <powerplay> failed -5
>
> Do you have more information on what's going wrong here since this is a r=
eally
> important patch for KFD debugging.
>
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com<mailto:kent.russell@a=
md.com>>
>
> Reviewed-by: Christian K=F6nig <christian.koenig@amd.com<mailto:christian=
.koenig@amd.com>>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 ---------------------=
-
> >   1 file changed, 26 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index cf5d6e585634..a3f997f84020 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -254,32 +254,6 @@ void amdgpu_device_vram_access(struct
> amdgpu_device *adev, loff_t pos,
> >      uint32_t hi =3D ~0;
> >      uint64_t last;
> >
> > -
> > -#ifdef CONFIG_64BIT
> > -   last =3D min(pos + size, adev->gmc.visible_vram_size);
> > -   if (last > pos) {
> > -           void __iomem *addr =3D adev->mman.aper_base_kaddr + pos;
> > -           size_t count =3D last - pos;
> > -
> > -           if (write) {
> > -                   memcpy_toio(addr, buf, count);
> > -                   mb();
> > -                   amdgpu_asic_flush_hdp(adev, NULL);
> > -           } else {
> > -                   amdgpu_asic_invalidate_hdp(adev, NULL);
> > -                   mb();
> > -                   memcpy_fromio(buf, addr, count);
> > -           }
> > -
> > -           if (count =3D=3D size)
> > -                   return;
> > -
> > -           pos +=3D count;
> > -           buf +=3D count / 4;
> > -           size -=3D count;
> > -   }
> > -#endif
> > -
> >      spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> >      for (last =3D pos + size; pos < last; pos +=3D 4) {
> >              uint32_t tmp =3D pos >> 31;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637224707637289768&amp;sdata=3DttNOHJt0IwywpOIWahK=
jjuC6OkT1jxduc6iMzYzndpg%3D&amp;reserved=3D0


Am 14.04.2020 16:35 schrieb "Deucher, Alexander" <Alexander.Deucher@amd.com=
<mailto:Alexander.Deucher@amd.com>>:

[AMD Public Use]

If this causes an issue, any access to vram via the BAR could cause an issu=
e.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Russell, Kent <Kent.Russell@amd.com<m=
ailto:Kent.Russell@amd.com>>
Sent: Tuesday, April 14, 2020 10:19 AM
To: Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd=
.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>=
 <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com<mailto:Felix.Kuehling@amd.com>>=
; Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>
Subject: RE: [PATCH] Revert "drm/amdgpu: use the BAR if possible in amdgpu_=
device_vram_access v2"

[AMD Official Use Only - Internal Distribution Only]

On VG20 or MI100, as soon as we run the subtest, we get the dmesg output be=
low, and then the kernel ends up hanging. I don't know enough about the tes=
t itself to know why this is occurring, but Jon Kim and Felix were discussi=
ng it on a separate thread when the issue was first reported, so they can h=
opefully provide some additional information.

 Kent

> -----Original Message-----
> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.=
leichtzumerken@gmail.com>>
> Sent: Tuesday, April 14, 2020 9:52 AM
> To: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>; am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
> amdgpu_device_vram_access v2"
>
> Am 13.04.20 um 20:20 schrieb Kent Russell:
> > This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.
> > The original patch causes a RAS event and subsequent kernel hard-hang
> > when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 and
> > Arcturus
> >
> > dmesg output at hang time:
> > [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!
> > amdgpu 0000:67:00.0: GPU reset begin!
> > Evicting PASID 0x8000 queues
> > Started evicting pasid 0x8000
> > qcm fence wait loop timeout expired
> > The cp might be in an unrecoverable state due to an unsuccessful
> > queues preemption Failed to evict process queues Failed to suspend
> > process 0x8000 Finished evicting pasid 0x8000 Started restoring pasid
> > 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may lost
> > due to RAS ERREVENT_ATHUB_INTERRUPT
> > amdgpu: [powerplay] Failed to send message 0x26, response 0x0
> > amdgpu: [powerplay] Failed to set soft min gfxclk !
> > amdgpu: [powerplay] Failed to upload DPM Bootup Levels!
> > amdgpu: [powerplay] Failed to send message 0x7, response 0x0
> > amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all smu
> features!
> > amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu feature=
s!
> > amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!
> > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP
> > block <powerplay> failed -5
>
> Do you have more information on what's going wrong here since this is a r=
eally
> important patch for KFD debugging.
>
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com<mailto:kent.russell@a=
md.com>>
>
> Reviewed-by: Christian K=F6nig <christian.koenig@amd.com<mailto:christian=
.koenig@amd.com>>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 ---------------------=
-
> >   1 file changed, 26 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index cf5d6e585634..a3f997f84020 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -254,32 +254,6 @@ void amdgpu_device_vram_access(struct
> amdgpu_device *adev, loff_t pos,
> >      uint32_t hi =3D ~0;
> >      uint64_t last;
> >
> > -
> > -#ifdef CONFIG_64BIT
> > -   last =3D min(pos + size, adev->gmc.visible_vram_size);
> > -   if (last > pos) {
> > -           void __iomem *addr =3D adev->mman.aper_base_kaddr + pos;
> > -           size_t count =3D last - pos;
> > -
> > -           if (write) {
> > -                   memcpy_toio(addr, buf, count);
> > -                   mb();
> > -                   amdgpu_asic_flush_hdp(adev, NULL);
> > -           } else {
> > -                   amdgpu_asic_invalidate_hdp(adev, NULL);
> > -                   mb();
> > -                   memcpy_fromio(buf, addr, count);
> > -           }
> > -
> > -           if (count =3D=3D size)
> > -                   return;
> > -
> > -           pos +=3D count;
> > -           buf +=3D count / 4;
> > -           size -=3D count;
> > -   }
> > -#endif
> > -
> >      spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> >      for (last =3D pos + size; pos < last; pos +=3D 4) {
> >              uint32_t tmp =3D pos >> 31;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637224707637289768&amp;sdata=3DttNOHJt0IwywpOIWahK=
jjuC6OkT1jxduc6iMzYzndpg%3D&amp;reserved=3D0


Am 14.04.2020 16:35 schrieb "Deucher, Alexander" <Alexander.Deucher@amd.com=
<mailto:Alexander.Deucher@amd.com>>:

[AMD Public Use]

If this causes an issue, any access to vram via the BAR could cause an issu=
e.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Russell, Kent <Kent.Russell@amd.com<m=
ailto:Kent.Russell@amd.com>>
Sent: Tuesday, April 14, 2020 10:19 AM
To: Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd=
.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>=
 <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com<mailto:Felix.Kuehling@amd.com>>=
; Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>
Subject: RE: [PATCH] Revert "drm/amdgpu: use the BAR if possible in amdgpu_=
device_vram_access v2"

[AMD Official Use Only - Internal Distribution Only]

On VG20 or MI100, as soon as we run the subtest, we get the dmesg output be=
low, and then the kernel ends up hanging. I don't know enough about the tes=
t itself to know why this is occurring, but Jon Kim and Felix were discussi=
ng it on a separate thread when the issue was first reported, so they can h=
opefully provide some additional information.

 Kent

> -----Original Message-----
> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.=
leichtzumerken@gmail.com>>
> Sent: Tuesday, April 14, 2020 9:52 AM
> To: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>; am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
> amdgpu_device_vram_access v2"
>
> Am 13.04.20 um 20:20 schrieb Kent Russell:
> > This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.
> > The original patch causes a RAS event and subsequent kernel hard-hang
> > when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 and
> > Arcturus
> >
> > dmesg output at hang time:
> > [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!
> > amdgpu 0000:67:00.0: GPU reset begin!
> > Evicting PASID 0x8000 queues
> > Started evicting pasid 0x8000
> > qcm fence wait loop timeout expired
> > The cp might be in an unrecoverable state due to an unsuccessful
> > queues preemption Failed to evict process queues Failed to suspend
> > process 0x8000 Finished evicting pasid 0x8000 Started restoring pasid
> > 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may lost
> > due to RAS ERREVENT_ATHUB_INTERRUPT
> > amdgpu: [powerplay] Failed to send message 0x26, response 0x0
> > amdgpu: [powerplay] Failed to set soft min gfxclk !
> > amdgpu: [powerplay] Failed to upload DPM Bootup Levels!
> > amdgpu: [powerplay] Failed to send message 0x7, response 0x0
> > amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all smu
> features!
> > amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu feature=
s!
> > amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!
> > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP
> > block <powerplay> failed -5
>
> Do you have more information on what's going wrong here since this is a r=
eally
> important patch for KFD debugging.
>
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com<mailto:kent.russell@a=
md.com>>
>
> Reviewed-by: Christian K=F6nig <christian.koenig@amd.com<mailto:christian=
.koenig@amd.com>>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 ---------------------=
-
> >   1 file changed, 26 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index cf5d6e585634..a3f997f84020 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -254,32 +254,6 @@ void amdgpu_device_vram_access(struct
> amdgpu_device *adev, loff_t pos,
> >      uint32_t hi =3D ~0;
> >      uint64_t last;
> >
> > -
> > -#ifdef CONFIG_64BIT
> > -   last =3D min(pos + size, adev->gmc.visible_vram_size);
> > -   if (last > pos) {
> > -           void __iomem *addr =3D adev->mman.aper_base_kaddr + pos;
> > -           size_t count =3D last - pos;
> > -
> > -           if (write) {
> > -                   memcpy_toio(addr, buf, count);
> > -                   mb();
> > -                   amdgpu_asic_flush_hdp(adev, NULL);
> > -           } else {
> > -                   amdgpu_asic_invalidate_hdp(adev, NULL);
> > -                   mb();
> > -                   memcpy_fromio(buf, addr, count);
> > -           }
> > -
> > -           if (count =3D=3D size)
> > -                   return;
> > -
> > -           pos +=3D count;
> > -           buf +=3D count / 4;
> > -           size -=3D count;
> > -   }
> > -#endif
> > -
> >      spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> >      for (last =3D pos + size; pos < last; pos +=3D 4) {
> >              uint32_t tmp =3D pos >> 31;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637224707637289768&amp;sdata=3DttNOHJt0IwywpOIWahK=
jjuC6OkT1jxduc6iMzYzndpg%3D&amp;reserved=3D0


Am 14.04.2020 16:35 schrieb "Deucher, Alexander" <Alexander.Deucher@amd.com=
<mailto:Alexander.Deucher@amd.com>>:

[AMD Public Use]

If this causes an issue, any access to vram via the BAR could cause an issu=
e.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Russell, Kent <Kent.Russell@amd.com<m=
ailto:Kent.Russell@amd.com>>
Sent: Tuesday, April 14, 2020 10:19 AM
To: Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd=
.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>=
 <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com<mailto:Felix.Kuehling@amd.com>>=
; Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>
Subject: RE: [PATCH] Revert "drm/amdgpu: use the BAR if possible in amdgpu_=
device_vram_access v2"

[AMD Official Use Only - Internal Distribution Only]

On VG20 or MI100, as soon as we run the subtest, we get the dmesg output be=
low, and then the kernel ends up hanging. I don't know enough about the tes=
t itself to know why this is occurring, but Jon Kim and Felix were discussi=
ng it on a separate thread when the issue was first reported, so they can h=
opefully provide some additional information.

 Kent

> -----Original Message-----
> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.=
leichtzumerken@gmail.com>>
> Sent: Tuesday, April 14, 2020 9:52 AM
> To: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>; am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
> amdgpu_device_vram_access v2"
>
> Am 13.04.20 um 20:20 schrieb Kent Russell:
> > This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.
> > The original patch causes a RAS event and subsequent kernel hard-hang
> > when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 and
> > Arcturus
> >
> > dmesg output at hang time:
> > [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!
> > amdgpu 0000:67:00.0: GPU reset begin!
> > Evicting PASID 0x8000 queues
> > Started evicting pasid 0x8000
> > qcm fence wait loop timeout expired
> > The cp might be in an unrecoverable state due to an unsuccessful
> > queues preemption Failed to evict process queues Failed to suspend
> > process 0x8000 Finished evicting pasid 0x8000 Started restoring pasid
> > 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may lost
> > due to RAS ERREVENT_ATHUB_INTERRUPT
> > amdgpu: [powerplay] Failed to send message 0x26, response 0x0
> > amdgpu: [powerplay] Failed to set soft min gfxclk !
> > amdgpu: [powerplay] Failed to upload DPM Bootup Levels!
> > amdgpu: [powerplay] Failed to send message 0x7, response 0x0
> > amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all smu
> features!
> > amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu feature=
s!
> > amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!
> > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP
> > block <powerplay> failed -5
>
> Do you have more information on what's going wrong here since this is a r=
eally
> important patch for KFD debugging.
>
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com<mailto:kent.russell@a=
md.com>>
>
> Reviewed-by: Christian K=F6nig <christian.koenig@amd.com<mailto:christian=
.koenig@amd.com>>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 ---------------------=
-
> >   1 file changed, 26 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index cf5d6e585634..a3f997f84020 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -254,32 +254,6 @@ void amdgpu_device_vram_access(struct
> amdgpu_device *adev, loff_t pos,
> >      uint32_t hi =3D ~0;
> >      uint64_t last;
> >
> > -
> > -#ifdef CONFIG_64BIT
> > -   last =3D min(pos + size, adev->gmc.visible_vram_size);
> > -   if (last > pos) {
> > -           void __iomem *addr =3D adev->mman.aper_base_kaddr + pos;
> > -           size_t count =3D last - pos;
> > -
> > -           if (write) {
> > -                   memcpy_toio(addr, buf, count);
> > -                   mb();
> > -                   amdgpu_asic_flush_hdp(adev, NULL);
> > -           } else {
> > -                   amdgpu_asic_invalidate_hdp(adev, NULL);
> > -                   mb();
> > -                   memcpy_fromio(buf, addr, count);
> > -           }
> > -
> > -           if (count =3D=3D size)
> > -                   return;
> > -
> > -           pos +=3D count;
> > -           buf +=3D count / 4;
> > -           size -=3D count;
> > -   }
> > -#endif
> > -
> >      spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> >      for (last =3D pos + size; pos < last; pos +=3D 4) {
> >              uint32_t tmp =3D pos >> 31;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637224707637289768&amp;sdata=3DttNOHJt0IwywpOIWahK=
jjuC6OkT1jxduc6iMzYzndpg%3D&amp;reserved=3D0


Am 14.04.2020 16:35 schrieb "Deucher, Alexander" <Alexander.Deucher@amd.com=
<mailto:Alexander.Deucher@amd.com>>:

[AMD Public Use]

If this causes an issue, any access to vram via the BAR could cause an issu=
e.

Alex
________________________________
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org<mailto:amd-gfx-bounces=
@lists.freedesktop.org>> on behalf of Russell, Kent <Kent.Russell@amd.com<m=
ailto:Kent.Russell@amd.com>>
Sent: Tuesday, April 14, 2020 10:19 AM
To: Koenig, Christian <Christian.Koenig@amd.com<mailto:Christian.Koenig@amd=
.com>>; amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>=
 <amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>>
Cc: Kuehling, Felix <Felix.Kuehling@amd.com<mailto:Felix.Kuehling@amd.com>>=
; Kim, Jonathan <Jonathan.Kim@amd.com<mailto:Jonathan.Kim@amd.com>>
Subject: RE: [PATCH] Revert "drm/amdgpu: use the BAR if possible in amdgpu_=
device_vram_access v2"

[AMD Official Use Only - Internal Distribution Only]

On VG20 or MI100, as soon as we run the subtest, we get the dmesg output be=
low, and then the kernel ends up hanging. I don't know enough about the tes=
t itself to know why this is occurring, but Jon Kim and Felix were discussi=
ng it on a separate thread when the issue was first reported, so they can h=
opefully provide some additional information.

 Kent

> -----Original Message-----
> From: Christian K=F6nig <ckoenig.leichtzumerken@gmail.com<mailto:ckoenig.=
leichtzumerken@gmail.com>>
> Sent: Tuesday, April 14, 2020 9:52 AM
> To: Russell, Kent <Kent.Russell@amd.com<mailto:Kent.Russell@amd.com>>; am=
d-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
> Subject: Re: [PATCH] Revert "drm/amdgpu: use the BAR if possible in
> amdgpu_device_vram_access v2"
>
> Am 13.04.20 um 20:20 schrieb Kent Russell:
> > This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.
> > The original patch causes a RAS event and subsequent kernel hard-hang
> > when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 and
> > Arcturus
> >
> > dmesg output at hang time:
> > [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!
> > amdgpu 0000:67:00.0: GPU reset begin!
> > Evicting PASID 0x8000 queues
> > Started evicting pasid 0x8000
> > qcm fence wait loop timeout expired
> > The cp might be in an unrecoverable state due to an unsuccessful
> > queues preemption Failed to evict process queues Failed to suspend
> > process 0x8000 Finished evicting pasid 0x8000 Started restoring pasid
> > 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may lost
> > due to RAS ERREVENT_ATHUB_INTERRUPT
> > amdgpu: [powerplay] Failed to send message 0x26, response 0x0
> > amdgpu: [powerplay] Failed to set soft min gfxclk !
> > amdgpu: [powerplay] Failed to upload DPM Bootup Levels!
> > amdgpu: [powerplay] Failed to send message 0x7, response 0x0
> > amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all smu
> features!
> > amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu feature=
s!
> > amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!
> > [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of IP
> > block <powerplay> failed -5
>
> Do you have more information on what's going wrong here since this is a r=
eally
> important patch for KFD debugging.
>
> >
> > Signed-off-by: Kent Russell <kent.russell@amd.com<mailto:kent.russell@a=
md.com>>
>
> Reviewed-by: Christian K=F6nig <christian.koenig@amd.com<mailto:christian=
.koenig@amd.com>>
>
> > ---
> >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 ---------------------=
-
> >   1 file changed, 26 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index cf5d6e585634..a3f997f84020 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -254,32 +254,6 @@ void amdgpu_device_vram_access(struct
> amdgpu_device *adev, loff_t pos,
> >      uint32_t hi =3D ~0;
> >      uint64_t last;
> >
> > -
> > -#ifdef CONFIG_64BIT
> > -   last =3D min(pos + size, adev->gmc.visible_vram_size);
> > -   if (last > pos) {
> > -           void __iomem *addr =3D adev->mman.aper_base_kaddr + pos;
> > -           size_t count =3D last - pos;
> > -
> > -           if (write) {
> > -                   memcpy_toio(addr, buf, count);
> > -                   mb();
> > -                   amdgpu_asic_flush_hdp(adev, NULL);
> > -           } else {
> > -                   amdgpu_asic_invalidate_hdp(adev, NULL);
> > -                   mb();
> > -                   memcpy_fromio(buf, addr, count);
> > -           }
> > -
> > -           if (count =3D=3D size)
> > -                   return;
> > -
> > -           pos +=3D count;
> > -           buf +=3D count / 4;
> > -           size -=3D count;
> > -   }
> > -#endif
> > -
> >      spin_lock_irqsave(&adev->mmio_idx_lock, flags);
> >      for (last =3D pos + size; pos < last; pos +=3D 4) {
> >              uint32_t tmp =3D pos >> 31;
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org<mailto:amd-gfx@lists.freedesktop.org>
https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.f=
reedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=3D02%7C01%7Calexande=
r.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e=
11a82d994e183d%7C0%7C0%7C637224707637289768&amp;sdata=3DttNOHJt0IwywpOIWahK=
jjuC6OkT1jxduc6iMzYzndpg%3D&amp;reserved=3D0

--_000_MN2PR12MB4518A3D9746674DA688AD34885DA0MN2PR12MB4518namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<!--[if !mso]><style>v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style><![endif]--><style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
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
p.msipheader4d0fcdd7, li.msipheader4d0fcdd7, div.msipheader4d0fcdd7
	{mso-style-name:msipheader4d0fcdd7;
	mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
span.EmailStyle20
	{mso-style-type:personal-compose;
	font-family:"Arial",sans-serif;
	color:#0078D7;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">If we&#8217;re passing the test on the revert, then =
the only thing that&#8217;s different is we&#8217;re not invalidating HDP a=
nd doing a copy to host anymore in amdgpu_device_vram_access since the func=
tion is still called in ttm access_memory with BAR.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Also cwsr tests fail on Vega20 with or without the r=
evert with the same RAS error.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Jon<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Kuehling, Felix &lt;Felix.Kuehling@amd.=
com&gt; <br>
<b>Sent:</b> Tuesday, April 14, 2020 2:32 PM<br>
<b>To:</b> Kim, Jonathan &lt;Jonathan.Kim@amd.com&gt;; Koenig, Christian &l=
t;Christian.Koenig@amd.com&gt;; Deucher, Alexander &lt;Alexander.Deucher@am=
d.com&gt;<br>
<b>Cc:</b> Russell, Kent &lt;Kent.Russell@amd.com&gt;; amd-gfx@lists.freede=
sktop.org<br>
<b>Subject:</b> Re: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possibl=
e in amdgpu_device_vram_access v2&quot;<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p>I wouldn't call it premature. Revert is a usual practice when there is a=
 serious regression that isn't fully understood or root-caused. As far as I=
 can tell, the problem has been reproduced on multiple systems, different G=
PUs, and clearly regressed to Christian's
 commit. I think that justifies reverting it for now.<o:p></o:p></p>
<p>I agree with Christian that a general HDP memory access problem causing =
RAS errors would potentially cause problems in other tests as well. For exa=
mple common operations like GART table updates, and GPUVM page table update=
s and PCIe peer2peer accesses in
 ROCm applications use HDP. But we're not seeing obvious problems from thos=
e. So we need to understand what's special about this test. I asked questio=
ns to that effect on our other email thread.<o:p></o:p></p>
<p>Regards,<br>
&nbsp; Felix<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">Am 2020-04-14 um 10:51 a.m. schrieb Kim, Jonathan:<o=
:p></o:p></p>
</div>
<blockquote style=3D"margin-top:5.0pt;margin-bottom:5.0pt">
<p class=3D"msipheader4d0fcdd7" style=3D"margin:0in;margin-bottom:.0001pt">=
<span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;co=
lor:#0078D7">[AMD Official Use Only - Internal Distribution Only]</span><o:=
p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">I think it&#8217;s premature to push this revert.<o:=
p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">With more testing, I&#8217;m getting failures from d=
ifferent tests or sometimes none at all on my machine.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Kent, let&#8217;s continue the discussion on the ori=
ginal thread.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<p class=3D"MsoNormal">Jon<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<div style=3D"border:none;border-top:solid #E1E1E1 1.0pt;padding:3.0pt 0in =
0in 0in">
<p class=3D"MsoNormal"><b>From:</b> Koenig, Christian <a href=3D"mailto:Chr=
istian.Koenig@amd.com">
&lt;Christian.Koenig@amd.com&gt;</a> <br>
<b>Sent:</b> Tuesday, April 14, 2020 10:47 AM<br>
<b>To:</b> Deucher, Alexander <a href=3D"mailto:Alexander.Deucher@amd.com">=
&lt;Alexander.Deucher@amd.com&gt;</a><br>
<b>Cc:</b> Russell, Kent <a href=3D"mailto:Kent.Russell@amd.com">&lt;Kent.R=
ussell@amd.com&gt;</a>;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a>; Kuehling, Felix
<a href=3D"mailto:Felix.Kuehling@amd.com">&lt;Felix.Kuehling@amd.com&gt;</a=
>; Kim, Jonathan
<a href=3D"mailto:Jonathan.Kim@amd.com">&lt;Jonathan.Kim@amd.com&gt;</a><br=
>
<b>Subject:</b> Re: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possibl=
e in amdgpu_device_vram_access v2&quot;<o:p></o:p></p>
</div>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<div>
<div>
<div>
<div>
<p class=3D"MsoNormal">That's exactly my concern as well. <o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">This looks a bit like the test creates erroneous dat=
a somehow, but there doesn't seems to be a RAS check in the MM data path.<o=
:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">And now that we use the BAR path it goes up in flame=
s.<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">I just don't see how we can create erroneous data in=
 a test case?<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal">Christian.<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">Am 14.04.2020 16:35 schrieb &quot;Deucher, Alexander=
&quot; &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher@a=
md.com</a>&gt;:<o:p></o:p></p>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">If this=
 causes an issue, any access to vram via the BAR could cause an issue.</spa=
n><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;<=
/span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex</s=
pan><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.Russell@am=
d.com</a>&gt;<br>
<b>Sent:</b> Tuesday, April 14, 2020 10:19 AM<br>
<b>To:</b> Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com=
">Christian.Koenig@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;<a href=3D"mailto:Felix.Kuehling@amd.com">Fe=
lix.Kuehling@amd.com</a>&gt;; Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.=
Kim@amd.com">Jonathan.Kim@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possibl=
e in amdgpu_device_vram_access v2&quot;</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[AMD Official Use Only - Internal Distribution Only]=
<br>
<br>
On VG20 or MI100, as soon as we run the subtest, we get the dmesg output be=
low, and then the kernel ends up hanging. I don't know enough about the tes=
t itself to know why this is occurring, but Jon Kim and Felix were discussi=
ng it on a separate thread when
 the issue was first reported, so they can hopefully provide some additiona=
l information.<br>
<br>
&nbsp;Kent<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@g=
mail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
&gt; Sent: Tuesday, April 14, 2020 9:52 AM<br>
&gt; To: Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.Rus=
sell@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; Subject: Re: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possible =
in<br>
&gt; amdgpu_device_vram_access v2&quot;<br>
&gt; <br>
&gt; Am 13.04.20 um 20:20 schrieb Kent Russell:<br>
&gt; &gt; This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.<br>
&gt; &gt; The original patch causes a RAS event and subsequent kernel hard-=
hang<br>
&gt; &gt; when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 =
and<br>
&gt; &gt; Arcturus<br>
&gt; &gt;<br>
&gt; &gt; dmesg output at hang time:<br>
&gt; &gt; [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!<br>
&gt; &gt; amdgpu 0000:67:00.0: GPU reset begin!<br>
&gt; &gt; Evicting PASID 0x8000 queues<br>
&gt; &gt; Started evicting pasid 0x8000<br>
&gt; &gt; qcm fence wait loop timeout expired<br>
&gt; &gt; The cp might be in an unrecoverable state due to an unsuccessful<=
br>
&gt; &gt; queues preemption Failed to evict process queues Failed to suspen=
d<br>
&gt; &gt; process 0x8000 Finished evicting pasid 0x8000 Started restoring p=
asid<br>
&gt; &gt; 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may l=
ost<br>
&gt; &gt; due to RAS ERREVENT_ATHUB_INTERRUPT<br>
&gt; &gt; amdgpu: [powerplay] Failed to send message 0x26, response 0x0<br>
&gt; &gt; amdgpu: [powerplay] Failed to set soft min gfxclk !<br>
&gt; &gt; amdgpu: [powerplay] Failed to upload DPM Bootup Levels!<br>
&gt; &gt; amdgpu: [powerplay] Failed to send message 0x7, response 0x0<br>
&gt; &gt; amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all=
 smu<br>
&gt; features!<br>
&gt; &gt; amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu f=
eatures!<br>
&gt; &gt; amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!<br>
&gt; &gt; [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of=
 IP<br>
&gt; &gt; block &lt;powerplay&gt; failed -5<br>
&gt; <br>
&gt; Do you have more information on what's going wrong here since this is =
a really<br>
&gt; important patch for KFD debugging.<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Kent Russell &lt;<a href=3D"mailto:kent.russell@am=
d.com">kent.russell@amd.com</a>&gt;<br>
&gt; <br>
&gt; Reviewed-by: Christian K=F6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com">christian.koenig@amd.com</a>&gt;<br>
&gt; <br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 -----=
-----------------<br>
&gt; &gt;&nbsp;&nbsp; 1 file changed, 26 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; index cf5d6e585634..a3f997f84020 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; @@ -254,32 &#43;254,6 @@ void amdgpu_device_vram_access(struct<br=
>
&gt; amdgpu_device *adev, loff_t pos,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hi =3D ~0;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t last;<br>
&gt; &gt;<br>
&gt; &gt; -<br>
&gt; &gt; -#ifdef CONFIG_64BIT<br>
&gt; &gt; -&nbsp;&nbsp; last =3D min(pos &#43; size, adev-&gt;gmc.visible_v=
ram_size);<br>
&gt; &gt; -&nbsp;&nbsp; if (last &gt; pos) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; voi=
d __iomem *addr =3D adev-&gt;mman.aper_base_kaddr &#43; pos;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e_t count =3D last - pos;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(write) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_toio(addr, buf, count);=
<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_flush_hdp(adev, NU=
LL);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } e=
lse {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_invalidate_hdp(ade=
v, NULL);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_fromio(buf, addr, count=
);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(count =3D=3D size)<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pos=
 &#43;=3D count;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf=
 &#43;=3D count / 4;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e -=3D count;<br>
&gt; &gt; -&nbsp;&nbsp; }<br>
&gt; &gt; -#endif<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;adev-&gt;mmi=
o_idx_lock, flags);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (last =3D pos &#43; size; pos &=
lt; last; pos &#43;=3D 4) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; uint32_t tmp =3D pos &gt;&gt; 31;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=3D=
ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=3DttNOHJt0IwywpOIWa=
hKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</blockquote>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">Am 14.04.2020 16:35 schrieb &quot;Deucher, Alexander=
&quot; &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher@a=
md.com</a>&gt;:<o:p></o:p></p>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">If this=
 causes an issue, any access to vram via the BAR could cause an issue.</spa=
n><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;<=
/span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex</s=
pan><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.Russell@am=
d.com</a>&gt;<br>
<b>Sent:</b> Tuesday, April 14, 2020 10:19 AM<br>
<b>To:</b> Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com=
">Christian.Koenig@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;<a href=3D"mailto:Felix.Kuehling@amd.com">Fe=
lix.Kuehling@amd.com</a>&gt;; Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.=
Kim@amd.com">Jonathan.Kim@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possibl=
e in amdgpu_device_vram_access v2&quot;</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[AMD Official Use Only - Internal Distribution Only]=
<br>
<br>
On VG20 or MI100, as soon as we run the subtest, we get the dmesg output be=
low, and then the kernel ends up hanging. I don't know enough about the tes=
t itself to know why this is occurring, but Jon Kim and Felix were discussi=
ng it on a separate thread when
 the issue was first reported, so they can hopefully provide some additiona=
l information.<br>
<br>
&nbsp;Kent<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@g=
mail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
&gt; Sent: Tuesday, April 14, 2020 9:52 AM<br>
&gt; To: Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.Rus=
sell@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; Subject: Re: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possible =
in<br>
&gt; amdgpu_device_vram_access v2&quot;<br>
&gt; <br>
&gt; Am 13.04.20 um 20:20 schrieb Kent Russell:<br>
&gt; &gt; This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.<br>
&gt; &gt; The original patch causes a RAS event and subsequent kernel hard-=
hang<br>
&gt; &gt; when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 =
and<br>
&gt; &gt; Arcturus<br>
&gt; &gt;<br>
&gt; &gt; dmesg output at hang time:<br>
&gt; &gt; [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!<br>
&gt; &gt; amdgpu 0000:67:00.0: GPU reset begin!<br>
&gt; &gt; Evicting PASID 0x8000 queues<br>
&gt; &gt; Started evicting pasid 0x8000<br>
&gt; &gt; qcm fence wait loop timeout expired<br>
&gt; &gt; The cp might be in an unrecoverable state due to an unsuccessful<=
br>
&gt; &gt; queues preemption Failed to evict process queues Failed to suspen=
d<br>
&gt; &gt; process 0x8000 Finished evicting pasid 0x8000 Started restoring p=
asid<br>
&gt; &gt; 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may l=
ost<br>
&gt; &gt; due to RAS ERREVENT_ATHUB_INTERRUPT<br>
&gt; &gt; amdgpu: [powerplay] Failed to send message 0x26, response 0x0<br>
&gt; &gt; amdgpu: [powerplay] Failed to set soft min gfxclk !<br>
&gt; &gt; amdgpu: [powerplay] Failed to upload DPM Bootup Levels!<br>
&gt; &gt; amdgpu: [powerplay] Failed to send message 0x7, response 0x0<br>
&gt; &gt; amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all=
 smu<br>
&gt; features!<br>
&gt; &gt; amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu f=
eatures!<br>
&gt; &gt; amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!<br>
&gt; &gt; [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of=
 IP<br>
&gt; &gt; block &lt;powerplay&gt; failed -5<br>
&gt; <br>
&gt; Do you have more information on what's going wrong here since this is =
a really<br>
&gt; important patch for KFD debugging.<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Kent Russell &lt;<a href=3D"mailto:kent.russell@am=
d.com">kent.russell@amd.com</a>&gt;<br>
&gt; <br>
&gt; Reviewed-by: Christian K=F6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com">christian.koenig@amd.com</a>&gt;<br>
&gt; <br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 -----=
-----------------<br>
&gt; &gt;&nbsp;&nbsp; 1 file changed, 26 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; index cf5d6e585634..a3f997f84020 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; @@ -254,32 &#43;254,6 @@ void amdgpu_device_vram_access(struct<br=
>
&gt; amdgpu_device *adev, loff_t pos,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hi =3D ~0;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t last;<br>
&gt; &gt;<br>
&gt; &gt; -<br>
&gt; &gt; -#ifdef CONFIG_64BIT<br>
&gt; &gt; -&nbsp;&nbsp; last =3D min(pos &#43; size, adev-&gt;gmc.visible_v=
ram_size);<br>
&gt; &gt; -&nbsp;&nbsp; if (last &gt; pos) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; voi=
d __iomem *addr =3D adev-&gt;mman.aper_base_kaddr &#43; pos;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e_t count =3D last - pos;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(write) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_toio(addr, buf, count);=
<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_flush_hdp(adev, NU=
LL);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } e=
lse {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_invalidate_hdp(ade=
v, NULL);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_fromio(buf, addr, count=
);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(count =3D=3D size)<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pos=
 &#43;=3D count;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf=
 &#43;=3D count / 4;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e -=3D count;<br>
&gt; &gt; -&nbsp;&nbsp; }<br>
&gt; &gt; -#endif<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;adev-&gt;mmi=
o_idx_lock, flags);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (last =3D pos &#43; size; pos &=
lt; last; pos &#43;=3D 4) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; uint32_t tmp =3D pos &gt;&gt; 31;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=3D=
ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=3DttNOHJt0IwywpOIWa=
hKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</blockquote>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">Am 14.04.2020 16:35 schrieb &quot;Deucher, Alexander=
&quot; &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher@a=
md.com</a>&gt;:<o:p></o:p></p>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">If this=
 causes an issue, any access to vram via the BAR could cause an issue.</spa=
n><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;<=
/span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex</s=
pan><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.Russell@am=
d.com</a>&gt;<br>
<b>Sent:</b> Tuesday, April 14, 2020 10:19 AM<br>
<b>To:</b> Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com=
">Christian.Koenig@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;<a href=3D"mailto:Felix.Kuehling@amd.com">Fe=
lix.Kuehling@amd.com</a>&gt;; Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.=
Kim@amd.com">Jonathan.Kim@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possibl=
e in amdgpu_device_vram_access v2&quot;</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[AMD Official Use Only - Internal Distribution Only]=
<br>
<br>
On VG20 or MI100, as soon as we run the subtest, we get the dmesg output be=
low, and then the kernel ends up hanging. I don't know enough about the tes=
t itself to know why this is occurring, but Jon Kim and Felix were discussi=
ng it on a separate thread when
 the issue was first reported, so they can hopefully provide some additiona=
l information.<br>
<br>
&nbsp;Kent<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@g=
mail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
&gt; Sent: Tuesday, April 14, 2020 9:52 AM<br>
&gt; To: Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.Rus=
sell@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; Subject: Re: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possible =
in<br>
&gt; amdgpu_device_vram_access v2&quot;<br>
&gt; <br>
&gt; Am 13.04.20 um 20:20 schrieb Kent Russell:<br>
&gt; &gt; This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.<br>
&gt; &gt; The original patch causes a RAS event and subsequent kernel hard-=
hang<br>
&gt; &gt; when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 =
and<br>
&gt; &gt; Arcturus<br>
&gt; &gt;<br>
&gt; &gt; dmesg output at hang time:<br>
&gt; &gt; [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!<br>
&gt; &gt; amdgpu 0000:67:00.0: GPU reset begin!<br>
&gt; &gt; Evicting PASID 0x8000 queues<br>
&gt; &gt; Started evicting pasid 0x8000<br>
&gt; &gt; qcm fence wait loop timeout expired<br>
&gt; &gt; The cp might be in an unrecoverable state due to an unsuccessful<=
br>
&gt; &gt; queues preemption Failed to evict process queues Failed to suspen=
d<br>
&gt; &gt; process 0x8000 Finished evicting pasid 0x8000 Started restoring p=
asid<br>
&gt; &gt; 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may l=
ost<br>
&gt; &gt; due to RAS ERREVENT_ATHUB_INTERRUPT<br>
&gt; &gt; amdgpu: [powerplay] Failed to send message 0x26, response 0x0<br>
&gt; &gt; amdgpu: [powerplay] Failed to set soft min gfxclk !<br>
&gt; &gt; amdgpu: [powerplay] Failed to upload DPM Bootup Levels!<br>
&gt; &gt; amdgpu: [powerplay] Failed to send message 0x7, response 0x0<br>
&gt; &gt; amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all=
 smu<br>
&gt; features!<br>
&gt; &gt; amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu f=
eatures!<br>
&gt; &gt; amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!<br>
&gt; &gt; [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of=
 IP<br>
&gt; &gt; block &lt;powerplay&gt; failed -5<br>
&gt; <br>
&gt; Do you have more information on what's going wrong here since this is =
a really<br>
&gt; important patch for KFD debugging.<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Kent Russell &lt;<a href=3D"mailto:kent.russell@am=
d.com">kent.russell@amd.com</a>&gt;<br>
&gt; <br>
&gt; Reviewed-by: Christian K=F6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com">christian.koenig@amd.com</a>&gt;<br>
&gt; <br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 -----=
-----------------<br>
&gt; &gt;&nbsp;&nbsp; 1 file changed, 26 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; index cf5d6e585634..a3f997f84020 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; @@ -254,32 &#43;254,6 @@ void amdgpu_device_vram_access(struct<br=
>
&gt; amdgpu_device *adev, loff_t pos,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hi =3D ~0;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t last;<br>
&gt; &gt;<br>
&gt; &gt; -<br>
&gt; &gt; -#ifdef CONFIG_64BIT<br>
&gt; &gt; -&nbsp;&nbsp; last =3D min(pos &#43; size, adev-&gt;gmc.visible_v=
ram_size);<br>
&gt; &gt; -&nbsp;&nbsp; if (last &gt; pos) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; voi=
d __iomem *addr =3D adev-&gt;mman.aper_base_kaddr &#43; pos;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e_t count =3D last - pos;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(write) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_toio(addr, buf, count);=
<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_flush_hdp(adev, NU=
LL);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } e=
lse {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_invalidate_hdp(ade=
v, NULL);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_fromio(buf, addr, count=
);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(count =3D=3D size)<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pos=
 &#43;=3D count;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf=
 &#43;=3D count / 4;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e -=3D count;<br>
&gt; &gt; -&nbsp;&nbsp; }<br>
&gt; &gt; -#endif<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;adev-&gt;mmi=
o_idx_lock, flags);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (last =3D pos &#43; size; pos &=
lt; last; pos &#43;=3D 4) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; uint32_t tmp =3D pos &gt;&gt; 31;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=3D=
ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=3DttNOHJt0IwywpOIWa=
hKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</blockquote>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">Am 14.04.2020 16:35 schrieb &quot;Deucher, Alexander=
&quot; &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher@a=
md.com</a>&gt;:<o:p></o:p></p>
<blockquote style=3D"border:none;border-left:solid #CCCCCC 1.0pt;padding:0i=
n 0in 0in 6.0pt;margin-left:4.8pt;margin-top:5.0pt;margin-right:0in;margin-=
bottom:5.0pt">
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">If this=
 causes an issue, any access to vram via the BAR could cause an issue.</spa=
n><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;<=
/span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex</s=
pan><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div>
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.Russell@am=
d.com</a>&gt;<br>
<b>Sent:</b> Tuesday, April 14, 2020 10:19 AM<br>
<b>To:</b> Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com=
">Christian.Koenig@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;<a href=3D"mailto:Felix.Kuehling@amd.com">Fe=
lix.Kuehling@amd.com</a>&gt;; Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.=
Kim@amd.com">Jonathan.Kim@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possibl=
e in amdgpu_device_vram_access v2&quot;</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[AMD Official Use Only - Internal Distribution Only]=
<br>
<br>
On VG20 or MI100, as soon as we run the subtest, we get the dmesg output be=
low, and then the kernel ends up hanging. I don't know enough about the tes=
t itself to know why this is occurring, but Jon Kim and Felix were discussi=
ng it on a separate thread when
 the issue was first reported, so they can hopefully provide some additiona=
l information.<br>
<br>
&nbsp;Kent<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@g=
mail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
&gt; Sent: Tuesday, April 14, 2020 9:52 AM<br>
&gt; To: Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.Rus=
sell@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; Subject: Re: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possible =
in<br>
&gt; amdgpu_device_vram_access v2&quot;<br>
&gt; <br>
&gt; Am 13.04.20 um 20:20 schrieb Kent Russell:<br>
&gt; &gt; This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.<br>
&gt; &gt; The original patch causes a RAS event and subsequent kernel hard-=
hang<br>
&gt; &gt; when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 =
and<br>
&gt; &gt; Arcturus<br>
&gt; &gt;<br>
&gt; &gt; dmesg output at hang time:<br>
&gt; &gt; [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!<br>
&gt; &gt; amdgpu 0000:67:00.0: GPU reset begin!<br>
&gt; &gt; Evicting PASID 0x8000 queues<br>
&gt; &gt; Started evicting pasid 0x8000<br>
&gt; &gt; qcm fence wait loop timeout expired<br>
&gt; &gt; The cp might be in an unrecoverable state due to an unsuccessful<=
br>
&gt; &gt; queues preemption Failed to evict process queues Failed to suspen=
d<br>
&gt; &gt; process 0x8000 Finished evicting pasid 0x8000 Started restoring p=
asid<br>
&gt; &gt; 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may l=
ost<br>
&gt; &gt; due to RAS ERREVENT_ATHUB_INTERRUPT<br>
&gt; &gt; amdgpu: [powerplay] Failed to send message 0x26, response 0x0<br>
&gt; &gt; amdgpu: [powerplay] Failed to set soft min gfxclk !<br>
&gt; &gt; amdgpu: [powerplay] Failed to upload DPM Bootup Levels!<br>
&gt; &gt; amdgpu: [powerplay] Failed to send message 0x7, response 0x0<br>
&gt; &gt; amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all=
 smu<br>
&gt; features!<br>
&gt; &gt; amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu f=
eatures!<br>
&gt; &gt; amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!<br>
&gt; &gt; [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of=
 IP<br>
&gt; &gt; block &lt;powerplay&gt; failed -5<br>
&gt; <br>
&gt; Do you have more information on what's going wrong here since this is =
a really<br>
&gt; important patch for KFD debugging.<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Kent Russell &lt;<a href=3D"mailto:kent.russell@am=
d.com">kent.russell@amd.com</a>&gt;<br>
&gt; <br>
&gt; Reviewed-by: Christian K=F6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com">christian.koenig@amd.com</a>&gt;<br>
&gt; <br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 -----=
-----------------<br>
&gt; &gt;&nbsp;&nbsp; 1 file changed, 26 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; index cf5d6e585634..a3f997f84020 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; @@ -254,32 &#43;254,6 @@ void amdgpu_device_vram_access(struct<br=
>
&gt; amdgpu_device *adev, loff_t pos,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hi =3D ~0;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t last;<br>
&gt; &gt;<br>
&gt; &gt; -<br>
&gt; &gt; -#ifdef CONFIG_64BIT<br>
&gt; &gt; -&nbsp;&nbsp; last =3D min(pos &#43; size, adev-&gt;gmc.visible_v=
ram_size);<br>
&gt; &gt; -&nbsp;&nbsp; if (last &gt; pos) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; voi=
d __iomem *addr =3D adev-&gt;mman.aper_base_kaddr &#43; pos;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e_t count =3D last - pos;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(write) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_toio(addr, buf, count);=
<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_flush_hdp(adev, NU=
LL);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } e=
lse {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_invalidate_hdp(ade=
v, NULL);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_fromio(buf, addr, count=
);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(count =3D=3D size)<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pos=
 &#43;=3D count;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf=
 &#43;=3D count / 4;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e -=3D count;<br>
&gt; &gt; -&nbsp;&nbsp; }<br>
&gt; &gt; -#endif<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;adev-&gt;mmi=
o_idx_lock, flags);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (last =3D pos &#43; size; pos &=
lt; last; pos &#43;=3D 4) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; uint32_t tmp =3D pos &gt;&gt; 31;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=3D=
ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=3DttNOHJt0IwywpOIWa=
hKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</blockquote>
</div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">Am 14.04.2020 16:35 schrieb &quot;Deucher, Alexander=
&quot; &lt;<a href=3D"mailto:Alexander.Deucher@amd.com">Alexander.Deucher@a=
md.com</a>&gt;:<o:p></o:p></p>
</div>
</div>
<div>
<p style=3D"margin:15.0pt"><span style=3D"font-size:10.0pt;font-family:&quo=
t;Arial&quot;,sans-serif;color:#317100">[AMD Public Use]</span><o:p></o:p><=
/p>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
<div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">If this=
 causes an issue, any access to vram via the BAR could cause an issue.</spa=
n><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">&nbsp;<=
/span><o:p></o:p></p>
</div>
<div>
<p class=3D"MsoNormal"><span style=3D"font-size:12.0pt;color:black">Alex</s=
pan><o:p></o:p></p>
</div>
<div class=3D"MsoNormal" align=3D"center" style=3D"text-align:center">
<hr size=3D"2" width=3D"98%" align=3D"center">
</div>
<div id=3D"divRplyFwdMsg">
<p class=3D"MsoNormal"><b><span style=3D"color:black">From:</span></b><span=
 style=3D"color:black"> amd-gfx &lt;<a href=3D"mailto:amd-gfx-bounces@lists=
.freedesktop.org">amd-gfx-bounces@lists.freedesktop.org</a>&gt; on behalf o=
f Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.Russell@am=
d.com</a>&gt;<br>
<b>Sent:</b> Tuesday, April 14, 2020 10:19 AM<br>
<b>To:</b> Koenig, Christian &lt;<a href=3D"mailto:Christian.Koenig@amd.com=
">Christian.Koenig@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a> &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.=
freedesktop.org</a>&gt;<br>
<b>Cc:</b> Kuehling, Felix &lt;<a href=3D"mailto:Felix.Kuehling@amd.com">Fe=
lix.Kuehling@amd.com</a>&gt;; Kim, Jonathan &lt;<a href=3D"mailto:Jonathan.=
Kim@amd.com">Jonathan.Kim@amd.com</a>&gt;<br>
<b>Subject:</b> RE: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possibl=
e in amdgpu_device_vram_access v2&quot;</span>
<o:p></o:p></p>
<div>
<p class=3D"MsoNormal">&nbsp;<o:p></o:p></p>
</div>
</div>
<div>
<div>
<p class=3D"MsoNormal">[AMD Official Use Only - Internal Distribution Only]=
<br>
<br>
On VG20 or MI100, as soon as we run the subtest, we get the dmesg output be=
low, and then the kernel ends up hanging. I don't know enough about the tes=
t itself to know why this is occurring, but Jon Kim and Felix were discussi=
ng it on a separate thread when
 the issue was first reported, so they can hopefully provide some additiona=
l information.<br>
<br>
&nbsp;Kent<br>
<br>
&gt; -----Original Message-----<br>
&gt; From: Christian K=F6nig &lt;<a href=3D"mailto:ckoenig.leichtzumerken@g=
mail.com">ckoenig.leichtzumerken@gmail.com</a>&gt;<br>
&gt; Sent: Tuesday, April 14, 2020 9:52 AM<br>
&gt; To: Russell, Kent &lt;<a href=3D"mailto:Kent.Russell@amd.com">Kent.Rus=
sell@amd.com</a>&gt;;
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
&gt; Subject: Re: [PATCH] Revert &quot;drm/amdgpu: use the BAR if possible =
in<br>
&gt; amdgpu_device_vram_access v2&quot;<br>
&gt; <br>
&gt; Am 13.04.20 um 20:20 schrieb Kent Russell:<br>
&gt; &gt; This reverts commit c12b84d6e0d70f1185e6daddfd12afb671791b6e.<br>
&gt; &gt; The original patch causes a RAS event and subsequent kernel hard-=
hang<br>
&gt; &gt; when running the KFDMemoryTest.PtraceAccessInvisibleVram on VG20 =
and<br>
&gt; &gt; Arcturus<br>
&gt; &gt;<br>
&gt; &gt; dmesg output at hang time:<br>
&gt; &gt; [drm] RAS event of type ERREVENT_ATHUB_INTERRUPT detected!<br>
&gt; &gt; amdgpu 0000:67:00.0: GPU reset begin!<br>
&gt; &gt; Evicting PASID 0x8000 queues<br>
&gt; &gt; Started evicting pasid 0x8000<br>
&gt; &gt; qcm fence wait loop timeout expired<br>
&gt; &gt; The cp might be in an unrecoverable state due to an unsuccessful<=
br>
&gt; &gt; queues preemption Failed to evict process queues Failed to suspen=
d<br>
&gt; &gt; process 0x8000 Finished evicting pasid 0x8000 Started restoring p=
asid<br>
&gt; &gt; 0x8000 Finished restoring pasid 0x8000 [drm] UVD VCPU state may l=
ost<br>
&gt; &gt; due to RAS ERREVENT_ATHUB_INTERRUPT<br>
&gt; &gt; amdgpu: [powerplay] Failed to send message 0x26, response 0x0<br>
&gt; &gt; amdgpu: [powerplay] Failed to set soft min gfxclk !<br>
&gt; &gt; amdgpu: [powerplay] Failed to upload DPM Bootup Levels!<br>
&gt; &gt; amdgpu: [powerplay] Failed to send message 0x7, response 0x0<br>
&gt; &gt; amdgpu: [powerplay] [DisableAllSMUFeatures] Failed to disable all=
 smu<br>
&gt; features!<br>
&gt; &gt; amdgpu: [powerplay] [DisableDpmTasks] Failed to disable all smu f=
eatures!<br>
&gt; &gt; amdgpu: [powerplay] [PowerOffAsic] Failed to disable DPM!<br>
&gt; &gt; [drm:amdgpu_device_ip_suspend_phase2 [amdgpu]] *ERROR* suspend of=
 IP<br>
&gt; &gt; block &lt;powerplay&gt; failed -5<br>
&gt; <br>
&gt; Do you have more information on what's going wrong here since this is =
a really<br>
&gt; important patch for KFD debugging.<br>
&gt; <br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Kent Russell &lt;<a href=3D"mailto:kent.russell@am=
d.com">kent.russell@amd.com</a>&gt;<br>
&gt; <br>
&gt; Reviewed-by: Christian K=F6nig &lt;<a href=3D"mailto:christian.koenig@=
amd.com">christian.koenig@amd.com</a>&gt;<br>
&gt; <br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 26 -----=
-----------------<br>
&gt; &gt;&nbsp;&nbsp; 1 file changed, 26 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; index cf5d6e585634..a3f997f84020 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; &#43;&#43;&#43; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; @@ -254,32 &#43;254,6 @@ void amdgpu_device_vram_access(struct<br=
>
&gt; amdgpu_device *adev, loff_t pos,<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint32_t hi =3D ~0;<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; uint64_t last;<br>
&gt; &gt;<br>
&gt; &gt; -<br>
&gt; &gt; -#ifdef CONFIG_64BIT<br>
&gt; &gt; -&nbsp;&nbsp; last =3D min(pos &#43; size, adev-&gt;gmc.visible_v=
ram_size);<br>
&gt; &gt; -&nbsp;&nbsp; if (last &gt; pos) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; voi=
d __iomem *addr =3D adev-&gt;mman.aper_base_kaddr &#43; pos;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e_t count =3D last - pos;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(write) {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_toio(addr, buf, count);=
<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_flush_hdp(adev, NU=
LL);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; } e=
lse {<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_asic_invalidate_hdp(ade=
v, NULL);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; mb();<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; memcpy_fromio(buf, addr, count=
);<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<b=
r>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if =
(count =3D=3D size)<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; return;<br>
&gt; &gt; -<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pos=
 &#43;=3D count;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; buf=
 &#43;=3D count / 4;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; siz=
e -=3D count;<br>
&gt; &gt; -&nbsp;&nbsp; }<br>
&gt; &gt; -#endif<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; spin_lock_irqsave(&amp;adev-&gt;mmi=
o_idx_lock, flags);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; for (last =3D pos &#43; size; pos &=
lt; last; pos &#43;=3D 4) {<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; uint32_t tmp =3D pos &gt;&gt; 31;<br>
_______________________________________________<br>
amd-gfx mailing list<br>
<a href=3D"mailto:amd-gfx@lists.freedesktop.org">amd-gfx@lists.freedesktop.=
org</a><br>
<a href=3D"https://nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2=
F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%=
7C01%7Calexander.deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd=
8961fe4884e608e11a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=3D=
ttNOHJt0IwywpOIWahKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0">https:=
//nam11.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flists.freedes=
ktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;amp;data=3D02%7C01%7Calexander.=
deucher%40amd.com%7C68e0bfea2a5f4a909ab108d7e07ed164%7C3dd8961fe4884e608e11=
a82d994e183d%7C0%7C0%7C637224707637289768&amp;amp;sdata=3DttNOHJt0IwywpOIWa=
hKjjuC6OkT1jxduc6iMzYzndpg%3D&amp;amp;reserved=3D0</a><o:p></o:p></p>
</div>
</div>
</div>
</div>
</blockquote>
</div>
</body>
</html>

--_000_MN2PR12MB4518A3D9746674DA688AD34885DA0MN2PR12MB4518namp_--

--===============1058299703==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

--===============1058299703==--
