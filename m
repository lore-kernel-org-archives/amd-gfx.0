Return-Path: <SRS0=xYMq=PI=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057DDC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 09:11:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F9E6135E
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Oct 2021 09:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A4F9E6135E
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DCF4896EC;
	Wed, 20 Oct 2021 09:11:27 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A950896EC
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Oct 2021 09:11:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GZv/dRrEA7NyfL9FsoDzUsZHUubmvk3Z0o2o1DEt+lYD3X3YKx6RF4HwsqtXrmUi/2r//GGnYYDWt8IfmUgjs52EiqXSxunThVFEusvKaeFZTz60MGJ6euml6a2UtGVbrmLoi/A50PT1UE1U9GXbAELBWpa9X6K5uxr9UsUtfK4kfqSvc/AWzagiGyxSO9Fd78bV+cQFiXBJ57bJxfj08Rrk9wzpbqAOrdxzV71YHX0b12PkhDe5sdY/7m5I+am6Bca9Smmgf0YZnV9C/pl54UzONu/M4vuzUGeb5eEoL8/RY6G/H5LF9UzntqVh/jbwXOcZbrLOz9tA9k8zQDdxDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGd2SQtakYFX48OXfLvzphZXccwiUJOXBtWDQ8uALeU=;
 b=Ft7/X8Yjy2gzIYi2qHOTwwHakwTSMAKMxYll7+yZBKJRBVB2BOo9hrPZ1BuuifcaYBuw8DO5VH0RLtLvhfdMVROZkfBk1xFmruFtLc/resKBKZgSHct2A6EWBExbmccZQjjjfxEnmQP05hMCbbEq5ERFWAV94aE7V1U1CJd/9X3CQ/kJIwMilkDXbuApnDbvYixc5qSQjOuRNe6LkQufSlr57KLY4YqBOrqDxpzokJ+zlLRFjNDW6BYKHpf4JxzpygT7y4of2pPE7Gci4aV8Dw7Cs5fo4a8BFH2/nKCdK+oW9pOR8rm0eCu1gumdZ/aEXPInGGZDTupVLs/IkXgDzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGd2SQtakYFX48OXfLvzphZXccwiUJOXBtWDQ8uALeU=;
 b=BxXQzT7odhLatt5jms88k0zHNkZs5qkQFVvDp4hh43tMPjuwrXdb2K/CKr4dOfuF8Qlrs6iKyO77cdgmOCAK7FaUWd3t67GKaui9FZ2u1x9+lDS+XVw7L31IPUv2ZnvYOFvCvfq3GZF8fzH3Pn6zx8y3dmz5qSqEKrGBc+4sxSY=
Authentication-Results: amd.com; dkim=none (message not signed)
 header.d=none;amd.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3930.namprd12.prod.outlook.com (2603:10b6:5:1c9::19)
 by DM5PR1201MB2488.namprd12.prod.outlook.com (2603:10b6:3:e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.18; Wed, 20 Oct
 2021 09:11:24 +0000
Received: from DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560]) by DM6PR12MB3930.namprd12.prod.outlook.com
 ([fe80::591a:8986:aca2:c560%3]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 09:11:23 +0000
Message-ID: <10ad459a-01c3-1fa0-837d-42dfe33129d2@amd.com>
Date: Wed, 20 Oct 2021 14:41:11 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 3/3] drm/amdgpu: recover gart table at resume
Content-Language: en-US
To: Nirmoy Das <nirmoy.das@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Christian.Koenig@amd.com, andrey.grodzovsky@amd.com
References: <20211019181449.12356-1-nirmoy.das@amd.com>
 <20211019181449.12356-3-nirmoy.das@amd.com>
From: "Lazar, Lijo" <lijo.lazar@amd.com>
In-Reply-To: <20211019181449.12356-3-nirmoy.das@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN1PR01CA0080.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:1::20) To DM6PR12MB3930.namprd12.prod.outlook.com
 (2603:10b6:5:1c9::19)
MIME-Version: 1.0
Received: from [172.31.158.229] (165.204.158.249) by
 PN1PR01CA0080.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c00:1::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4628.16 via Frontend Transport; Wed, 20 Oct 2021 09:11:21 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2705b168-8e16-4e74-d3a9-08d993a9967d
