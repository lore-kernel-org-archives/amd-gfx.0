Return-Path: <SRS0=793y=2J=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D245C43603
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 03:52:51 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A0F2072B
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Dec 2019 03:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="rt1146QV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A0F2072B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EDD56E072;
	Thu, 19 Dec 2019 03:52:50 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2064.outbound.protection.outlook.com [40.107.92.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 644576E072
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Dec 2019 03:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCIbrUU7VciNR9I8RRLt8bArI8bd95ETESd8UVF09rLh6uL0Z3IUUffqnjUkBajhsYgZL0UdiJInoxy2OtQ0BNNdmx1wAytObsWS23Ey3LopUwI3/DP6u4KviFAasvNLxEVuiskDbqxbl5LG5l1gMqinOVJD5P0zPSUuXHjUt7sJ1trJXKURHhiECOX4H6MyDoHSSC8FARaxUMxKxQpHsy9IV0gpsAB16achWXxJyzwcRdihqp1x4E1rbMlwT2DnkljTTB0++ob55ezWiyATu7dM3oGSGQuO+bzPb/wWcJBdyJO4qQTLqwsRsoF7VuTXgFkbZe16PyaOqO4q83kdxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJgOIBdRS+7uBW6s0SEz+CpBhbUsiTh+oCQbMSCWBMA=;
 b=Bdlb4S1USuRxOyTkfE4NfHgpQnp64MshEVBomrBx83xi4WK35YbulB8m1GOqiuCYccbgz70LKuwoy1HfPClry6SeD/BiJaPnMXcHB5N8jKXLFRTXgeBtXl+xFIW1HuCR/JVVL7GAcC6ctVDwwNOyWb9qtEktEE3nH9gMkR/E2TlhY05X+gmj8EWjMfgxcFIdmZTW1oLmHEN8V2rUQy9hNOf3Du7jPxOMsZgdqZbM1zddplg/aIUufIXpsJvS3a1L/6n2+Ulg0uJL3tlatz0fTnObK5wIIkZGfXjOQzkjeFkuEUderfClfN6J449HedwjqSeEKSNf0zcAmQLGGCSwgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJgOIBdRS+7uBW6s0SEz+CpBhbUsiTh+oCQbMSCWBMA=;
 b=rt1146QVMqkczqotSfxqxegh4u941zgA3EL/zRPSl8r9vn1LbwsUu3eryShA6c7JKqn1NxG3H1GPWpb4Cj/tuwBIE7co8CFS3o9mvZCaeCTD1ejur/YiAzo/EfUAYjnC3SdQALBl/rA//5V3mwpc/mbUaDDdiaKExFL9PD+kfmU=
Received: from MN2PR12MB3933.namprd12.prod.outlook.com (10.255.236.82) by
 MN2PR12MB3614.namprd12.prod.outlook.com (20.178.241.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14; Thu, 19 Dec 2019 03:52:47 +0000
Received: from MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5]) by MN2PR12MB3933.namprd12.prod.outlook.com
 ([fe80::411d:b54b:4cfe:ee5%3]) with mapi id 15.20.2559.012; Thu, 19 Dec 2019
 03:52:47 +0000
From: "Liu, Monk" <Monk.Liu@amd.com>
To: "Liu, Shaoyun" <Shaoyun.Liu@amd.com>, "amd-gfx@lists.freedesktop.org"
 <amd-gfx@lists.freedesktop.org>
Subject: RE: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV
Thread-Topic: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV
Thread-Index: AQHVtMOL6YZvkxHYqES0ji1IWZ65nqe+dlwAgAJdfKCAAAGqcA==
Date: Thu, 19 Dec 2019 03:52:47 +0000
Message-ID: <MN2PR12MB39334EA3BB4AB52FDC37A97084520@MN2PR12MB3933.namprd12.prod.outlook.com>
References: <1576577994-12874-1-git-send-email-Monk.Liu@amd.com>
 <1576577994-12874-2-git-send-email-Monk.Liu@amd.com>
 <b4117c49-7107-6ded-a5e0-9fd7ea69e9dc@amd.com>
 <MN2PR12MB3933E586A9792FC3901F460184520@MN2PR12MB3933.namprd12.prod.outlook.com>
