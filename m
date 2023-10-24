Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754D3C25B47
	for <amd-gfx@archiver.kernel.org>; Tue, 24 Oct 2023 21:08:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9ED610E4E0;
	Tue, 24 Oct 2023 21:08:07 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2052.outbound.protection.outlook.com [40.107.243.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1B1610E4E0
 for <amd-gfx@lists.freedesktop.org>; Tue, 24 Oct 2023 21:08:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZabTFXBDiXWyr6XT7hvh2JIw3po2FpA86vYrSqhMKVTHRE00dI99SkW50J6hu96D+4hWoJIEk5cbNa0WaPXRQrX6xpjcqYQRYl6GrjXNZn46CLYj4ivyGs+37C73PvFD8ef2DUzdYekGz7KHSazliYq4f9Yhr3AZCH240dmRN7vwoYVOWUhU8hcN/VDasbec04ff3a1AHrTRaMiNlVUsIzQ63DGrre0H7xnVJcsHKcJq2AGgIvJGhKRwFFt4KAqCzTfYxXjDpPNdUmQy5y9g5jOMLIpCBM1mpO2olff+Ehq6cdmB9lq2aArvb3G36moipMNZALg3COGsuYz9QoxVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V4/BoXktT776KuXoyejprmQt7l5v17DCJiF0yPwbXVg=;
 b=X0puU0YRvTrsYdTkmfBXwoRlfBslYLJzQE5oViqztaXRHy1urRoRN0HhQTNKf21vI/dtQdh1WNtKt+Ze50BJtQYzzg8vmy3WkVh7wG/SIgOphKucHJY3ZiiEqqDLLu6VZ1tNFDo3iP9lozY8hB7YMTYJgktcCsl7Da77yxu6GxRDtAsZpz0j4bOK+5k4sX+cyabEDs++v6ehDRDgYQzQU6/PtSmQMhEP86It7+01ey2Z/FbYwa+W9NkXaVGzO+/yWYdY+2/DAPwwCd0N/FczMb5YhxiprsGMAEgjQy54Cr1NYzcZBWZ/313Lhv7pPH+KbaTLJ6DQcW695MXiUmAo+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V4/BoXktT776KuXoyejprmQt7l5v17DCJiF0yPwbXVg=;
 b=tYufgcbqQ+kLnnSbotWKribcfdes5BWpT6Ih4JXtC+UQAefxrQphOxSz34Y3nrkfHe0uGeWlavxDoZf7mcSXRrKn5KEamiRIhbJrVj8Sps9U7c++a7GfiU6FAP3eoRbPxAPBU5ICBwooyhrDIMYeCf3GoHdHmxof7UJcylMGro0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by MW4PR12MB7312.namprd12.prod.outlook.com (2603:10b6:303:21a::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Tue, 24 Oct
 2023 21:08:04 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::2c3:911a:bd2c:ac31%4]) with mapi id 15.20.6907.032; Tue, 24 Oct 2023
 21:08:03 +0000
Message-ID: <9ec590bb-2b9a-4700-80a1-83f1b19c787d@amd.com>
Date: Tue, 24 Oct 2023 17:08:01 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] drm/amdgpu: Add EXT_COHERENT support for APU and NUMA
 systems
