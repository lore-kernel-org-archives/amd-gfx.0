Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8154BCDB465
	for <amd-gfx@archiver.kernel.org>; Thu, 19 Oct 2023 15:55:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19F8E10E522;
	Thu, 19 Oct 2023 15:55:20 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C8C310E522
 for <amd-gfx@lists.freedesktop.org>; Thu, 19 Oct 2023 15:55:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmkM6TXLFhVsrX4hz6wzDcG/+YRCY4u3dXM1EMyKtqHSr5aWBHNzj97uGQWyrNEhdBAdWk0iDBmH2161DDhBraoTILKI/Oa12krTGG7oqUKb9e4Db0rb6k3AQUJLGO5WnAzbfKGyxVNcRZd6IuzCyA2q2jEb4R1Ahm8nNPI37djSTo5YmP4Egyru/BfTwSIg5gQG604T3TmAIK0dhshvxu/+2KeU2u1h2lBOSn2BIRuppXPA9hPqfLxTBAmXIK5QGrXmPg+V2EOOgJRMM/yG2cnctkIWqvWRjKHolfDdHtjKscx5eoO4+Ifrz/6nFqQ1gzN28junXY5K+qK7sY91Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jyG9DHeXO5+6Kr9xNWhGSkhV0XXZtqwO0NU9bam+GnM=;
 b=BSGPYosYjr8v2rZG7PZPop3KzHCKWxty0Wzs6cGBzGrFJlWqLCGghM6l1z4vCY28Ew3K3UnFeLw1x58sIj66MdFMLgP34p0tWioPsEy0s0TsMqvtsfZzTV+jRM25rSNtgkBtcwMhimqqXfnYZ5z4Uu5JPOnK0OeJJ0l1hkDsq550hLPfMMXeb2YuasDitpoCqHv5lur2s8tL2LN2voUBTCCJM3v1ZjOCrcE4dRMA2gN+H3KqdMyDyFM4zD4hP++YkftQp09bsRNTwNcSAKXAL5S3WNpd4HBgxJ90NaHw/pgCPHlMBjL1afzPcN1+5szAEBBFd78kam0p58/I04q6gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jyG9DHeXO5+6Kr9xNWhGSkhV0XXZtqwO0NU9bam+GnM=;
 b=OXtqEyOcWj7MxGyDuErtooidqxCutgZJpWVgSplenxCu5L+IbsSflYCEd1T/UD6Q4tMH72xTs5onx/NbgkgMyoiftIFr0xTHz9tJzflYqq7hgjcWXyBY0tInMmDCh+CmB3X/29jEnW5i35mRCKeCw6pcC2/CffN0pck41hT8vuc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB7432.namprd12.prod.outlook.com (2603:10b6:303:22d::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 15:55:14 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2e40:ffd7:e752:644f%6]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 15:55:14 +0000
