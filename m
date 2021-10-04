Return-Path: <SRS0=otPk=OY=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DDDC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 16:56:49 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B8FB61222
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Oct 2021 16:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8B8FB61222
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E098B6E1CF;
	Mon,  4 Oct 2021 16:56:48 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2079.outbound.protection.outlook.com [40.107.94.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 545316E1CF
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Oct 2021 16:56:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=coD/PI9Jl4LgaEZ+3Aw98lT2cbDFU5ZM/fv9qYf6BH16NBTxbD+uN0/i91ivs/2qU/Ru5xRYu1Fvt5+NjupNovxDBoRzGYCnyz43U92+a3QXf86PIl6ZgfGDu7g5r6aFG/6HEGOi1L/ABxtoGoI47WJMeOFJKmVmOikSGn1DA5JkRFHWm/TJ77R66RRIq/9+bxms6BppR8ZbiwRw5kHOSixd8e/dn4VLNIU5LsD9rycAIYDkG3h6P5FCwVlP/dv7/pS6byFMgB1fnXhTKAV+L7weIfBQ7NpO6A0Q/u8qBddvG52B7tEtt1bPJCHYEMURn/NyXLSjYUKqNEePxxJBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9yjYXky2OFBbveZux2amMz0VyXdFR1l6trJYVwEgno8=;
 b=P8R/ddrJRL2JX1ad2gCDrzpmoOblxt5lXHAWcQPQd7oMcqUFEu/TS/pDnEfMab6xHKyBNsSeARKvruie+xVwIzNcdtvm329cS0hUNRjfzunUM7AcZr+a24+URmwaq/RP5GIdYBFFlrfjLDGvxP93VJOBQ8zrvyAODPIEFbFBiqzTtqoK4RhYd6XAODSb/elYjSurxj4R3GfnsGlsGj1hsUzHcyV7+4djMyJyzIUtl+roHi+gCdlp6/qByjDyXNpNOVGttGR2DEvfpMOt5pSdjZs2yjFUrWwm3AyyT49pzrsTgBJ9DjAnVv8s7WvLZa2ZolbNHA5wEwNiaSxgk26xWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9yjYXky2OFBbveZux2amMz0VyXdFR1l6trJYVwEgno8=;
 b=YF0why1RFCuo5XrAJwpl9MbmfL9wM6LzdU/unu0pXOTjoTM02kbUYGVl/g2uhhtb1ST/ofCflN1kVDy1UpZVXZRWuKPj2gEZ5c46VO/sOtuVsS3dtllaMvZ9281E3vXWXh4W1UqCqYSLRs5IOXCNugpDuFEdVlga34yYK8csNck=
Received: from DM5PR12MB1884.namprd12.prod.outlook.com (2603:10b6:3:10d::12)
 by DM5PR1201MB2489.namprd12.prod.outlook.com (2603:10b6:3:e2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.22; Mon, 4 Oct
 2021 16:56:45 +0000
Received: from DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d054:bfe9:a655:d24b]) by DM5PR12MB1884.namprd12.prod.outlook.com
 ([fe80::d054:bfe9:a655:d24b%7]) with mapi id 15.20.4566.022; Mon, 4 Oct 2021
 16:56:45 +0000
From: "Zhu, James" <James.Zhu@amd.com>
To: "Kuehling, Felix" <Felix.Kuehling@amd.com>, "Zhang, Yifan"
 <Yifan1.Zhang@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init
Thread-Topic: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init
Thread-Index: AQHXtELezSsynhy0+UWRMSPpBG62Q6u5ljSAgAFpn4WAB5/wAIAAWL0AgAAfOXw=
Date: Mon, 4 Oct 2021 16:56:45 +0000
Message-ID: <DM5PR12MB18844E4563122422AC0618ABE4AE9@DM5PR12MB1884.namprd12.prod.outlook.com>
References: <20210928082819.205231-1-yifan1.zhang@amd.com>
 <20210928082819.205231-2-yifan1.zhang@amd.com>
 <11cc6ad8-5c08-6846-930b-f935c1e29936@amd.com>
 <DM5PR12MB18849F60DEE73D7FB8E20017E4A99@DM5PR12MB1884.namprd12.prod.outlook.com>
 <BN6PR12MB11875C3AC679F399E01C5D12C1AE9@BN6PR12MB1187.namprd12.prod.outlook.com>
 <58199fef-3e27-4c18-07cc-a8d4fe8d0b29@amd.com>
