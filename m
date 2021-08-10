Return-Path: <SRS0=kf8h=NB=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BFFC4338F
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 16:40:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4D660C3E
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Aug 2021 16:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD4D660C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CE9E898B7;
	Tue, 10 Aug 2021 16:40:58 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF7E1898B7
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Aug 2021 16:40:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cHIikF30yyrDbt5i91bAaxlXG1QgXfKeuakElQrSuo6OAiwNUPi2JrjZgO0ZtzabxjtNNjENAquZyMMkoyIqPU+1M8BNmADNaVR6aseoENcwrNaA566ZJ42E8rxXU/KwHlM70+rQZ73hA5/6dGBzK7M6mYjUPhEWfO3tEsZy6f/3hoHsB6SIaPEQnjIHPc5upla6RSUTl40K1cXdOY2uRy99MrGHtwGw7QtYf4sV95rm+hY+rpluXZu/YcEfZhWiW8FLin1H78i1F1k3+/KHXp61yjOfdRc2TAtygypwFX8s5sbw4AJbcetEceNJcwNiYKZfpIEbSezr0QDZ+igipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHTMm+BG1A7BRNOASxy9FzJumgPZ/dO/Ubw7KxEczYY=;
 b=cUWqGCJnV2B4P+VoyqMs0ugpYLhtYjch80sUo+XuFqJ1hVSk0kXWvzxvmvVLBT0xsv+haJcva446e0jhFB6epgwG4uRKn2MhgzbrtwNgaxEqTtlwzvJRFhKNEbkhEtbEyH3s2gxF+kKYl9rVwScflLbtrmlIkR8x+ujAMfuflRL0XFr97hMU1Fb/ZNHV17KIUJN92zAVyhgXPfy8Lyd2Jsl7uRcQ6SvqB8knVcqtKcieMhOWiBde3mOcMKm8GSpCCxpPJJg58McfYSmDUkI53lUDfDK8AzX4y71/thl+P4/WqcV26mAjaC9HvJQzMsJAxIPs7cGoBbd52LFyPzStmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bHTMm+BG1A7BRNOASxy9FzJumgPZ/dO/Ubw7KxEczYY=;
 b=D3LHrzDN6Z2DZpvBHXUhqXdcrHQ1GgQA/1G+JOmVQg5eRY59uzt31ZmquNhFvsoYEd4Uw5B0uWk/nY4yFL4VTud6rvPRMWRi9fE7rM/gvY1DuvN/EC+352x1aVnMT8jgb5p1BqdmEo7aJTTd1isLWa80NXVmrX//j8bVi6vx9u8=
Authentication-Results: hotmail.com; dkim=none (message not signed)
 header.d=none;hotmail.com; dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB4623.namprd12.prod.outlook.com (2603:10b6:805:e9::17)
 by SN6PR12MB2655.namprd12.prod.outlook.com (2603:10b6:805:72::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4394.19; Tue, 10 Aug
 2021 16:40:53 +0000
Received: from SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::9f8:ec71:6535:cd36]) by SN6PR12MB4623.namprd12.prod.outlook.com
 ([fe80::9f8:ec71:6535:cd36%5]) with mapi id 15.20.4394.023; Tue, 10 Aug 2021
 16:40:53 +0000
Subject: Re: [PATCH v4] drm/amd/amdgpu embed hw_fence into amdgpu_job
To: Jingwen Chen <Jingwen.Chen2@amd.com>, amd-gfx@lists.freedesktop.org
Cc: monk.liu@amd.com, christian.koenig@amd.com,
 Jack Zhang <Jack.Zhang1@amd.com>, Jack Zhang <Jack.Zhang7@hotmail.com>
