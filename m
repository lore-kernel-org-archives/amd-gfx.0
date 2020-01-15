Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCBCC33CB1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 07:46:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA8E9222C3
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 07:46:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="37+e1Wst"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA8E9222C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E50D6E861;
	Wed, 15 Jan 2020 07:46:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2073.outbound.protection.outlook.com [40.107.243.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CFC76E861
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 07:45:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EJOxJHx8am+pKUSphRqYQgNl4MpAauGW9xzClia77ZziGzj0Cq+j19dtfgTQexSMytGSbUKnyAfRs+spj74npykVpuyldkj8jKl1wOVqO+2ktJXBcpdjIsef8do+XKL/7Yd9uni7FuVT968dbwEY8Ykzz27/6xhahZbeDWl0Ircu/9Yb6IzfKP48LhL9DHm01rLM8j8YhNdkhKc4wvi0zN7KgKv3gF9GOCgtfWwOHkUMOrWIqLVPWNsg71J4i77NcXeLQ7FexJYaul2nsW0bEeJa173u2bNx4YkoiFA9wcbc09mop1FQOgJr6B0ZeP+/fFqp1hBMRwzk3sGdeLvOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MUZAenfJZXk/P9NofS1Y7ToB5X+C/8Jr3Ry3rh+h7o=;
 b=Bir7DEd6EWq7g7JKPZRB91anbUMKpMu61+q3e4RlXI17BvfbF7Tf2cTa7km/do24D/AM0+N7uD67sYCSpB/vKseBgw4zFTe/S0uxo1XIS1RjyHVSctn0JNzX0jEyinty7z5j9jE2Lutua/2Wsbt/0XCQDV77PTPn10kRhiDyPmNlwSARyoGeuNW/zHVrr9tMmK+5y+0Nt27aQIcOpP1cDfVaQTjK3yyCAt3atN8ykQK1or/szdO82IwUPahZVtyuSvkJdYPO3trs/Lpk3UKWHgvSxTk00e2KyKv950zQ8VeD3+Wn3iB2jxq0nSroB/gX23QU85UDzPTA704Fmrxqyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MUZAenfJZXk/P9NofS1Y7ToB5X+C/8Jr3Ry3rh+h7o=;
 b=37+e1WstLM/rOuuIJ+urY2DUu8yGkw4QVQjyZCzm2cxZtBXtJUCbYZa4Gk6IshewZ85Tv0JL/Z+Kfeg4CYeUqKoLOVNQMWUfwQ8ijJjDELoXZBeMy0N8VzW8TkhX7tFRZjvW03TWp/EjdQv8FRm0WZRVagbcV/fh/SPNHGzIyaM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1466.namprd12.prod.outlook.com (10.172.38.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.11; Wed, 15 Jan 2020 07:45:57 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2623.015; Wed, 15 Jan 2020
 07:45:57 +0000
Subject: Re: [PATCH] drm/amdgpu: fill the alignment for secure buffer
To: Huang Rui <ray.huang@amd.com>, amd-gfx@lists.freedesktop.org
References: <1579072065-10883-1-git-send-email-ray.huang@amd.com>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <0045cca4-5197-285c-3808-6c5c5b6eb3e4@amd.com>
Date: Wed, 15 Jan 2020 08:45:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <1579072065-10883-1-git-send-email-ray.huang@amd.com>
Content-Language: en-US
X-ClientProxiedBy: AM0PR01CA0132.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::37) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR01CA0132.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2623.10 via Frontend
 Transport; Wed, 15 Jan 2020 07:45:55 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 42a66fe4-7bb5-4b17-2ef6-08d7998ef4cc
X-MS-TrafficTypeDiagnostic: DM5PR12MB1466:|DM5PR12MB1466:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB146680BA16CC0C0E9D57266D83370@DM5PR12MB1466.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 02830F0362
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(346002)(376002)(39860400002)(136003)(366004)(396003)(189003)(199004)(186003)(16526019)(6486002)(8936002)(31686004)(2616005)(316002)(8676002)(81166006)(478600001)(54906003)(81156014)(6666004)(66556008)(66946007)(66476007)(31696002)(36756003)(5660300002)(2906002)(86362001)(4326008)(52116002)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1466;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xiqJcWImiw2V0N4LzzJfJza9HE8J4qfdd6M/UYnh+4RKNh/ha7qX8HCnDxzpqt7jVOCZpC5gJxz7owEM3vFh+cI2MbZfwM95L8PuOjxAYYeX7dDwRnZGtw+QeYZxDDyiu2eCdR4spv7IcwRKX3351cWY5r5tFFAI/8xBZBzklohIwVAAgCOG06pFYAuVeZqtxnDuFBma88q4s3r50ArJJ25Il/e3w0XSVfm3kEcG5Gd3AVghm3cpcJH7+cAbKCHk5y/jPDwtHcNxXME7BtRj6oSxC/KCTu0hYcklRqD/c8FM01x6x+jboAWq7SnGs/pECMwmnCU7shtnrgNvuq/niD/xv/AQWCUEs+BvQGwBLBMdDTgmVTmGW2MtmNh82C6PolwhdEMjvgER90W2OnsA8y/9JkhNdqpvkpegcdZjVlOYQKT3giCwJ7mjU0fQMk6L2DUkt8+mgAgd2YC2S5I9rYXB6q1GWdEMyjtej4IJV0fLm5TVy8L/bRSAl4ie5zeS
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a66fe4-7bb5-4b17-2ef6-08d7998ef4cc
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 07:45:57.0960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wTnkTjM+BnaatE/5kRFo2F8/negqw5k/ofxf6xH+3QfT5KAKwWs89zRZtpXgeZry
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1466
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Aaron Liu <aaron.liu@amd.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.01.20 um 08:07 schrieb Huang Rui:
> The alignment should match the page size for secure buffer.

That is superfluous, buffer are aligned to a page size anyway.

Christian.

>
> Signed-off-by: Huang Rui <ray.huang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 ++++---
>   1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index f39012e..a03eead 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -261,9 +261,10 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>   		resv = vm->root.base.bo->tbo.base.resv;
>   	}
>   
> -	if (flags & AMDGPU_GEM_CREATE_ENCRYPTED) {
> -		/* XXX: pad out alignment to meet TMZ requirements */
> -	}
> +	/* TMZ requires the secure buffer to align with page size at least */
> +	if (flags & AMDGPU_GEM_CREATE_ENCRYPTED)
> +		args->in.alignment = roundup(args->in.alignment,
> +					     AMDGPU_GPU_PAGE_SIZE);
>   
>   	r = amdgpu_gem_object_create(adev, size, args->in.alignment,
>   				     (u32)(0xffffffff & args->in.domains),

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
