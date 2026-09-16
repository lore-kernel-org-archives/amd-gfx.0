Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A7D8C88E5C
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 13:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9428910EA7A;
	Wed, 16 Sep 2026 13:00:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sqLLmJ/M";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011032.outbound.protection.outlook.com [52.101.62.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4FA410EA7A
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 13:00:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlDgPAkbTDSwjEoSxs7udNKRKbPssP125dlEK9ObQttRUhSt4tYP47kMHxWMx/gDf9LRAxnEKjHveRcU2psU5jQ/T/4GXi/rdihrEGzOdnJc/zZ9+if+PAbtkBsZHxw3q7SCjG5UdZOc2mNqBIpKhVxWgqSgAYQubDy18SrLJ0ElB6Nlm9VD+ABSj51his+YSv3oskAr6ahd3zLJd7cuJ+gTQwIqlg94oVmDLSkfWEDcO/NrQVIQ15bMCUkbFELPTXuxFm5N+SD8iBXWwQnW8DVGM+iOhoia5ic9wZoc6oU51snI5qOey2YvNxyVpgkWaXUk91xLAkoC4KC5kubX9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EslPCw13lIS0N0FF3znKuk7MK9FGH+1bJKZqJZEZ6Qs=;
 b=yeO1Bfh+Wb80JlWN5m8PFY4HTAbuPK0X2Djp/ldK1hU2JYf13wyWXczupLg9bMUGrNm9nWlbu3zqKly8/rpKG7BznsYRpuYulwFWn408FieNMs9d8BJ6WBIegRlPKet6DuaAHMzkixjdy/TMzKMXTjK2gdfWRfOOqC0tEuC2o7k3y4uEHENshTexYAwahhKdR8xBy2aYddOaAYmT0/qUDX0XaZ/vjzOytIW7b833RObYr0P3B2YQSTIjo7UtnHAgF/POCOME269Xpg4+F40MdRNW7G9b6sgjv6odu/fQWPln2lQWvViEmT32+O2M9S8O8tYWc7OU1+7pTdSMx/7RjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EslPCw13lIS0N0FF3znKuk7MK9FGH+1bJKZqJZEZ6Qs=;
 b=sqLLmJ/MhC8lbECiWDxG3Rhdx2Jpl9XFL92Lqv+JtceulDdwb72MbQI1cO5A/azgRnPGaCoYJP1STspRZ+c/BUAVcTi6pKaVeUWfcik++ZjDPh5av/NU+rCQxkhreRJlKFVHxzgRxQcjKtAIjCaKXNMj859DuSB1iBDw7zwmwbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY5PR12MB6527.namprd12.prod.outlook.com (2603:10b6:930:30::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 13:00:18 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 13:00:18 +0000
Message-ID: <f4a6405c-8801-4a81-a40c-716a5fd847b0@amd.com>
Date: Wed, 16 Sep 2026 15:00:14 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: serialize GEM fault mappings with GPU reset
To: Yifan Zhang <yifan1.zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com, Perry.Yuan@amd.com
References: <20260916100204.3750592-1-yifan1.zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260916100204.3750592-1-yifan1.zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0298.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e7::7) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY5PR12MB6527:EE_
X-MS-Office365-Filtering-Correlation-Id: 368f09d8-6d67-499d-ccb2-08df13f275a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|22082099003|18002099003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: FEXSGJDmy6+MZ6WmIkR+WIryHYUirjuin6qQ8QIiG7+HuND3B+OZnFwlPoBgVg1kJPmAVVnvha/LWUxzQos+pTPKoLXmYLXa9ER5XRFNuLYC00eHDCZLJodJX05oxkaFIBV3bF+YTDBUSudwq9xZwu7ibUYAeVBTALlQHOqhdTW55aSPFKdsb7JbcgG1Xw8sBZwv7k6m3hbf5HOvIwuMBc/O/f8KB3ms+LL7moSlHBhit9cZow7/ePjOjkFrNABv1TgRvPUctDgCG6mlBOtsKD8oQAex8Ew6xyVl+5s4m1/5lzrIMZgvUZdsE7IHhOjn7TmaeiwRf7+X7w0m5aZO9ZguAsfa3O700gGDlCIJLjVkRHDbPVi+g/6qlhyfs9rHSyYAOemPu0q7waPXFKBy5aw0iv53f6tFkyNdJ4UD4R7QjCnVwTjvJ3lpiLVutA8tV866L7jwkX1xr1C/a0VucFpjj7IEXTUVwVS5+0QJgp1mU5TZpH77GYpHAEAkLLMghVIaIbn9v/Np6khy39RL52D/4unMqZSSpQVS5pXidcnZulWgGjw0tZo755iTWEwqz0nBCYxt/4X4uT7siprI1BZ34mtFYaF28EnN4z2oTZ24+hZShFx2Hy2RGUzVW7Ka3ucEErEB06JK8WFIc3wBW0Yi33NDX41hHKGJbeWHX84=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGZnU1pUdG5HbG82UDMwOTJMdDl3dnQyQnY0VnozdTViYnZaR0ozUE1EM1VY?=
 =?utf-8?B?cUNRM0J4ekxkVWFwODlmSEprR2dNWXY5bTJuYnJZSksrRlYzN3FOU25qR0tP?=
 =?utf-8?B?TWtTS0lodDdmWVJwNjdFQ2EzNVhSeC8yUzlNQzJiejZtWTBJNWZ5MkpvME5T?=
 =?utf-8?B?a1BaQWJCK0VqOXY3R29iVkRnSEZXbE1ORytnVVhDS2VRbTdFTVkrclQxRXlq?=
 =?utf-8?B?VVJIaUFnRUlhMkRQcU4rOS9RR0EzbUNTcWVHdE9hM1BodXo4QU9Ta1dST1Vn?=
 =?utf-8?B?TTF3R3pkYkJ3SlAxVFByMjlLK2dhSzZORmh3cTFVWmJpa1ZsTEV1ekdtenNy?=
 =?utf-8?B?ejRtdHFoSDZYazJqL3JneGlPSHRjTW9nckFoSDErWXcrMytEbW9kenVhWkpB?=
 =?utf-8?B?UW5nNjBzUUhDTlpTTWRDSnJ3YXBrYmdxSlU3OGt4K2tjbkhLYnBJTFA3d25a?=
 =?utf-8?B?eFhxblZ2TUMrTXZXWC9UdU1uVHE3TmpWK3dPb1hYWDE0NFpOcGE5NDFZUE1K?=
 =?utf-8?B?bUo3QXh6NGtRMWs2amFFdDdLaUlGTjhJYU9odjRtbVcvS3o4SjRDdTRDQ1Q2?=
 =?utf-8?B?anpzQndJcVJIbmZaM1czQS9NSzl2TGEvYWF5bVJCMm5uMmRJWWRkR0NGbGVW?=
 =?utf-8?B?dHc0YTJtVDhMYU96UWVDaHVTeEgxdGw2MjV5em5PdUVPOFgyTTJsQnlUSmJG?=
 =?utf-8?B?ZnN3Ty9hclQ0anJKY3JheTVWdmxHZHZ1VEpIb0dXNTN5RHRPVk8veEF4V1ha?=
 =?utf-8?B?Y2pPTDlTNCsrOEhaV3RtVXFRLy9tRjFyMUE0bGtQelgvWE5jc2xNV3phMkl0?=
 =?utf-8?B?bXJXREozUnk4NXFDV1JrWmo0MFBvWkZDTFVYdkFJL3N4ZUZsS2l3RnNMNCtw?=
 =?utf-8?B?UmUxWU0xSktVblpoWjYvVzd4dHJIVlRwWFptVjVJUHMwbjJIa2NDTkljNDh1?=
 =?utf-8?B?T05QeDlQU0N0YUpmM3I2R3dnaGVVUDFSM3U3Yit3R3ZIOFUraGJFWGJxV2NM?=
 =?utf-8?B?a3U2d2p0Zk55SG9qeTl0cjIxUWNmMk9FNFR4V01zZVZNWnRzcFRyZGMra3hF?=
 =?utf-8?B?SXN0RFBYem5qY1VIeVErYkxNSWdNWGxDOFZQTSs4MlpkYVY4WDc1VFJFeHlF?=
 =?utf-8?B?L0VEbSs0OTI1bDRpT0JRZ3pNMWhtWUlYWVowK0k1UlZLZ1lyU0lvTDlxbWpE?=
 =?utf-8?B?anhRcFJrNG9RRUJmVVhLSlRybkVDRFgzV0xpeTVyd0ZBN3pPUWpqaG5heXNl?=
 =?utf-8?B?eFpUVHhidVlYK21sZS95d2J2b3VIaVpJQnFJdUdpQjYvVjB4THNiZnk1eTc0?=
 =?utf-8?B?dndpVmpYMGVzRVl5WW1VUGUyKzh0cnZmSVIzakxVL2Roc0N1K2RSS1RaVWJZ?=
 =?utf-8?B?U1BnWEpyaWQ3enozTFdiV21GNXZpdHdNYWR0alphN2lyN1pmL3VpdmNEdWx3?=
 =?utf-8?B?c1ppTGdZcWhEK0lVd0haN2hHU2Rmb3Qwb1NiWmxCOEdJUWw5RkQ0dnhrRnRr?=
 =?utf-8?B?ZHM0Vmg4cHJUMUYwbjVBVm5lbDFaYnFaTWRUcEhVMGVFWGJmZHNQSWNFUEtS?=
 =?utf-8?B?VzVVR0Q5Nk5JaHZaQi9VR2U1dS9aSit1WG1JTjlEbE4rNHEzcXcxNitHNjA1?=
 =?utf-8?B?bSt3Q0RSV2VhaHVaYkhGUDVVQTlCcDArempsMUNHRFR6TXUxcW15RnNSdENQ?=
 =?utf-8?B?aHpXckdLbzJUUGpyQTY4cWdpNzA5NWl1QlNXaERuNEZzL2ZTSGg2QlNFSFJB?=
 =?utf-8?B?bWNPaUxiM1gvTCtKekJZMytZNVR3alZ6Y1ZHcE4wTDIrSHZVMWJhcHc2Z09l?=
 =?utf-8?B?OWpBenZWMXRxNWsrcjNaL21tRm1nclord2hjSW9sZ0I5ditsbDI3M3plL2Yz?=
 =?utf-8?B?YW5mTmJacWJLTFc3czF5aEFuMmtuMTh5L01LOXUyeFBacUlHUUk0NW0vSUZ3?=
 =?utf-8?B?WURJeHZJQk1ZM0FBQzBONE9NT3V6eVBnSnpZYmMwTVN2Nmg3NFhLcU9XTHA3?=
 =?utf-8?B?Y1pxRXd2KzBmQVpIaFl0UkpZekZNbHZwZVdHK0c3ZGNQODdvbjdUaldjSDNr?=
 =?utf-8?B?MHNycmZ1RUtjeTRQck9MMmE2aVFsRXRUQ0F4ZVNRVHgrMTJtRUtWMzRPSXMv?=
 =?utf-8?B?UjlEdEp3ZDBoOWV2Ylg4SEU3TWY3enhBVFRyOXZaMmcvaDV0ZElhTWJjaDJB?=
 =?utf-8?B?L0JpcTRjYXVIdXhZKzFjdEpTajNwbGVLa3hYWmZlTm1iSEZuc1RFN2ZSLzZy?=
 =?utf-8?B?RGEyam5LMXhTbVAyRllyd0VpblZQa1ZKRlJJR1RBcDdnRlBDSEZ4aWIxdGxp?=
 =?utf-8?Q?rFEOoTRRGrjNuogTyl?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 368f09d8-6d67-499d-ccb2-08df13f275a0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 13:00:18.8296 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SyU4m1VxbyhU/fDMsTReEAuj6TzThwm2YkXCCCg/Xd3iMbTO/oaAzlzyxEwXJOk0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6527
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

