Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71518C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Dec 2022 17:30:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D265B10E237;
	Mon, 12 Dec 2022 17:30:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11C1310E237
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Dec 2022 17:30:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cq/WYJ1vUkqy4QIMD928amZ/MJ5DR5rpuSaczF0NKZ9jKhW4Ks61ORBC8CCxAvkDcfEVqxe1Yx5L63gQNtkKnHL7mNoiD28xmFruwXT6RNij4T1HZ1ZIC9UWYSA0tzb7w/ziaJ5REi8iGmapVuMLiAhCxmfsIpVdpI7DdsxZQU4F4FE2aU8qzGo7fFeRxJBVAKdMY2WQah8770y5SENI30Bq/8V7/WfUGAYu0TA0sCwFn2eCGlX3TMqNHbiF6nMXJSDFMz7ZD5rdDCJHOdXFREPuvQJ4yTlH5X/JgcRe/CiYSMfE6KHBq672/6+Q3KcEWxjwQic7dZPykfUR1rLimQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGBMzD6ilqQfdplNtIk3IL1kiPo5C1L/xMZU0G8GUqw=;
 b=byxo03aZtVA8aoy3QY8F+erHXti9znkty915NNQfF+jlyKcdsSZcwfbXmyYio5sVkRYMvmfJ0ww6ehgrdWLzAjAvdeK26MRWDuBYLQFMqlleAESHvs10YIQTXNdK0tdkBGuh7uzbWs84UW36C6CYkUDY9e5J1fasImj+mOgxh5yCjWi01c/bLVcHrFyxjDRj63BKp9O4Ij4UJ3mYWg96snbNl9sRWqhPU7efu409eD9HygBhv8OXINJlB+Iq2Dy0ThXAJUjwi11R9NNcisLk0Ji/4Du2qXLg+3sDqH+3DBemiPebtka5dFKk9FWUowyFeOVXICKkHsdf60lvvExxcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGBMzD6ilqQfdplNtIk3IL1kiPo5C1L/xMZU0G8GUqw=;
 b=WJ1qBAG8rg8go3NAsoDGAqtNdmbc4+xcpTUhSKwLCuB6PeRFaDajgtS3uYoJEltccgnYzbQDV71TVaJLvXRZnBjxM21YRsFMvxgBMh/IMpTl3NOGfKXNBGKQpNQqRgf76EMDYlFUoZT58h3rnPh5Ptu79Lhq3vuIz0hmF66HHJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DS7PR12MB6024.namprd12.prod.outlook.com (2603:10b6:8:84::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Mon, 12 Dec
 2022 17:30:01 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5880.019; Mon, 12 Dec 2022
 17:29:59 +0000
Message-ID: <655a1045-dbcc-dd4b-fcf6-6bc28ec3e8a3@amd.com>
Date: Mon, 12 Dec 2022 12:29:58 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] drm/amdgpu: revert "generally allow over-commit during BO
 allocation"
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 amd-gfx@lists.freedesktop.org
References: <20221212163359.3251969-1-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221212163359.3251969-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0010.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|DS7PR12MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd807a0-f6b4-4424-f1f5-08dadc667e94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6caXPZ1D8npBNyGn0N313ptiIFUFGdWZkfIY6NHhjo5NHaW5efMopZIFCJYwiujCxfxrl9Ew38pTANdOlDzxWKXBTKUFerZkO1S4RO8P1eTTgPh3zg5r56UTX3J0P91h5tHJRX8ndNvTz0xjnsufa3YYWYWoZXRF8KBdTQO999+2hXsPbG3tNEFFBznfeB/e/WNuOBX87XgNrE3bKkKuoULJS0f11Man64XcIvFItaefoxsq2sVQACqA5VFS6N4QUECTauLP9HeOPQIkgr0CYPP4+S1mb1tiSgOFNdUWaJl9YFKC9XcUSZVDKrtl2CkpE0y34ipO4bONYBUpGuMr7a78eNYF0GOGEm8QoytHzg3KYQJR3aF4MPSzFQiU6f2TF80rFPyGU9JoIgE31VUtdx4oun5IiRjVbX+HX1avv7HjzJXSXGPsaoQj/ysfAPqX9cHTCGhp96Mxh+Db60driNpKwDyUKFto1FM/qkWJZhQhBbqenN14aqPZ9/Ci7/H+mteAWUnZcw2HnT/lbhABM2dhVCbHQ3sNbh/mQggnPQ/amffPa5A2pD8IRYjYVW5opb6MMZ5oVA2ZalTAXW0nmydql9domfkrAVlPeOBKZbBTOjsd0ap4S4EXTpammixKnkTkgGjXhMaZ0F62PqMp3vL5JvD3/MnydWvQPw0wePX6p2tZpbYTWTUcL8nSV/GCGIBA12RtO9gMjErjYZM+RMSVlz42Pj1nW8tMXUeAUCs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(136003)(366004)(346002)(376002)(396003)(451199015)(2906002)(4001150100001)(31686004)(44832011)(38100700002)(86362001)(36756003)(41300700001)(6512007)(66476007)(6506007)(53546011)(5660300002)(316002)(26005)(66556008)(66946007)(8676002)(8936002)(478600001)(6486002)(31696002)(66574015)(36916002)(186003)(83380400001)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTQxR0dMYi83OC9aR0hPRDhQTEpHbFE2TkFPakd6V1NHSU0rdjIvWWxnUHRD?=
 =?utf-8?B?c1NpcDVZNzl3NjY0NDFSRTlrOW9OWk5FN1dxUld2UWtSTTZ1eE0wakFzbHpI?=
 =?utf-8?B?cW5udlBuZDBhQzFsdzcrOWdVOFRSNUhoWmNoSmtHckpIRCtBNzZQUWYxWjQ0?=
 =?utf-8?B?MCsvVnIrZmlPN2tWVVZ5bkZzRUxOMnlrdlY1MDNqVUVNL0NORExjSTBsbldD?=
 =?utf-8?B?akJiUk1qK3pxc2xNNzk3QjYyVzVuY1JtQ0VxSlhLUFlzV1Y5b2Q3dVVpQTRP?=
 =?utf-8?B?RkZ3YnZ0VnFCcUdLRGNRUTYrM1piYXI4YmRGcTc0cTdwbVFSdWg4dGxackZ1?=
 =?utf-8?B?bVZJM3E3YllPYTlmNkw3NGVPajAyc3BWbkJSZlZjZG5ocnF2YjF0cWk4dTJU?=
 =?utf-8?B?YVp5aUsvOER6ZFNnU3REZVBXOHRJSUZaTnFsNlUwR3JTZytNQSttOEd3UXUr?=
 =?utf-8?B?NUozN0xTTEVXcFJiVEozc3hXWURkTDFKQ3FqU2huU25lQUE3bkZ4d2FqUGFZ?=
 =?utf-8?B?S1dmZWJ6OFJCcHdRV29CbDlaNXJET3UrcUUwQ2N0d3RWd2JtYmNEWldiaHRS?=
 =?utf-8?B?anBwNkpsSmpjblRyVS91dzVNa2Y2V2sxMGJkV1lZb2EwR1l6VCtqNXgzdDg3?=
 =?utf-8?B?Y091TlRkZms0WTF3VlFoUWo1UFEyYWZJQlhwZTFHNXYySXNidGdocDg3K0VU?=
 =?utf-8?B?TEpoUks3OVVSODZKVVZ1UnR5KzZRNitQbHVDTU9nTldsY0ZyQ1JhOVJINmZK?=
 =?utf-8?B?cGt4Ym5KY3dqTmxCbXRIQmVSV2hRQ1dCVU9MVHNlRHYvQm44OTZSL21ScXdO?=
 =?utf-8?B?UXFINDB1NkRnVDNXSDdGeUdzQjRRQ3FuTHZFdFc5MW40ZjFSWDhCUjVXUTVU?=
 =?utf-8?B?b21wNXRzNkUrZXE4Y2U0emxnUmVSMk44OFl3L3JlS2lieUQwalRadkE2Ujcv?=
 =?utf-8?B?ekNLaGVuOUxXOUEwWW13SnZBeFg3VG1UdDBDMDk0Szg3bVJxSWFXWUdoK0d3?=
 =?utf-8?B?cGVxOHZ0ZE53cE1NTmhLRHpMcHMwRnhQd0kwMmhxYVRtTzV4SDE1TzdMSGdS?=
 =?utf-8?B?WVlhTmQ2WHZ4ZElYbHJBL2syUU1VTnpxOTJaN1lIWkJwOE9RZDVYN2RiUzlh?=
 =?utf-8?B?Z3ZVclpFQXkzREQ4UTV4TzExeXMrWlNnUEpUNTBVeEkwTUIrS3F3QmJPUzZD?=
 =?utf-8?B?S0lobUlLZDVySVpEbFF2cVNHd0lUdThGSzR1R3FUYU5iRWNWL2Q2b2U4Uzly?=
 =?utf-8?B?c2dHaUZ4NHRFVTVGS3RyTzlHUmhCd251V3E4YVRHRFY2S3BLY1dIeng3SjY3?=
 =?utf-8?B?TVBrMHcyeVh1L0hYU2x0d3Y1U0tZc1d3RnJNVFN5MTVlQk9Hak9PUS9EMFpG?=
 =?utf-8?B?L3JveFFTbThKSWp5TWppaHJtN29aMVB6eWlkbFgzZjFXcEFhUldHRE5sL3lX?=
 =?utf-8?B?NzBiT2lOb0Q1MHY5UVF1anRveFVsY0VYZHk3UGNiL3IwNTd3U3BrcFZBL1JF?=
 =?utf-8?B?TzM5TXJkMFJIalFzQ2V5eGdhM0hQTkQ3WFBJWml2NjhQblFsRlZGbmRpRndk?=
 =?utf-8?B?cmNwZlFIMzQ1eE5TN0tXQ0NvRW51NytRSE4yS2hQRkFOcFZyeWYwUXlsQ3Jh?=
 =?utf-8?B?cmNQVFpoMSs1U1RFYjh3ckQ1bFFOT002MVNHZ0NuL0tnUDhKSGR4UHEybFMy?=
 =?utf-8?B?MHl2ejRhSEM4Vk5GZFJBUXg3aWN3OVdhd3MrU3FyYzJONzBDaGs2YWxINVVO?=
 =?utf-8?B?ZGN1cTNHOEtKM2ZXYmZkVi9XT3hHeXBrQ25wYWMrd2x0aTR4OGpuZm1mcTdO?=
 =?utf-8?B?eThETlRjeGMwajhmbldsbVdROXcxT2ErWXFiTkF5L2FNTWN2STJkTnFJa3ZY?=
 =?utf-8?B?aFdEUWprSFpFYnZRbjhtU1dCOWp1MEgyUDBUd1g0WkxQK2NCSjNzT08wd2Ir?=
 =?utf-8?B?YTFBclhlTm9XZ0w0M1N6YnpKclBKemJkbzB2YU82b0hpVCtUb1hyWlVEemFq?=
 =?utf-8?B?bHVGR1JKb3JaN0lNTXRmdzZ4OWxHYTc4ZWlEZTlvQi8yMUxKU3gvaXZrSEtm?=
 =?utf-8?B?ZVRGNjFTZ3llVEovUUtQS2QzSSs5VksxUTBtWi9GdlVyZ0RhUnpJckpNUXVQ?=
 =?utf-8?Q?apNj1MB2rDI1CnYW2lthJ+46N?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd807a0-f6b4-4424-f1f5-08dadc667e94
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2022 17:29:59.6374 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wD0Y/CgO0Gp+I3MhttF7+heS/xNlSTml57lXFBoUBeo0gyRlD2AwfV15hp4zx4vbvBBRErtlecOWATtkFxbdyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6024
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

