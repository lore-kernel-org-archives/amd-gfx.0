Return-Path: <SRS0=1Ph7=32=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA60C33CAC
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 15:43:56 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5002F21741
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Feb 2020 15:43:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="PnuQkTd+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5002F21741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F23AE6FA8D;
	Thu,  6 Feb 2020 15:43:55 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-cys01nam02on0620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe45::620])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BFD56FA8D
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Feb 2020 15:43:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c05wuGZC/F3X5ZOZHgcmAhFdTE80jY3bi9vRlnFKFlxY8T7DPclriE50A4YtnS6Qoc6XCbNRgRTruLR/eNzTMZyqx32sSUhvkoitxdmcSJFO7UEyS4Lt93UaC+dBzHJjExkQX/6Zxei8kl3eLxIU3uTxzByR21M+QDAAf4ibnr72KI5+7GpFyxXBbZUx1kEVEIC3/HLgPbuLrnnkqYD2o2Lu/GcdilmJI09wQhEMTrVGBhevdM+6l8BhFrxV6M+frO37NXpEc4q8JVSytvwTNOjDjio2IPRBJSYEWyJNtcBdECu4Sy4R6Pc1bRbd5ZUcXYBeiHkXuiNYAP2Z6XeTww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4NnmuymBwGVlk8llWrOWRk9GX0Mk85b1vz7WybhobQ=;
 b=IcEIG04SK3MVphzkkG+02OMeWAyo5bTVPM1GgidY8vsppqGyhZXlBRdbjC39xEOUQgz9jTZNPtyPgVEOrV4tw48r/IhER/Yno/y8nikeVPvxHFwrEWKJq49AaEgXQj+e9rC35OJSfEmCOJ5XYkTwO7wmgC31/BAtNWju22P4PZ2f+3iRkfMqmk3WKeCR469s91ZKxpmYRu7XwolqhIiHvHOrttw27cbmNnnV84E7vrrU43mHsvFu9zgNDfzfABqR0uyf4PnFMEl88Lpdvey6qlMf9nT/9nXUCbgA2fMkSy8sliyS2WRW18kHQ9blQVsd+z04/VL0C0TVFr0KxT/KtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4NnmuymBwGVlk8llWrOWRk9GX0Mk85b1vz7WybhobQ=;
 b=PnuQkTd+jpKuCw7ZCMvxmgx+dXBgLsjm1TlOC149YIqGW/q/VJ6quJHP23/AsewLF6WYsAnUe7t0usYWyze0ODJBuGrCbOy1FOyOaeel9FgHQKmFxECppDY0ADSum3cruOSAcBmIhMLyv/jUGp400haUVT5f0FBOpu4dXb277Tw=
Received: from BL0PR12MB2580.namprd12.prod.outlook.com (52.132.27.147) by
 BL0PR12MB2452.namprd12.prod.outlook.com (52.132.28.32) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 15:43:50 +0000
Received: from BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::920:7e64:773:4005]) by BL0PR12MB2580.namprd12.prod.outlook.com
 ([fe80::920:7e64:773:4005%7]) with mapi id 15.20.2707.023; Thu, 6 Feb 2020
 15:43:50 +0000
From: "Zeng, Oak" <Oak.Zeng@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>, "Kuehling, Felix"
 <Felix.Kuehling@amd.com>
Subject: RE: [Patch v2 3/4] drm/amdkfd: refactor runtime pm for baco
Thread-Topic: [Patch v2 3/4] drm/amdkfd: refactor runtime pm for baco
Thread-Index: AQHV2LD1e5Wr66YpiE6ujK8uOzMeaqgLksUAgAB6WoCAAjSIgIAAEySA
Date: Thu, 6 Feb 2020 15:43:49 +0000
Message-ID: <BL0PR12MB2580981FA3DC53B14FA8DEB5801D0@BL0PR12MB2580.namprd12.prod.outlook.com>
References: <20200201033707.16351-1-rajneesh.bhardwaj@amd.com>
 <20200201033707.16351-4-rajneesh.bhardwaj@amd.com>
 <aeb4f57d-fac8-8a4f-caac-2dd725f2f66a@amd.com>
 <CADnq5_PjVGNMsoxNcOZesZGXVe=P7QgNZDAmL7XV2OTEg3OxJQ@mail.gmail.com>
 <CADnq5_PhEwAszT1R56K9+u+uXiaLaEbyh6Uguv=OzyPfqdWq=w@mail.gmail.com>
