Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05C28F3381D
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 08:59:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 924B910E4F8;
	Tue, 17 Mar 2026 08:59:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="L8m2uJtb";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012070.outbound.protection.outlook.com [52.101.43.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF9F710E4F8
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 08:59:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=te5tar/EgL6EWqGtQmkB6/lA+LHCEHY2KpDVk9CN8Fo4af/Ti9PTbiRU/ShLREow5cH7FrWvt+fZMHLURCL+z47PO9aa7kR1UA/LyemFrKYZzU3O5xPhaVOd7OLCYWq1JkZcvCD4/zKlPiTh/OkKCijArlK61U6YzAqhWhdJq9Id6k5HnznDMiXuhmnA7BhycRH4bDLvlqnV1vovi0NWBk7v8UdmGggmgATMkaN7KbsCLtSplLr0iR7FH96o+/nSfpzTTJn2msnSDbkCYGMD5WLCNZRIHPz5/qzzIzVCFDgQnyTPyccP0/3BwsQnbIehkDEQaSl1Fy4vRmTl0FgJYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FvVz2LejW4y0xHJGYe1K/QbjUhVyn4xEP4NblP/9pMM=;
 b=kPFZxabZmA954q6ljGMcWEficezENz+CHNkrUmzeHApiuBf1GgbNfYhiCy1XyGAGIbDeGGN/YlnIdHDkdmapD/Zs4lYV0tzZjzivej6CpDCVG9Q2FFnZxL1UW4/SORsSfpQ93YgCaiTdCXOc2ECOM9oP5Cp9mN5hvo7K47QFvMU1EoQzYNNayDDRVr4oPfwMPDj/uu9MjbwOTx+dG5R9wL7gDadBZ9UJqJSXZUEltA2mZL0ydnVAyjhXUsbAT1KL8QuLiFQe9t7s/PF7iq9v9FBlxwUDMzeX6kSdXmtpg7uGTPHqWBQ90Oc3VOqWygWCZy+dHjb6j+rRul4VV78GWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FvVz2LejW4y0xHJGYe1K/QbjUhVyn4xEP4NblP/9pMM=;
 b=L8m2uJtbpUESzmOKmTdCdS0U3wAgD4USDuc8SX9hctz8XrelhRIaCzDk3REQgq+x2LmJpzJwtO0EoqQHHiPujuG2LaPlzF4RdAL6piE6102C3WOJzL+RTNbCG/GvkaTusKTwbED+IFFUCDYU76aKDZwaoUxlmFNHC72xK9uEABs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by SJ0PR12MB7036.namprd12.prod.outlook.com (2603:10b6:a03:483::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.17; Tue, 17 Mar
 2026 08:59:38 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%4]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 08:59:38 +0000
Content-Type: multipart/alternative;
 boundary="------------jdKzYrwPH8Bc7IN8NfcjdCVE"
Message-ID: <2c655fb8-f8d7-46f7-9ab8-9574a45b1fde@amd.com>
Date: Tue, 17 Mar 2026 14:29:32 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] drm/amdgpu: WIP sync amdgpu_ttm_fill_mem only to
 kernel fences
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
References: <20260310191327.2279-1-christian.koenig@amd.com>
 <20260310191327.2279-11-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260310191327.2279-11-christian.koenig@amd.com>
X-ClientProxiedBy: PN4P287CA0018.INDP287.PROD.OUTLOOK.COM
 (2603:1096:c01:269::8) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|SJ0PR12MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 34d2340b-ac8a-4cc2-dbca-08de840384e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003|8096899003;