In-Reply-To: <58199fef-3e27-4c18-07cc-a8d4fe8d0b29@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Enabled=True;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_SetDate=2021-10-04T16:56:44.647Z;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Name=AMD
 Official Use
 Only; MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_ContentBits=0;
 MSIP_Label_88914ebd-7e6c-4e12-a031-a9906be2db14_Method=Standard; 
suggested_attachment_session_id: dc8992d3-29d3-a8f1-dd2e-053d1e45e6a1
authentication-results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96f4c64f-5bc3-464f-1300-08d98757f2c7
x-ms-traffictypediagnostic: DM5PR1201MB2489:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR1201MB248941C9FA0B047E2B1E1133E4AE9@DM5PR1201MB2489.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C3mZarbWiuX1GjA1KFgsd1Gy17qEHaNxHY+vvo1Ai0Y4zExl81YYT7ADKlIwl+1V8bYlLv/Z2NJI3d0RG29Ns1WHpJl3GSL2xSH0/InOvlMaTKPr4r/vOXMrjq6vumJw+8Ql3wQEqLRre/m5aXBqBpDWDcio1EjVofnhGgiATD2Pojgjz3mlsOvOuqhdkFyi9ZKCiXhXPUaZct2bxPWGVhPMZQx0TNAsT7BmNpxUc4xXaCbWp65XEpO+MCvsafgTEMvip1g5SZZqcR8k7hH0h67X0JsUohP5zu0Z6Mq88sYiLBiuyuPaTiRocdxfr/X802dK/jtLMEQg5XlMf22OAIYbarUFkxVbF4on+deivOtX/9sh3gyHPYTiShKERbvMrBhRnuqoyMBrhYPb8IlsIuLTOKiltUqigVneR4jFIlsvkdliiucSi8dgvDzGizjR+WxctzUiIFz9KmHm84UL3xfxvlWf1SxLxiXFQP9qdeNmQEb1vm7ru/NzdGECEacFXOU/ewvkGYUTx2sx9AgKkj4Sueg+Tu+m6HgCwmUD0KpZd5gB5N/wWBN9IyJVwh1iPSBSmtRMeo0G69EqRKe7dRtZeV1tO77GwOyCJmTn/icqabee1Rbz0XOIYkNbI8Ud68EsVryCsNsULOJnV6tybws42HXLJEjUH3gpjPTzddIQN7ZKpPQ3EiVOJPn8eU9BX4n58yeREbOY1lpHezZl+g==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR12MB1884.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(122000001)(9686003)(316002)(8936002)(110136005)(19627405001)(86362001)(38070700005)(33656002)(53546011)(38100700002)(6506007)(8676002)(55016002)(66946007)(52536014)(64756008)(66446008)(5660300002)(91956017)(186003)(66556008)(71200400001)(76116006)(7696005)(26005)(83380400001)(66476007)(2906002)(508600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lIMSEwD/7QL4sjly/VIDpwc2CDmjkFuhMAdD1EepBXlyO3DD7OGSSJz1a9UP?=
 =?us-ascii?Q?xi8+kwx/g4161EZaWHGXprwxm95OQMTyHuahhe8fdRWjqGkmJU9ughhi9lPH?=
 =?us-ascii?Q?/x7yyfWdsPsFJavdDEM7ISrCVfC/hlgrkAXDFag/3qyDhXTM2Aaj+PG3QZeJ?=
 =?us-ascii?Q?ZHiTAIfBHUl/BgjpZzl+zc6UAPzDSufVMKBzgNoZpRkwY/Z2/hjtXTvttN+x?=
 =?us-ascii?Q?XPezyEjmz4YQBGS1/vIY8wxMK1KDtSinswNikexO8BPkji3UY6OAvj1NIiPO?=
 =?us-ascii?Q?LtkIc4W871ROGkPKNJoldBYGFgSDB0Z+orgVFc1gHcvShgOrUKtwj+9SZixd?=
 =?us-ascii?Q?XrPcS+oPx3jLP8ydRNuzRsyXLXPjLDbPMM6vz3yAas4yFvgObBAbH76CcYn7?=
 =?us-ascii?Q?o/UkZmz29DHdAIVBMT5XuHA7qax/uUt1lH7AcfPwAtAOP0ruLzYGnF+WusCg?=
 =?us-ascii?Q?t4pDaJnH4L0lYJrhZcMQhR2MTbxOU/JSNDJjdNXw3gNFJ11xrhZzE0qoGytD?=
 =?us-ascii?Q?wAa+qx5aXu4obZ/tNInIKNPinrX72nTWmbCP618QaRhaZAo9DNq5srIwtFOz?=
 =?us-ascii?Q?168FrRyfPcyI18oun9PxC9CBu0qlYhTq1I4O0AKkqWpETw5TStwczWpHBJXS?=
 =?us-ascii?Q?3oWIKloe6QOUHEhmF78Gu8eLARNkBCr9ZeDNJRVa6dZTganTQs+lksZHgpGW?=
 =?us-ascii?Q?o0BruYSCdMbpubOLmvm1tObml+0ZR0GjD8VpDyyQ0cEweSWtOnDVZ1qwPjwD?=
 =?us-ascii?Q?74cee7XpbHZHaFbi5rySKXFjWE9cYVRdJLSNdzJXID8LRkeyCEwofS44BvZa?=
 =?us-ascii?Q?E+F8zoAxqcqKoLxm3agMfY12QWmiDySdPTwmvrQmF2qkqKQA8tkjRr0Ifx9F?=
 =?us-ascii?Q?sXEXu8ml0xNUwcFwHGE+oDCXIfXs9FqEpVzt6Q0jYz0WgkLQGYxRhi/DrBCv?=
 =?us-ascii?Q?zONS6inhfDHhj+PlFVfuT3TBf2S7SiJ8A7vKU+aPXTV4jpysgCmX3CdRfD0w?=
 =?us-ascii?Q?xKItRKwDGJTmKfj0XfZc9JDk2akOa2WqrO4hJrUSYNZussA5sUEIJJycdeal?=
 =?us-ascii?Q?j4z7dY9IgzhIW/MaEKJSOWzRAK6teuHyJNf91as8dE8QGJcERGfkRe8SCK7V?=
 =?us-ascii?Q?n3hM1Z1lOb7BsNCQ1GiuzEteFVSKK7FbBxv0l5EOORa1E2qJJ5B389YawSZW?=
 =?us-ascii?Q?gWOHll/uNN7HVlmkMKlY9TCPFo9wilaMtmYc897smxP7hz0Iheeb7MhMqL1i?=
 =?us-ascii?Q?Qk9FEvij7RGhyRQBM8ZeNsG4ed0TpkBQOZG41ojjziHaGKf5UU5K93H/Sccr?=
 =?us-ascii?Q?UVz2qnM0WOBbjqlJUbev69Pl?=
Content-Type: multipart/alternative;
 boundary="_000_DM5PR12MB18844E4563122422AC0618ABE4AE9DM5PR12MB1884namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB1884.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96f4c64f-5bc3-464f-1300-08d98757f2c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Oct 2021 16:56:45.3183 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IX9qzRkuj5D9FyVXZVOH5SB7wkObLjIE5jxH1pLko2ZhSpZTefj9UkeqoDLz+JYq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2489
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

--_000_DM5PR12MB18844E4563122422AC0618ABE4AE9DM5PR12MB1884namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only]