References: <20210810032253.102933-1-Jingwen.Chen2@amd.com>
From: Andrey Grodzovsky <andrey.grodzovsky@amd.com>
Message-ID: <8f46a024-da65-f6ca-5904-ea07f98ffe39@amd.com>
Date: Tue, 10 Aug 2021 12:40:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
In-Reply-To: <20210810032253.102933-1-Jingwen.Chen2@amd.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0127.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::6) To SN6PR12MB4623.namprd12.prod.outlook.com
 (2603:10b6:805:e9::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2607:fea8:3edf:49b0:a41d:183f:e0b7:3e74]
 (2607:fea8:3edf:49b0:a41d:183f:e0b7:3e74) by
 YT1PR01CA0127.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2f::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4415.13 via Frontend Transport; Tue, 10 Aug 2021 16:40:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ebbdb11-9b06-42cd-3740-08d95c1d9e91
X-MS-TrafficTypeDiagnostic: SN6PR12MB2655:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR12MB26553AE7DB29586BD1446EB4EAF79@SN6PR12MB2655.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:660;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sCqpw008v1g2SNlwa/6Ttc8Fek1/CPZAeYFL/z16OFTUA192GG1po9u2G5FnLm1o1sxpAB8kHKUxywKoMBwx1eKSgAXadjQceaJwyQnC3NkxoXcOw+7PLjEVjnTbjca/rnY/wMxt9VnrQg41mdly103OKnQxQfXaLLScoW698Yf08VzlUgU7cjoL5wENetObu93lZhu8lzBTdj0iPzMTH4bWaPAZ+2YhU+HBTi9sUXIDDqNFMu5IaF0gKUgSPqQ7aQ9b3SOoGX8zoh8M8WRC8M5S0cCtWwVzedu8+AKeuODYIHqmgmtZ/eK9GkYs/Jo5iidfPvjOblL/vgctkMBGkpJnnFfGloA2SYEJBR8HUmOLvEWjbyLu7UVB9U9xtazxUR1d1msG5i2E6V0g3RFvQ/56dEsMl5A3elLYhDqKEH3WvxHkW06A+HSGz244V5B6uwz9JMrH4xu19JQZGnDXC8eZ6NximlEmTMCf/Roq6Vd1WN4MLXi4Mpo9IOlEpmkyJgoKhV6JXbYZ3JSJrdC1fsom4w731itCx7TSvinAR3XoI6/Mst3KplTTRH0Ijo0dfqWGQZhvgKRSxFD1hqC0QV2c/em7Ax8PAiFJeUsi+32Pli7ciq8d4GPLV7V8gxT3/0w70Hhsc5Cl+cC+b4BZafBtha5F8OxkUDpyBrvlq7fxi0kCEMbzeRvT4ZT8GRKYC6RcJ4nNLSmgkqBmvC5t7+c+pod1WWOoVBWJNN5zaa4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN6PR12MB4623.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(136003)(376002)(39860400002)(346002)(2616005)(8936002)(66946007)(66556008)(53546011)(30864003)(66476007)(5660300002)(2906002)(44832011)(31696002)(8676002)(86362001)(6486002)(45080400002)(186003)(83380400001)(478600001)(38100700002)(36756003)(316002)(54906003)(4326008)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2xQbW4xVU5VVnM4N3lrNmZjUEs5SDZpYVlrWkRON1ZrcE0vbk54cTcvWjFR?=
 =?utf-8?B?RVBWaklLL0xxeitURVpTWnZoWW5nRVNTMldXek9EYWhCdGhodWxqVG8zWWdZ?=
 =?utf-8?B?dlNrOHZCdFUycGd6QmdaNTRZeXBvQndtZzNqZm4rcVlvVGRVSlF3N0pyOGRu?=
 =?utf-8?B?OThNdlBvNi91cFdrWWtRVnhKcjdVZ2Rwa1hhL0pwcnpPcjc1ZFIrb0gzSkxZ?=
 =?utf-8?B?M2o4NnUzdmdiejVsaHhKR1oyNUFRU0RxUGd6N0NEWE96MlFyaW5xTVpNb1Nw?=
 =?utf-8?B?cnFsMkZsWE5QdXpDWmNGajBKeDFLVnNRZ0hMQ1NwdUNxUmJwVktONm9lOWwr?=
 =?utf-8?B?WmoreGxab2t3ZW9hYlZYUW1GWVNWNHZFdlFPYUpRUUJYS2RhWWpJRTF5eTNO?=
 =?utf-8?B?V0NCcEZXSVZaS0JTUzF3eGIzcVlmUXpqMm5lLzQ2bFg1MG1qeFBYMngxdDk2?=
 =?utf-8?B?N3NvRC9tZXZPOXhEVDRiSDFSay9qS041RkRlSjdnazdOcThROTBqRGNrdS9L?=
 =?utf-8?B?WWdWajRtd2F4OEdaK2pGb1BXWGhQb3BXUE04NTlKUDcvOHJGUDJ2SzkvcW5k?=
 =?utf-8?B?OVU4YXkwTlVOSGVZbDJ2SDFPbHFOMVhvenFCeFRGR0QvOGFZWjVsSGZQUmRk?=
 =?utf-8?B?bDZRaWpGY3NXYnh5aGpid295WER1cWNUWTV2dlFqU3NzQTF6dXp1c3dJRU5V?=
 =?utf-8?B?MFVhUzl3L25DK2VYR0FkVjdibU1mWEY4Z0JBYVJ5THVLVytSTys1MWZuZ3Yr?=
 =?utf-8?B?YkpTZENNZEdNK3AyL0crUWE3ZFU5K21UTnZ1UmlSUFVocVBIa2dEcWlWVW5u?=
 =?utf-8?B?ZXJmSDVhaEU2YUJ2UHdVbGFoZHZ0SGxobG04bnllOThVMW5nOGpoNDM1YXJx?=
 =?utf-8?B?MnlyRnV3OXpSSzJzVVhpSGFNcFZkTW8xYjN2c1kzL3FLbDNCWHMrcytOeGlm?=
 =?utf-8?B?SlNHSmRURk03cnpjMFU3bnB1VWtYRE8wM2FheGttb0gwMkYyc2tHbHBCd3pz?=
 =?utf-8?B?KzBBbGdJcHdlNnNlUTlJaE50aldDb3kyK28xVHo3bU1lVnpBSFpoSmMzMHNl?=
 =?utf-8?B?aWliYXdRTVJQdVNzWTY3cWplZnZiRXB2N201NERBcHdhMzF2N2JJWHBTNFRv?=
 =?utf-8?B?OCs3Nkd3NStYWm8yZjlqeVBxTFhsQS9ON3hkOGtpbGkydEJkRDRNL0Z5YkR4?=
 =?utf-8?B?ck5jbGlaVjdudlAvQngxU2krRGFkWWducG1iZUsvYmVHMjVRR3VXbDFXdjdo?=
 =?utf-8?B?cXo2bWd3MXA3OTlTU0haazRwcjQzdm80NW9KL29VOHN4WnlQamlQR0gyWExk?=
 =?utf-8?B?L2F0enNzN0dobzlsMGRacW9YWTRKb1hPM2JCNkdQdGFXLzlmdDRvMUZtbDlv?=
 =?utf-8?B?NVJiNVM3M0JPcXp4dVI2YTBwRTNCaEFwa0dHWW42T254aG8rb1BRcHZxNmdx?=
 =?utf-8?B?ZjQveFp5NVdSYzg2WHBJaEhSNVkyVEs2anF0dWZ1V2h3TVp2eXMxbitmRnRy?=
 =?utf-8?B?Q1ZKb1l6UG04M1JoK3NMUkZXT2ZaRnFudTIwZDI2b0RGQWNxV1RlN0MzZk53?=
 =?utf-8?B?S3JFN29ReFM0QjZxTHhFdmtwaDlrWEowTkJkNjlzRVZMVEVzTStjTlMyOXJ4?=
 =?utf-8?B?VGF1SkdDay85c2pDOFYwa1FPWEtITVVyZEEvcnNJWkUySVBrV245Mlh0cUJ6?=
 =?utf-8?B?UStHcGJDOUVzTzduams3eDMrdGFFZDZYNmxHbzhEaGUzN3Z2RG5Ud1RUM0tQ?=
 =?utf-8?B?SkJhZ3J3SWoyUEtVbHg4OCtUTksvUzlHTmYybG0weWdtM3JsaExwdGdrcFlZ?=
 =?utf-8?B?TzhLZ2N0RU1yYXFCWnpsMXplWFNqV3BwOE51dXJvcytWanF3VlkrZmNGcXA3?=
 =?utf-8?Q?POJvsiIfHrRIR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ebbdb11-9b06-42cd-3740-08d95c1d9e91
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB4623.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2021 16:40:53.5718 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0D4yD0db9P2erXWavgmQG00QGbOjNtk7FRogCgdX0W+JyX0Scql5i7dTXgLWluyoFWUT+qwWumkdg1qOtK6Tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2655
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

