Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC446C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 03:49:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 827D4206D7
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 03:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="zwXcU0fY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 827D4206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A4386E072;
	Thu, 19 Dec 2019 03:49:32 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18B5E6E072
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 03:49:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZVTVnmUfPYid79+cBEOjJrBu/YvX226DB6BsCmOUNcrRZ+x/JEzumK3MC3BQnKn2iLTJkEtO/5wDFymB1pC1vAF6cKo14vB3/s/H6FTtncEB9tC5VrYKD9hrbfrIdZbUTULm0aOx8dYvZGA5pKpcabKs51HKiB1wnhcqc+wWKPuXeTz8fo730dJa6SY1LLCIPAIbj+DpvwYMaArPlhIZcf2S4g7K7LrfkFLFz8WW17/mrhVla7u2Xq30j8RR/U/E6JxtVlPuePQxutuvivM0bONCdyRBFU91Mv88uZ3l7ku+pHvZs9SB4Mk6a6RgFbVRIqmBMeoGG43tKpa5bUy6SQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ld0eBVFQD5wnJ4c6UfeF9d2Vn40w+4Jm19Zd0jPXx04=;
 b=Z6+n4yaGfSr/gNU1vD4329H7udcyPnK51Ncn4Rtxf15gUk4dM4n6fgcJqPDQ1R72oh8CC1NqcV3wZGnZAV97oWKmpK6TYTmq96FM6KDFNvEMbTH3UYWFfWNJXOLBKbbfzsE7Yaw+SDKwDoFWA0AERQTJ+ZQgfuTnfs4GvoF+WEIBmCBorpiTqu9b/C79QPhukJ9tpZjFUH+1gfeKYapk4BtxNo24DaDiFNPJbzhe60iwHBZETlSdpj/fktUeu6PV3Bvb/y1ahGZl0TrlBVOCOGyANI61SgNmVwHzep6/4yQ7nrJNFFXtB/dvHwreGRNe4Fo3zL0fyvm0zp0A75QKXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ld0eBVFQD5wnJ4c6UfeF9d2Vn40w+4Jm19Zd0jPXx04=;
 b=zwXcU0fYBjNjhl2K2693KVDqXikIlptsRkfaKRobYgJLqiWZa0nM+DOKqHeh5Ab1Ayrj3N/z1AMbU0nnSbSDsxk8YlbPz4+aGf018zUPqSt4BhEZbp7Uw+mb29zGBNN1nuTBr3VoWvxMpDIJws3S2chz0Yi3pOCA3XbJM8ha/CM=
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (10.255.236.82) by
 MN2PR12MB3614.namprd12.prod.outlook.com (20.178.241.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 03:49:27 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5%3]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 03:49:27 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV
Thread-Index: AQHVtMOL6YZvkxHYqES0ji1IWZ65nqe+dlwAgAJdfKA=
Date: Thu, 19 Dec 2019 03:49:26 +0000
Message-ID: <MN2PR12MB3933E586A9792FC3901F460184520@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <1576577994-12874-1-git-send-email-Monk.Liu@amd.com>
 <1576577994-12874-2-git-send-email-Monk.Liu@amd.com>
 <b4117c49-7107-6ded-a5e0-9fd7ea69e9dc@amd.com>
