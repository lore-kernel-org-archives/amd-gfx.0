Return-Path: <SRS0=ZYFY=5S=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1574EC43331
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 17:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A958E20757
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Apr 2020 17:25:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="eprEKl7x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A958E20757
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 629246EACD;
	Thu,  2 Apr 2020 17:25:59 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2068.outbound.protection.outlook.com [40.107.93.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 096426EACD
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Apr 2020 17:25:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gpKhuSVvCXi3JCq8pElJmxyjkNb0RUjZHhedjNXdNqcQhgI1Uj6ff4QFe/vHgGHmgopcPjPV1Mthco1M+6oYeoJkU5glS5/6jFBQllSOB42Eao8xgcqr4X6pCAiAxL13qycrNa++ua0rKCy2mr/uSoAfK6pKOzToBAXxFKvQ8Qqz6wFoKRJd9ySESouFwkGgQ2b7lI3ivWuG579jdqRkk983sC5Oo14H24/i5cJAUMCw4l0ABYlbuLW5psIX5chh8Dndz0NLH+5bn7Ea/BYxodimgLWoisQO4tFADLFV2ByxqiuAdHDnhiZVSEYWhHwVSeINXiMxhawLVF5gi2eftg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6a22FvkIb86GhimaCn0oRM/Nsg4qauoEZobr0VK6HsA=;
 b=l/jVU8W5ubOsWL6W/+kiHDgwuhoLlb7mbUCF5uPET6oLp4CghT0LMEZGICtRpl1QcLhU+eNquf0sUAZvxlwkCZFLzjHuHyj2hcQ2gyMH1zz7lJX+ygfjrpDaPKoe60XNBbEO9QIjY+Y0wiHzzSt+npcie/SWHFkG3pyCs8dLWInXVXDGj8LSjWfq6cOIaLr1JnaLcC958BS1T6wgXf7TFQ34zmcgvlqHSPL8cLoJOplrT03eVOr9oP25kqhuOQoEAvgAfN1GC5T1cT4TQfk0ccS07OIp6/f79uOkL8oXMCULrZNSnojstJaauqPWadtgtHYURfSgg2rpf94egbzb5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6a22FvkIb86GhimaCn0oRM/Nsg4qauoEZobr0VK6HsA=;
 b=eprEKl7xppMxqOE//D4BCMTp80sMD2NS4l+2oQqeGYNuZ3rxRRp/vieMLTwfb8B6T/MNXGuDh02vjNRn/4jm9O0kxZnCTgq37w2L8qHlOYLvAm1SpPgbEwma1BLTE9OZ9O7IhzucbR8dUzEOKvP/y4+WMHcbruWICtvYS4h2VKs=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Felix.Kuehling@amd.com; 
Received: from SN1PR12MB2414.namprd12.prod.outlook.com (2603:10b6:802:2e::31)
 by SN1PR12MB2493.namprd12.prod.outlook.com (2603:10b6:802:2d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.15; Thu, 2 Apr
 2020 17:25:54 +0000
Received: from SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806]) by SN1PR12MB2414.namprd12.prod.outlook.com
 ([fe80::38ef:1510:9525:f806%7]) with mapi id 15.20.2856.019; Thu, 2 Apr 2020
 17:25:54 +0000
Subject: Re: [PATCH] drm/amdgpu/sriov add amdgpu_amdkfd_pre_reset in gpu reset
To: Jack Zhang <Jack.Zhang1@amd.com>, amd-gfx@lists.freedesktop.org,
 Monk Liu <Monk.Liu@amd.com>
References: <1585812006-3368-1-git-send-email-Jack.Zhang1@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <fd3d379c-41d2-3626-6785-a2466d7de582@amd.com>
Date: Thu, 2 Apr 2020 13:25:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <1585812006-3368-1-git-send-email-Jack.Zhang1@amd.com>
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::37) To SN1PR12MB2414.namprd12.prod.outlook.com
 (2603:10b6:802:2e::31)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.100] (142.116.63.128) by
 YTXPR0101CA0060.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b00:1::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2878.16 via Frontend
 Transport; Thu, 2 Apr 2020 17:25:53 +0000