On 2022-12-12 11:33, Christian König wrote:
> This reverts commit 4ec11490081bcbc4b90d20622cd211c6eba8d6fc.
>
> This causes problem for KFD because when we overcommit we accidentially
> bind the BO to GTT for moving it into VRAM. We also need to make sure
> that this is done only as fallback after trying to evict first.
>
> Signed-off-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 16 +++++++++++++---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  6 +++++-
>   2 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 62e98f1ad770..a0780a4e3e61 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -113,7 +113,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
>   	bp.resv = resv;
>   	bp.preferred_domain = initial_domain;
>   	bp.flags = flags;
> -	bp.domain = initial_domain | AMDGPU_GEM_DOMAIN_CPU;
> +	bp.domain = initial_domain;
>   	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
>   
>   	r = amdgpu_bo_create_user(adev, &bp, &ubo);
> @@ -332,10 +332,20 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>   	}
>   
>   	initial_domain = (u32)(0xffffffff & args->in.domains);
> +retry:
>   	r = amdgpu_gem_object_create(adev, size, args->in.alignment,
> -				     initial_domain, flags, ttm_bo_type_device,
> -				     resv, &gobj);
> +				     initial_domain,
> +				     flags, ttm_bo_type_device, resv, &gobj);
>   	if (r && r != -ERESTARTSYS) {
> +		if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED) {
> +			flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> +			goto retry;
> +		}
> +
> +		if (initial_domain == AMDGPU_GEM_DOMAIN_VRAM) {
> +			initial_domain |= AMDGPU_GEM_DOMAIN_GTT;
> +			goto retry;
> +		}
>   		DRM_DEBUG("Failed to allocate GEM object (%llu, %d, %llu, %d)\n",
>   				size, initial_domain, args->in.alignment, r);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index fd3ab4b5e5bb..871f7c136de5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -582,7 +582,11 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>   		bo->flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
>   
>   	bo->tbo.bdev = &adev->mman.bdev;
> -	amdgpu_bo_placement_from_domain(bo, bp->domain);
> +	if (bp->domain & (AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA |
> +			  AMDGPU_GEM_DOMAIN_GDS))
> +		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
> +	else
> +		amdgpu_bo_placement_from_domain(bo, bp->domain);
>   	if (bp->type == ttm_bo_type_kernel)
>   		bo->tbo.priority = 1;
>   
