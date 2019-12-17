Return-Path: <SRS0=JueS=2H=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CDA1C43603
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 15:37:58 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33E6E2465E
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Dec 2019 15:37:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="v2TWgyYA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33E6E2465E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E0AA6E111;
	Tue, 17 Dec 2019 15:37:57 +0000 (UTC)
Received: from NAM04-CO1-obe.outbound.protection.outlook.com
 (mail-eopbgr690088.outbound.protection.outlook.com [40.107.69.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E09F6E111
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Dec 2019 15:37:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oBb4y26si26ug52LADZmKpcHmzgwWrBAbUbLtJb/r1ZynPE+9wAgRyayjB09vvJn1CmRctpbKcJyL+iqyTHxnJl0raztC6PlIPNoajP9wpVTGCKzws5Jdr+J6vfaPHmAlFDCDpeC8vjB06Gnul7ZubB1AeX2tet3eiwyrbaVMLIEGvJLZO/YLIoTf1b1qqxg62L6U+HCl/iQ2fyndO6NT5VCuH+QWvgOeMe4sze+1+NpBz+SkFg9EAYk195rNYA95i48xoCQUSWBsF3KgktQcE4VtA5Xu3xD7sshgdoffbtADJ9YFGA7udS7eRUGXI2o0o6s/I/HD/3356/PYWeInA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOZh4PRCYhy96W/qhE1wjLYRjPDDlvf8i1fVGeXianY=;
 b=ROgoKrWXKVkS+0ErepO/p3zaPLTDOsRZkkMCu/N0/8pLgKGn8YknAxmN3dwsMGzrtciStiCblyPMUJxIljhOtMMHAqTw5yVFO0iHYT6JUjSzCnCMtUqxU5tpM1NOuZIlf2itsxobkLQDnVKHzlotaKas96y6E0c8Nvd4xfFiZQ9F8ej/6ahQl1w6Ss3TNIjYd1miaFDPrAf9GdKC3ajB0/1IxLHJYQJYTKjmpv3OakLQCt6ByA4LbcoFZ/1TXhW0D4HN2rRvZOt4DUlfzxK169j8Obtf7XUhrNfyuw6GILR03Gb3a1aSjTSrghU4ylR7ctw5YENl/YpwZrSdkuQxig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IOZh4PRCYhy96W/qhE1wjLYRjPDDlvf8i1fVGeXianY=;
 b=v2TWgyYAX4E5yVj+Blp/BjAP6Vt6vDmwfhtlBmd5hOV1IUGlYhp6uvLeVNPG1L4aJy+dJA5HUNWdhxaP55t0/ilp1vYEOAc8suL463BkUXDyZ4CHaY80ofC9mSye0mFZnGEj5HpP8PYWxuQmpSaXNl6TCW3J/GFRbDqRBv6ZjTs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Shaoyun.Liu@amd.com; 
Received: from DM6PR12MB3241.namprd12.prod.outlook.com (20.179.105.153) by
 DM6PR12MB3882.namprd12.prod.outlook.com (10.255.76.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Tue, 17 Dec 2019 15:37:54 +0000
Received: from DM6PR12MB3241.namprd12.prod.outlook.com
 ([fe80::e9a0:2dda:d7b9:9a10]) by DM6PR12MB3241.namprd12.prod.outlook.com
 ([fe80::e9a0:2dda:d7b9:9a10%5]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 15:37:54 +0000
Subject: Re: [PATCH 2/2] drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV
To: amd-gfx@lists.freedesktop.org
References: <1576577994-12874-1-git-send-email-Monk.Liu@amd.com>
 <1576577994-12874-2-git-send-email-Monk.Liu@amd.com>
From: shaoyunl <shaoyun.liu@amd.com>
Message-ID: <b4117c49-7107-6ded-a5e0-9fd7ea69e9dc@amd.com>
Date: Tue, 17 Dec 2019 10:37:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <1576577994-12874-2-git-send-email-Monk.Liu@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTOPR0101CA0056.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:14::33) To DM6PR12MB3241.namprd12.prod.outlook.com
 (2603:10b6:5:186::25)
MIME-Version: 1.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2905f326-d25d-4caf-58e0-08d78307153b
X-MS-TrafficTypeDiagnostic: DM6PR12MB3882:
X-Microsoft-Antispam-PRVS: <DM6PR12MB3882B592421C9B60AF75754CF4500@DM6PR12MB3882.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-Forefront-PRVS: 02543CD7CD
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(366004)(376002)(396003)(346002)(136003)(199004)(189003)(8936002)(8676002)(81166006)(81156014)(4001150100001)(52116002)(26005)(6506007)(31686004)(53546011)(6512007)(5660300002)(86362001)(66946007)(6916009)(66476007)(2616005)(316002)(478600001)(2906002)(6486002)(186003)(66556008)(36756003)(31696002)(43062003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM6PR12MB3882;
 H:DM6PR12MB3241.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uqNsSpVD5lnUcN7JqZ4nmifPEvhRDNDumxuep3dgIMIRhkAFFA0OzYf1Q/z4BXSZO1+kWz69yd9o8GpuxLXuG8E7bbvDxDRLaFc9xiwNI2YHyaINcxRjEvr+5MXkfeaegBg96Lu5xjfo7j9EwMMPGCwD9onfx99YejE5piSBjgC2xoxZbR8IQwbfGX8YZLa2OvI3qH1lELze3HML0EnVyeT4mnx/0AMSRyRiI4PfCt3Vq5iO7U1oUSdbpd7kH5lMtUkGoiHHCcO8tqcvofGihf1Z+qQvDbJx9xT0FFbTzBJbCV0c7jAbWpOspVz/2wvoLeHj9xG7w+NDAEKPWGfzzi/q622VSCGio8EQPaL8/BZDpyYoSu/BSAhSFibvJNLJSPjykRhTe/ptUHPaoUdX0nlczFauk+iopw8zLyfWjWDrthxbpaCcenPvM488AB7Z2tEBFXyTuLxj7n96A05M1QVIhnTK48IpSZFoBFR66FihUtNoFKWjacMvaQMSicRF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2905f326-d25d-4caf-58e0-08d78307153b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2019 15:37:54.2164 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 45HA+YrY3JnfNntwiyHiG0Mv0Hx82qa14nWKsuu5FjmdBNazrjAHvPUIGd7bwsMbjvkeAXKRPddsDBf5Dm08Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3882
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

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
> amdkfd_pre_reset() would ruin MEC after hypervisor finished the VF FLR,
> the correct sequence is do amdkfd_pre_reset before VF FLR but there is
> a limitation to block this sequence:
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
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
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
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