X-MS-TrafficTypeDiagnostic: DM5PR1201MB2488:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB2488559B917C4D63A52C16B597BE9@DM5PR1201MB2488.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vS2UiTvDmpihPp3d0YVkprXnHZAPPCEfMvMn0CVCKsLS3vEpsuPuOcsLQha7n3FGr+L4y8vh2cG4isd3A9X2b6y+WD+Nzf3hHrO17mBwAlBuBlgxADESRtUd7sUEg51cOjemQHHqitIDctkjhHCX4SDrcFLXFl5xQhje0GvtGt32M+M49Wl+X0neL8MjqTxrhIgKXha1x6NTFTdS2vSoHpXZyPRGtcHTLYiTRIFYCgtRRnux5pEK/azizwCG4sqz2eHGlxIJNQWPLt7F2/65hzBeLBZGrumgeR9juZ1k5xaTOpwIS5ir+cJjbQK43Q9AjCb6XsD8XOA/4CpWaMNOnn9qkmUC0kAwwwncjN2BDSoLICaLfN4QXanLvPgHx+PFLIMeQilgAC4hk0aA8tUyRrZiVdzzsOsVyMPzC5XY5ZLM7f8nf4sA5EB1j3Aop2Yw2amjG9ZbmVfOLXx/Pp5k1rqb/XJDH8JAKStPeOg0pd5ICXF3AxZ1yZtoztRRleIeH1f9xsWCz5MXsn6i5tbJkYEStDuyZN6kxbJI8A4qQ9DqP4zsohfp/7TKDhoE9KgxnKM9Oo1w3DAG5XOhtr/R39pCGu413N/pUnrKJf7e4yie4Mgz5OGDkXg2kVZY41L6Y9NnKtOI3cHREYB/k05yldrCz7Msd2OS4cpe8bBVsxH6v69GOV5PwLSxN58Qe5WNWLo/5a/tkGKMqJe69ry2tsTX1aYFswC/iZzFvboV6K0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB3930.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(5660300002)(6486002)(36756003)(66946007)(66476007)(66556008)(53546011)(26005)(16576012)(6666004)(508600001)(2616005)(31686004)(316002)(956004)(2906002)(83380400001)(86362001)(31696002)(38100700002)(8676002)(186003)(8936002)(4326008)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YURpQmwxSmtqc0J3K0Y0MUNTb0pkUUxFL2RaRTBieVUwL3VnSExBTlRZOU9a?=
 =?utf-8?B?RStpcEdXUHRCT3B4ZDgxVStpOVBVVFp3UHExWklPT1pFd3BvY2xpZkczMGNQ?=
 =?utf-8?B?Q214S1FDV2I3akdTREdGbmJLVHFuNitPOWxUaTlxS3RHblY1bnMzcXNrbEdR?=
 =?utf-8?B?cWpNTEgxVnliNnAvejk2ZG9oaWdkS0RCcWtlQW1QNW9KOXVjaTBqc3V2SUdJ?=
 =?utf-8?B?amxiQVREaGpvRVZrMCtkUlUzMUd1emFWaTNQeHJOajdiRkJPdURjYWo2UHdN?=
 =?utf-8?B?a2tBcGNSR3N5WklrSTdCc1hvUTNTYzYwMDh0cTJIMjI1a0dCMVhnWm13V3VF?=
 =?utf-8?B?WWZCTlBwZkxYWGI5WkpFUmlLOUpSL2xpRUVOakZwZVRNR0gzUmhwdlBBenFP?=
 =?utf-8?B?YkxyS2FaK3hkdTVoM3g5eW1nWkMxaWxFU3VyK1l0M29CZ1h2N3hhOHJOMWlS?=
 =?utf-8?B?OG1zdy85UVZBL25EVmp5TDZuYXlTQlFkZHB1Ukh1dWQzN1kzclNjTmxIRXhX?=
 =?utf-8?B?WElPUGJDd1JEbEFDR0xnOFpYSFFObzk4UlJBQVZ2NjdneTBTRlRUeUVjTWs2?=
 =?utf-8?B?dDdJTEdqSUNFckViTE5iS2J5cFJ1K05wVytWbXZUZUNjazdlUHYwb3RaVkZY?=
 =?utf-8?B?VWZCQ3QveURXS1ZhOTV3Zi9CSkNFVW0wMFNIRER4bFl6QXU2MGVBcHdlWE5I?=
 =?utf-8?B?elRaWmVPUGJKQmpmQUhueVAxTjhWMHh5cHhtWmk1aG5KdVRWT2VRZmxiRGd6?=
 =?utf-8?B?Q1lTQmdJY2piWWptUUlQTWk4b21ncVdGY0x1QXFNTVFoa2tKSi9mWE5ya3FV?=
 =?utf-8?B?UTBVcDRWTlFLOUx6OG51NzhBTVVaYzM4L3J1MzVoV2ZGbUYwZFNHQklqNnAr?=
 =?utf-8?B?OTZ2bklNMnFLcTlERE56enJMckpxdldJbmFNbVYyaU9KZE9qd1Bldm5tUnJy?=
 =?utf-8?B?dHpWaEszcitvRmJNb1JOMlVoaUlOOTZTZGg2QVE5ajBZUDhiY0Y1NGV0a3hH?=
 =?utf-8?B?SG4zUFJKRlFBQmszWWZLRmxpTUFYY25GOHMrSHdEYnJCV3pmVWF5RlFMWEY3?=
 =?utf-8?B?MlV4YlNTb24vN3BxVU5ZbmpnMG5LOGo5Y0FmcGJVREowZzVhalFyRlNSM0l5?=
 =?utf-8?B?VTdoUVFKOWNLc1dUSXNSL2oyQngvemtwMGJpTnVkbFlEZkYyY3VzTitQSDEr?=
 =?utf-8?B?Q1N6UWd0aks5clBDM3BqSVdlTlpYNWtmREJaQ3JOMllMQkJKNVF0Y3czY0ps?=
 =?utf-8?B?Vyt0R3VVaW4rQ3dpWE5nSEY4aFo3SEg1a3g3a2dwLzN1UmV0RklUZlE5TWxy?=
 =?utf-8?B?UVBVUUZRYVh5QWh4a01xL0VrUzJoeWZocXJreHJlU2NNQ2JkNE5zYW9CNzYw?=
 =?utf-8?B?SU5LTzkxZ0dIRzlrZzFRdkttbjIwUUR6YnRXcE00RmZFd3V6MlFuR2s4RW1i?=
 =?utf-8?B?TmFwWEJvVnBJeWt2eE90TFZxbkJwK2pTNlEyeCswWFRHMmw4ODl4QTFVZWNR?=
 =?utf-8?B?bUFLbjFBN0EyYWxJMG1ZSlAxV1pNcXY5SE9scUhCL3VvczN4Slh6R3dOYksr?=
 =?utf-8?B?NXFBVlFhNWpiOCsvUks5TWRLSnc1UHYrbmJIUWgzK25NaUk2SU5KL09EOER5?=
 =?utf-8?B?b25CRFZLM0J5ejh3NlIxZVp4clFINWZlVlBxL0hXYzBSS2Z6N1NJRVFQYlZW?=
 =?utf-8?B?blRjL2NicmdqMzN6clpObDFGcDdqeHdVMFFldXc1OUZtdktrZGZpQ0U5SERB?=
 =?utf-8?Q?kXnhrif0Une3NW3YbYv9io6D3uJBOOrRHJi+Hjz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2705b168-8e16-4e74-d3a9-08d993a9967d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3930.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2021 09:11:23.7278 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: llazar@amd.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB2488
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



