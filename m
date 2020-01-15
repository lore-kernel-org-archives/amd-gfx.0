Return-Path: <SRS0=p2a1=3E=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87A1C33CB1
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 10:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A262A207FF
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2020 10:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2gD/1T1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A262A207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 599CE6E902;
	Wed, 15 Jan 2020 10:34:01 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FEA36E902
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2020 10:34:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ktpfo8OGdkplQZZXeGln4u8YesQTqUqPWuGovQ2ctudaoMmv3Jkef7ng26YcAq2TP56YmE6d7JfNwpnwsC5r2wJkYisL77gThZaouaneOUbK3E4fALXxEdpFXY6Mb5fXHGbImn5FqYyuobEA3hORfTeR+NzS0vTsu9St41l7WoBhD+Ysg/33HlAQEQ8gjgR/Fl6UHxTFY48JCOILq5KpbUVrxW858DyoCi9P6MNV8Co9XvZnyKg7qPFiBiGUIN28QJFOoTqmcwge7KOQwDFGkuiZg8xhlexuOcbAAhb5NO3pnXpDjpnY61CSGoYYPauz9VszY4Jw4oVznDpVJT2uhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jDUl+6PfdlgxwvHBreKfLGAzTr68LFpR4iSEcwISis=;
 b=jZaRpg+W+Q21pIhZ8TpoegMI4TwUm41m6DTDB8Fr/PRI6uT41+ks9HdaVBab85cXfU0lZjUxXk/e7neWuUzJtSXcDlnVF35JbA5snC7tQL8kA9L9Fe6na6IlG9MPFTwHkSrKkOS9J1i0O98gOFwW7toHEDN9+4NtdzTqyUnzmOGxcn8d3C+lEfa1DMvcjvm3y1MWmr8qT4D/6FsTQF8/D/NJSD6G7YhQ2GSHPEbdJbuz8wEtPvV+4n3IWNsq8LFb7pO3m+mU36Fh5S/TuN4hrzYdAVMqe2B5ZkaqofqzB7JLoFjLhAfsJPzGLcZYjNTuLkg2RL/unuYPt2Hf3uDTUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jDUl+6PfdlgxwvHBreKfLGAzTr68LFpR4iSEcwISis=;
 b=2gD/1T1h0Zh0PcIJPZX52RKxl43GM5U1anQn7FH4JgqxFl6k7mkWoCHjFgikPbm3sB7daRwUWLOq9Zodq+l/4HOjJ7f2VQp7QM2ZLdEJrgit5BlpzQhI0QbcGikBm7D1rDyzNnZnRe1txgF7/9TvZul5elANPB1C2FTQw+nX2xw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Christian.Koenig@amd.com; 
Received: from DM5PR12MB1705.namprd12.prod.outlook.com (10.175.88.22) by
 DM5PR12MB1802.namprd12.prod.outlook.com (10.175.86.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2623.13; Wed, 15 Jan 2020 10:33:58 +0000
Received: from DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89]) by DM5PR12MB1705.namprd12.prod.outlook.com
 ([fe80::8dde:b52a:d97a:e89%2]) with mapi id 15.20.2623.015; Wed, 15 Jan 2020
 10:33:58 +0000
Subject: Re: [PATCH] drm/amdgpu: fill the alignment for secure buffer
To: Huang Rui <ray.huang@amd.com>
References: <1579072065-10883-1-git-send-email-ray.huang@amd.com>
 <0045cca4-5197-285c-3808-6c5c5b6eb3e4@amd.com>
 <20200115074856.GA20818@jenkins-Celadon-RN>
From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <5388eafe-77ca-45bf-40d7-7947e28c6249@amd.com>
Date: Wed, 15 Jan 2020 11:33:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200115074856.GA20818@jenkins-Celadon-RN>
Content-Language: en-US
X-ClientProxiedBy: AM0PR02CA0087.eurprd02.prod.outlook.com
 (2603:10a6:208:154::28) To DM5PR12MB1705.namprd12.prod.outlook.com
 (2603:10b6:3:10c::22)