In-Reply-To: <CADnq5_PhEwAszT1R56K9+u+uXiaLaEbyh6Uguv=OzyPfqdWq=w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2020-02-06T15:43:47Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=4365eed7-6066-43c6-b7bf-000094246893;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_enabled: true
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_setdate: 2020-02-06T15:43:47Z
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_method: Standard
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_name: Internal Use Only -
 Unrestricted
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_siteid: 3dd8961f-e488-4e60-8e11-a82d994e183d
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_actionid: f2bc7235-bfb7-4fb0-b30a-0000bbbbb71f
msip_label_76546daa-41b6-470c-bb85-f6f40f044d7f_contentbits: 0
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Oak.Zeng@amd.com; 
x-originating-ip: [99.228.101.96]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 17e38e11-20a1-4fc4-bd30-08d7ab1b5c96
x-ms-traffictypediagnostic: BL0PR12MB2452:|BL0PR12MB2452:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR12MB2452B10191654D51C0733ED2801D0@BL0PR12MB2452.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10001)(10009020)(4636009)(396003)(376002)(346002)(136003)(39860400002)(366004)(199004)(189003)(81166006)(186003)(8936002)(8676002)(81156014)(6636002)(966005)(478600001)(2906002)(9686003)(55016002)(45080400002)(7696005)(5660300002)(52536014)(64756008)(66476007)(66446008)(86362001)(26005)(66556008)(30864003)(71200400001)(6506007)(53546011)(76116006)(33656002)(66946007)(316002)(54906003)(4326008)(110136005);
 DIR:OUT; SFP:1101; SCL:1; SRVR:BL0PR12MB2452;
 H:BL0PR12MB2580.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CyNX8X2pmIL55xCeWx5ndHd1yEAgJiWL1oqUMUyG3FwQDRhQv3AaXRlW5sRKHzuTNv6XbQ5C3aB8BjHov+9TY8sInxUUV3Wnzih4FBMmBtoNEPzTdGKJxaCzAjHCQaBF1wCoIpnBZW1PMC5OzNXVA0TUQpOGdaZ5qqWBz/9gR0zJDS4JTRXNwQlcaEuwW1rAHUJ+YBrTsa8ru/DM1gKQlzcDEnvarBIWZJI+wvNrfmNGj18JHfgIR5+PbmOZMp49hJcC2aUPF1fsYnAucIFBw2y0PEjpW49+OWw5glGX3PxuI0vBlebeaculBkbNHx+EpHnjoOd47Nm++wBZEhxuBSXOC9MoCXbg/Nz2LG5KUEhQtgZSK+ptVWjcDj/0tp0Sprq7GquKFNc5JoB5HctzTz1C98LLRG3NzEAur9tBvOHZXhE4I1JsFdTuo81J5MKOBxqih8vx0oIEVVFUo5/WWQRYJzOilQTRsvUQLrgUZFI/Zr0TPs1kUyzt72N93b3VcE8J47kmBfjYtQT6ulvqAj2JwJoXmMMSt4EIJk+x+4CExjYurh48l4rsl+WlR4HNCiPQhYb1c5xf27JL6StzkuIZXc9FwXajy3b3qvg0yiiges2i6ObOHkm/Pi4z6URl