Hi Flelix,

I have tested YiFan's patch and pco s3 test can pass.

The original s3 issue always occurred on resume, And YiFan's patches
are only related to initialization.

Hi YiFan,

Reviewed-by: James Zhu <James.Zhu@amd.com> for the series

Tested-by: James Zhu <James.Zhu@amd.com> for the series



Thanks & Best Regards!


James Zhu

________________________________
From: Kuehling, Felix <Felix.Kuehling@amd.com>
Sent: Monday, October 4, 2021 11:00 AM
To: Zhang, Yifan <Yifan1.Zhang@amd.com>; Zhu, James <James.Zhu@amd.com>; am=
d-gfx@lists.freedesktop.org <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device init

I'm trying to understand what the end result is after James' and your
patches. If I'm reading it correctly, we now initialize IOMMUv2 after
kfd_device_init during initialization, but before kfd_device_init during
resume from S3. Is  that the correct understanding?

My concern is, that we may run into related problems again if the root
cause and the mechanism of the fix are poorly understood. Do you have an
explanation why this different sequence is needed during init and resume?

That said, given that your patches are tested and reviewed by James, you
can add my Acked-by to both patches. The series is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>

Thanks,
  Felix


Am 2021-10-04 um 5:42 a.m. schrieb Zhang, Yifan:
>
> [AMD Official Use Only]
>
>
>
> Hi Felix,
>
>
>
> After sync w/ James, we agree that this patch series could fix both
> our problems, and he verified this patch series will not cause
> regression of his previous issue. Do you have more comments regarding
> this patch series ? Thanks.
>
>
>
> BRs,
>
> Yifan
>
>
>
> *From:* Zhu, James <James.Zhu@amd.com>
> *Sent:* Wednesday, September 29, 2021 9:19 PM
> *To:* Kuehling, Felix <Felix.Kuehling@amd.com>; Zhang, Yifan
> <Yifan1.Zhang@amd.com>; amd-gfx@lists.freedesktop.org
> *Subject:* Re: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device ini=
t
>
>
>
> [AMD Official Use Only]
>
>
>
> H Felix,
>
>
>
> Since the previous patch can help on PCO suspend/resume hung issue.
> Let me work with YiFan to see if
>
> there is proper way to cover both cases.
>
>
>
> Thanks & Best Regards!
>
>
>
> James Zhu
>
> ------------------------------------------------------------------------
>
> *From:*Kuehling, Felix <Felix.Kuehling@amd.com
> <mailto:Felix.Kuehling@amd.com>>
> *Sent:* Tuesday, September 28, 2021 11:41 AM
> *To:* Zhang, Yifan <Yifan1.Zhang@amd.com
> <mailto:Yifan1.Zhang@amd.com>>; amd-gfx@lists.freedesktop.org
> <mailto:amd-gfx@lists.freedesktop.org> <amd-gfx@lists.freedesktop.org
> <mailto:amd-gfx@lists.freedesktop.org>>; Zhu, James <James.Zhu@amd.com
> <mailto:James.Zhu@amd.com>>
> *Subject:* Re: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device
> init
>
>
>
> [+James]
>
> This basically undoes James's change "drm/amdgpu: move iommu_resume
> before ip init/resume". I assume James made his change for a reason. Can
> you please discuss the issue with him and determine a solution that
> solves both your problem and his?
>
> If James' patch series was a mistake, I'd prefer to revert his patches,
> because his patches complicated the initialization sequence and exposed
> the iommu init sequence in amdgpu.
>
> Thanks,
>   Felix
>
>
> Am 2021-09-28 um 4:28 a.m. schrieb Yifan Zhang:
> > This patch is to fix clinfo failure in Raven/Picasso:
> >
> > Number of platforms: 1
> >   Platform Profile: FULL_PROFILE
> >   Platform Version: OpenCL 2.2 AMD-APP (3364.0)
> >   Platform Name: AMD Accelerated Parallel Processing
> >   Platform Vendor: Advanced Micro Devices, Inc.
> >   Platform Extensions: cl_khr_icd cl_amd_event_callback
> >
> >   Platform Name: AMD Accelerated Parallel Processing Number of
> devices: 0
> >
> > Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com
> <mailto:yifan1.zhang@amd.com>>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > index 4c8f2f4647c0..89ed9b091386 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> > @@ -2393,10 +2393,6 @@ static int amdgpu_device_ip_init(struct
> amdgpu_device *adev)
> >        if (r)
> >                goto init_failed;
> >
> > -     r =3D amdgpu_amdkfd_resume_iommu(adev);
> > -     if (r)
> > -             goto init_failed;
> > -
> >        r =3D amdgpu_device_ip_hw_init_phase1(adev);
> >        if (r)
> >                goto init_failed;
> > @@ -2435,6 +2431,10 @@ static int amdgpu_device_ip_init(struct
> amdgpu_device *adev)
> >        if (!adev->gmc.xgmi.pending_reset)
> >                amdgpu_amdkfd_device_init(adev);
> >
> > +     r =3D amdgpu_amdkfd_resume_iommu(adev);
> > +     if (r)
> > +             goto init_failed;
> > +
> >        amdgpu_fru_get_product_info(adev);
> >
> >  init_failed:
>