MIME-Version: 1.0
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
 (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by
 AM0PR02CA0087.eurprd02.prod.outlook.com (2603:10a6:208:154::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.19 via Frontend
 Transport; Wed, 15 Jan 2020 10:33:56 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: c9d20554-5d21-4629-7a1a-08d799a66d99
X-MS-TrafficTypeDiagnostic: DM5PR12MB1802:|DM5PR12MB1802:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1802EAB12AF44B1A8422AE7383370@DM5PR12MB1802.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 02830F0362
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(136003)(346002)(39860400002)(376002)(396003)(366004)(189003)(199004)(6666004)(478600001)(5660300002)(6636002)(4326008)(6486002)(31686004)(81166006)(186003)(8936002)(2906002)(36756003)(66556008)(81156014)(66946007)(16526019)(37006003)(316002)(52116002)(6862004)(2616005)(54906003)(86362001)(8676002)(31696002)(66476007)(21314003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:DM5PR12MB1802;
 H:DM5PR12MB1705.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9mxiqqX6rbCYl6ygVilsc9TgQwcg46d+wz8S15+krPg/5KD7mGVfJJj2QGdWFazPGEBS4LE0nZ9lCZSj6ctee+P4vME/UrchHM+l98PYrkgetnd1dUClVAyeriZRtyd+xQ5c7QXJVQjIXLy0XjyREDrhsp3WG2OMIF5rZmrReCmpHcZGm6UJhaFox2bAd69aOVFfiIiQwm1ZaJKIOvmpMo6i/pLkbzut3H5w/+LeA8H0budjM1mQBsEKf9tZBTH7NIDoLkYfT//HLndgxsMRtOsYt6zPu4U9y3qFQJ9/cOgLrJSBhn4p8BuLO7v7FKEpGIRuyQxMDW8sNk2jDsL4aqCpWuKDunv67OrcUS+wOz95H8JCijdVPe13Xrt9wyXABJcIwOhM7VAktPc/5McI4P0RMyYyyyuERUSFx42gfjN++Q81+Hrgl1guZtL5Iv7OAzrR06NlIE2MPPcP1ASIhpK4KsaVOJQLMbf9aQnXiD6BB0ZiFAfKQBrgO4ej/9PO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9d20554-5d21-4629-7a1a-08d799a66d99
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2020 10:33:58.2758 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBw9ErfogbqKp5HuKMn8fc0jbGWKHSAzlZpiqZ68Wg4+ip52fmyPsCUo0ATa9bYs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1802
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
Cc: "Deucher, Alexander" <Alexander.Deucher@amd.com>, "Pelloux-prayer,
 Pierre-eric" <Pierre-eric.Pelloux-prayer@amd.com>, "Wentland,
 Harry" <Harry.Wentland@amd.com>, "Liu, Aaron" <Aaron.Liu@amd.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 15.01.20 um 08:48 schrieb Huang Rui:
> On Wed, Jan 15, 2020 at 03:45:50PM +0800, Koenig, Christian wrote:
>> Am 15.01.20 um 08:07 schrieb Huang Rui:
>>> The alignment should match the page size for secure buffer.
>> That is superfluous, buffer are aligned to a page size anyway.
>>
> If use huge page, will buffer still be aligned?

Yes, the minimum alignment is always one page.

Christian.

>
> Thanks,
> Ray
>
>> Christian.
>>
>>> Signed-off-by: Huang Rui <ray.huang@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 ++++---
>>>    1 file changed, 4 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> index f39012e..a03eead 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
>>> @@ -261,9 +261,10 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>>>    		resv = vm->root.base.bo->tbo.base.resv;
>>>    	}
>>>    
>>> -	if (flags & AMDGPU_GEM_CREATE_ENCRYPTED) {
>>> -		/* XXX: pad out alignment to meet TMZ requirements */
>>> -	}
>>> +	/* TMZ requires the secure buffer to align with page size at least */
>>> +	if (flags & AMDGPU_GEM_CREATE_ENCRYPTED)
>>> +		args->in.alignment = roundup(args->in.alignment,
>>> +					     AMDGPU_GPU_PAGE_SIZE);
>>>    
>>>    	r = amdgpu_gem_object_create(adev, size, args->in.alignment,
>>>    				     (u32)(0xffffffff & args->in.domains),

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
