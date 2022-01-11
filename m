Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98F9EC433EF
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Jan 2022 18:49:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34A3310E30E;
	Tue, 11 Jan 2022 18:49:10 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F20910E30E
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Jan 2022 18:49:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HtbRoZbdS+pmMDl0lOQA6jcTqLD0rDWuBigwrJ/25Usj5p+SfrhZ4fB/aY8w8m+01R79wcDCHM8tiBpDhXuOHNbIyz0lxW1EJ/hdvNAvKPgGq7APv0vLRvaepLeuvz9A/vk2ZcqXRgLHRHuVEZVJyvDhWzIciNAhLn3xE4Gg3FzabpLh1hdLCsrKD1DD1jc97ZnGbm4g/eWUHawEsb+mlKGJTCD0+HJTgCT23qiCIuSliv5ZC3P82G4bt4oZbj/C9JaQpaFhbJNKMF40QKm5r5TN6Rk6cT/r9HXaMSpHFnFOnCz973G9PI3vu6/YCp9y9eH0vWh23ZajczFi8vtK6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xX0dDiVYxPCN42VNWQJwCJqGjdfv8Qt6q8cuLTjj4rc=;
 b=kD8svNnA1qbklmh9Jgjrq3UKBAtconbbY9gEb6hVwNBxPN9gTElpkfKkCyeEFoF3P1idnS0geKb/xCflCGIQZdCxws3NhaJgOJlcDJoTjn0De0u3sSv34hMsP9vYAGgxtFVhNeCUJX6RMjW2M5tIUcphACQLaU758IuUDWnOY8WOrb7CknZYDF7NetojmLi85UTNV+v432zdeCaOqCtEP0oXmkv/8vecWUZJ/NDMN987r2YwV1wp7UU3YN3WaT+rbW19bCQJT1HRVPgoVXkZLZjqzYTpDD+zNNGidnIj4dmzv0bc5znpwFspY9/V4jbhf7EMv1g4IQT5+jZJTbzPwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xX0dDiVYxPCN42VNWQJwCJqGjdfv8Qt6q8cuLTjj4rc=;
 b=k3zAlAi0V54PIiSXEFBPGC47dhavQk/gHraUqRMOIit2OoBv/EomThjH2A3cEqNpZICJVV1ogPJSNKiOFdG1QOKkBItSKCIHoaElD9QYYBAcKohUbiesPhJ9uNP35IiTnrjOgotYkJymBuV/dh0xID4+AzqBPKDRnPge94zcyq0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5112.namprd12.prod.outlook.com (2603:10b6:208:316::16)
 by BL0PR12MB5508.namprd12.prod.outlook.com (2603:10b6:208:1c1::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 18:49:05 +0000
Received: from BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::894a:fe8e:9985:3b96]) by BL1PR12MB5112.namprd12.prod.outlook.com
 ([fe80::894a:fe8e:9985:3b96%2]) with mapi id 15.20.4888.009; Tue, 11 Jan 2022
 18:49:05 +0000
Subject: Re: [PATCH] drm/amdgpu: improve debug VRAM access performance using
 sdma