--_000_DM5PR12MB18844E4563122422AC0618ABE4AE9DM5PR12MB1884namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;" ali=
gn=3D"Left">
[AMD Official Use Only]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi Flelix,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
I have tested YiFan's patch and pco s3 test can pass.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
The original s3 issue always occurred on resume, And YiFan's patches</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
are only related to initialization.</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Hi YiFan,</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
Reviewed-by:<span style=3D"color:#c0c0c0"> </span>James<span style=3D"color=
:#c0c0c0">
</span>Zhu<span style=3D"color:#c0c0c0"> </span>&lt;James.Zhu@amd.com&gt;<s=
pan style=3D"color:#c0c0c0">
</span><span style=3D"color:#ff9d04">for</span><span style=3D"color:#c0c0c0=
"> </span>
the<span style=3D"color:#c0c0c0"> </span>series
<pre style=3D"margin-top:0px;margin-bottom:0px">Tested-by:<span style=3D"co=
lor:#c0c0c0">&nbsp;</span>James<span style=3D"color:#c0c0c0">&nbsp;</span>Z=
hu<span style=3D"color:#c0c0c0">&nbsp;</span>&lt;James.Zhu@amd.com&gt;<span=
 style=3D"color:#c0c0c0">&nbsp;</span><span style=3D"color:#ff9d04">for</sp=