Message-ID: <cec6b37b-3817-449e-9299-fe18448599df@amd.com>
Date: Thu, 19 Oct 2023 11:55:11 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: Add EXT_COHERENT support for APU and NUMA
 systems
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231019133249.598193-1-David.Francis@amd.com>
Content-Language: en-US
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231019133249.598193-1-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0248.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::30) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: c760b166-f013-4c48-a203-08dbd0bbc86c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /8lWNSl+Tee0P8/3c9d91ia54qlwCAQ+1ijI98QDNX1u39VECEHBjcqtzblXBw/P4qK6TNHqcKKXSBYxrTQpz/F7yQD/FQK088QgjgQJvzuYTQyKQc5RLOp3P11yu2B4tm+aiun2xxiwOtHpqe7D+gUo1WjOy82C0iwo0WDYUQ2Cuvy9LcGxu/EssFBBaKeanjigdxQfzzbEZKMof75/DKK2rZWN1vHNipObMLvP5UzaH1C9nuXmzjQNnYfK8I/WJFmDibXO5kg4f0ujj3FkJfGBzbxyzfBQ7FFy9pyUrbmfsJ3e18W0I+aYB/AW3VJloxscHqyOV8+ytXpWW43ETK2LK0zXGaErjv7wlMl/3NQjPCOesu6930BrkXc1ZxzJfu46E642bR6MJ/qOoh7Jv8bmnK9VLOQ1E0+UmosqvBLndtpeOMIxFe3asOBQ5e4l/emU6mcaR2kiFyKhXyxrj2UCk33sMCqnHLTXckZ7/pt2gMTlHmgOZiQXVrSnkYcEPuEEfIErWJghkBDimYUwYudWEQgMcwhhXnrKT75no0v50BJ3U9xxgCv/mIU1GW8BYYPJ65DmMywGMotQYA+pjfj7I3NmdJsC6BDEQE9Kf159vTYkAkqN2QRV1C6a/5zOLM4aLshn5S953Q36dKKmIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(26005)(31686004)(38100700002)(83380400001)(41300700001)(44832011)(5660300002)(478600001)(8676002)(8936002)(66946007)(66556008)(2906002)(4001150100001)(86362001)(66476007)(316002)(6486002)(6506007)(53546011)(6666004)(36916002)(31696002)(6512007)(2616005)(36756003)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2VQV2piZEdEQXhrZWZzbGZJTFJyL2E1ZlZDUnZtVVhuMml4VnhkSGlyY3Bp?=
 =?utf-8?B?aVR4S1hiUHoxQWQ2cmRkNUtjd0pPSmNzcGdkSkJ2RlRUWHhsOFJtd3Biekw3?=
 =?utf-8?B?dFpEb250YmQ4SG9vSXlhK2ZaTHk2dE9wazFvSUJGOWVoWlQwQkV5VG1uaUcw?=
 =?utf-8?B?V05DQitwUnlzYU5vWFY5S05GMnc2VFU4M1hCaFcwTEVXRWtDSnRnVk92RFQ5?=
 =?utf-8?B?OWFGYjNtRVhqWVQyVlBGU3ptNVpNZWlmeFhOa3ErYS9maXB0Ty9CYXQya0tR?=
 =?utf-8?B?dDRRUDFyQzBDYjVBbUQ3bnA0azJPSE95bHJjQnRyelk3RGFvQlh1SjYwQWJC?=
 =?utf-8?B?clhOYjZZV2NvWUl3ZFhSbkpPZXRjM1oxZm43STBKTGNxWityZ0ZJWHh3Uk5P?=
 =?utf-8?B?bDAwUU1VZWtmcks1YnAxUlNpSTZnVnMxMmc4UHdkbk9ENTZ5bG4zNG51bmg3?=
 =?utf-8?B?am1FS1FiVkZENTRHWEVmV25ndE1MYWdnaE5lSmhkclhnK081VWFyVU1KT1Bh?=
 =?utf-8?B?d01CMHpOZXBNbW5tKy9qZnhoR0NzSDJSR0RKTjZRL3NUWlNPYlJCTDNieEJi?=
 =?utf-8?B?aVJhNkxuT3dGd3c3NHM0bHY3RE44YXdYNTNpR2JmVTJNU1pTbGJjSURhWHFa?=
 =?utf-8?B?THdMS1hCRmhzMEdUSm5YUnlLczJZdXZKMHRqK0RnQkoyYkhZMmZEKzVnbE4w?=
 =?utf-8?B?V1Bxelg2ZlJYU05CUkdxSW1mdmtXSURzbTN1SStFZGNkMGRUWEhVN25lK3U2?=
 =?utf-8?B?S2NYWWE1SnJ4cWt5TVBOSzNSUURLdVhXU0FuZmY4UWplNG9HaFlpeWhPQVFT?=
 =?utf-8?B?ZlFJazNZYm9nb2lMV3c5bHQ0c3FldFJNd0U3S1VRRURDc0xWM2dHejhkSm1h?=
 =?utf-8?B?U3phMXdncW1RdloyZ2RzQjkzc2J3U2RvUGlETVhQOFd4ZnZ3QTVDV3BORWti?=
 =?utf-8?B?cTBzeGszN2N5bHE5b25UVHRZTm9vVTdhNHZXTHdDWmVhNTN6SDQ5Z0hnYnlH?=
 =?utf-8?B?Z3NSdXh5REI3MEVhVG9BbUwwMkZjanBOT3BKczRlR3MyNlVDdDJzNFZFUXlq?=
 =?utf-8?B?NStzOWZ6blpPQ2NJNjk1NzhXbi8reHZzdjBLNGRwZVQ1ayt0VGovS01OQk1m?=
 =?utf-8?B?M2xTUEdIUjFnMzV0L2FqdldsK0ZIbndoTEdqVG9vRXdYcFhDQTUxRDdaNTNY?=
 =?utf-8?B?cFFFbmNodGw5QTlKVEJBTlRLN2VvYVRDdmh6QUwyYUxHV1l5MHgvNHJIYWZx?=
 =?utf-8?B?KzR1SWViRmZMQ2V2dUd0aG5TV0cxYTFCTGhhR0NFU3FmTzdVVFBWYUZHMGQx?=
 =?utf-8?B?M0d4NnB6NXB3YVgyZlZoV3dKZFhFNGJYNXN4eFlLc3E3a0RLOWJFR1laOUI2?=
 =?utf-8?B?T0xpbVhnWWxCTDFPUE9yUk4xNVY2Mzc5SEd0VlQyMjZHV25sVmlXUVo3eE1K?=
 =?utf-8?B?dGw0d2N4YUxLZE9TallCeXlUOXNnaGFnM2l3M05Vakw0VmJqNWwwbnVqOGFj?=
 =?utf-8?B?UE9LeE85ZjhmaHEzeGdlUWhrR0J2WHBZVG8zb0Jrak5qY0hKSStTODRyZnl4?=
 =?utf-8?B?QjJqaXA4cFFvV29vRnVtRHJHUi9XZklMV1BHNk4xV1RSSllUTElOT3UyUzR3?=
 =?utf-8?B?eFJmbXVQaEdLRGFWdTdyRXZ0QXlybGdjMkdlNDJTUTdYNm1SZWg2c0Z1aEh0?=
 =?utf-8?B?TmRJbDZ6YjJCSUdKNlZ6SFozSUN0NWxnR2lUWjBpZWxHUmFpdGVBNTdLMUF2?=
 =?utf-8?B?UHpYRXlNTkRjaWVzRUtpSWtNdUdWeXQ0emVJZ0FxS0QvaTdqSUVWNUZGWFgx?=
 =?utf-8?B?SHl1blhocFloM0xIRnZjME5jeHFPMlFQYkEwMDBGaWw2bXdZcmdGOHlCTFE5?=
 =?utf-8?B?aW40alBvSk1Geis3RmN2b1Z4dVJYTUx2bnpCaG1zTGxiQWZCVGp2Y05JbVpR?=
 =?utf-8?B?bVo2bjZyRkhINXdmMnhnNlYvSHZCWmFvMVJndUE3akw0VzB6ampSUjM0M2pl?=
 =?utf-8?B?c1dPQXZ3cWw1dm9VNnl1YkJrQU9YcWVlVklXUFUrU2w4N2ppaEk2ekxHU21v?=
 =?utf-8?B?TjQ1d1lVZlBzYmUzeXU4dC9tWnJaa3MwYi9PZXVTdUcrSUZLWnB6OURFemtP?=
 =?utf-8?Q?NlayUS2aTqkDSnHAeOv4qW1Yz?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c760b166-f013-4c48-a203-08dbd0bbc86c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 15:55:14.4573 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5G0LtOk0Ziqf/U+V72dC4fMO9tHikYwF+jsEol5PeUT936GovHW4Ma+VrheehvHu2b5pUVyhLgniaFpWE/8jGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7432
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