x-ms-exchange-antispam-messagedata: Y9n0AyB+kAuxiN/dR0FtEmhy5/bKXPB6UQ0n81K+K1tct/Ky2cyukWUzUsrToOwmd+xk8q85hFmryviHo5BGrRLD9WU74q+h/UhGDiEyoZ+154zhLamCm1bAxZQpvVW4sEnt+ff7US/1R1iKmoPZ7w==
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17e38e11-20a1-4fc4-bd30-08d7ab1b5c96
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 15:43:50.0165 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9vtrDWFaW2FNrg+tuoL6Eh5em7vQwFp2B4fpX5GYCwJqwSKzY2oi9lDuKUDEM9C
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2452
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Bhardwaj,
 Rajneesh" <Rajneesh.Bhardwaj@amd.com>,
 amd-gfx list <amd-gfx@lists.freedesktop.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi Alex,

I am trying to understand why prevent runtime pm when xgmi is active. Is it because other device's accessing suspended device's HBM? Here is my understanding: after device is suspend, the DF and HBM will still be alive. So as long as the gL2 probing to device is disabled (this should be guaranteed by gL2 flush during suspend), other device should still be able to access HBM on the suspended device.  

Regards,
Oak

-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of Alex Deucher
Sent: Thursday, February 6, 2020 9:27 AM
To: Kuehling, Felix <Felix.Kuehling@amd.com>
Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Bhardwaj, Rajneesh <Rajneesh.Bhardwaj@amd.com>; amd-gfx list <amd-gfx@lists.freedesktop.org>
Subject: Re: [Patch v2 3/4] drm/amdkfd: refactor runtime pm for baco

On Tue, Feb 4, 2020 at 11:46 PM Alex Deucher <alexdeucher@gmail.com> wrote:
>
> On Tue, Feb 4, 2020 at 4:28 PM Felix Kuehling <felix.kuehling@amd.com> wrote:
> >
> > On 2020-01-31 10:37 p.m., Rajneesh Bhardwaj wrote:
> > > So far the kfd driver implemented same routines for runtime and 
> > > system wide suspend and resume (s2idle or mem). During system wide 
> > > suspend the kfd aquires an atomic lock that prevents any more user 
> > > processes to create queues and interact with kfd driver and amd 
> > > gpu. This mechanism created problem when amdgpu device is runtime 
> > > suspended with BACO enabled. Any application that relies on kfd 
> > > driver fails to load because the driver reports a locked kfd device since gpu is runtime suspended.
> > >
> > > However, in an ideal case, when gpu is runtime  suspended the kfd 
> > > driver should be able to:
> > >
> > >   - auto resume amdgpu driver whenever a client requests compute service
> > >   - prevent runtime suspend for amdgpu  while kfd is in use
> > >
> > > This change refactors the amdgpu and amdkfd drivers to support 
> > > BACO and runtime power management.
> > >
> > > Signed-off-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
> >
> > One small comment inline. Other than that patches 1-3 are
> >
> > Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
> >
> > Also, I believe patch 1 is unchanged from v1 and already got a 
> > Reviewed-by from Alex. Please remember to add that tag before you submit.
> >
> > The last patch that enabled runtime PM by default, I'd leave the 
> > decision to submit that up to Alex. There may be other 
> > considerations than just KFD.
>
> KFD was the only thing left.  I've been running with runpm forced on 
> for a while now with no problems across a wide variety of hardware.

Actually, we need to prevent runtime pm if xgmi is active.  One more thing to check.

Alex