To: Jonathan Kim <jonathan.kim@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220104191211.1707514-1-jonathan.kim@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <b4bfef7d-8621-634c-dba0-8f1b201aa5c5@amd.com>
Date: Tue, 11 Jan 2022 13:49:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20220104191211.1707514-1-jonathan.kim@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YTXPR0101CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b00:1::43) To BL1PR12MB5112.namprd12.prod.outlook.com
 (2603:10b6:208:316::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f256e74a-c416-4db0-af56-08d9d5330ac9
X-MS-TrafficTypeDiagnostic: BL0PR12MB5508:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB550828F336487470123F9B4692519@BL0PR12MB5508.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uN8xxIIopjgfb6UlhBCt7oekHxOtXgbL6G12JpGg+TxEjzRaHGl/yO9xIJkyjZaunruRLILwhx5a0eri5KKrEv+WnfHzxb19fIQ9y9rzMMOYZLW4grQENUYn/tRN++xhAIuhIEu23bQ8LX5Fzo0bYPUz+N09/+YHZWFYQt1dNcxJLGbSO8fPYjbmNQXcY1JOsq/doQieTEPPOqCyG9W7ObX/kbCud2Ze5VRIskXKlZVCbhQIfZKEJjrgqY0A0hWwBN1vMa+tu25crOADaZYez9nNUFDRt+3Z9LWfy/CI0p6lvGMEy5e766Qo3sJ9El6+lryOMZENDEGseSFs4UFRr5lF5c0Hm1NK2lv2VryIno+9yw8Nz1yukDeKIJmVXozvr9Xn7r1gkRWSikWMKUX8I8hHrZe6sYSQuSR4bWwC3ug3fWS7MQVT9riGyHYt/2H7otaUu53ZAqL+wwuHfbaRuK2IZBkwnjptiwXH/kS/AT3iH6hOkXuYbYpHnhuEqpFvJ05vBEf5JF9kWtdf6roHJEr0cb43Xqvd5GtzF7avYADkvv0A9liJP6vwjahN0PNE6Mv/bpJYbFBqaf7hchUoE1VAbTTwYORcr8y9u8iBAmbp28dMIsFWdyJPD8nILHzHATyVRKCeDi9qM8TUynW6Ys9FvXZvzpQVoKLU0Z0/u83Bb3bGvvgl7Bt7hFywwWAKq4p3YWtmU6kTrOpATFScRJ3dk6zQx639S3F3DRFhEyCu0bMDfXbLTC8kZ2hwuFxE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5112.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(186003)(6506007)(36756003)(316002)(2906002)(8676002)(44832011)(86362001)(4326008)(31686004)(83380400001)(2616005)(8936002)(66946007)(6512007)(31696002)(26005)(66476007)(38100700002)(5660300002)(508600001)(6486002)(66556008)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1UwZ2VudElReWV5QmpBbUVSR3dmdG1lNkhmdmRncUhocG5FeHlFM1lWRnly?=
 =?utf-8?B?VDFJNVh5cUJsaVpIRE5DSU9xOFFpRDhJR1FDU2wzampoYXVTcjAyVktOZmxj?=
 =?utf-8?B?eHZucjB2Y1FuakpIa1hFTjZocFVXWDdpSE5hUktQK1kvaUc2OUwzN0U5eStq?=
 =?utf-8?B?UXNpRm9RdUVnZEQrKzRKcmI1UTZHdGZqWXlWQlFvRm8xNitVbzVQdnFBOUZO?=
 =?utf-8?B?UC9EemErd21uZUs5WEpUY2lZNzI2cGV2UWppejhydVBRRmZFUFovMVhCSHJW?=
 =?utf-8?B?U2EwMElEbmFBZVJZSmhIWmFTM0RLbTI3ZCtiWFJDMmtnMXlsRyt0aHBoM3ZS?=
 =?utf-8?B?ZkpnbUVuMm1EQ3dzQmtGSWpKcWcrL2k1Q2pDVkxxdHk5elQzbFFWU2dXYU9H?=
 =?utf-8?B?VkVHWUJVd0FlTlpGQVFZd0F1dWorb1drK3UvL2Y2RnJZVHhYYXgvaDh1dGxl?=
 =?utf-8?B?VjBSTTVkMFF1SUppK0gyRW45dHZiNHBKQTBzcTd2Sk9CQTlGWHhxSzQ1Z21h?=
 =?utf-8?B?Nk02MHpMRG03ZzAxaXRHWmRBNjBCSkwxZjV6TE14dTlZSGRSeXBSSm5kbVZS?=
 =?utf-8?B?TjBhWGZ3Nkp3aU1ObVNxV1B0bHlrR0hHYll4Q2o2RXFmWnpxK29qdW45N0lw?=
 =?utf-8?B?V2JWbnFmVEt5bFNiOHJDSGFGRXloV1lBaEE4c0VST0VzQ0NESlhFQXBsTGlY?=
 =?utf-8?B?SEVjTnE0ZnBBdGlhN2hLY0svT1QyQ3M4d1hjTTJGOERoaDVCS2N2b0VCeVZH?=
 =?utf-8?B?Z1BnbFNEUDFzMzY2TkVUQTRDNjM4REE4Q2ZENHk4YmYrTU1OcXFxbGdEY2Vm?=
 =?utf-8?B?bFhYMGNUOUF1OUQ0Nm9KRXUrRXB1cUN3QmV1VDh6b0NZUjZyU01Lcjd6VUVW?=
 =?utf-8?B?L0luTXo1ZEhCc2dCQllpZVF0eW44ZmRuYllTOHFwQnc3Q0Z1L1U4YWh5QllC?=
 =?utf-8?B?QkdubzRMM3pCUlBzNkVLa1d2SitJcU8rSnN0TWQ4U1FtUXFCZ20wankzMy9Q?=
 =?utf-8?B?dUdvTGx2WHFPenRLbi8xN3FwcDhvZ2REU2UvRXZWU25NZWVhTzJXOEFVWTEz?=
 =?utf-8?B?d1ZLQmhRZTNmTnRZVGZnRDBRK3c5Q29UVXlZc1YwbllGNFg1UXF1UUVMOEg4?=
 =?utf-8?B?Uk0wcFpVNXBvdmR1RG5LMnlvVlo0bDNBSEZBalpkeXQ4Vk5NVEdnNFBtY2RE?=
 =?utf-8?B?MjZmZ2N3SGE4QXJ0TXdYRnpOMHRMQ3RFNFA3dmVURzNicjdQejE1N2RzS3pM?=
 =?utf-8?B?V0U0dVY3ZDlIRjFOdVF4YXpCV3pySCtiNnFseGJDNVZ3MXhpYmNhTy9oTmgy?=
 =?utf-8?B?UGFVSWZ0ZUEwamJyMEhxeFgrcnhrRG9keGhyakRrOXdxeGd2Qm5takNlYkRa?=
 =?utf-8?B?ZnlGZmViTkcyQnBHZVRDYmtMQlFHc2RFdFZpWm5OK0dMUERYbmFOeVpyeTdh?=
 =?utf-8?B?R25nMlpSRjFLV29Dak91bGNDV2M5Vnp0cTBXUHYycHJPZ2EwcE5ZeU1qLzRn?=
 =?utf-8?B?aTdCek9TTXJlT0x5aldFMmM4L0JwOFc2d2UwWHlkZWNrbWxOb3JxQXlGVWxp?=
 =?utf-8?B?dk1ieUNQVTFkZTZjZm9BTUM0c1k0TVhqdXNrb3NCTEltQlFoYTVuZkIrSnUr?=
 =?utf-8?B?cUNuN3NWUkNjV1JGZXZmNDZQY1ZoTXlhWVNDWkcxdTZSdTRMN2hneHNveWFF?=
 =?utf-8?B?dDBoMERZcU10aFZhOE04REk3MmVRSjVrTmxuajk2Y1lmY0xCTTFmWmhHcE53?=
 =?utf-8?B?NFlMWDNSazBkSzk5d0txWjhjQkp3Nm8zSkJMZlgwcU52R2tVdXBJZC8yZXVL?=
 =?utf-8?B?VmlVLy96ZG1ZMWxzREtIT2xTSUhCYjNsOHo1SStESzB0ckh1YmZsZlFvZ216?=
 =?utf-8?B?aTR2SUJia28xTEMvT3pFZ2FVSytXM01iMGtncHFOQnROOU8vS2ZIR3FOTUty?=
 =?utf-8?B?bTFjVWs1dXV0NExRbHoxQytoMi95dk9OenArbVl4c2dHVlk0QmFhUDUzWUNx?=
 =?utf-8?B?U1EyaTRsUGpBSWxLQ2NtcjBSVWRSU3Q1U01vSU13YWp0ZEczNFlqT1JzUWtn?=
 =?utf-8?B?aGs2WmRtT09pdFNGcnRQTEVtUzVVa0xDYjY3NG5QYUFERktvUnBEUmJDL3o3?=
 =?utf-8?B?WUlLS0ozTzlWOFFSV3JkSURqUGwxTlhQb0xxVnNDZm5QcWo0WXZOVUpucGNv?=
 =?utf-8?Q?9vvdTzSWwvjdVxLt81AM+6c=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f256e74a-c416-4db0-af56-08d9d5330ac9
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5112.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 18:49:05.7567 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o0ijl0WCKvUMnWdEdnIrCORDeAjyRDCr//uvLiHCR8gDufb6t53sexC8NfZ1SFS9ohEKaBLj9tyn84uXSzu0iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5508
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
Cc: Christian.Koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-01-04 um 2:12 p.m. schrieb Jonathan Kim:
> For better performance during VRAM access for debugged processes, do
> read/write copies over SDMA.
>
> In order to fulfill post mortem debugging on a broken device, fallback to
> stable MMIO access when gpu recovery is disabled or when job submission
> time outs are set to max.  Failed SDMA access should automatically fall
> back to MMIO access.
>
> Use a pre-allocated GTT bounce buffer pre-mapped into GART to avoid
> page-table updates and TLB flushes on access.
>
> Signed-off-by: Jonathan Kim <jonathan.kim@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 78 +++++++++++++++++++++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  5 +-
>  2 files changed, 82 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 367abed1d6e6..512df4c09772 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -48,6 +48,7 @@
>  #include <drm/ttm/ttm_range_manager.h>
>  
>  #include <drm/amdgpu_drm.h>
> +#include <drm/drm_drv.h>
>  
>  #include "amdgpu.h"
>  #include "amdgpu_object.h"
> @@ -1429,6 +1430,70 @@ static void amdgpu_ttm_vram_mm_access(struct amdgpu_device *adev, loff_t pos,
>  	}
>  }
>  
> +static int amdgpu_ttm_access_memory_sdma(struct ttm_buffer_object *bo,
> +					unsigned long offset, void *buf, int len, int write)
> +{
> +	struct amdgpu_bo *abo = ttm_to_amdgpu_bo(bo);
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
> +	struct amdgpu_job *job;
> +	struct dma_fence *fence;
> +	uint64_t src_addr, dst_addr;
> +	unsigned int num_dw;
> +	int r, idx;
> +
> +	if (len != PAGE_SIZE)
> +		return -EINVAL;
> +
> +	if (!adev->mman.sdma_access_ptr)
> +		return -EACCES;
> +
> +	r = drm_dev_enter(adev_to_drm(adev), &idx);
> +	if (r)
> +		return r;
> +
> +	if (write)
> +		memcpy(adev->mman.sdma_access_ptr, buf, len);
> +
> +	num_dw = ALIGN(adev->mman.buffer_funcs->copy_num_dw, 8);
> +	r = amdgpu_job_alloc_with_ib(adev, num_dw * 4, AMDGPU_IB_POOL_DELAYED, &job);
> +	if (r)
> +		goto out;
> +
> +	src_addr = write ? amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo) :
> +			amdgpu_bo_gpu_offset(abo);
> +	dst_addr = write ? amdgpu_bo_gpu_offset(abo) :
> +			amdgpu_bo_gpu_offset(adev->mman.sdma_access_bo);
> +	amdgpu_emit_copy_buffer(adev, &job->ibs[0], src_addr, dst_addr, PAGE_SIZE, false);
> +
> +	amdgpu_ring_pad_ib(adev->mman.buffer_funcs_ring, &job->ibs[0]);
> +	WARN_ON(job->ibs[0].length_dw > num_dw);
> +
> +	r = amdgpu_job_submit(job, &adev->mman.entity, AMDGPU_FENCE_OWNER_UNDEFINED, &fence);
> +	if (r) {
> +		amdgpu_job_free(job);
> +		goto out;
> +	}
> +
> +	if (!dma_fence_wait_timeout(fence, false, adev->sdma_timeout))
> +		r = -ETIMEDOUT;
> +	dma_fence_put(fence);
> +
> +	if (!(r || write))
> +		memcpy(buf, adev->mman.sdma_access_ptr, len);
> +out:
> +	drm_dev_exit(idx);
> +	return r;
> +}
> +
> +static inline bool amdgpu_ttm_allow_post_mortem_debug(struct amdgpu_device *adev)
> +{
> +	return amdgpu_gpu_recovery == 0 ||
> +		adev->gfx_timeout == MAX_SCHEDULE_TIMEOUT ||
> +		adev->compute_timeout == MAX_SCHEDULE_TIMEOUT ||
> +		adev->sdma_timeout == MAX_SCHEDULE_TIMEOUT ||
> +		adev->video_timeout == MAX_SCHEDULE_TIMEOUT;
> +}
> +
>  /**
>   * amdgpu_ttm_access_memory - Read or Write memory that backs a buffer object.
>   *
> @@ -1453,6 +1518,10 @@ static int amdgpu_ttm_access_memory(struct ttm_buffer_object *bo,
>  	if (bo->resource->mem_type != TTM_PL_VRAM)
>  		return -EIO;
>  
> +	if (!amdgpu_ttm_allow_post_mortem_debug(adev) &&
> +			!amdgpu_ttm_access_memory_sdma(bo, offset, buf, len, write))
> +		return len;
> +
>  	amdgpu_res_first(bo->resource, offset, len, &cursor);
>  	while (cursor.remaining) {
>  		size_t count, size = cursor.size;
> @@ -1793,6 +1862,12 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>  		return r;
>  	}
>  
> +	if (amdgpu_bo_create_kernel(adev, PAGE_SIZE, PAGE_SIZE,
> +				AMDGPU_GEM_DOMAIN_GTT,
> +				&adev->mman.sdma_access_bo, NULL,
> +				adev->mman.sdma_access_ptr))
> +		DRM_WARN("Debug VRAM access will use slowpath MM access\n");
> +
>  	return 0;
>  }
>  
> @@ -1823,6 +1898,9 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>  	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_OA);
>  	ttm_device_fini(&adev->mman.bdev);
>  	adev->mman.initialized = false;
> +	if (adev->mman.sdma_access_ptr)
> +		amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
> +					&adev->mman.sdma_access_ptr);
>  	DRM_INFO("amdgpu: ttm finalized\n");
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 91a087f9dc7c..b0116c4a768f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -98,6 +98,10 @@ struct amdgpu_mman {
>  	u64		fw_vram_usage_size;
>  	struct amdgpu_bo	*fw_vram_usage_reserved_bo;
>  	void		*fw_vram_usage_va;
> +
> +	/* PAGE_SIZE'd BO for process memory r/w over SDMA. */
> +	struct amdgpu_bo	*sdma_access_bo;
> +	void			*sdma_access_ptr;
>  };
>  
>  struct amdgpu_copy_mem {
> @@ -193,5 +197,4 @@ uint64_t amdgpu_ttm_tt_pte_flags(struct amdgpu_device *adev, struct ttm_tt *ttm,
>  int amdgpu_ttm_evict_resources(struct amdgpu_device *adev, int mem_type);
>  
>  void amdgpu_ttm_debugfs_init(struct amdgpu_device *adev);
> -
>  #endif