X-Microsoft-Antispam-Message-Info: k5upKBd4xfwgpz11HPWQpO6W+wmi+Q9n0oWp8SJwkbsu1L8Tedw75nuFw6643W4EoCNwPVqEFlByGldqX1FBLGSVjsfQnLrNwNsNDg0d5kI9soy1VKhGLIERuVk4MFFKe2s/eoqTI5HaJRPD4ldjoyBM9u1I60b2mFT7fKKNxK31wsGvX42Nm3HJ4XOmqxj2Ob/3C6qnw2cAK19bj6BcqGg6TcjMZFFkfNi9KeI9hY3nYxuiqDic5Ksbj+u/tC0WyIESQqLfWmu+13UYcB3053azS2gNAGu/VqHg7ZK8H94faDWg/tFyBzIeI1XVewTKvwSjKx5I/2m7hfWPd6S65P4kR6uPpKWdkP1weMYZPVup9siITgOkEkaPXppjvM1LcNUj3pk/UVLPWZE+NpHVTvhhiPhca62iFJEJZrg0kjbNTehW9JjE8XTCkzwweS4Y/kPGYlTSuwwt+Slavpg7FYJZKkkdchinEFbnsD+hGcrwau77rhwMNMZMJJ9V2rctK3t0mjfQapyDyAJqzXrmLrLoEe86GZc3d9zJxP01Gd4ZTKvWSWm3R9e2Y0SG/2bgWIhvTi4504x2dMBj3eNvfGMW8NoibVv3VErZRLUW/o5NJ8vLMZjaZ7SLoiIiVhLhJtByV3WuL5XEu7AWzUXgKG4NbQVV0kKA7uyIO643nj2ohpnaGRZI21QOaBNyQ4ao3S3rfU8U5qnTACCXyNTSs5vbw6T5SLrurP1EKq3He6M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cFB6eGxTT0VGUmhnMGpvSVY1R2hrbHVzd2hXTjJ0dHNzNXdkZ2dhdVc3em5t?=
 =?utf-8?B?dFBkTWFyUjh5T0dMbmJjNnZwN1NSR0RVbCtUSnc0ZDZVZmY0bU5iTmk0MXZm?=
 =?utf-8?B?ajVqQU8remRtS3FUS0xva1FoYlFZZTlpVnkwVE5LdGE5V1gvZGVKa3VVUktC?=
 =?utf-8?B?S1Z5N2RxK05TbGhDbXhQMGhQbGVIUkk2VXVSNkdxUFJQU3hycVQ5Y2tOOXg3?=
 =?utf-8?B?SDluTG9MajU1VGM4VUIzOENiKzNDcnJ3dm9KNFVxMXFsUzR4N093cmErT0pv?=
 =?utf-8?B?UDVNVFA1azkrWmV6UkZWUDVOTjMvckdCRVFxVWxzNVMvSURpMVlmQVJYd1hI?=
 =?utf-8?B?Y2s0R3NOWEZtelRzRlZFemRMRTZIMVdNR000ZEhoNXBFbkdzSmpKQjhvRDZu?=
 =?utf-8?B?SFg0WUJVVDJIbTNiQk9iTzRqOTRQRjJ4dDd3QlV5K1FUZ1EzanlVcmdzRmla?=
 =?utf-8?B?UGhHSHNVK2g3S2JvaE9IVXV4OTZOVHljejdLOWt3b0h6S2NlTUFkaWt2NjV5?=
 =?utf-8?B?T3MxOWF1TVhXT3Y0c2ZSWWVxRUZaaG40bmorMENldUt1OVJuT2JVN25DelZw?=
 =?utf-8?B?ZEdjeFZnMkFQc3RsbTFRTFhBb3VoMjV6ZTNWTklLTW80NnBqMkJZUW9RM2t5?=
 =?utf-8?B?WGZlVEZYTjM4T3EvYnQzUEpzaktBV2luZzA4bVhmRUFiVUJnRnB0MjZHTHFZ?=
 =?utf-8?B?blBLWXh3bmdBajVGYm1rSHZJNndwOHNRc3gxQzlrR2ZtNUhGbGR1azBtNHla?=
 =?utf-8?B?Z3dLZmVIOGNBaXl0YUthR1Jka29XMTdySGFxVHF4SWlXVDZSaTU5cGtrdWwv?=
 =?utf-8?B?aUFmb0YxcnVsZythS2NWRTEwSm9KekM3KzcrNFRGRloyQVZzUk5jNlQ3d25T?=
 =?utf-8?B?YnBMcmVWSlpreGxSZ2FseXlZRVBlU2RWSng0ZVhyNDhjenZnMm5odU5vU3dJ?=
 =?utf-8?B?Qm9yWkpmaDQzdVpLdmI0NWdhcXNsZXEvcXRENldrMmdhaFQxTlhBdzNaUng4?=
 =?utf-8?B?TTROZFJ0S2tjMk9kd0VBemlicG14SVl2SWlycmxxVCs4ZVBJNktxRkhFRnEx?=
 =?utf-8?B?Q3JBakVXcU44Y3FJaVA0YWZkWGk3VEZOSWNDcHpuZDl0S1ZXZFkvNU9wOXVm?=
 =?utf-8?B?bGFTbVFZRVozWFE4NkdNQktvT0phQUk2MkNGYVEwcnBvdldVZ1JObzZvT1la?=
 =?utf-8?B?LzN2RitiSzhJVkpZNGF4WjlkdUFjOU05eThFdDJnS0NaTFJnVUI5T09pNmdq?=
 =?utf-8?B?VWljSWF0SG9xT1FSTUhsWVg5TElVeDJWMnZYOEFaRUZyaHNxUXZIOFlzVkJX?=
 =?utf-8?B?ZzNaSHFvRWtaMGxIVXN2U0dRbFAwcTg1ZFNvaUZOdXZHeFhmSTRJWGcrdG1X?=
 =?utf-8?B?RDBWYUFoOUNxZ3hoZ2VxTEhEbUZNQ0tZamIxbnc3Y2tGUGxDRHI2czNROTRO?=
 =?utf-8?B?U3pwK3ZNK2VNS0dLRFd0SUU2Yi9uRjZYUTFHeG8zbDFVNHlCcGhQS0F6SDhy?=
 =?utf-8?B?dE8va3RYcFlQT2thMzZpRnpwRDY5eU1rR1IycjF5WUdqQjdUQjhjcWR1TFBB?=
 =?utf-8?B?RC81b2FhYU5NK2RiUXdGNVl5NXprMHRJSHhtYVVnbWM3Tzk0L3Zab3U0SjVi?=
 =?utf-8?B?dUlvYWs2VmZPNWcxb3lNZU04ZlRyQUovNUk4ZkZZMGxOd2FVTHNqMHR6ZENX?=
 =?utf-8?B?dHo0dEMzWS9uYnZmNkNJWUl2cnNURU9iZWRtcFlrRm9tejNyMTVpbGZuejNq?=
 =?utf-8?B?NzV2cW1iTlYrQ0ZvOUdEeTlCUjBlQVFkWnhmdEtCSmdxUGUwemJjZXlaeG9I?=
 =?utf-8?B?NkFxS205elB4cndkYjNzeWxtK0xjbFA4Q24yQmtpbGpSejJoTDl4dGdBcWRT?=
 =?utf-8?B?NUVLNUtoZTg3UlpJSDJLeFA2cWdReEVvbFROT1VuUVRkRHVMOWhPSmJOcGt1?=
 =?utf-8?B?QkFFODVyOHo4ZWxmdnU5T3pEM0lzL3dvamRpaHRhcmI3UEp0VnNsNENwaGdQ?=
 =?utf-8?B?OEFRUVFWUFBkSHJadVUwbHlpRC9xQnlma051d2hVSk5KaTZrOFU5SlpKVFdZ?=
 =?utf-8?B?MVE1dy9BNEpVQit2TFRPTjFHdUpvUmxwcTFxQ01YY2lzcnhaZVlIMGYrNDVW?=
 =?utf-8?B?aUVWVTZsZHpwN2drMUlmS0ZtRHhQZnVqUFNhb3ZYRmxTWmF0SGlqUXVBa0RX?=
 =?utf-8?B?citRVVd5d0ZOVTdhdlJRbTF3MmRURmlCVVgwN1U4SStJV2hiYU9oem9sOE9h?=
 =?utf-8?B?T0pvTDRWVlgrUERwbWdaUS9nak9JMTIyQ1F3bWs3L0hXOS85V3R3Y0Urdk82?=
 =?utf-8?B?L3VYazhWeGEwMDV6cys4Rmd4dnU5a2dsRmtWTVEwc2krcXRKUjRNZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d2340b-ac8a-4cc2-dbca-08de840384e6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 08:59:38.3879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gMt4ZX8c3wS+5/yFuQhEQ683R0RShjSN9KbiDRpVEGMzmp7hhaqxYkqHcLuwLj/l5NstJBnWGBSglow24G5KqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7036
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