On 2023-10-19 09:32, David Francis wrote:
> On gfx943 APU, EXT_COHERENT should give MTYPE_CC for local and
> MTYPE_UC for nonlocal memory.
>
> On NUMA systems, local memory gets the local mtype, set by an
> override callback. If EXT_COHERENT is set, memory will be set as
> MTYPE_UC by default, with local memory MTYPE_CC.
>
> Add an option in the override function for this case, and
> add a check to ensure it is not used on UNCACHED memory.
>
> Signed-off-by: David Francis <David.Francis@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 13 +++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  8 +++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 33 +++++++++++++++--------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c      |  8 +++---
>   5 files changed, 42 insertions(+), 22 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 46d27c8ffff7..189341944bf1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -761,6 +761,7 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
>    * @immediate: immediate submission in a page fault
>    * @unlocked: unlocked invalidation during MM callback
>    * @flush_tlb: trigger tlb invalidation after update completed
> + * @allow_override: change MTYPE for local NUMA nodes
>    * @resv: fences we need to sync to
>    * @start: start of mapped range
>    * @last: last mapped entry
> @@ -777,7 +778,7 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
>    * 0 for success, negative erro code for failure.
>    */
>   int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			   bool immediate, bool unlocked, bool flush_tlb,
> +			   bool immediate, bool unlocked, bool flush_tlb, bool allow_override,
>   			   struct dma_resv *resv, uint64_t start, uint64_t last,
>   			   uint64_t flags, uint64_t offset, uint64_t vram_base,
>   			   struct ttm_resource *res, dma_addr_t *pages_addr,
> @@ -815,6 +816,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	params.immediate = immediate;
>   	params.pages_addr = pages_addr;
>   	params.unlocked = unlocked;
> +	params.allow_override = allow_override;
>   
>   	/* Implicitly sync to command submissions in the same VM before
>   	 * unmapping. Sync to moving fences before mapping.
> @@ -1062,6 +1064,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   		trace_amdgpu_vm_bo_update(mapping);
>   
>   		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb,
> +					   !(bo->flags & AMDGPU_GEM_CREATE_UNCACHED),
>   					   resv, mapping->start, mapping->last,
>   					   update_flags, mapping->offset,
>   					   vram_base, mem, pages_addr,
> @@ -1257,8 +1260,8 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
>   		    mapping->start < AMDGPU_GMC_HOLE_START)
>   			init_pte_value = AMDGPU_PTE_DEFAULT_ATC;
>   
> -		r = amdgpu_vm_update_range(adev, vm, false, false, true, resv,
> -					   mapping->start, mapping->last,
> +		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
> +					   resv, mapping->start, mapping->last,
>   					   init_pte_value, 0, 0, NULL, NULL,
>   					   &f);
>   		amdgpu_vm_free_mapping(adev, vm, mapping, f);
> @@ -2546,8 +2549,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   		goto error_unlock;
>   	}
>   
> -	r = amdgpu_vm_update_range(adev, vm, true, false, false, NULL, addr,
> -				   addr, flags, value, 0, NULL, NULL, NULL);
> +	r = amdgpu_vm_update_range(adev, vm, true, false, false, false,
> +				   NULL, addr, addr, flags, value, 0, NULL, NULL, NULL);
>   	if (r)
>   		goto error_unlock;
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index 6e71978db13f..9ea8b5b644e3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -244,6 +244,12 @@ struct amdgpu_vm_update_params {
>   	 * @table_freed: return true if page table is freed when updating
>   	 */
>   	bool table_freed;
> +
> +	/**
> +	 * @allow_override: true for memory that is not uncached: allows MTYPE
> +	 * to be overridden for NUMA local memory.
> +	 */
> +	bool allow_override;
>   };
>   
>   struct amdgpu_vm_update_funcs {
> @@ -436,7 +442,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
>   int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> -			   bool immediate, bool unlocked, bool flush_tlb,
> +			   bool immediate, bool unlocked, bool flush_tlb, bool allow_override,
>   			   struct dma_resv *resv, uint64_t start, uint64_t last,
>   			   uint64_t flags, uint64_t offset, uint64_t vram_base,
>   			   struct ttm_resource *res, dma_addr_t *pages_addr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> index 9b025fd17b84..80273809c93f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -842,7 +842,7 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>   	 * to be on the same NUMA node.
>   	 */
>   	if ((flags & AMDGPU_PTE_SYSTEM) && (adev->flags & AMD_IS_APU) &&
> -	    adev->gmc.gmc_funcs->override_vm_pte_flags &&
> +	    params->allow_override && adev->gmc.gmc_funcs->override_vm_pte_flags &&
>   	    num_possible_nodes() > 1 && !params->pages_addr)
>   		amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index 3a1050344b59..1456f76b7fb2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1251,12 +1251,15 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>   		return;
>   	}
>   
> -	/* Only override mappings with MTYPE_NC, which is the safe default for
> -	 * cacheable memory.
> +	/* MTYPE_NC is the same default and can be overridden.
> +	 * MTYPE_UC will be present if the memory is external-coherent

ext_coherent stands for "extended coherent", not "external". With that 
fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> +	 * and can also be overridden.
>   	 */
>   	if ((*flags & AMDGPU_PTE_MTYPE_VG10_MASK) !=
> -	    AMDGPU_PTE_MTYPE_VG10(MTYPE_NC)) {
> -		dev_dbg_ratelimited(adev->dev, "MTYPE is not NC\n");
> +	    AMDGPU_PTE_MTYPE_VG10(MTYPE_NC) &&
> +	    (*flags & AMDGPU_PTE_MTYPE_VG10_MASK) !=
> +	    AMDGPU_PTE_MTYPE_VG10(MTYPE_UC)) {
> +		dev_dbg_ratelimited(adev->dev, "MTYPE is not NC or UC\n");
>   		return;
>   	}
>   
> @@ -1283,15 +1286,23 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>   			    vm->mem_id, local_node, nid);
>   	if (nid == local_node) {
>   		uint64_t old_flags = *flags;
> -		unsigned int mtype_local = MTYPE_RW;
> +		if ((*flags & AMDGPU_PTE_MTYPE_VG10_MASK) ==
> +			AMDGPU_PTE_MTYPE_VG10(MTYPE_NC)) {
> +			unsigned int mtype_local = MTYPE_RW;
>   
> -		if (amdgpu_mtype_local == 1)
> -			mtype_local = MTYPE_NC;
> -		else if (amdgpu_mtype_local == 2)
> -			mtype_local = MTYPE_CC;
> +			if (amdgpu_mtype_local == 1)
> +				mtype_local = MTYPE_NC;
> +			else if (amdgpu_mtype_local == 2)
> +				mtype_local = MTYPE_CC;
> +
> +			*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
> +				 AMDGPU_PTE_MTYPE_VG10(mtype_local);
> +		} else {
> +			/* MTYPE_UC case */
> +			*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
> +				 AMDGPU_PTE_MTYPE_VG10(MTYPE_CC);
> +		}
>   
> -		*flags = (*flags & ~AMDGPU_PTE_MTYPE_VG10_MASK) |
> -			 AMDGPU_PTE_MTYPE_VG10(mtype_local);
>   		dev_dbg_ratelimited(adev->dev, "flags updated from %llx to %llx\n",
>   				    old_flags, *flags);
>   	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 7b81233bc9ae..87cd1ad14a72 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1286,7 +1286,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
>   			if (num_possible_nodes() <= 1)
>   				mapping_flags |= mtype_local;
>   			else
> -				mapping_flags |= AMDGPU_VM_MTYPE_NC;
> +				mapping_flags |= ext_coherent ? AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>   		/* system memory accessed by the dGPU */
>   		} else {
>   			mapping_flags |= AMDGPU_VM_MTYPE_UC;
> @@ -1321,7 +1321,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	pr_debug("[0x%llx 0x%llx]\n", start, last);
>   
> -	return amdgpu_vm_update_range(adev, vm, false, true, true, NULL, start,
> +	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, start,
>   				      last, init_pte_value, 0, 0, NULL, NULL,
>   				      fence);
>   }
> @@ -1428,8 +1428,8 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
>   		 * different memory partition based on fpfn/lpfn, we should use
>   		 * same vm_manager.vram_base_offset regardless memory partition.
>   		 */
> -		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, NULL,
> -					   last_start, prange->start + i,
> +		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, true,
> +					   NULL, last_start, prange->start + i,
>   					   pte_flags,
>   					   (last_start - prange->start) << PAGE_SHIFT,
>   					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