On 9/16/26 12:02, Yifan Zhang wrote:
> GPU recovery invalidates CPU mappings before resetting the device. A
> concurrent GEM fault can install a new mapping after invalidation and
> allow userspace to access the framebuffer BAR while the device is being
> reset. Serialize PFN insertion with the reset-domain write semaphore to
> close this race.
> 
> Holding the read semaphore across the entire fault is unsafe: migration
> fence waits may depend on recovery, and page-table allocation inside
> vmf_insert_pfn_prot() can enter reclaim and wait for GPU fences through
> MMU notifier callbacks. Recovery cannot complete those fences while it
> is blocked acquiring the write semaphore.
> 
> Add an optional mapping semaphore to the TTM reserved fault helper.
> Prepare page tables with apply_to_page_range() before taking the read
> semaphore, then insert the PFN through vmf_insert_pfn_prot(). Restrict
> this path to non-COW PFNMAP VMAs with mmap_lock held, relying on mapping
> invalidation clearing PTEs without freeing the prepared page tables.
> Keep the existing MM PFN permission and cache-mode checks, and leave
> fence waits, BO population and page-table allocation outside reset
> exclusion.
> 
> On semaphore contention, retry the fault when allowed. Drop the BO
> reservation and mmap_lock before waiting, and retain an extra GEM
> reference to protect the object and semaphore lifetime. RETRY_NOWAIT
> keeps both locks held; faults that cannot retry return SIGBUS. Keep the
> existing TTM helper as an unlocked wrapper so other callers retain their
> original behavior, and opt AMDGPU GEM faults into the new helper.