>
> Alex
>
> >
> > See inline ...
> >
> >
> > > ---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c | 12 +++---
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h |  8 ++--
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 +-
> > >   drivers/gpu/drm/amd/amdkfd/kfd_device.c    | 29 +++++++++------
> > >   drivers/gpu/drm/amd/amdkfd/kfd_priv.h      |  1 +
> > >   drivers/gpu/drm/amd/amdkfd/kfd_process.c   | 43 ++++++++++++++++++++--
> > >   6 files changed, 70 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c 
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > > index 8609287620ea..314c4a2a0354 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> > > @@ -178,18 +178,18 @@ void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
> > >               kgd2kfd_interrupt(adev->kfd.dev, ih_ring_entry);
> > >   }
> > >
> > > -void amdgpu_amdkfd_suspend(struct amdgpu_device *adev)
> > > +void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool 
> > > +run_pm)
> > >   {
> > >       if (adev->kfd.dev)
> > > -             kgd2kfd_suspend(adev->kfd.dev);
> > > +             kgd2kfd_suspend(adev->kfd.dev, run_pm);
> > >   }
> > >
> > > -int amdgpu_amdkfd_resume(struct amdgpu_device *adev)
> > > +int amdgpu_amdkfd_resume(struct amdgpu_device *adev, bool run_pm)
> > >   {
> > >       int r = 0;
> > >
> > >       if (adev->kfd.dev)
> > > -             r = kgd2kfd_resume(adev->kfd.dev);
> > > +             r = kgd2kfd_resume(adev->kfd.dev, run_pm);
> > >
> > >       return r;
> > >   }
> > > @@ -713,11 +713,11 @@ void kgd2kfd_exit(void)
> > >   {
> > >   }
> > >
> > > -void kgd2kfd_suspend(struct kfd_dev *kfd)
> > > +void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
> > >   {
> > >   }
> > >
> > > -int kgd2kfd_resume(struct kfd_dev *kfd)
> > > +int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
> > >   {
> > >       return 0;
> > >   }
> > > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h 
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > > index 47b0f2957d1f..9e8db702d878 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
> > > @@ -122,8 +122,8 @@ struct amdkfd_process_info {
> > >   int amdgpu_amdkfd_init(void);
> > >   void amdgpu_amdkfd_fini(void);
> > >
> > > -void amdgpu_amdkfd_suspend(struct amdgpu_device *adev); -int 
> > > amdgpu_amdkfd_resume(struct amdgpu_device *adev);
> > > +void amdgpu_amdkfd_suspend(struct amdgpu_device *adev, bool 
> > > +run_pm); int amdgpu_amdkfd_resume(struct amdgpu_device *adev, 
> > > +bool run_pm);
> > >   void amdgpu_amdkfd_interrupt(struct amdgpu_device *adev,
> > >                       const void *ih_ring_entry);
> > >   void amdgpu_amdkfd_device_probe(struct amdgpu_device *adev); @@ 
> > > -249,8 +249,8 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
> > >                        struct drm_device *ddev,
> > >                        const struct kgd2kfd_shared_resources *gpu_resources);
> > >   void kgd2kfd_device_exit(struct kfd_dev *kfd); -void 
> > > kgd2kfd_suspend(struct kfd_dev *kfd); -int kgd2kfd_resume(struct 
> > > kfd_dev *kfd);
> > > +void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm); int 
> > > +kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm);
> > >   int kgd2kfd_pre_reset(struct kfd_dev *kfd);
> > >   int kgd2kfd_post_reset(struct kfd_dev *kfd);
> > >   void kgd2kfd_interrupt(struct kfd_dev *kfd, const void 
> > > *ih_ring_entry); diff --git 
> > > a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> > > b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > index 5030a09babb8..43843e6c4bcd 100644
> > > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > > @@ -3311,7 +3311,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
> > >               }
> > >       }
> > >
> > > -     amdgpu_amdkfd_suspend(adev);
> > > +     amdgpu_amdkfd_suspend(adev, !fbcon);
> > >
> > >       amdgpu_ras_suspend(adev);
> > >
> > > @@ -3395,7 +3395,7 @@ int amdgpu_device_resume(struct drm_device *dev, bool fbcon)
> > >                       }
> > >               }
> > >       }
> > > -     r = amdgpu_amdkfd_resume(adev);
> > > +     r = amdgpu_amdkfd_resume(adev, !fbcon);
> > >       if (r)
> > >               return r;
> > >
> > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device.c 
> > > b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > > index 798ad1c8f799..42ee9ea5c45a 100644
> > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device.c
> > > @@ -732,7 +732,7 @@ bool kgd2kfd_device_init(struct kfd_dev *kfd,
> > >   void kgd2kfd_device_exit(struct kfd_dev *kfd)
> > >   {
> > >       if (kfd->init_complete) {
> > > -             kgd2kfd_suspend(kfd);
> > > +             kgd2kfd_suspend(kfd, false);
> > >               device_queue_manager_uninit(kfd->dqm);
> > >               kfd_interrupt_exit(kfd);
> > >               kfd_topology_remove_device(kfd); @@ -753,7 +753,7 @@ 
> > > int kgd2kfd_pre_reset(struct kfd_dev *kfd)
> > >
> > >       kfd->dqm->ops.pre_reset(kfd->dqm);
> > >
> > > -     kgd2kfd_suspend(kfd);
> > > +     kgd2kfd_suspend(kfd, false);
> > >
> > >       kfd_signal_reset_event(kfd);
> > >       return 0;
> > > @@ -787,21 +787,23 @@ bool kfd_is_locked(void)
> > >       return  (atomic_read(&kfd_locked) > 0);
> > >   }
> > >
> > > -void kgd2kfd_suspend(struct kfd_dev *kfd)
> > > +void kgd2kfd_suspend(struct kfd_dev *kfd, bool run_pm)
> > >   {
> > >       if (!kfd->init_complete)
> > >               return;
> > >
> > > -     /* For first KFD device suspend all the KFD processes */
> > > -     if (atomic_inc_return(&kfd_locked) == 1)
> > > -             kfd_suspend_all_processes();
> > > +     /* for runtime suspend, skip locking kfd */
> > > +     if (!run_pm) {
> > > +             /* For first KFD device suspend all the KFD processes */
> > > +             if (atomic_inc_return(&kfd_locked) == 1)
> > > +                     kfd_suspend_all_processes();
> > > +     }
> > >
> > >       kfd->dqm->ops.stop(kfd->dqm);
> > > -
> > >       kfd_iommu_suspend(kfd);
> > >   }
> > >
> > > -int kgd2kfd_resume(struct kfd_dev *kfd)
> > > +int kgd2kfd_resume(struct kfd_dev *kfd, bool run_pm)
> > >   {
> > >       int ret, count;
> > >
> > > @@ -812,10 +814,13 @@ int kgd2kfd_resume(struct kfd_dev *kfd)
> > >       if (ret)
> > >               return ret;
> > >
> > > -     count = atomic_dec_return(&kfd_locked);
> > > -     WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
> > > -     if (count == 0)
> > > -             ret = kfd_resume_all_processes();
> > > +     /* for runtime resume, skip unlocking kfd */
> > > +     if (!run_pm) {
> > > +             count = atomic_dec_return(&kfd_locked);
> > > +             WARN_ONCE(count < 0, "KFD suspend / resume ref. error");
> > > +             if (count == 0)
> > > +                     ret = kfd_resume_all_processes();
> > > +     }
> > >
> > >       return ret;
> > >   }
> > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h 
> > > b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > > index c0b0defc8f7a..20dd4747250d 100644
> > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
> > > @@ -647,6 +647,7 @@ struct kfd_process_device {
> > >        * function.
> > >        */
> > >       bool already_dequeued;
> > > +     bool runtime_inuse;
> > >
> > >       /* Is this process/pasid bound to this device? (amd_iommu_bind_pasid) */
> > >       enum kfd_pdd_bound bound;
> > > diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
> > > b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > > index 25b90f70aecd..6907a5a2cbc8 100644
> > > --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > > +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
> > > @@ -31,6 +31,7 @@
> > >   #include <linux/compat.h>
> > >   #include <linux/mman.h>
> > >   #include <linux/file.h>
> > > +#include <linux/pm_runtime.h>
> > >   #include "amdgpu_amdkfd.h"
> > >   #include "amdgpu.h"
> > >
> > > @@ -440,6 +441,16 @@ static void kfd_process_destroy_pdds(struct kfd_process *p)
> > >               kfree(pdd->qpd.doorbell_bitmap);
> > >               idr_destroy(&pdd->alloc_idr);
> > >
> > > +             /*
> > > +              * before destroying pdd, make sure to report availability
> > > +              * for auto suspend
> > > +              */
> > > +             if (pdd->runtime_inuse) {
> > > +                     pm_runtime_mark_last_busy(pdd->dev->ddev->dev);
> > > +                     pm_runtime_put_autosuspend(pdd->dev->ddev->dev);
> > > +                     pdd->runtime_inuse = false;
> > > +             }
> > > +
> > >               kfree(pdd);
> > >       }
> > >   }
> > > @@ -754,6 +765,7 @@ struct kfd_process_device *kfd_create_process_device_data(struct kfd_dev *dev,
> > >       pdd->process = p;
> > >       pdd->bound = PDD_UNBOUND;
> > >       pdd->already_dequeued = false;
> > > +     pdd->runtime_inuse = false;
> > >       list_add(&pdd->per_device_list, &p->per_device_data);
> > >
> > >       /* Init idr used for memory handle translation */ @@ -843,15 
> > > +855,40 @@ struct kfd_process_device *kfd_bind_process_to_device(struct kfd_dev *dev,
> > >               return ERR_PTR(-ENOMEM);
> > >       }
> > >
> > > +     /*
> > > +      * signal runtime-pm system to auto resume and prevent
> > > +      * further runtime suspend once device pdd is created until
> > > +      * pdd is destroyed.
> > > +      */
> > > +     if (!pdd->runtime_inuse) {
> > > +             err = pm_runtime_get_sync(dev->ddev->dev);
> > > +             if (err < 0)
> > > +                     return ERR_PTR(err);
> > > +     }
> > > +
> > >       err = kfd_iommu_bind_process_to_device(pdd);
> > >       if (err)
> > > -             return ERR_PTR(err);
> > > +             goto out;
> > >
> > >       err = kfd_process_device_init_vm(pdd, NULL);
> > >       if (err)
> > > -             return ERR_PTR(err);
> > > +             goto out;
> > >
> > > -     return pdd;
> > > +     if (!err) {
> > > +             /*
> > > +              * make sure that runtime_usage counter is incremented
> > > +              * just once per pdd
> > > +              */
> > > +             if (!pdd->runtime_inuse)
> > > +                     pdd->runtime_inuse = true;
> >
> > The "if" is redundant here. You can just set pdd->runtime_inuse = 
> > true unconditionally.
> >
> > Regards,
> >    Felix
> >
> > > +
> > > +             return pdd;
> > > +     }
> > > +out:
> > > +     /* balance runpm reference count and exit with error */
> > > +     pm_runtime_mark_last_busy(dev->ddev->dev);
> > > +     pm_runtime_put_autosuspend(dev->ddev->dev);
> > > +     return ERR_PTR(err);
> > >   }
> > >
> > >   struct kfd_process_device *kfd_get_first_process_device_data(
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fli
> > sts.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%
> > 7Coak.zeng%40amd.com%7Cd5179ff2709543f0871008d7ab10b0b7%7C3dd8961fe4
> > 884e608e11a82d994e183d%7C0%7C0%7C637165960494222799&amp;sdata=YVNSWu
> > 0FM92F0wiMQE70TcNvOmjUiw3kkO%2ByQik2Mmw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Coak.zeng%40amd.com%7Cd5179ff2709543f0871008d7ab10b0b7%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637165960494222799&amp;sdata=YVNSWu0FM92F0wiMQE70TcNvOmjUiw3kkO%2ByQik2Mmw%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