Content-Language: en-US
To: David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org
References: <20231024190816.312852-1-David.Francis@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20231024190816.312852-1-David.Francis@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0100.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:4::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|MW4PR12MB7312:EE_
X-MS-Office365-Filtering-Correlation-Id: 50449968-7332-424b-f9ed-08dbd4d54fa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KTKDXKjBbNlnBsyQNWh2idLdPhWsw0/i60TL5aru1jx8uW8uGEwW62YQAvdQjhgHgMlVtNG+JpRfWhBzXW+8ed9htabz5OKudOlpS7VOSCjMAnViEC3dETpI8cNFW9i1IwgnUYMLtpIT6G4twfk6wslgVhs3TYcDtTYQEFZc8AMDLKddHhpRZKjKVcrtpG9f5UOHCvF+oOAMVAok/6Cj4ewqd6r6fH2njXkGS5EuI7TO1fr7d2pcUxMBGXwxGiCjvEoL5dl3ezH5gaLz6fPdxxblXdtFZLQq9mLgFXxWI4MSfaLoD7OAjz78/mEw9CwnylF+kX84Le5szDl+a1ZfP/wrxKlzln1CE96VZ+yJHiUlDVfMYE4YQUew7xn94gj7OdSCk3n2mKa0VcntP9UPf5tuxidRt+xjHWISCodBWvkTKZ6suD/spZg19RCoJCghHo+yGX1m/JvgIaMeZSyBDt1sli/TqV0X5oh3IPUFTEBCwmKlIxgOJ9FWuEdHSkESeaNnQ7kKtYupvvcW0ugnFwXV66bbqkSTe4cnHOzLreqLRNlXTLeJUyTh2+SXy7d3vEhMxnZ8Yr91ZIPFEhEHrlqFH+o+dyjgKsm8ReDDKwH/fFGAtO021f7Da2N/vNvjbfMQLU0D+qeDeaJ8QOFj/g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2906002)(41300700001)(38100700002)(66476007)(66946007)(66556008)(6506007)(2616005)(36916002)(478600001)(316002)(6512007)(53546011)(6486002)(83380400001)(86362001)(31696002)(36756003)(5660300002)(8676002)(44832011)(8936002)(26005)(31686004)(4001150100001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VDZOK25tV1Y5a2s3UUN6OVdHaWE3R093WGx5U1ZoL3VTYzQzajdTRWJ5UVJk?=
 =?utf-8?B?RU9IU2M4UnlZS3NBM01NR1dKNjdRcVZuckJzQVY4Y0l5M0VYT1RWNDdCS2Jx?=
 =?utf-8?B?Q1d4bWtJUFpySjh6K1dYNjFSdjdzM2ZXM2R3NXVNaG9pd3REeUxqUVNFNkQ0?=
 =?utf-8?B?UGQraDJnOGJTYUEyOUlCbUUrd3RmczR0djIxODNyMVNCVXN5S0x0QlYzVzly?=
 =?utf-8?B?ODFuSTc3a3hqTzJWOTR4N3VpZ0pqSjVsTnlRODBhM0xXZmcybDdNelVtNEpN?=
 =?utf-8?B?VGwvQnp3N0o0WUg5Y05XUFVDOXRoSU9KZ00yZmFDUEorbjFhNG94YUx6UFEx?=
 =?utf-8?B?TWJFNWp3bHl4eTNQK2t4aWdDT0l6SE9ITEM2N0dEZlRMbE5FUTYxUy9mMEp3?=
 =?utf-8?B?MWdqaDZEVTZTV3cvVEhVZUlXVldhanovd0syRlRWNmNmd1Nuck9IQVBOYy9N?=
 =?utf-8?B?S2FMUkpYR1BrQS9oTC9PbVNWUzJlZkRoVW5BeWwyTG1VTDZzRGtxTWZrWWoy?=
 =?utf-8?B?OWorWGE2ekNveloxV2hkV1NFRksxMjRBL2t6TktOcXNVZnY4NGJBQk1zM1d6?=
 =?utf-8?B?NkxkTjZuUUs5N1pCdllOc0JFdFlUdDhiNVhIcGF0dXFTQnZZQ0FlYVBPTmht?=
 =?utf-8?B?OVJBakFIemJTRHpySmN2MFZsTUErMEVLcFRadExtekhaaXY1cmcvTTB5TitB?=
 =?utf-8?B?UUZraDNrVDZPYUZWNmdlT1JCa0JqYXk1cHJ4Q2F4cFEra3dyaUZRem9PQyt4?=
 =?utf-8?B?eFc4cktPendrY3NCWnRvREl0amtNVEFoQ05FV2VXbE8wUlJydEk5Q0lNc1JL?=
 =?utf-8?B?Q2Vtb0M5cmxrQWJuaGN6Q1RvdjZJR0FJcVZNQzA5aVZRaFJnNEcxVVlRbHgz?=
 =?utf-8?B?dWpnUEhZWkVCaW1SUTVQYzFaZFRGL1U2Q2ZJYXR0TWU4d2wxa0lVT0Z2ejZj?=
 =?utf-8?B?TFZFTUtRRjRwUzRZb1VTak8zZGJwVS94SXV1SEVlV05NUWprb2lXaEJwQXFt?=
 =?utf-8?B?bmpqVW9sNHVDTjlKUGRTK05WL05La0lDRklwZ2MrTk9Hb3FHZjdndytzZlpt?=
 =?utf-8?B?RjJvbytWeUNhNjNmb3lFOEpveHZheHowT3NnYlBKRENkeG1WNnZpMGo2NEE2?=
 =?utf-8?B?LzFlMHI3VCtiMk5TNWNxNmRXbGJXSTRiSUpmTkU5eThDeExMZVREWHBKckV5?=
 =?utf-8?B?UHlwQ1VZbUdwV3JHQXVGbkptYkx2UjJVc2xYN0pWK3A4ZFF1ZDk2Ynp3bEYx?=
 =?utf-8?B?a0pIM25jOXRlcHpJYkp0eVNybG9WTUxxdUx6ZkpHWkkydWNSeTBrckJQSGYv?=
 =?utf-8?B?WDhVMHY2SHRIeDJLVHFMYThNMGhIVGQ3YWxiUUZWbHk4emxwUWQvcFNGNGN2?=
 =?utf-8?B?VTJLY0hxMWMrc3RpQ1h1dG5sUkUxbEpZeXdBYlF1c1V5QkZoT3pyUTlKSDhK?=
 =?utf-8?B?Vll3elZXalZYK2FxR2phUjZTNmJVZy9QNUoyV2gycWVMZE5TUW9MNHN1S2Zx?=
 =?utf-8?B?SXhRMzhvUzQ4MUEyRmVzUUZTemJURUl4U2tqNTE4RllPUDhXL1FaT2RWeFp4?=
 =?utf-8?B?bWtxc3cvMHFsQ0RvRjNSYUg4alJmdlhBVExLZmdVV3k1djFvcU1UYWVvZzVO?=
 =?utf-8?B?YktOZ2dLS0FZSUdpbjVsd0YyR1UyYVV1akgvak5wTlU1REdLK050dHExMm5S?=
 =?utf-8?B?T3ZLN3ZPSmIxQ0EzRVFMb2NaOUNvZmtQNVI5V1dON0tidkFDRVdVY1A5Mktk?=
 =?utf-8?B?bWtjdmwzdWgzNnJtQUZLdzNHRysrdmVZeGYrMktFZWlkUFZ0SHVubVc2NlVZ?=
 =?utf-8?B?TG0zUnE4ZHg1VmoyY0VDSzJSRy9zcHN4ZVRNYkdGd2o1Qnh6OHJhbnRaeU9T?=
 =?utf-8?B?VmRVRHJ2TFhJRGNIdDd5RHI3S0hDbUpkMGl5MDBSVTFZZlJTRkJBZUIxZGJo?=
 =?utf-8?B?QnRHdjcwV3BQTFRPdUpFdklMU2NNQUh1UFozcVZPQ2lCL1R2U1dMR2dqZm5Y?=
 =?utf-8?B?cHBlaTFkMVF2RG0yR1Q5cUplbkJRNTVhYnRScmJpSllIRDFwVUdnWjloTy9Q?=
 =?utf-8?B?QTYyWUc2bHd5dG9MSjRSY2JjMDBuNEgvRThhcDVYb0hIcEkyeit4SkRKSUpX?=
 =?utf-8?Q?IbcKs07MpPjVwgw66Y9yjv94Z?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50449968-7332-424b-f9ed-08dbd4d54fa6
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 21:08:03.3988 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GFF0Hmu5iuELIN2qj5iyF1fsZs/g0nzzWWDhC6/CrL8SbJ19uxv6mmrcFHzos5l2i1wGN9pNK0ihUDOU6xGZRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7312
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


On 2023-10-24 15:08, David Francis wrote:
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
> V2: Combined APU and NUMA code into one patch
> V3: Fixed a potential nullptr in amdgpu_vm_bo_update
>
> Signed-off-by: David Francis <David.Francis@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 17 +++++++-----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  8 +++++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  2 +-
>   drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c     | 33 +++++++++++++++--------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c      |  8 +++---
>   5 files changed, 45 insertions(+), 23 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index d72daf15662f..155c04589753 100644
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
> @@ -990,6 +992,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   	struct ttm_resource *mem;
>   	struct dma_fence **last_update;
>   	bool flush_tlb = clear;
> +	bool uncached;
>   	struct dma_resv *resv;
>   	uint64_t vram_base;
>   	uint64_t flags;
> @@ -1027,9 +1030,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   
>   		bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
>   		vram_base = bo_adev->vm_manager.vram_base_offset;
> +		uncached = (bo->flags & AMDGPU_GEM_CREATE_UNCACHED) != 0;
>   	} else {
>   		flags = 0x0;
>   		vram_base = 0;
> +		uncached = false;
>   	}
>   
>   	if (clear || (bo && bo->tbo.base.resv ==
> @@ -1063,7 +1068,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   		trace_amdgpu_vm_bo_update(mapping);
>   
>   		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb,
> -					   resv, mapping->start, mapping->last,
> +					   !uncached, resv, mapping->start, mapping->last,
>   					   update_flags, mapping->offset,
>   					   vram_base, mem, pages_addr,
>   					   last_update);
> @@ -1258,8 +1263,8 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
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
> @@ -2547,8 +2552,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
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
> index 9b025fd17b84..a2287bb25223 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
> @@ -843,7 +843,7 @@ static void amdgpu_vm_pte_update_flags(struct amdgpu_vm_update_params *params,
>   	 */
>   	if ((flags & AMDGPU_PTE_SYSTEM) && (adev->flags & AMD_IS_APU) &&
>   	    adev->gmc.gmc_funcs->override_vm_pte_flags &&
> -	    num_possible_nodes() > 1 && !params->pages_addr)
> +	    num_possible_nodes() > 1 && !params->pages_addr && params->allow_override)
>   		amdgpu_gmc_override_vm_pte_flags(adev, params->vm, addr, &flags);
>   
>   	params->vm->update_funcs->update(params, pt, pe, addr, count, incr,
> diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> index fee3141bb607..b66c5f7e1c56 100644
> --- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> +++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
> @@ -1251,12 +1251,15 @@ static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
>   		return;
>   	}
>   
> -	/* Only override mappings with MTYPE_NC, which is the safe default for
> -	 * cacheable memory.
> +	/* MTYPE_NC is the same default and can be overridden.
> +	 * MTYPE_UC will be present if the memory is extended-coherent
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
> index 640ada95e2c3..fe937670c927 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1280,7 +1280,7 @@ svm_range_get_pte_flags(struct kfd_node *node,
>   			if (num_possible_nodes() <= 1)
>   				mapping_flags |= mtype_local;
>   			else
> -				mapping_flags |= AMDGPU_VM_MTYPE_NC;
> +				mapping_flags |= ext_coherent ? AMDGPU_VM_MTYPE_UC : AMDGPU_VM_MTYPE_NC;
>   		/* system memory accessed by the dGPU */
>   		} else {
>   			mapping_flags |= AMDGPU_VM_MTYPE_UC;
> @@ -1315,7 +1315,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   
>   	pr_debug("[0x%llx 0x%llx]\n", start, last);
>   
> -	return amdgpu_vm_update_range(adev, vm, false, true, true, NULL, start,
> +	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, start,
>   				      last, init_pte_value, 0, 0, NULL, NULL,
>   				      fence);
>   }
> @@ -1422,8 +1422,8 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
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