Clear NAK to the whole thing.

That violates core kernel locking and to be honest the implementation is just a mess.

There was already a dicussion ongoing upstream which rejected that approach.

Please don't try to fix up something without knowing the full technical background. 

Regards,
Christian.

> 
> Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c |   6 +-
>  drivers/gpu/drm/ttm/ttm_bo_vm.c         | 104 +++++++++++++++++++++++-
>  include/drm/ttm/ttm_bo.h                |   3 +
>  3 files changed, 109 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 0d579517c03c..2937f6cda62a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -119,6 +119,7 @@ amdgpu_gem_update_timeline_node(struct drm_file *filp,
>  static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
>  {
>  	struct ttm_buffer_object *bo = vmf->vma->vm_private_data;
> +	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
>  	struct drm_device *ddev = bo->base.dev;
>  	vm_fault_t ret;
>  	int idx;
> @@ -134,8 +135,9 @@ static vm_fault_t amdgpu_gem_fault(struct vm_fault *vmf)
>  			goto unlock;
>  		}
>  
> -		ret = ttm_bo_vm_fault_reserved(vmf, vmf->vma->vm_page_prot,
> -					       TTM_BO_VM_NUM_PREFAULT);
> +		ret = ttm_bo_vm_fault_reserved_lock(vmf, vmf->vma->vm_page_prot,
> +						    TTM_BO_VM_NUM_PREFAULT,
> +						    &adev->reset_domain->sem);
>  
>  		drm_dev_exit(idx);
>  	} else {
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index a80510489c45..e9ac14c471ab 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -162,6 +162,70 @@ vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
>  }
>  EXPORT_SYMBOL(ttm_bo_vm_reserve);
>  
> +static vm_fault_t ttm_bo_vm_mapping_retry(struct ttm_buffer_object *bo,
> +					  struct vm_fault *vmf,
> +					  struct rw_semaphore *mapping_lock)
> +{
> +	if (!(vmf->flags & FAULT_FLAG_ALLOW_RETRY))
> +		return VM_FAULT_SIGBUS;
> +
> +	if (vmf->flags & FAULT_FLAG_RETRY_NOWAIT)
> +		return VM_FAULT_RETRY;
> +
> +	drm_gem_object_get(&bo->base);
> +	dma_resv_unlock(bo->base.resv);
> +	mmap_read_unlock(vmf->vma->vm_mm);
> +	if (!down_read_killable(mapping_lock))
> +		up_read(mapping_lock);
> +	drm_gem_object_put(&bo->base);
> +
> +	return VM_FAULT_RETRY;
> +}
> +
> +/**
> + * ttm_bo_vm_insert_pfn - prepare page tables before taking mapping exclusion
> + * @vma: non-COW PFNMAP VMA, protected by mmap_lock
> + * @address: page-aligned address within @vma
> + * @pfn: backing page frame
> + * @prot: protection for this page
> + * @mapping_lock: semaphore held for writing while invalidating mappings
> + *
> + * The empty page tables must survive until insertion: mmap_lock excludes
> + * munmap/mremap, PFNMAP excludes MADV_DONTNEED and THP collapse, and mapping
> + * invalidation clears PTEs without freeing page tables. Thus the subsequent
> + * vmf_insert_pfn_prot() does not allocate page tables under @mapping_lock,
> + * while retaining the MM's PFN permission and cache-mode checks.
> + *
> + * Return: VM_FAULT_RETRY on contention, with all caller-owned locks retained;
> + * otherwise the insertion result or an allocation/validation error.
> + */
> +static vm_fault_t ttm_bo_vm_insert_pfn(struct vm_area_struct *vma,
> +				       unsigned long address, unsigned long pfn,
> +				       pgprot_t prot,
> +				       struct rw_semaphore *mapping_lock)
> +{
> +	vm_fault_t ret;
> +	int err;
> +
> +	mmap_assert_locked(vma->vm_mm);
> +	if ((vma->vm_flags & (VM_PFNMAP | VM_MIXEDMAP)) != VM_PFNMAP ||
> +	    is_cow_mapping(vma->vm_flags))
> +		return VM_FAULT_SIGBUS;
> +	if (address < vma->vm_start || address >= vma->vm_end)
> +		return VM_FAULT_SIGBUS;
> +
> +	err = apply_to_page_range(vma->vm_mm, address, PAGE_SIZE, NULL, NULL);
> +	if (err)
> +		return err == -ENOMEM ? VM_FAULT_OOM : VM_FAULT_SIGBUS;
> +
> +	if (!down_read_trylock(mapping_lock))
> +		return VM_FAULT_RETRY;
> +	ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
> +	up_read(mapping_lock);
> +
> +	return ret;
> +}
> +
>  /**
>   * ttm_bo_vm_fault_reserved - TTM fault helper
>   * @vmf: The struct vm_fault given as argument to the fault callback
> @@ -183,6 +247,33 @@ EXPORT_SYMBOL(ttm_bo_vm_reserve);
>  vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>  				    pgprot_t prot,
>  				    pgoff_t num_prefault)
> +{
> +	return ttm_bo_vm_fault_reserved_lock(vmf, prot, num_prefault, NULL);
> +}
> +EXPORT_SYMBOL(ttm_bo_vm_fault_reserved);
> +
> +/**
> + * ttm_bo_vm_fault_reserved_lock - fault a BO with optional mapping exclusion
> + * @vmf: fault information, with mmap_lock held
> + * @prot: page protection
> + * @num_prefault: maximum number of pages to prefault
> + * @mapping_lock: optional semaphore held for writing during invalidation
> + *
> + * The BO must be reserved. The caller must not hold @mapping_lock. Its lifetime
> + * must be protected by the BO's reference to the DRM device. When supplied,
> + * only non-COW PFNMAP mappings are supported. Fence waits, BO population and
> + * page-table allocation run without the semaphore.
> + *
> + * On contention, ALLOW_RETRY drops the BO reservation and mmap_lock before
> + * waiting, except RETRY_NOWAIT which retains both locks. Without ALLOW_RETRY,
> + * contention returns SIGBUS with both locks held rather than blocking reset.
> + *
> + * Return: Fault result. VM_FAULT_RETRY without RETRY_NOWAIT means both locks
> + * have been dropped; otherwise both locks remain held.
> + */
> +vm_fault_t ttm_bo_vm_fault_reserved_lock(struct vm_fault *vmf, pgprot_t prot,
> +					 pgoff_t num_prefault,
> +					 struct rw_semaphore *mapping_lock)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  	struct ttm_buffer_object *bo = vma->vm_private_data;
> @@ -263,7 +354,16 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>  		 * at arbitrary times while the data is mmap'ed.
>  		 * See vmf_insert_pfn_prot() for a discussion.
>  		 */
> -		ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
> +		if (mapping_lock) {
> +			ret = ttm_bo_vm_insert_pfn(vma, address, pfn, prot,
> +						   mapping_lock);
> +			if (ret == VM_FAULT_RETRY)
> +				return ttm_bo_vm_mapping_retry(bo, vmf, mapping_lock);
> +			if (ret & VM_FAULT_ERROR)
> +				return i ? VM_FAULT_NOPAGE : ret;
> +		} else {
> +			ret = vmf_insert_pfn_prot(vma, address, pfn, prot);
> +		}
>  
>  		/* Never error on prefaulted PTEs */
>  		if (unlikely((ret & VM_FAULT_ERROR))) {
> @@ -279,7 +379,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>  	}
>  	return ret;
>  }
> -EXPORT_SYMBOL(ttm_bo_vm_fault_reserved);
> +EXPORT_SYMBOL_GPL(ttm_bo_vm_fault_reserved_lock);
>  
>  static void ttm_bo_release_dummy_page(struct drm_device *dev, void *res)
>  {
> diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> index 8310bc3d55f9..06138c1688f6 100644
> --- a/include/drm/ttm/ttm_bo.h
> +++ b/include/drm/ttm/ttm_bo.h
> @@ -438,6 +438,9 @@ vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,
>  vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *vmf,
>  				    pgprot_t prot,
>  				    pgoff_t num_prefault);
> +vm_fault_t ttm_bo_vm_fault_reserved_lock(struct vm_fault *vmf, pgprot_t prot,
> +					 pgoff_t num_prefault,
> +					 struct rw_semaphore *mapping_lock);
>  vm_fault_t ttm_bo_vm_fault(struct vm_fault *vmf);
>  void ttm_bo_vm_open(struct vm_area_struct *vma);
>  void ttm_bo_vm_close(struct vm_area_struct *vma);

