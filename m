Return-Path: <SRS0=KKXi=LR=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D150BC4743C
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 18:52:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FCA9611AD
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jun 2021 18:52:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FCA9611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A5396E977;
	Wed, 23 Jun 2021 18:52:26 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2064.outbound.protection.outlook.com [40.107.220.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 691286E977
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jun 2021 18:52:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cm2GFA+l/LF6o6mxAl2CrsVz6FI9lxUjldDapNrC8OTHmc6ew4k0YZYU5yeLW6RXU9d8OXHmaS8cIOn+9flQU1YZevXvNAqjLTDJ7PZ7UwCX9NcYBM6h336hAw5k25RC0XaIjdxLe4kAUm3tZrqH6nA7mq+7wmCII2kVDIm8jC2IqyipdSRPVVhTzP/GqgD2DUL0en87Fkh0dNIzCDUMPQs1iAYurbkJKxsHyNTuzw9fJ14u2Iyjl9qCFdIGZUorvs7qHPm/nEjA0WBIxWrWIjgYYIR/OGXdLZYMvONACFBZ9NV8YoLYF5kEpzv4ihRCH2wgqfWBn5b5N0cFqsMojg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vYi83lK+mME0R6j/Qs/awVy1xmPZzmTDD0Qedy+pGw=;
 b=PICz8T3KHbRAM5tsk4icB1R+GHC38V1z5vQJeu01GyVi9rO1LBHdwdyDMqXj648XkT1RFu2+mukSBJVR/vfvARTmNAnx5dTBOq+wiqis2VkLeKpAhMxhnzojD5iudeBic3hzykVp/aMcxTWJb6p2dbmaqhk/Jh9xiWNFnGZSR3mzE9m1ySrF0+0JERJmJuBKrqzW0PV8FzgRPmQXP9RJCaR8hBBGo5DJqZdNZOAm6vP7Zepo/AMzBP6+/grjuqHogVxtjFi1r+EFpueFBUtTWjxLXBgnEFOWgdj58Nh8VzqroTLWEfWsSrojcuUDuR0bUiqQ8crDX+QVIu/Z/MdQag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vYi83lK+mME0R6j/Qs/awVy1xmPZzmTDD0Qedy+pGw=;
 b=gMpY6UDGxmAkyIVN8mLpOTlr5xG63nPifFZqnA3bgXx98O/cOdSL/3ev7kxJzfdI+NpmLbQzV5k69QvOlubuHqkkxz7/1ceDGp7zCp8YQcsUM7j0qzVm08gCNtpsx9PC+5+1h7kuCfDV1P9rd/UB/C395CU5fW+OhqvyYudsGpo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5129.namprd12.prod.outlook.com (2603:10b6:408:136::12)
 by BN9PR12MB5365.namprd12.prod.outlook.com (2603:10b6:408:102::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Wed, 23 Jun
 2021 18:52:23 +0000
Received: from BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd]) by BN9PR12MB5129.namprd12.prod.outlook.com
 ([fe80::3c78:e58b:fba7:b8dd%6]) with mapi id 15.20.4242.025; Wed, 23 Jun 2021
 18:52:23 +0000
Subject: Re: [PATCH v2 4/4] drm/amdkfd: implement counters for vm fault and
 migration
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20210622133213.21393-1-Philip.Yang@amd.com>
 <20210623150202.31811-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
Message-ID: <623fd188-e4ac-0144-3bd2-094fa5020e9a@amd.com>
Date: Wed, 23 Jun 2021 14:52:20 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
In-Reply-To: <20210623150202.31811-1-Philip.Yang@amd.com>
Content-Language: en-US
X-Originating-IP: [165.204.55.251]
X-ClientProxiedBy: YTBPR01CA0035.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:14::48) To BN9PR12MB5129.namprd12.prod.outlook.com
 (2603:10b6:408:136::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [172.27.226.80] (165.204.55.251) by
 YTBPR01CA0035.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:14::48) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4264.18 via Frontend Transport; Wed, 23 Jun 2021 18:52:22 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8b25e4eb-85fc-43e1-8da7-08d936780927