On 10/19/2021 11:44 PM, Nirmoy Das wrote:
> Get rid off pin/unpin of gart BO at resume/suspend and
> instead pin only once and try to recover gart content
> at resume time. This is much more stable in case there
> is OOM situation at 2nd call to amdgpu_device_evict_resources()
> while evicting GART table.
> 
> Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  4 ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c   | 42 ++++++++++++----------
>   drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c     |  9 ++---
>   drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c      | 10 +++---
>   drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c      | 10 +++---
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c      |  9 ++---
>   6 files changed, 45 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5807df52031c..f69e613805db 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3941,10 +3941,6 @@ int amdgpu_device_suspend(struct drm_device *dev, bool fbcon)
>   	amdgpu_fence_driver_hw_fini(adev);
> 
>   	amdgpu_device_ip_suspend_phase2(adev);
> -	/* This second call to evict device resources is to evict
> -	 * the gart page table using the CPU.
> -	 */
> -	amdgpu_device_evict_resources(adev);
> 
>   	return 0;
>   }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index d3e4203f6217..97a9f61fa106 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -107,33 +107,37 @@ void amdgpu_gart_dummy_page_fini(struct amdgpu_device *adev)
>    *
>    * @adev: amdgpu_device pointer
>    *
> - * Allocate video memory for GART page table
> + * Allocate and pin video memory for GART page table
>    * (pcie r4xx, r5xx+).  These asics require the
>    * gart table to be in video memory.
>    * Returns 0 for success, error for failure.
>    */
>   int amdgpu_gart_table_vram_alloc(struct amdgpu_device *adev)
>   {
> +	struct amdgpu_bo_param bp;
>   	int r;
> 
> -	if (adev->gart.bo == NULL) {
> -		struct amdgpu_bo_param bp;
> -
> -		memset(&bp, 0, sizeof(bp));
> -		bp.size = adev->gart.table_size;
> -		bp.byte_align = PAGE_SIZE;
> -		bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
> -		bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> -			AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
> -		bp.type = ttm_bo_type_kernel;
> -		bp.resv = NULL;
> -		bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> -
> -		r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
> -		if (r) {
> -			return r;
> -		}
> -	}
> +	if (adev->gart.bo != NULL)
> +		return 0;
> +
> +	memset(&bp, 0, sizeof(bp));
> +	bp.size = adev->gart.table_size;
> +	bp.byte_align = PAGE_SIZE;
> +	bp.domain = AMDGPU_GEM_DOMAIN_VRAM;
> +	bp.flags = AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED |
> +		AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
> +	bp.type = ttm_bo_type_kernel;
> +	bp.resv = NULL;
> +	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> +
> +	r = amdgpu_bo_create(adev, &bp, &adev->gart.bo);
> +	if (r)
> +		return r;
> +
> +	r = amdgpu_gart_table_vram_pin(adev);
> +	if (r)
> +		return r;
> +
>   	return 0;
>   }
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> index 3ec5ff5a6dbe..75d584e1b0e9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
> @@ -992,9 +992,11 @@ static int gmc_v10_0_gart_enable(struct amdgpu_device *adev)
>   		return -EINVAL;
>   	}
> 
> -	r = amdgpu_gart_table_vram_pin(adev);
> -	if (r)
> -		return r;
> +	if (adev->in_suspend) {
> +		r = amdgpu_gtt_mgr_recover(adev);

When the existing usage of this function is checked, this is called 
during reset recovery after ip resume phase1. Can't the same thing be 
done in ip_resume() to place this after phase1 resume instead of 
repeating in every IP version?

Thanks,
Lijo

> +		if (r)
> +			return r;
> +	}
> 
>   	r = adev->gfxhub.funcs->gart_enable(adev);
>   	if (r)
> @@ -1062,7 +1064,6 @@ static void gmc_v10_0_gart_disable(struct amdgpu_device *adev)
>   {
>   	adev->gfxhub.funcs->gart_disable(adev);
>   	adev->mmhub.funcs->gart_disable(adev);
> -	amdgpu_gart_table_vram_unpin(adev);
>   }
> 
>   static int gmc_v10_0_hw_fini(void *handle)
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> index 0a50fdaced7e..02e90d9443c1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
> @@ -620,9 +620,12 @@ static int gmc_v7_0_gart_enable(struct amdgpu_device *adev)
>   		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>   		return -EINVAL;
>   	}
> -	r = amdgpu_gart_table_vram_pin(adev);
> -	if (r)
> -		return r;
> +
> +	if (adev->in_suspend) {
> +		r = amdgpu_gtt_mgr_recover(adev);
> +		if (r)
> +			return r;
> +	}
> 
>   	table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
> 
> @@ -758,7 +761,6 @@ static void gmc_v7_0_gart_disable(struct amdgpu_device *adev)
>   	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>   	WREG32(mmVM_L2_CNTL, tmp);
>   	WREG32(mmVM_L2_CNTL2, 0);
> -	amdgpu_gart_table_vram_unpin(adev);
>   }
> 
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> index 492ebed2915b..dc2577e37688 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
> @@ -837,9 +837,12 @@ static int gmc_v8_0_gart_enable(struct amdgpu_device *adev)
>   		dev_err(adev->dev, "No VRAM object for PCIE GART.\n");
>   		return -EINVAL;
>   	}
> -	r = amdgpu_gart_table_vram_pin(adev);
> -	if (r)
> -		return r;
> +
> +	if (adev->in_suspend) {
> +		r = amdgpu_gtt_mgr_recover(adev);
> +		if (r)
> +			return r;
> +	}
> 
>   	table_addr = amdgpu_bo_gpu_offset(adev->gart.bo);
> 
> @@ -992,7 +995,6 @@ static void gmc_v8_0_gart_disable(struct amdgpu_device *adev)
>   	tmp = REG_SET_FIELD(tmp, VM_L2_CNTL, ENABLE_L2_CACHE, 0);
>   	WREG32(mmVM_L2_CNTL, tmp);
>   	WREG32(mmVM_L2_CNTL2, 0);
> -	amdgpu_gart_table_vram_unpin(adev);
>   }
> 
>   /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index cb82404df534..732d91dbf449 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1714,9 +1714,11 @@ static int gmc_v9_0_gart_enable(struct amdgpu_device *adev)
>   		return -EINVAL;
>   	}
> 
> -	r = amdgpu_gart_table_vram_pin(adev);
> -	if (r)
> -		return r;
> +	if (adev->in_suspend) {
> +		r = amdgpu_gtt_mgr_recover(adev);
> +		if (r)
> +			return r;
> +	}
> 
>   	r = adev->gfxhub.funcs->gart_enable(adev);
>   	if (r)
> @@ -1793,7 +1795,6 @@ static void gmc_v9_0_gart_disable(struct amdgpu_device *adev)
>   {
>   	adev->gfxhub.funcs->gart_disable(adev);
>   	adev->mmhub.funcs->gart_disable(adev);
> -	amdgpu_gart_table_vram_unpin(adev);
>   }
> 
>   static int gmc_v9_0_hw_fini(void *handle)
> --
> 2.32.0
> 