Reviewed-by: Andrey Grodzovsky <andrey.grodzovsky@amd.com>

Andrey

On 2021-08-09 11:22 p.m., Jingwen Chen wrote:
> From: Jack Zhang <Jack.Zhang1@amd.com>
>
> Why: Previously hw fence is alloced separately with job.
> It caused historical lifetime issues and corner cases.
> The ideal situation is to take fence to manage both job
> and fence's lifetime, and simplify the design of gpu-scheduler.
>
> How:
> We propose to embed hw_fence into amdgpu_job.
> 1. We cover the normal job submission by this method.
> 2. For ib_test, and submit without a parent job keep the
> legacy way to create a hw fence separately.
> v2:
> use AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT to show that the fence is
> embeded in a job.
> v3:
> remove redundant variable ring in amdgpu_job
> v4:
> add tdr sequence support for this feature. Add a job_run_counter to
> indicate whether this job is a resubmit job.
>
> Signed-off-by: Jingwen Chen <Jingwen.Chen2@amd.com>
> Signed-off-by: Jack Zhang <Jack.Zhang7@hotmail.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c  |  1 -
>   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  | 12 +++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c   | 73 ++++++++++++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     | 39 +++++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     |  6 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h    |  5 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      |  2 +-
>   9 files changed, 108 insertions(+), 34 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> index 7b46ba551cb2..3003ee1c9487 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
> @@ -714,7 +714,6 @@ int amdgpu_amdkfd_submit_ib(struct kgd_dev *kgd, enum kgd_engine_type engine,
>   	ret = dma_fence_wait(f, false);
>   
>   err_ib_sched:
> -	dma_fence_put(f);
>   	amdgpu_job_free(job);
>   err:
>   	return ret;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> index 536005bff24a..277128846dd1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
> @@ -1414,7 +1414,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
>   			continue;
>   		}
>   		job = to_amdgpu_job(s_job);
> -		if (preempted && job->fence == fence)
> +		if (preempted && (&job->hw_fence) == fence)
>   			/* mark the job as preempted */
>   			job->preemption_status |= AMDGPU_IB_PREEMPTED;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 9e53ff851496..ade2fa07a50a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4447,7 +4447,7 @@ int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
>   int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   				 struct amdgpu_reset_context *reset_context)
>   {
> -	int i, r = 0;
> +	int i, j, r = 0;
>   	struct amdgpu_job *job = NULL;
>   	bool need_full_reset =
>   		test_bit(AMDGPU_NEED_FULL_RESET, &reset_context->flags);
> @@ -4471,6 +4471,16 @@ int amdgpu_device_pre_asic_reset(struct amdgpu_device *adev,
>   		if (!ring || !ring->sched.thread)
>   			continue;
>   
> +		/*clear job fence from fence drv to avoid force_completion
> +		 *leave NULL and vm flush fence in fence drv */
> +		for (j = 0; j <= ring->fence_drv.num_fences_mask; j ++) {
> +			struct dma_fence *old,**ptr;
> +			ptr = &ring->fence_drv.fences[j];
> +			old = rcu_dereference_protected(*ptr, 1);
> +			if (old && test_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &old->flags)) {
> +				RCU_INIT_POINTER(*ptr, NULL);
> +			}
> +		}
>   		/* after all hw jobs are reset, hw fence is meaningless, so force_completion */
>   		amdgpu_fence_driver_force_completion(ring);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 7495911516c2..a8302e324110 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -129,30 +129,50 @@ static u32 amdgpu_fence_read(struct amdgpu_ring *ring)
>    *
>    * @ring: ring the fence is associated with
>    * @f: resulting fence object
> + * @job: job the fence is embeded in
>    * @flags: flags to pass into the subordinate .emit_fence() call
>    *
>    * Emits a fence command on the requested ring (all asics).
>    * Returns 0 on success, -ENOMEM on failure.
>    */
> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f, struct amdgpu_job *job,
>   		      unsigned flags)
>   {
>   	struct amdgpu_device *adev = ring->adev;
> -	struct amdgpu_fence *fence;
> +	struct dma_fence *fence;
> +	struct amdgpu_fence *am_fence;
>   	struct dma_fence __rcu **ptr;
>   	uint32_t seq;
>   	int r;
>   
> -	fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_KERNEL);
> -	if (fence == NULL)
> -		return -ENOMEM;
> +	if (job == NULL) {
> +		/* create a sperate hw fence */
> +		am_fence = kmem_cache_alloc(amdgpu_fence_slab, GFP_ATOMIC);
> +		if (am_fence == NULL)
> +			return -ENOMEM;
> +		fence = &am_fence->base;
> +		am_fence->ring = ring;
> +	} else {
> +		/* take use of job-embedded fence */
> +		fence = &job->hw_fence;
> +	}
>   
>   	seq = ++ring->fence_drv.sync_seq;
> -	fence->ring = ring;
> -	dma_fence_init(&fence->base, &amdgpu_fence_ops,
> -		       &ring->fence_drv.lock,
> -		       adev->fence_context + ring->idx,
> -		       seq);
> +	if (job != NULL && job->job_run_counter) {
> +		/* reinit seq for resubmitted jobs */
> +		fence->seqno = seq;
> +	} else {
> +		dma_fence_init(fence, &amdgpu_fence_ops,
> +				&ring->fence_drv.lock,
> +				adev->fence_context + ring->idx,
> +				seq);
> +	}
> +
> +	if (job != NULL) {
> +		/* mark this fence has a parent job */
> +		set_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &fence->flags);
> +	}
> +
>   	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
>   			       seq, flags | AMDGPU_FENCE_FLAG_INT);
>   	pm_runtime_get_noresume(adev_to_drm(adev)->dev);
> @@ -175,9 +195,9 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
>   	/* This function can't be called concurrently anyway, otherwise
>   	 * emitting the fence would mess up the hardware ring buffer.
>   	 */
> -	rcu_assign_pointer(*ptr, dma_fence_get(&fence->base));
> +	rcu_assign_pointer(*ptr, dma_fence_get(fence));
>   
> -	*f = &fence->base;
> +	*f = fence;
>   
>   	return 0;
>   }
> @@ -621,8 +641,16 @@ static const char *amdgpu_fence_get_driver_name(struct dma_fence *fence)
>   
>   static const char *amdgpu_fence_get_timeline_name(struct dma_fence *f)
>   {
> -	struct amdgpu_fence *fence = to_amdgpu_fence(f);
> -	return (const char *)fence->ring->name;
> +	struct amdgpu_ring *ring;
> +
> +	if (test_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &f->flags)) {
> +		struct amdgpu_job *job = container_of(f, struct amdgpu_job, hw_fence);
> +
> +		ring = to_amdgpu_ring(job->base.sched);
> +	} else {
> +		ring = to_amdgpu_fence(f)->ring;
> +	}
> +	return (const char *)ring->name;
>   }
>   
>   /**
> @@ -656,8 +684,20 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
>   static void amdgpu_fence_free(struct rcu_head *rcu)
>   {
>   	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
> -	struct amdgpu_fence *fence = to_amdgpu_fence(f);
> -	kmem_cache_free(amdgpu_fence_slab, fence);
> +
> +	if (test_bit(AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT, &f->flags)) {
> +	/* free job if fence has a parent job */
> +		struct amdgpu_job *job;
> +
> +		job = container_of(f, struct amdgpu_job, hw_fence);
> +		kfree(job);
> +	} else {
> +	/* free fence_slab if it's separated fence*/
> +		struct amdgpu_fence *fence;
> +
> +		fence = to_amdgpu_fence(f);
> +		kmem_cache_free(amdgpu_fence_slab, fence);
> +	}
>   }
>   
>   /**
> @@ -680,6 +720,7 @@ static const struct dma_fence_ops amdgpu_fence_ops = {
>   	.release = amdgpu_fence_release,
>   };
>   
> +
>   /*
>    * Fence debugfs
>    */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> index ec65ab0ddf89..c076a6b9a5a2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
> @@ -262,7 +262,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
>   				       fence_flags | AMDGPU_FENCE_FLAG_64BIT);
>   	}
>   
> -	r = amdgpu_fence_emit(ring, f, fence_flags);
> +	r = amdgpu_fence_emit(ring, f, job, fence_flags);
>   	if (r) {
>   		dev_err(adev->dev, "failed to emit fence (%d)\n", r);
>   		if (job && job->vmid)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index d33e6d97cc89..7da9c1855bd0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -127,11 +127,16 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
>   {
>   	struct amdgpu_ring *ring = to_amdgpu_ring(job->base.sched);
>   	struct dma_fence *f;
> +	struct dma_fence *hw_fence;
>   	unsigned i;
>   
> -	/* use sched fence if available */
> -	f = job->base.s_fence ? &job->base.s_fence->finished : job->fence;
> +	if (job->hw_fence.ops == NULL)
> +		hw_fence = job->external_hw_fence;
> +	else
> +		hw_fence = &job->hw_fence;
>   
> +	/* use sched fence if available */
> +	f = job->base.s_fence ? &job->base.s_fence->finished : hw_fence;
>   	for (i = 0; i < job->num_ibs; ++i)
>   		amdgpu_ib_free(ring->adev, &job->ibs[i], f);
>   }
> @@ -142,20 +147,27 @@ static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
>   
>   	drm_sched_job_cleanup(s_job);
>   
> -	dma_fence_put(job->fence);
>   	amdgpu_sync_free(&job->sync);
>   	amdgpu_sync_free(&job->sched_sync);
> -	kfree(job);
> +
> +    /* only put the hw fence if has embedded fence */
> +	if (job->hw_fence.ops != NULL)
> +		dma_fence_put(&job->hw_fence);
> +	else
> +		kfree(job);
>   }
>   
>   void amdgpu_job_free(struct amdgpu_job *job)
>   {
>   	amdgpu_job_free_resources(job);
> -
> -	dma_fence_put(job->fence);
>   	amdgpu_sync_free(&job->sync);
>   	amdgpu_sync_free(&job->sched_sync);
> -	kfree(job);
> +
> +	/* only put the hw fence if has embedded fence */
> +	if (job->hw_fence.ops != NULL)
> +		dma_fence_put(&job->hw_fence);
> +	else
> +		kfree(job);
>   }
>   
>   int amdgpu_job_submit(struct amdgpu_job *job, struct drm_sched_entity *entity,
> @@ -184,11 +196,14 @@ int amdgpu_job_submit_direct(struct amdgpu_job *job, struct amdgpu_ring *ring,
>   
>   	job->base.sched = &ring->sched;
>   	r = amdgpu_ib_schedule(ring, job->num_ibs, job->ibs, NULL, fence);
> -	job->fence = dma_fence_get(*fence);
> +	/* record external_hw_fence for direct submit */
> +	job->external_hw_fence = dma_fence_get(*fence);
>   	if (r)
>   		return r;
>   
>   	amdgpu_job_free(job);
> +	dma_fence_put(*fence);
> +
>   	return 0;
>   }
>   
> @@ -246,10 +261,12 @@ static struct dma_fence *amdgpu_job_run(struct drm_sched_job *sched_job)
>   		if (r)
>   			DRM_ERROR("Error scheduling IBs (%d)\n", r);
>   	}
> -	/* if gpu reset, hw fence will be replaced here */
> -	dma_fence_put(job->fence);
> -	job->fence = dma_fence_get(fence);
>   
> +	if (!job->job_run_counter)
> +		dma_fence_get(fence);
> +	else if (finished->error < 0)
> +		dma_fence_put(&job->hw_fence);
> +	job->job_run_counter ++;
>   	amdgpu_job_free_resources(job);
>   
>   	fence = r ? ERR_PTR(r) : fence;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> index 81caac9b958a..9e65730193b8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
> @@ -46,7 +46,8 @@ struct amdgpu_job {
>   	struct amdgpu_sync	sync;
>   	struct amdgpu_sync	sched_sync;
>   	struct amdgpu_ib	*ibs;
> -	struct dma_fence	*fence; /* the hw fence */
> +	struct dma_fence	hw_fence;
> +	struct dma_fence	*external_hw_fence;
>   	uint32_t		preamble_status;
>   	uint32_t                preemption_status;
>   	uint32_t		num_ibs;
> @@ -62,6 +63,9 @@ struct amdgpu_job {
>   	/* user fence handling */
>   	uint64_t		uf_addr;
>   	uint64_t		uf_sequence;
> +
> +	/* job_run_counter >= 1 means a resubmit job */
> +	uint32_t		job_run_counter;
>   };
>   
>   int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 9c11ced4312c..03d4b29a76d6 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -48,6 +48,9 @@
>   #define AMDGPU_FENCE_FLAG_INT           (1 << 1)
>   #define AMDGPU_FENCE_FLAG_TC_WB_ONLY    (1 << 2)
>   
> +/* fence flag bit to indicate the face is embeded in job*/
> +#define AMDGPU_FENCE_FLAG_EMBED_IN_JOB_BIT		(DMA_FENCE_FLAG_USER_BITS + 1)
> +
>   #define to_amdgpu_ring(s) container_of((s), struct amdgpu_ring, sched)
>   
>   #define AMDGPU_IB_POOL_SIZE	(1024 * 1024)
> @@ -118,7 +121,7 @@ void amdgpu_fence_driver_hw_init(struct amdgpu_device *adev);
>   void amdgpu_fence_driver_hw_fini(struct amdgpu_device *adev);
>   int amdgpu_fence_driver_sw_init(struct amdgpu_device *adev);
>   void amdgpu_fence_driver_sw_fini(struct amdgpu_device *adev);
> -int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence,
> +int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **fence, struct amdgpu_job *job,
>   		      unsigned flags);
>   int amdgpu_fence_emit_polling(struct amdgpu_ring *ring, uint32_t *s,
>   			      uint32_t timeout);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 2a88ed5d983b..2af8860d74cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1218,7 +1218,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
>   		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
>   
>   	if (vm_flush_needed || pasid_mapping_needed) {
> -		r = amdgpu_fence_emit(ring, &fence, 0);
> +		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
>   		if (r)
>   			return r;
>   	}