X-MS-TrafficTypeDiagnostic: BN9PR12MB5365:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN9PR12MB5365E74E770A7E2B0E3F9EAC92089@BN9PR12MB5365.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bYo7Zkfh30oiUlCnDRZ2lDaLfUo1qKyjfU+VnE0QNHyw4/1gceJ2PCarmyYKHHpLxiNWc65RYmkAGPahEQ8wMT/W0Fhn6u5Mv7pOkbBeW5jXGal6Avd/zVEJM9+E06NCMSCwYMjE55CsH02bs8517Bf4Unr0srun85hs/cUdD81mtYJWk75PEgsfTe0maCfTorUpxAuLajpdyxOII+mM/vEvtiUaDRsUNyC4Agv1LVnaJ997jJwone8oo0RxM4eOdbyprU6jM10+Dj+2y6dOLy0ObhCfZxme0d5eCIrxuyspItV52jBSZAIGt4IwCs6MbFmiNxDX4tUVTSE7ALtHD9h0sWKWglKDR3C3JCs2EnMUCqpq2yon2vFHNqQUjIBQW7G6zcQ8zLV1h0kTrvblF6hczFBDbQ4W3FBJreHgTKpW76hpk3kLoV8rErB/CBZzuZx3kw5/f2bXoD86wJ/iSw2ismHQgAiNidEQQHkSBuAs06AeDQbQ4eFSz20TZMEdurdcJRQdIZrPYDClA17RbMT7Z4Uw6CA/tk1bRfKsh2YmWKFiXkBmkNAY+ZDi8tbBVHzBXzioeIDakx9rfkU7wSz4KfM2zKmIFPfRYq4fzsH4OzDuPtj6n4TE5zD31TeUp1j+NB2mth7PeSK4Chm7kyPW+kSIr3bcoWunQ+s0imhztqbXi0HmF+Mpk58Lumzc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5129.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(53546011)(186003)(86362001)(8936002)(6486002)(316002)(16526019)(44832011)(478600001)(36756003)(31696002)(31686004)(16576012)(8676002)(2616005)(2906002)(36916002)(83380400001)(38100700002)(956004)(66946007)(66476007)(66556008)(26005)(5660300002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnNWQnBHTmtrem5FL1hLYis1UStpKzVBc09IU1ZKV0NuTGh1N2lrVUk1WHpr?=
 =?utf-8?B?b1hqV2grbml1TUFyS2l1K2pEY2dMT2FGUVhTN1ZXVGtXL0ZNbWdYUlJjcXF4?=
 =?utf-8?B?ZWg3YklMc3Q1elNmZjZKUmVQdTNBbDB5bUxnTnBBbEdzSngvR3dndGFoTU1K?=
 =?utf-8?B?TDJUSkQvOEVuWHVDWU5WUFpRNy9MVy9tcFVoN0VmZTduZ0pEYXM1SCtHcGhv?=
 =?utf-8?B?N28rNjlxbHNzcGRYaCsxL1F5QlJKL3BPc2lSb0RyR1N5WkkzdzBnVGp4TzRP?=
 =?utf-8?B?dzBVQ2hJUjVYZXFqbGk2d0pPc1RwZlR5UC85ZWZGc1FrWUJuVG9VcmVTd1l6?=
 =?utf-8?B?dmRoZWYvbFFaL0ZxWmhKd3E0eUoyazlYYk5oRjdUbHZQTm5uclp3eG9Ic0dY?=
 =?utf-8?B?bTQ3ektHTDJQbW5sR0pycWJCbWhPTUhJYUdFcllmSzdaNW5hRWtFRC8xTS9V?=
 =?utf-8?B?T1JoT016ZmQwMWs5T05aREp3WVBJSThnOWgxNm9CTXdWZzZla2QzdkdxQ2N4?=
 =?utf-8?B?MW5SREp1ZDNmUUg1TzhGNkhpY1Q0U0s5WGJvMDlocjJSeUpuVFE0QjVxdnVO?=
 =?utf-8?B?K2szUXVKUGJNQUFHc09jWm9XM1UwRVo0Smgyb1RLWWIyenJFa3RTZWpGWktx?=
 =?utf-8?B?MjJnaWhWazNrZWxNbjJQQTZuWWVpVTZvZ2ltakFCVWVaQysvdFhnZXRGSWZO?=
 =?utf-8?B?LzBZTW9yVFZYa28ycWxPUTkyZGxIRzFtYVI1N3BBOTY0ZVpxWUl0c1FTRjhD?=
 =?utf-8?B?MTlnWG02UmpSZ21BT01Va0dqM0xyR2QzZlhPby9zUWk1VGhFZXA1NjBiOS9v?=
 =?utf-8?B?Njkwak4wL3VTT1QxODVSaEVLMUJLUWdlUElGQ2RlakRFbG8zWDJyZVhtbm5S?=
 =?utf-8?B?aExYZllFYlZLcTl3UG9WTVJsU3F5ZUhzV3NweVVnYmdudmovTmVVSkI2TmRy?=
 =?utf-8?B?U3FuVEMzL3Fla2E1MzRRZG15U0h6bFFjbmsvdytidElVUDF4UmNXcEZ6aXdk?=
 =?utf-8?B?Y09lRE84Z0l5aVFPVjE0V0x2U29sbktZbU9DcjlabmVQNGVsY0w2akNKQjE1?=
 =?utf-8?B?S1dPcFpkMUFDWkJvQmpqNlloWStOOUNsaHl3OHErbllVa1hCSEhDYXJJOTFL?=
 =?utf-8?B?ZDVoOGNjVDIxQ1Vaa2RXcjA1RTVuZnpnQmhXVEp1Ry9PeG90WU1ueHduMmNT?=
 =?utf-8?B?ME1reVdnLzNPaGs3eTUyNWkyOWhJWlQ5V2NYRXBtMjBVSmZHM2ZWdEpzWFhN?=
 =?utf-8?B?cEF2ZkdtV2NRRVV6MFlFS0VhdUt1MGF0SUlBeVJ2QTdJcTlFUTNXTEVUaGZT?=
 =?utf-8?B?MUNyYUQzdGduUUlRdkp5d04walZ1ZW0rcTVnNzVKSnYzS1M4RU45cTdxTldF?=
 =?utf-8?B?K3R5T2hHTnpqcjI1bVFHZFhjanQ1b0RNT2ZFTGEyN2NFSVo0Y3NLZ0RienFQ?=
 =?utf-8?B?ZGNSdG9SM0NMQVB0WUk1SkVXR1JyRTJ5MUJkWUtrWjFjYTVpaXhpKzg4L042?=
 =?utf-8?B?d1dvM1F6TDBETDkzNWYzRzFPUmlXcGQzVlJNT29KL2RsTFZvVys5T1VsUUkx?=
 =?utf-8?B?dk1yU3dUcXZqTVBGUnJSWEgwQXJxYTVPTCtRclNSc3JKdWQ5K2I0azJ3VWZU?=
 =?utf-8?B?RVRScmM2QkQvRkFmZnVKdklNTVVuUmhBdStWc3VqL2hMTzRyM1J4S1oweTIw?=
 =?utf-8?B?T3JnQlhkeVlkdERUS3RFandWZUVId0g0bGw1RktoSEY3SGFwejZVVjBiM0th?=
 =?utf-8?Q?knfCEBVCkqFwgRJsZRkUQABJo7Y8Uj73Z1DxuKg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b25e4eb-85fc-43e1-8da7-08d936780927
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5129.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2021 18:52:22.9707 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PKUpzAXdv3AiLrjoRjC+nuH4PyQIS23pL1Y4mShj/x8Dqmsd/gnPncIVRbCbrbismGlcQbXKp9MM+zfLEi6bXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5365
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

On 2021-06-23 11:02 a.m., Philip Yang wrote:
> Add helper function to get process device data structure from adev to
> update counters.
>
> Update vm faults, page_in, page_out counters will no be executed in
> parallel, use WRITE_ONCE to avoid any form of compiler optimizations.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 14 ++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 45 +++++++++++++++++++++++-
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h     |  2 ++
>   3 files changed, 60 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index fd8f544f0de2..45b5349283af 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -413,6 +413,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   			uint64_t end)
>   {
>   	uint64_t npages = (end - start) >> PAGE_SHIFT;
> +	struct kfd_process_device *pdd;
>   	struct dma_fence *mfence = NULL;
>   	struct migrate_vma migrate;
>   	dma_addr_t *scratch;
> @@ -473,6 +474,12 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   out_free:
>   	kvfree(buf);
>   out:
> +	if (!r) {
> +		pdd = svm_range_get_pdd_by_adev(prange, adev);
> +		if (pdd)
> +			WRITE_ONCE(pdd->page_in, pdd->page_in + migrate.cpages);
> +	}
> +
>   	return r;
>   }
>   
> @@ -629,6 +636,7 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   		       struct vm_area_struct *vma, uint64_t start, uint64_t end)
>   {
>   	uint64_t npages = (end - start) >> PAGE_SHIFT;
> +	struct kfd_process_device *pdd;
>   	struct dma_fence *mfence = NULL;
>   	struct migrate_vma migrate;
>   	dma_addr_t *scratch;
> @@ -678,6 +686,12 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   out_free:
>   	kvfree(buf);
>   out:
> +	if (!r) {
> +		pdd = svm_range_get_pdd_by_adev(prange, adev);
> +		if (pdd)
> +			WRITE_ONCE(pdd->page_out,
> +				   pdd->page_out + migrate.cpages);
> +	}
>   	return r;
>   }
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 7f5ebc00b349..00b46846a5e0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -564,6 +564,24 @@ svm_range_get_adev_by_id(struct svm_range *prange, uint32_t gpu_id)
>   	return (struct amdgpu_device *)pdd->dev->kgd;
>   }
>   
> +struct kfd_process_device *
> +svm_range_get_pdd_by_adev(struct svm_range *prange, struct amdgpu_device *adev)
> +{
> +	struct kfd_process *p;
> +	int32_t gpu_idx, gpuid;
> +	int r;
> +
> +	p = container_of(prange->svms, struct kfd_process, svms);
> +
> +	r = kfd_process_gpuid_from_kgd(p, adev, &gpuid, &gpu_idx);
> +	if (r) {
> +		pr_debug("failed to get device id by adev %p\n", adev);
> +		return NULL;
> +	}
> +
> +	return kfd_process_device_from_gpuidx(p, gpu_idx);
> +}
> +
>   static int svm_range_bo_validate(void *param, struct amdgpu_bo *bo)
>   {
>   	struct ttm_operation_ctx ctx = { false, false };
> @@ -2311,6 +2329,27 @@ static bool svm_range_skip_recover(struct svm_range *prange)
>   	return false;
>   }
>   
> +static void
> +svm_range_count_fault(struct amdgpu_device *adev, struct kfd_process *p,
> +		      struct svm_range *prange, int32_t gpuidx)
> +{
> +	struct kfd_process_device *pdd;
> +
> +	if (gpuidx == MAX_GPU_INSTANCE)
> +		/* fault is on different page of same range
> +		 * or fault is skipped to recover later
> +		 */
> +		pdd = svm_range_get_pdd_by_adev(prange, adev);
> +	else
> +		/* fault recovered
> +		 * or fault cannot recover because GPU no access on the range
> +		 */
> +		pdd = kfd_process_device_from_gpuidx(p, gpuidx);
> +
> +	if (pdd)
> +		WRITE_ONCE(pdd->faults, pdd->faults + 1);
> +}
> +
>   int
>   svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   			uint64_t addr)
> @@ -2320,7 +2359,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	struct svm_range *prange;
>   	struct kfd_process *p;
>   	uint64_t timestamp;
> -	int32_t best_loc, gpuidx;
> +	int32_t best_loc;
> +	int32_t gpuidx = MAX_GPU_INSTANCE;
>   	bool write_locked = false;
>   	int r = 0;
>   
> @@ -2440,6 +2480,9 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   out_unlock_svms:
>   	mutex_unlock(&svms->lock);
>   	mmap_read_unlock(mm);
> +
> +	svm_range_count_fault(adev, p, prange, gpuidx);
> +
>   	mmput(mm);
>   out:
>   	kfd_unref_process(p);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 0c0fc399395e..a9af03994d1a 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -174,6 +174,8 @@ void svm_range_dma_unmap(struct device *dev, dma_addr_t *dma_addr,
>   			 unsigned long offset, unsigned long npages);
>   void svm_range_free_dma_mappings(struct svm_range *prange);
>   void svm_range_prefault(struct svm_range *prange, struct mm_struct *mm);
> +struct kfd_process_device *
> +svm_range_get_pdd_by_adev(struct svm_range *prange, struct amdgpu_device *adev);
>   
>   /* SVM API and HMM page migration work together, device memory type
>    * is initialized to not 0 when page migration register device memory.
_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx
