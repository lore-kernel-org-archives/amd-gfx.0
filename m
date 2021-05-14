Return-Path: <SRS0=oeKV=KJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DBCC433B4
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 06:14:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BDF261185
	for <amd-gfx@archiver.kernel.org>; Fri, 14 May 2021 06:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BDF261185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4EF96E1B1;
	Fri, 14 May 2021 06:14:20 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2077.outbound.protection.outlook.com [40.107.243.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 212986E1B1
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 May 2021 06:14:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6TcVMc2OtPJW2QJtyu926ExPJgcp2VarDQBgR9IMSgyO5mPc5xZZLzbNdwug6LqhxXLm2Yehjs8GNEUKlhDLeSFznnQL0i03SIf/OMobKRS7ZWhufxWefoOL9CcVyjy8yTfUKwrkm/4asDyyvBN0ZtokbgUs6N+P1phYyZUlOYvk50j4c9RVYbhFMAqhATUcrJeX32WGpd6KwtZz2YdlkhwTrDA3/Sl9vI1g1RIp9E24I5Vp+FHp/B8XmupW+sk+6xkq7mnsqQQaNPud0gVXhut7pZIfCq8p3KOZi1/qEFAaTgqlLV2yTFSCPRU4RUqTCBXTRAenE/Iw2JogYDBYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qof4mAo3qab3ApebsZhGPVNHDZAV9tYyVo6iRZRxYXM=;
 b=ajWjMB3TL2GTUPiaLOyzqSF08MNxO6VSOmck0Jc4VNed2ONy3Y3tORCPSrs85Cyj4ZNaq0Ht0pX7pL8BFHWjY2JWFAzWNzJe6hqcP/Aw0yxxZ1ql8LrkEC06XHsUxxdhKWmnRMLf82C6VBpHpZGS50w1Y5EKRYVYBSJvPgLF8KxKLogOzWPLCTOGbFuSS24ZVHNARO5PM0leQY426qwhAYo8zimJ9rxwH2ZaxK/kC56ZbozYiP7QXhwgz2wmu3Xm8uGIxqcSqMIXgJN0AzGeduXAAG92XzRuVDZjktAY0NNfm5htLhcWEe99jz1121ALGv6wiejyX+QTy8OADb39Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qof4mAo3qab3ApebsZhGPVNHDZAV9tYyVo6iRZRxYXM=;
 b=1fDPzaF15nIKPxzzXFF6MsNiORwlC4bDUUQhsg6v5Hpb0vMy+5KKoAhyltCabNWi9MrcPhtQCoNv5Xv+TKFDRyAYW+LjibkezBPLSEISO+w/t6G/qOyW4cuk7Om7+DwQujTfsFtSw6B0pLLHs2U4eoznLhrzUDIc2im2d+DMXLo=
Received: from BN9PR12MB5161.namprd12.prod.outlook.com (2603:10b6:408:11a::15)
 by BN9PR12MB5098.namprd12.prod.outlook.com (2603:10b6:408:137::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4129.26; Fri, 14 May
 2021 06:14:16 +0000
Received: from BN9PR12MB5161.namprd12.prod.outlook.com
 ([fe80::13:8bca:807:9781]) by BN9PR12MB5161.namprd12.prod.outlook.com
 ([fe80::13:8bca:807:9781%7]) with mapi id 15.20.4129.026; Fri, 14 May 2021
 06:14:16 +0000
From: "Gu, JiaWei (Will)" <JiaWei.Gu@amd.com>
To: Alex Deucher <alexdeucher@gmail.com>
Subject: RE: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF msg
Thread-Topic: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF msg
Thread-Index: AQHXR8L16W5YG33TlkyouVsmvlLg0arhPsmwgAEGMWCAAA9LgIAAALhggAAOHoCAABwGsA==
Date: Fri, 14 May 2021 06:14:16 +0000
Message-ID: <BN9PR12MB51612AB4FA10D30C51A1240BF8509@BN9PR12MB5161.namprd12.prod.outlook.com>
References: <20210513064051.12930-1-Jiawei.Gu@amd.com>
 <CH0PR12MB51566C4310A9E3644BCAA9E0F8519@CH0PR12MB5156.namprd12.prod.outlook.com>
 <CH0PR12MB515669BD1D8D0402206D641BF8509@CH0PR12MB5156.namprd12.prod.outlook.com>
 <CADnq5_M6C7dNsWxNzJXeRWbMF10sT5BVcq-3S5bGvavM96pFcA@mail.gmail.com>
 <CH0PR12MB515632660C14957DC10353A4F8509@CH0PR12MB5156.namprd12.prod.outlook.com>
 <CADnq5_MVZmgn=J87bv4zSfHsMK5HSE-20cEPwpjc7PUSR_s9yQ@mail.gmail.com>
In-Reply-To: <CADnq5_MVZmgn=J87bv4zSfHsMK5HSE-20cEPwpjc7PUSR_s9yQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Enabled=true;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SetDate=2021-05-14T06:14:10Z; 
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Method=Standard;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_Name=Internal Use Only -
 Unrestricted;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ActionId=9ec3fcb0-0dd5-4414-b615-9b1f3a9749e0;
 MSIP_Label_76546daa-41b6-470c-bb85-f6f40f044d7f_ContentBits=1
msip_justification: I confirm the recipients are approved for sharing this
 content
authentication-results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=amd.com;
x-originating-ip: [165.204.134.244]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: af4da8c8-650c-4f6a-bc28-08d9169f80d5
x-ms-traffictypediagnostic: BN9PR12MB5098:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN9PR12MB5098EAAEECD42C1EBA9E6EFDF8509@BN9PR12MB5098.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zr1FjaFD5LvxMn0x5fZlku+tZc11NsVnIEPqsc7ikN1zig+vpc7K2sk4RdgGhfozS8mYS2hcQoxXnPKQ/ad1+jMZDsDFss7r97ozgXbfAZPsc2hUJdt1Ectc0qfAGSnu3R878Fy++jMrHnWYwgocVExVjGqbyARBeF4kMV//qHuaqugwHb0UOVyUyCYRNuke4DVzobVxiWyMm1jeRcVQk9PirSn74uVc9z1VsVeuvk5oBQ3jhp3IehnqPhwxM8yVpW/evx7vQ4PntqflBfMO1oCZa/Ddrb+e4coOpdFYOYalB50qjmKF5WUO8AjARC3Hr4iMfR5FSo0IRIkdVz6mSCX7+SdcuFBE9XrKIjUXvpg9nmyF+OHZObDQloVkLw/6jSSpq2XBh2VYs371qCzOSLtK68D7xUkB37qfXcRSUfKg7KyDB1Gy8/TNyXWiPiPFWHzx3FUQq0K5ZWNAXbMNg9xYvMqGHWDslYPq+/vKq22IGXUZtLX3/hpy5GNVv3o1sZz/eFzhiFEYU9ukq1a0dVU8BXfl+tG3HbKjMWDbHRfWce/Y7jvtB3WggSeDL+xMeTB7T/nmqAuxp6aguv4NHXF1bYZMnj7kR/MasbzEmylSW8ClK4VGOyJI7FxrNpQ4vSQysZMsRHZoQZ57TYw37RTrLfb/2LK8TW/RHR4JgvudpD+jZHnIIMBjlAWezyqK
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(136003)(376002)(39860400002)(366004)(346002)(9686003)(38100700002)(33656002)(55016002)(66946007)(66556008)(52536014)(66476007)(5660300002)(76116006)(66446008)(26005)(478600001)(966005)(6916009)(54906003)(316002)(8936002)(6506007)(53546011)(8676002)(2906002)(4326008)(122000001)(186003)(64756008)(45080400002)(86362001)(7696005)(71200400001)(84040400003)(83380400001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zvYUCBZdbATsoVuHawgf+AEmZkn1rDSsg6gEGXJdgJ0Cl7q82fdSl1vHYBfF?=
 =?us-ascii?Q?SylOEhF1tUS71Kp8MCLpN9odccw+TBV2e7NyByeRgebKSWz/bzKGrp47+td3?=
 =?us-ascii?Q?XQsNVdXCLkysVxMTQi0WB+KwHYmC40A8bMf/4dID8O/svz5F1nVzi4pW6Ski?=
 =?us-ascii?Q?kuNZM9eqe4Vic+DUKIPvUUCnkF8aVh0o8SfJGkN6nk5+W558l9pgw+8S87CJ?=
 =?us-ascii?Q?Wm/8F+gbehvdCR3ClRSwlgxQjwKxPwBmuhk+kL+oE1IwSr6mILJUlUFIuz6N?=
 =?us-ascii?Q?x/jSt4DpEwdl83Sdwa9kavEmrj8MCb55AmPQoWEluApdDQi4AGn8OykWqnf/?=
 =?us-ascii?Q?QPAj1ihgBgyOmAzvJVZ02JzNVERSio4KBrug57GgRm6+MGpHoyFPR0i8/H/1?=
 =?us-ascii?Q?OlqjW+CAbdl1czatnnwgNVq93lua769UrGtO9tD0ozwoN0gW/R34xsxx/ZD+?=
 =?us-ascii?Q?XjG2qPb4Y4M9Mf7Ya/36AedfhqufAKCSP4ahNC87GzgMTAN/49NBw5nnJU7S?=
 =?us-ascii?Q?drJeIm4OzdsudDMhF5vdTQ1rVVh31AZ1ouhwMN8DZw3lRj6ryXev+OOl1bCW?=
 =?us-ascii?Q?Bu8/ar3oYZ+QhtPuyuCH8rynNE9xDxnTh4isl2yLpnaFX9fjVTa7rEeNey0v?=
 =?us-ascii?Q?Jp/egGcjTQzp3psulPrUJxQj+q5iJeBXZpTbwK3yGWxMlf8YjR3RXH+a1uAB?=
 =?us-ascii?Q?vDIMiaH9EA74bcNpIfgx/Dv4JHd8dnpxmJ4om9MiDqeCGFHYv6SxYWK1jxUr?=
 =?us-ascii?Q?qxKot5KbF8k+UCM85zSHq+5E1Ec3wwCG8d6HUhgeQYGpV/X+lqlldHdeA8DC?=
 =?us-ascii?Q?LEJrGHLluIKm1SG5h72BNn9JGtS30EO8NAfGOWQZhkx40o4D6JNjLjBNwEKD?=
 =?us-ascii?Q?Qpr9i3EwcIGXukMcSEBVKo1WdQGFS6c2Y5lVjNHhbskNLMqmONlqTrUqh3Hd?=
 =?us-ascii?Q?MS6X310mswCJ/+kjUv3jubGCPJNoV9JXaZ5MBc6b6nSNYkZMj62NREZB+LAl?=
 =?us-ascii?Q?AwkMRcWM9FokC5WaonbVMYw8TTpmHzYxWIdEnplTWFrbfvpCDX4hFU2WkXz4?=
 =?us-ascii?Q?8AWaRIttWCUQk8o35NYzldU4fVrfeAEHdnb47hamNXJqDTofGDfzzHRFL5Zn?=
 =?us-ascii?Q?kFWsoRKd0uacxozUfncQptrIwAKNnxIEONBjeCofmO45FrjccKJlgA5gEx/T?=
 =?us-ascii?Q?W2xWBJlmObgT92oc04O7n68QytS/FlwMRHw6sUb1In1+AH+zu61/RdWC0Sdd?=
 =?us-ascii?Q?lIOCkW+EoIhpg7OllBHnAxujvYnm9yx0qhnbPTMRwiSKb3L5/M7IIqnOlr+n?=
 =?us-ascii?Q?3MIO0TG6FfCqwDaAjmTl7GXy?=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af4da8c8-650c-4f6a-bc28-08d9169f80d5
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 May 2021 06:14:16.5593 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ynecbPsfxPAnlU3XDPiJtFwd7tGEe9s1J5pgA7ZEs14+bzBn+irvWQgqnzv+7u8tAggZOWWHKeigNcNQN5K8Bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5098
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
Cc: "Deng, Emily" <Emily.Deng@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>, "Nieto, 
 David M" <David.Nieto@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[AMD Official Use Only - Internal Distribution Only]

Hi David,

Can you help double confirm that in design unique_id should always be fetched by PF2VF under SRIOV?
If so we can skip smu_get_unique_id() under SRIOV (though func is empty and nothing really happens) as Alex's suggestion.

Best regards,
Jiawei 

-----Original Message-----
From: Alex Deucher <alexdeucher@gmail.com> 
Sent: Friday, May 14, 2021 12:27 PM
To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
Cc: amd-gfx@lists.freedesktop.org; Nieto, David M <David.Nieto@amd.com>; Deng, Emily <Emily.Deng@amd.com>
Subject: Re: [PATCH] drm/amdgpu: Fill adev->unique_id with data from PF2VF msg

On Thu, May 13, 2021 at 11:47 PM Gu, JiaWei (Will) <JiaWei.Gu@amd.com> wrote:
>
> [AMD Official Use Only - Internal Distribution Only]
>
> Hi Alex,
>
> unique_id is fetched from FUSE_DATA on hypervisor.
>
> Under my experiment, both multi-VF & single VF can still read FUSE_DATA to get it.
> But per David's info, guest shouldn't be able to read it (though it can currently)...
>
> So I guess in design, the unique_id should be only fetched from hypervisor in SRIOV case, and guest should always get it from host.

thanks.  so does the patch also need something like this?

diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index 32dadeee9514..9243e5de5bb7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -686,7 +686,8 @@ static int smu_late_init(void *handle)
                return ret;
        }

-       smu_get_unique_id(smu);
+       if (!amdgpu_sriov_vf(adev))
+               smu_get_unique_id(smu);

        smu_get_fan_parameters(smu);

otherwise we fetch it twice.

Alex

>
> Hi David,
>
> Please feel free to correct my statement / provide more background.
>
> Best regards,
> Jiawei
>
> -----Original Message-----
> From: Alex Deucher <alexdeucher@gmail.com>
> Sent: Friday, May 14, 2021 11:33 AM
> To: Gu, JiaWei (Will) <JiaWei.Gu@amd.com>
> Cc: amd-gfx@lists.freedesktop.org; Nieto, David M 
> <David.Nieto@amd.com>; Deng, Emily <Emily.Deng@amd.com>
> Subject: Re: [PATCH] drm/amdgpu: Fill adev->unique_id with data from 
> PF2VF msg
>
> unique_id is normally fetched from the SMU on bare metal.  I guess in the SR-IOV case, this would come from the hypervisor since the SMU is not normally handled in the VF.  That makes sense for multi-VF, but what about single VF?  Are you sure the ordering is correct such that the SMU value won't overwrite this?  Maybe that's ok because they would be the same in that case?
>
> Alex
>
>
> On Thu, May 13, 2021 at 10:39 PM Gu, JiaWei (Will) <JiaWei.Gu@amd.com> wrote:
> >
> > [AMD Official Use Only - Internal Distribution Only]
> >
> > pinging
> >
> > -----Original Message-----
> > From: Gu, JiaWei (Will)
> > Sent: Thursday, May 13, 2021 7:01 PM
> > To: Jiawei Gu <Jiawei.Gu@amd.com>; amd-gfx@lists.freedesktop.org; 
> > Nieto, David M <David.Nieto@amd.com>
> > Cc: Deng, Emily <Emily.Deng@amd.com>
> > Subject: RE: [PATCH] drm/amdgpu: Fill adev->unique_id with data from 
> > PF2VF msg
> >
> > [AMD Official Use Only - Internal Distribution Only]
> >
> > Add David.
> >
> > -----Original Message-----
> > From: Jiawei Gu <Jiawei.Gu@amd.com>
> > Sent: Thursday, May 13, 2021 2:41 PM
> > To: amd-gfx@lists.freedesktop.org
> > Cc: Deng, Emily <Emily.Deng@amd.com>; Gu, JiaWei (Will) 
> > <JiaWei.Gu@amd.com>
> > Subject: [PATCH] drm/amdgpu: Fill adev->unique_id with data from 
> > PF2VF msg
> >
> > Initialize unique_id from PF2VF under virtualization.
> >
> > Signed-off-by: Jiawei Gu <Jiawei.Gu@amd.com>
> > ---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > index a57842689d42..96e269cbe326 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
> > @@ -471,6 +471,8 @@ static int amdgpu_virt_read_pf2vf_data(struct amdgpu_device *adev)
> >                         ((struct amd_sriov_msg_pf2vf_info *)pf2vf_info)->feature_flags.all;
> >                 adev->virt.reg_access =
> >                         ((struct amd_sriov_msg_pf2vf_info 
> > *)pf2vf_info)->reg_access_flags.all;
> > +               adev->unique_id =
> > +                       ((struct amd_sriov_msg_pf2vf_info 
> > + *)pf2vf_info)->uuid;
> >
> >                 break;
> >         default:
> > --
> > 2.17.1
> > _______________________________________________
> > amd-gfx mailing list
> > amd-gfx@lists.freedesktop.org
> > https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fli
> > st 
> > s.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=04%7C01%7C
> > Ji
> > aWei.Gu%40amd.com%7C8c5b87447e364531b89008d916890f54%7C3dd8961fe4884
> > e6 
> > 08e11a82d994e183d%7C0%7C0%7C637565600188355261%7CUnknown%7CTWFpbGZsb
> > 3d 
> > 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%
> > 7C 
> > 1000&amp;sdata=Go8nw1HMA5I4wLJv2jk9hpSm2%2F0BR9nRzwwdAlJfttc%3D&amp;
> > re
> > served=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