In-Reply-To: <b4117c49-7107-6ded-a5e0-9fd7ea69e9dc@amd.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 35b5f8c1-5160-4da2-6e26-08d784367203
x-ms-traffictypediagnostic: MN2PR12MB3614:|MN2PR12MB3614:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3614918F01F4DE5F33144E9084520@MN2PR12MB3614.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(199004)(189003)(13464003)(81156014)(55016002)(81166006)(66446008)(8676002)(64756008)(66556008)(9686003)(66476007)(52536014)(8936002)(5660300002)(76116006)(316002)(110136005)(33656002)(66946007)(71200400001)(86362001)(478600001)(2906002)(45080400002)(7696005)(966005)(4001150100001)(6506007)(26005)(53546011)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3614;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jI4PXc+4/gkz6rsPEfS+zLm5ISlC3J9FkRjPtLb+BHtmarWKtUWwl1aSQZUjYzYfGU4jzYU5pz84n19/VJvabyL169aoTTKz15NSpaIhF8ubwakjeWTtvFTVDli9kxQgUwfq1BMFGDts1hNny9QylUS/JpMnKVLlI+UfP8czKDI2rbs7fLaR6HilrqBMX64ZawE8BGRXf6CGW8uFIaxVE+jUtIaX/PfQLCmhtTA7zKPOGDkC1aW9tCRgSc449ruCFBPHpTMH/qkWSz7lQWMV84pMombdRgf4arOOL7LV1QvXaFlERWvosTfx3xqiNBTGCZISqYwlKAxhw0WjSApEhsJMo0UqgvdJW6q2OSR8r7eEy9r6SAa0BIarixNJbQfMTdF13uaBfRffTerEeT+IX3ieeWrFXnmGNz+wqwb5VTdYzC48l30tdWT8kEdwdMpA585Nw6bbiNzD1S971ZBOXS/KcjBmqyDfOgtcyfPJHwMRRRnnXTY76zKDZGZZoOwpaduhG2pEsnCitZrgDOqkLnuFvx5vSvM9n8a5v2r0pk4=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35b5f8c1-5160-4da2-6e26-08d784367203
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 03:49:26.9673 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y0xO04w6RnxFeLrgeIkqSHXCkwaBbyQDHy7oLpfOQxsJeNfy8SCIw2kLyAnRymuw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3614
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Shaoyun

>>> Do we know the root cause why this function would ruin MEC ? From the logic, I think this function should be called before FLR since we need to disable the user queue submission first.
Right now I don't know which detail step lead to KIQ ring test fail, I totally agree with you that this func should be called before VF FLR, but we cannot do it and the reason is described in 
The comment:

> if we do pre_reset() before VF FLR, it would go KIQ way to do register 
> access and stuck there, because KIQ probably won't work by that time 
> (e.g. you already made GFX hang)


>>> I remembered the function should use hiq to communicate with HW , shouldn't use kiq to access HW registerm,  has this been changed ?
Tis function use WREG32/RREG32 to do register access, like all other functions in KMD,  and WREG32/RREG32 will let KIQ to do the register access
If we are under dynamic SRIOV  mode (means we are SRIOV VF and isn't under full exclusive mode)

You see that if you call this func before EVENT_5 (event 5 triggers VF FLR) then it will run under dynamic mode and KIQ will handle the register access, which is not an option 
Since ME/MEC probably already hang ( if we are testing quark on gfx/compute rings)

Do you have a good suggestion ?

thanks
_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of shaoyunl
Sent: Tuesday, December 17, 2019 11:38 PM
To: amd-gfx@lists.freedesktop.org
Subject: Re: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV

I think amdkfd side depends on this call to stop the user queue, without this call, the user queue can submit to HW during the reset which could cause hang again ...
Do we know the root cause why this function would ruin MEC ? From the logic, I think this function should be called before FLR since we need to disable the user queue submission first.
I remembered the function should use hiq to communicate with HW , shouldn't use kiq to access HW registerm,  has this been changed ?


Regards
shaoyun.liu


On 2019-12-17 5:19 a.m., Monk Liu wrote:
> issues:
> MEC is ruined by the amdkfd_pre_reset after VF FLR done
>
> fix:
> amdkfd_pre_reset() would ruin MEC after hypervisor finished the VF 
> FLR, the correct sequence is do amdkfd_pre_reset before VF FLR but 
> there is a limitation to block this sequence:
> if we do pre_reset() before VF FLR, it would go KIQ way to do register 
> access and stuck there, because KIQ probably won't work by that time 
> (e.g. you already made GFX hang)
>
> so the best way right now is to simply remove it.
>
> Signed-off-by: Monk Liu <Monk.Liu@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --
>   1 file changed, 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c 
> b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 605cef6..ae962b9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3672,8 +3672,6 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>   	if (r)
>   		return r;
>   
> -	amdgpu_amdkfd_pre_reset(adev);
> -
>   	/* Resume IP prior to SMC */
>   	r = amdgpu_device_ip_reinit_early_sriov(adev);
>   	if (r)
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flists.freedesktop.org%2Fmailman%2Flistinfo%2Famd-gfx&amp;data=02%7C01%7Cmonk.liu%40amd.com%7Cee9c811452634fc2739808d7830718f6%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637121938885721447&amp;sdata=FiqkgiUX8k5rD%2F%2FiJQU2cF1MGExO8yXEzYOoBtpdfYU%3D&amp;reserved=0
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