In-Reply-To: <MN2PR12MB3933E586A9792FC3901F460184520@MN2PR12MB3933.namprd12.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Monk.Liu@amd.com; 
x-originating-ip: [180.167.199.189]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 9673bf58-506d-4ab4-1132-08d78436e93e
x-ms-traffictypediagnostic: MN2PR12MB3614:|MN2PR12MB3614:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR12MB3614A0C5F4B9186BE28E3A3884520@MN2PR12MB3614.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0256C18696
x-forefront-antispam-report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(366004)(199004)(189003)(13464003)(81156014)(55016002)(81166006)(66446008)(8676002)(64756008)(66556008)(9686003)(66476007)(52536014)(8936002)(5660300002)(76116006)(316002)(110136005)(33656002)(66946007)(71200400001)(86362001)(478600001)(2906002)(45080400002)(2940100002)(7696005)(966005)(4001150100001)(6506007)(26005)(53546011)(186003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3614;
 H:MN2PR12MB3933.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
received-spf: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o4ePv5jZScrZyGzpV0hZ/uUvul1JMvIQB3S4CT6mKeMxBNDSG+je+Cm4RL3VuDXz8jNtxRguL4HP0jYhYdsxhzkO9peXnW+pssXRZI45HITBxeYYUk7aawr2Shs23Ehqf7owX3HHCov/UCfHGsb98c7h8jaszug0b/rpfnEJejMEoBfLPl2AnzxAFUXOpSoQWcoWOf6iX112n1EPgTPd6G+y924HR01nNaORezAKbZ/kjbiG+EuOkr5YqaB1Ebvr50N/0GzCqGHmV2pQ6flbVyraDrlyBxeXXZyNWYVbOsBetZ37pZQ5nmn+uU5RKGNLKA+iXywpQ35CHmRH1M8X4haj40kc3i+djETJRKm3VGgYpHQGXZcld5qr7r9K7DyMgDVslpGNQaIb9CrXFzYIDQ0yHBdITbkGjVEueotrzt/xbHF/RhhmCx9xiUB0iZiRvruK/a1pbYWicyeEqwAMslLqvf/6WYy+F412vpbQCZrMFXUZbCmSo4ln9WG8DufDC4tJ9Xf/ozICHdUNW/nCtXI0CJi1DrpszVFVjPlceS4=
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9673bf58-506d-4ab4-1132-08d78436e93e
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Dec 2019 03:52:47.0744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xgEFovWJU+jpGB/O65I4Ne29GI985ANpLE4zIWuCJLRG4rDoks8F6PSw/Rrm/u5I
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

Oh, by the way

>>> Do we know the root cause why this function would ruin MEC ?

Only we call this function right after VF FLR will ruin MEC and lead to following KIQ ring test fail , and on bare-metal it is called before gpu rest , so that's why on bare-metal we don't have this issue 

But the reason we cannot call it before VF FLR on SRIOV case was already stated in this thread 

Thanks
_____________________________________
Monk Liu|GPU Virtualization Team |AMD


-----Original Message-----
From: Liu, Monk 
Sent: Thursday, December 19, 2019 11:49 AM
To: shaoyunl <shaoyun.liu@amd.com>; amd-gfx@lists.freedesktop.org
Subject: RE: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV

Hi Shaoyun

>>> Do we know the root cause why this function would ruin MEC ? From the logic, I think this function should be called before FLR since we need to disable the user queue submission first.
Right now I don't know which detail step lead to KIQ ring test fail, I totally agree with you that this func should be called before VF FLR, but we cannot do it and the reason is described in The comment:

> if we do pre_reset() before VF FLR, it would go KIQ way to do register 
> access and stuck there, because KIQ probably won't work by that time 
> (e.g. you already made GFX hang)


>>> I remembered the function should use hiq to communicate with HW , shouldn't use kiq to access HW registerm,  has this been changed ?
Tis function use WREG32/RREG32 to do register access, like all other functions in KMD,  and WREG32/RREG32 will let KIQ to do the register access If we are under dynamic SRIOV  mode (means we are SRIOV VF and isn't under full exclusive mode)

You see that if you call this func before EVENT_5 (event 5 triggers VF FLR) then it will run under dynamic mode and KIQ will handle the register access, which is not an option Since ME/MEC probably already hang ( if we are testing quark on gfx/compute rings)

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