--------------jdKzYrwPH8Bc7IN8NfcjdCVE
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

It would be good if we add some explanation of why we used 
DMA_RESV_USAGE_BOOKKEEP for buffer copy and for fill we use 
DMA_RESV_USAGE_KERNEL.
Either as a comment or in commit message would help new folks to get a 
hold on it. Other than that its a good catch.

Acked-by: Sunil Khatri <sunil.khatri@amd.com>


For my understanding:
A copy buffer could involve buffer move to different domains too and 
might need to depend on all fences including read/write and internal 
kernel fences. At the same time buffer fill only
writes to the memory and only depend on kernel implicit sync fences ?

Regards
Sunil Khatri

On 11-03-2026 12:43 am, Christian König wrote:
> That's not even remotely correct, but should unblock testing for now.
>
> Signed-off-by: Christian König<christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 714fd8d12ca5..69f52a078022 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2428,12 +2428,14 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
>   				  struct amdgpu_ttm_buffer_entity *entity,
>   				  unsigned int num_dw,
>   				  struct dma_resv *resv,
> +				  enum dma_resv_usage usage,
>   				  bool vm_needs_flush,
>   				  struct amdgpu_job **job,
>   				  u64 k_job_id)
>   {
>   	enum amdgpu_ib_pool_type pool = AMDGPU_IB_POOL_DELAYED;
>   	int r;
> +
>   	r = amdgpu_job_alloc_with_ib(adev, &entity->base,
>   				     AMDGPU_FENCE_OWNER_UNDEFINED,
>   				     num_dw * 4, pool, job, k_job_id);
> @@ -2449,8 +2451,7 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
>   	if (!resv)
>   		return 0;
>   
> -	return drm_sched_job_add_resv_dependencies(&(*job)->base, resv,
> -						   DMA_RESV_USAGE_BOOKKEEP);
> +	return drm_sched_job_add_resv_dependencies(&(*job)->base, resv, usage);
>   }
>   
>   int amdgpu_copy_buffer(struct amdgpu_device *adev,
> @@ -2479,9 +2480,9 @@ int amdgpu_copy_buffer(struct amdgpu_device *adev,
>   	max_bytes = adev->mman.buffer_funcs->copy_max_bytes;
>   	num_loops = DIV_ROUND_UP(byte_count, max_bytes);
>   	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->copy_num_dw, 8);
> -	r = amdgpu_ttm_prepare_job(adev, entity, num_dw,
> -				   resv, vm_needs_flush, &job,
> -				   AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER);
> +	r = amdgpu_ttm_prepare_job(adev, entity, num_dw, resv,
> +				   DMA_RESV_USAGE_BOOKKEEP, vm_needs_flush,
> +				   &job, AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER);
>   	if (r)
>   		goto error_free;
>   
> @@ -2524,6 +2525,7 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
>   	num_loops = DIV_ROUND_UP_ULL(byte_count, max_bytes);
>   	num_dw = ALIGN(num_loops * adev->mman.buffer_funcs->fill_num_dw, 8);
>   	r = amdgpu_ttm_prepare_job(adev, entity, num_dw, resv,
> +				   DMA_RESV_USAGE_KERNEL,
>   				   vm_needs_flush, &job, k_job_id);
>   	if (r)
>   		return r;
--------------jdKzYrwPH8Bc7IN8NfcjdCVE
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p>It would be good if we add some explanation of why we used
      DMA_RESV_USAGE_BOOKKEEP for buffer copy and for fill we use
      DMA_RESV_USAGE_KERNEL.<br>
      Either as a comment or in commit message would help new folks to
      get a hold on it. Other than that its a good catch.<br>
      <br>
    </p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt">Acked-by:
      Sunil
      Khatri <a class="moz-txt-link-rfc2396E" href="mailto:sunil.khatri@amd.com">&lt;sunil.khatri@amd.com&gt;</a></p>
    <p><br>
      For my understanding:<br>
      A copy buffer could involve buffer move to different domains too
      and might need to depend on all fences including read/write and
      internal kernel fences. At the same time buffer fill only<br>
      writes to the memory and only depend on kernel implicit sync
      fences ?</p>
    <p>Regards<br>
      Sunil Khatri&nbsp;</p>
    <div class="moz-cite-prefix">On 11-03-2026 12:43 am, Christian König
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260310191327.2279-11-christian.koenig@amd.com">
      <pre wrap="" class="moz-quote-pre">That's not even remotely correct, but should unblock testing for now.

Signed-off-by: Christian König <a class="moz-txt-link-rfc2396E" href="mailto:christian.koenig@amd.com">&lt;christian.koenig@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 714fd8d12ca5..69f52a078022 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2428,12 +2428,14 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
 				  struct amdgpu_ttm_buffer_entity *entity,
 				  unsigned int num_dw,
 				  struct dma_resv *resv,
+				  enum dma_resv_usage usage,
 				  bool vm_needs_flush,
 				  struct amdgpu_job **job,
 				  u64 k_job_id)
 {
 	enum amdgpu_ib_pool_type pool = AMDGPU_IB_POOL_DELAYED;
 	int r;
+
 	r = amdgpu_job_alloc_with_ib(adev, &amp;entity-&gt;base,
 				     AMDGPU_FENCE_OWNER_UNDEFINED,
 				     num_dw * 4, pool, job, k_job_id);
@@ -2449,8 +2451,7 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
 	if (!resv)
 		return 0;
 
-	return drm_sched_job_add_resv_dependencies(&amp;(*job)-&gt;base, resv,
-						   DMA_RESV_USAGE_BOOKKEEP);
+	return drm_sched_job_add_resv_dependencies(&amp;(*job)-&gt;base, resv, usage);
 }
 
 int amdgpu_copy_buffer(struct amdgpu_device *adev,
@@ -2479,9 +2480,9 @@ int amdgpu_copy_buffer(struct amdgpu_device *adev,
 	max_bytes = adev-&gt;mman.buffer_funcs-&gt;copy_max_bytes;
 	num_loops = DIV_ROUND_UP(byte_count, max_bytes);
 	num_dw = ALIGN(num_loops * adev-&gt;mman.buffer_funcs-&gt;copy_num_dw, 8);
-	r = amdgpu_ttm_prepare_job(adev, entity, num_dw,
-				   resv, vm_needs_flush, &amp;job,
-				   AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER);
+	r = amdgpu_ttm_prepare_job(adev, entity, num_dw, resv,
+				   DMA_RESV_USAGE_BOOKKEEP, vm_needs_flush,
+				   &amp;job, AMDGPU_KERNEL_JOB_ID_TTM_COPY_BUFFER);
 	if (r)
 		goto error_free;
 
@@ -2524,6 +2525,7 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
 	num_loops = DIV_ROUND_UP_ULL(byte_count, max_bytes);
 	num_dw = ALIGN(num_loops * adev-&gt;mman.buffer_funcs-&gt;fill_num_dw, 8);
 	r = amdgpu_ttm_prepare_job(adev, entity, num_dw, resv,
+				   DMA_RESV_USAGE_KERNEL,
 				   vm_needs_flush, &amp;job, k_job_id);
 	if (r)
 		return r;
</pre>
    </blockquote>
  </body>
</html>

--------------jdKzYrwPH8Bc7IN8NfcjdCVE--