X-Originating-IP: [142.116.63.128]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8f5f9be5-7673-46ac-f2aa-08d7d72ae5a6
X-MS-TrafficTypeDiagnostic: SN1PR12MB2493:|SN1PR12MB2493:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN1PR12MB2493E474E60781D7C9F1A1B192C60@SN1PR12MB2493.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:392;
X-Forefront-PRVS: 0361212EA8
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2414.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10009020)(4636009)(366004)(376002)(39860400002)(346002)(136003)(396003)(52116002)(478600001)(5660300002)(66476007)(66946007)(66556008)(8676002)(31686004)(36756003)(186003)(16526019)(26005)(6486002)(86362001)(81156014)(316002)(81166006)(110136005)(8936002)(6636002)(2616005)(2906002)(16576012)(31696002)(44832011)(956004);
 DIR:OUT; SFP:1101; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dLApTo0FVY5IqBHsRQjEiEcxgtdxQASqDqf8tY0D7qC1sEBrH4puJ8wndMhsYl720t1s/xlxp+JuZ4+sCJxBFAwRoLZWCbRDGwn+4ZUmt40YZvsgcuH7MFmoyVrTLk4wTzXUb/31D1uWiDo5dUWUvt88rztxzanoJ7YONPZD4eaiy33VetHqXkJHfBk26pCnEHpZ0VroV24r4K7AVaEQWVb1uzGzmP9mINMaPtTVyt5dXn7cclLmgLWT3+v7MpanY6vUVpIsFoYRiOc97k0YbvaHSjJ4mBwpKIWmpwNYaSpGfvkMkzzJHx7cLzOIlu5v+ESdj5mBSRyJcOPB3zaMdyh+V/TmFrZ0k+GnZ6RAvjKQiHsQ8U2/yRWvI9el8NNfTZgv0UFsAlO47FTKTF+NyJIy7136nIveHTnhtlQUrjVRTGoQ5Ltkf+gVcEoOFzdW
X-MS-Exchange-AntiSpam-MessageData: TBBT/HorUUQYdOthblK0sZ/cq6y6Vexw8qkFDQYd1a348W5Ik2BhBYK1uqlxBamNf5j/rWrz2359X8Z3T2RaJTrLHPCsFtK0Y80eL/oCSAIpgmM5HsEAaCo29sDwXZaZufmEQ/asrcXVoUf7M7fSwg==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5f9be5-7673-46ac-f2aa-08d7d72ae5a6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2020 17:25:54.1624 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jgsojN/UrH0PacdNoTHx1mH1kJ80JJlJ8tzftz8pYdcvbQPqk/zX4MiOtL+ODaRIt5DUkZ8TX8cp60XgXgDDVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2493
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

[+Monk]

This looks reasonable to me. However, you're effectively reverting this
commit by Monk:

a03eb637d2a5 drm/amdgpu: fix KIQ ring test fail in TDR of SRIOV

In hind-sight, Monk's commit was broken. Removing the call to pre_reset
has other consequences, such as breaking notifications about reset to
user mode, and probably invalidating some assumptions in kfd_post_reset.
Can you coordinate with Monk to work out why his change was needed, and
whether you'll need a different solution for the problem he was trying
to address?

In the meanwhile, this patch is

Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>


Am 2020-04-02 um 3:20 a.m. schrieb Jack Zhang:

> kfd_pre_reset will free mem_objs allocated by kfd_gtt_sa_allocate
>
> Without this change, sriov tdr code path will never free those allocated
> memories and get memory leak.
>
> Signed-off-by: Jack Zhang <Jack.Zhang1@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 8faaa17..832daf7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3847,6 +3847,8 @@ static int amdgpu_device_reset_sriov(struct amdgpu_device *adev,
>  {
>  	int r;
>  
> +	amdgpu_amdkfd_pre_reset(adev);
> +
>  	if (from_hypervisor)
>  		r = amdgpu_virt_request_full_gpu(adev, true);
>  	else
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