an><span style=3D"color:#c0c0c0">&nbsp;</span>the<span style=3D"color:#c0c0=
c0">&nbsp;</span>series</pre>
<br>
</div>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 12pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div id=3D"divtagdefaultwrapper" dir=3D"ltr" style=3D"font-size:12pt; color=
:#000000; font-family:Calibri,Arial,Helvetica,sans-serif">
<p style=3D"margin-top: 0px; margin-bottom: 0px;">Thanks &amp; Best Regards=
!</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;"><br>
</p>
<p style=3D"margin-top: 0px; margin-bottom: 0px;">James Zhu<br>
</p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Kuehling, Felix &lt;F=
elix.Kuehling@amd.com&gt;<br>
<b>Sent:</b> Monday, October 4, 2021 11:00 AM<br>
<b>To:</b> Zhang, Yifan &lt;Yifan1.Zhang@amd.com&gt;; Zhu, James &lt;James.=
Zhu@amd.com&gt;; amd-gfx@lists.freedesktop.org &lt;amd-gfx@lists.freedeskto=
p.org&gt;<br>
<b>Subject:</b> Re: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device =
init</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">I'm trying to understand what the end result is af=
ter James' and your<br>
patches. If I'm reading it correctly, we now initialize IOMMUv2 after<br>
kfd_device_init during initialization, but before kfd_device_init during<br=
>
resume from S3. Is&nbsp; that the correct understanding?<br>
<br>
My concern is, that we may run into related problems again if the root<br>
cause and the mechanism of the fix are poorly understood. Do you have an<br=
>
explanation why this different sequence is needed during init and resume?<b=
r>
<br>
That said, given that your patches are tested and reviewed by James, you<br=
>
can add my Acked-by to both patches. The series is<br>
<br>
Acked-by: Felix Kuehling &lt;Felix.Kuehling@amd.com&gt;<br>
<br>
Thanks,<br>
&nbsp; Felix<br>
<br>
<br>
Am 2021-10-04 um 5:42 a.m. schrieb Zhang, Yifan:<br>
&gt;<br>
&gt; [AMD Official Use Only]<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; Hi Felix,<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; After sync w/ James, we agree that this patch series could fix both<br=
>
&gt; our problems, and he verified this patch series will not cause<br>
&gt; regression of his previous issue. Do you have more comments regarding<=
br>
&gt; this patch series ? Thanks.<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; BRs,<br>
&gt;<br>
&gt; Yifan<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; *From:* Zhu, James &lt;James.Zhu@amd.com&gt;<br>
&gt; *Sent:* Wednesday, September 29, 2021 9:19 PM<br>
&gt; *To:* Kuehling, Felix &lt;Felix.Kuehling@amd.com&gt;; Zhang, Yifan<br>
&gt; &lt;Yifan1.Zhang@amd.com&gt;; amd-gfx@lists.freedesktop.org<br>
&gt; *Subject:* Re: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device =
init<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; [AMD Official Use Only]<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; H Felix,<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; Since the previous patch can help on PCO suspend/resume hung issue.<br=
>
&gt; Let me work with YiFan to see if<br>
&gt;<br>
&gt; there is proper way to cover both cases.<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; Thanks &amp; Best Regards!<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; James Zhu<br>
&gt;<br>
&gt; ----------------------------------------------------------------------=
--<br>
&gt;<br>
&gt; *From:*Kuehling, Felix &lt;Felix.Kuehling@amd.com<br>
&gt; &lt;<a href=3D"mailto:Felix.Kuehling@amd.com">mailto:Felix.Kuehling@am=
d.com</a>&gt;&gt;<br>
&gt; *Sent:* Tuesday, September 28, 2021 11:41 AM<br>
&gt; *To:* Zhang, Yifan &lt;Yifan1.Zhang@amd.com<br>
&gt; &lt;<a href=3D"mailto:Yifan1.Zhang@amd.com">mailto:Yifan1.Zhang@amd.co=
m</a>&gt;&gt;; amd-gfx@lists.freedesktop.org<br>
&gt; &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">mailto:amd-gfx@li=
sts.freedesktop.org</a>&gt; &lt;amd-gfx@lists.freedesktop.org<br>
&gt; &lt;<a href=3D"mailto:amd-gfx@lists.freedesktop.org">mailto:amd-gfx@li=
sts.freedesktop.org</a>&gt;&gt;; Zhu, James &lt;James.Zhu@amd.com<br>
&gt; &lt;<a href=3D"mailto:James.Zhu@amd.com">mailto:James.Zhu@amd.com</a>&=
gt;&gt;<br>
&gt; *Subject:* Re: [PATCH 2/2] drm/amdgpu: init iommu after amdkfd device<=
br>
&gt; init<br>
&gt;<br>
&gt; &nbsp;<br>
&gt;<br>
&gt; [+James]<br>
&gt;<br>
&gt; This basically undoes James's change &quot;drm/amdgpu: move iommu_resu=
me<br>
&gt; before ip init/resume&quot;. I assume James made his change for a reas=
on. Can<br>
&gt; you please discuss the issue with him and determine a solution that<br=
>
&gt; solves both your problem and his?<br>
&gt;<br>
&gt; If James' patch series was a mistake, I'd prefer to revert his patches=
,<br>
&gt; because his patches complicated the initialization sequence and expose=
d<br>
&gt; the iommu init sequence in amdgpu.<br>
&gt;<br>
&gt; Thanks,<br>
&gt; &nbsp; Felix<br>
&gt;<br>
&gt;<br>
&gt; Am 2021-09-28 um 4:28 a.m. schrieb Yifan Zhang:<br>
&gt; &gt; This patch is to fix clinfo failure in Raven/Picasso:<br>
&gt; &gt;<br>
&gt; &gt; Number of platforms: 1<br>
&gt; &gt;&nbsp;&nbsp; Platform Profile: FULL_PROFILE<br>
&gt; &gt;&nbsp;&nbsp; Platform Version: OpenCL 2.2 AMD-APP (3364.0)<br>
&gt; &gt;&nbsp;&nbsp; Platform Name: AMD Accelerated Parallel Processing<br=
>
&gt; &gt;&nbsp;&nbsp; Platform Vendor: Advanced Micro Devices, Inc.<br>
&gt; &gt;&nbsp;&nbsp; Platform Extensions: cl_khr_icd cl_amd_event_callback=
<br>
&gt; &gt;<br>
&gt; &gt;&nbsp;&nbsp; Platform Name: AMD Accelerated Parallel Processing Nu=
mber of<br>
&gt; devices: 0<br>
&gt; &gt;<br>
&gt; &gt; Signed-off-by: Yifan Zhang &lt;yifan1.zhang@amd.com<br>
&gt; &lt;<a href=3D"mailto:yifan1.zhang@amd.com">mailto:yifan1.zhang@amd.co=
m</a>&gt;&gt;<br>
&gt; &gt; ---<br>
&gt; &gt;&nbsp; drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 8 ++++----<br>
&gt; &gt;&nbsp; 1 file changed, 4 insertions(+), 4 deletions(-)<br>
&gt; &gt;<br>
&gt; &gt; diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; index 4c8f2f4647c0..89ed9b091386 100644<br>
&gt; &gt; --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c<br>
&gt; &gt; @@ -2393,10 +2393,6 @@ static int amdgpu_device_ip_init(struct<br=
>
&gt; amdgpu_device *adev)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; goto init_failed;<br>
&gt; &gt;&nbsp;<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_amdkfd_resume_iommu(adev);=
<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &gt; -&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; goto init_failed;<br>
&gt; &gt; -<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_device_ip_=
hw_init_phase1(adev);<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; goto init_failed;<br>
&gt; &gt; @@ -2435,6 +2431,10 @@ static int amdgpu_device_ip_init(struct<br=
>
&gt; amdgpu_device *adev)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (!adev-&gt;gmc.xgmi.=
pending_reset)<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_amdkfd_device_init(adev);<br>
&gt; &gt;&nbsp;<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; r =3D amdgpu_amdkfd_resume_iommu(adev);=
<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp; if (r)<br>
&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; goto init_failed;<br>
&gt; &gt; +<br>
&gt; &gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; amdgpu_fru_get_product_=
info(adev);<br>
&gt; &gt;&nbsp;<br>
&gt; &gt;&nbsp; init_failed:<br>
&gt;<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_DM5PR12MB18844E4563122422AC0618ABE4AE9DM5PR12MB1884namp_--
