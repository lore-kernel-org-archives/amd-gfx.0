Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46937C433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 19:59:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEBD910E713;
	Mon, 14 Mar 2022 19:59:44 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 351CC10E713
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 19:59:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CFtT579eAhBhMjFqzczpjNhQG3q6F2kQJ6ogq5ALtaDfxBj3pgpitr71xjxYX8kEITxxTKF4Lv+hanUV8jjIMOb7HGrUvQI47BEw7XO4V0b3C544gt/jPmroOi3pxuL5IzBkYVSJvV1FnkUDOwOqt1cgBtwVSCX3t/CzL3d0FCiFN3VH7nObFSMsZAH9PdJjhcyU/p+RBtMIuNI9iUGT7IGKwk/Ow1xBIXaSE+6jP0HSpp0jWlO6lIUMvS33PftUcB89Jz1kBHwHychqXQPvYlbiLno3l/RmZPgOsq7vJ/N9FdISCijcMUOJXPtJMfeISrF0cwjacXdOaUaDBbD1aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71OsZh26quwRQnhs5suI1UCOvj26hl5Yg6sd0U6ujtw=;
 b=aTyZvn+I4QdLmNw/fEIr5/9gY8L8RM9uPvhNCWhOeq8pbO3RXKY55TMG0wdZSDsZnQ3pB0lP3par0ax/BiY+b2a3C2NQi7JGwEbpCJj3C38cZ0U4xKickqcsHDxDNfj346SgW2nbLubr/QdLbZwe8T+8t/iFhCHK6i5Ew0/OqvMhkv/NJVaB3K0ABGDtjdXWmVavzzsRgvdyXRviV86ld/TQBWOIbTlKKK71F2gv1zkJq8lowkjpGp2ycLvR1uZ4//7wV9TCLtbQV0gLaCBjLFz60k+tKI/lgZ7EbMX5kXGZQe/V1v2yv0svYHCOA390EprqH9mzbyJzzXbQ6i/1Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71OsZh26quwRQnhs5suI1UCOvj26hl5Yg6sd0U6ujtw=;
 b=eOPJNxawsbH0gjjMCiV/yj0ziBXrHMdwlyIxa1iuJmC+q+rjFDDO2DBoT/hV/oLY8Mg33mHNZiqFPlgYp6dxV2OMAuRkeEj9ght/GhVD6taXrPU7mGpwrMnThBoTdXDz5pBqJS52HnQKqD++4M8v3h3ISRJjYDbeI+/97w/MJts=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL1PR12MB5287.namprd12.prod.outlook.com (2603:10b6:208:317::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Mon, 14 Mar
 2022 19:59:41 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%3]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 19:59:41 +0000
Message-ID: <3e48dab3-f807-6a1f-a1a4-5f5d7791db10@amd.com>
Date: Mon, 14 Mar 2022 15:59:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 1/1] drm/amdkfd: evict svm bo worker handle error
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220314145020.9142-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220314145020.9142-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT3PR01CA0009.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::21) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 006e40eb-14e0-429f-35f7-08da05f52d6c
X-MS-TrafficTypeDiagnostic: BL1PR12MB5287:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB52878FD1E2576DD577E75351920F9@BL1PR12MB5287.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MQ4uSGy3pVFjoGhSAM/TUbMkFHCaSGcj5JLc1f04sHakDiatpnMGK7zf9eFlKuP6FeSpi9XWWMDBBlM2kRE5+ByTJhM/AsDHXR9BsesUvm5jOkV9lv41PL4F6u4IaSFxFGBSlnGd3TG5xZwlKrPWpRJif6MbFn2HNW4Zpvn7ijL5it5BMC672YN6WJ2IgZVZGQxPG18RzjwJwXX4MLH0Ep+2YsAbzb1fVRS+QsR7hLq6ktotV1oBncBxLscPRMJnAzVjk9BgP42ihdjACUBQSIMAiiWsFBStAaPKDoiJWYbbbpprGZfK3AOaO1925QgNrXVNPDmoxU1YyLd5mxHJk72Einrc3oGH7L11ptIrwvoV9zHNtk9CsEXvy0KRm3jG/5cm4dXH1if+JJ3gUo3gqrFEqy/7oYH7P56kp3yg2E1rwp40o//en3MDe5XTAm8yMh7DvqF6HNrd0CrtWTHx5Yd8tJrzyAARIF3rsvfYRa2eUHDsXsqGCezqcQfyGm5xq334/T1Xh9zEqflplFIrxiBSJC3IvD5ljJaiTz0rDVlo5WS3KBJVe6Kn2ui4psgZoUmIlxqGJHfwRPAksnoOwwtRUxY5MSNlu8h0H+yabhD9tvBvVEhGAJXjAt/X1rnZ0vjfxyz6UXdi6fM2pRfq78U1bcfT/UOghjC/IAJb6b3DPTFP1AL1+0uxnO0oq7E5P9QWrjtPCG0RRdP8ntJcf1onKCYXarpbn3TNY4sv27Nro+WnBxxGw9ObDRJriOA9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(38100700002)(2616005)(8936002)(66476007)(66556008)(508600001)(6506007)(31686004)(5660300002)(26005)(66946007)(186003)(44832011)(6512007)(6486002)(36756003)(2906002)(31696002)(316002)(83380400001)(8676002)(4326008)(86362001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXpTTjluYmdJMEF1NXhkZ1V4QVRUYkJjYmdKaFR4MHo4TmJ4bEVnT2QrdW8z?=
 =?utf-8?B?ZUIxYVc5K0pBQkR2cHZxN0t2cTA0UUp1TEdQRHdpN0VYbStaYmNBSVhrMUdH?=
 =?utf-8?B?aUcvcGpJZC9FdFB6cDlnZ1ZLNnArQ0VMZHdqaUxyeFZYV1AvSVU1NnJGZ042?=
 =?utf-8?B?OHErei9QWnRLWmpVV0wxTDJzUXU3UzBabk8rRDVXb3cxanliYkpwOVdDRW95?=
 =?utf-8?B?T3JBb1loNFE5Smc0WEdxcVdSbmN3RWhDWEVDdHI4UTl6cEJOTXFucDdXYmJy?=
 =?utf-8?B?N1dINk9FY1VmNFZKRG9zMGtHZHZlS0V1T1FySGY1ODBsZUdzR0x5UW5aRzl5?=
 =?utf-8?B?UGVjV2NkSWM4bUVIOUhJejd3YndpVDMxYkRSbTh6RXNpT1ZXUlR6UWI0bkoy?=
 =?utf-8?B?bnlEZlQ3aDdCa3BMUHNEeXBXS3BzTmhvRmNyUW1NZkJENmMyZjd0cmZ6Nzcy?=
 =?utf-8?B?SHQrRkYrTE9IVDlPTm4yOFRlejRJTzhOd1QzVTlLUGMzTWpINUwvWG0vQk8x?=
 =?utf-8?B?dWRtRDVIbzM2QTUrMDNIVE5TdGozUEo1bWVJTE0vSWFOL0c0dCtrY1Uxd1k5?=
 =?utf-8?B?Mm5rdE9sWHNLVFltbGE1YjdTdXNEcGZBY3ZkVUovNm9sU0RjYWt5WEdNZlhn?=
 =?utf-8?B?WCtEdzBBcE4zTmRTQkVEUkE3dWliM3pwQ0ZoQ1p1dHZ4S3JYYUdkSHlTeG80?=
 =?utf-8?B?N1ZGUmRDQm81ZWlDYmNBUUR2aEl3YklwRFFtY1U1YUpxa1VxdlRwWjNkaFhm?=
 =?utf-8?B?RENLVHkwaDA2MHFSZlZ5bU1pMEUydXI5eU1yVWk3STcyZEx3a0NYRi9NaFdM?=
 =?utf-8?B?a2xrdW5pdjlRVXU3Qk9YS3BKYS9QaVJPUlpuM3J0TTZxVG9nZ1VwMmFFa0lo?=
 =?utf-8?B?WlN4Q3cwVTdYdUhvdjA5T0d5Rm9MSjBnSWFhbWl3R3RhWFR5NnRkcUx2OWts?=
 =?utf-8?B?SlpzUUhMV2hNSkw2YXU2OEV0NnpTV2x6VC9wZFN4aldqOFRCUUN5NStpL1pr?=
 =?utf-8?B?d1JKYjBsYXdYSmJ1RmM0dUxneDlQT3djcFJKM1J5T2RqcjVhb3pxTEp4ZW8z?=
 =?utf-8?B?dUdXOVRRdks5blJ0R2xMWmVaS2gyWXJKa0NhYWJwYXVIL0JYclRFV1gxUys4?=
 =?utf-8?B?bXRhejZLZDNveWpHcTd2R3dOYmdpbldqV2xJeVdZelZHV2hSR1NPZzdCQngr?=
 =?utf-8?B?L2dxZk5kelQ0LzVvNzY5TUFJZ3UxaTUwcUJ6VFZMT25uUDNMWlU0cmhoU0Iv?=
 =?utf-8?B?Mlh2dWJwNElRU3QwVmhaNDRjbTZ1Y2FSSDBxMTBUZHNYS3Q0ekFHSGdMczVZ?=
 =?utf-8?B?Rm1zV0k4M01UbmFJandLSmFUVUV5VU1zSHpadDMvOERqcGdEd2JKTTZxN2p6?=
 =?utf-8?B?U3ZiTzVmNmdKNGRRVGgrNnFWd0d1TmFPa2tjY1BQZXpNWEJqMWRSSENibkFv?=
 =?utf-8?B?NXNkcnE4OHdNVXpCcHJad21nSVhjRlpxTFBKUUd0Q3JXeGV4MWUrTVd6NUJz?=
 =?utf-8?B?cjRRUGtwMXhaN3BPZUVUdEdBNm9ncFFjZkUvNURsS1ptWGNVQ1NxRHdESG5M?=
 =?utf-8?B?aGNtVVFkdjZxemtONitTYisyVHk5ZXR2dDFqK2JYRFpWY01jRm5hRHZISFh3?=
 =?utf-8?B?RW9DRnU2SFh2VmVyZFhRN2ZnRG5HOWtReXVvMzhZMGJobEJmV3laKzJ1bXAx?=
 =?utf-8?B?Z3loOUJXbjNWbGtFeGl0WUFhcG9qRGpWZ1VqT015VHRYTnQ1SDVzMEFpRlgw?=
 =?utf-8?B?RGlZTXFqdkRYejZyeEVxYnR2WGx0bm40bzFxMU40NERJM1BabXJwOWhYNFp5?=
 =?utf-8?B?bGdyR0NuVjljbTByZlBJanlDR2IzOWtlSlpxKzZMVUprajBuMjdTaXRKdXM3?=
 =?utf-8?B?Um40RFdNOUNyVmFlY0ZDWno5cVNHV1R2UjlDRjltaU9oUFZJbjVhWGZOU0Fy?=
 =?utf-8?Q?sJrYoVUUooyQbvudLeIEsv8yyaZg3Imw?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 006e40eb-14e0-429f-35f7-08da05f52d6c
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 19:59:41.4956 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 71oQEbWvYqd6vDVaT5rihgl+PGO3ReMI+Us0IomWXRHg3GfJ+iidOI7gQianly+0ZV4Ztht9/KvXpREgZQOwCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5287
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
Cc: alex.sierra@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Am 2022-03-14 um 10:50 schrieb Philip Yang:
> Migrate vram to ram may fail to find the vma if process is exiting
> and vma is removed, evict svm bo worker sets prange->svm_bo to NULL
> and warn svm_bo ref count != 1 only if migrating vram to ram
> successfully.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 27 +++++++++++++++++++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 20 ++++++++++--------
>   2 files changed, 33 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 7f689094be5a..c8aef2fe459b 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -638,6 +638,22 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   	return r;
>   }
>   
> +/**
> + * svm_migrate_vma_to_ram - migrate range inside one vma from device to system
> + *
> + * @adev: amdgpu device to migrate from
> + * @prange: svm range structure
> + * @vma: vm_area_struct that range [start, end] belongs to
> + * @start: range start virtual address in pages
> + * @end: range end virtual address in pages
> + *
> + * Context: Process context, caller hold mmap read lock, svms lock, prange lock

I believe this is not quite correct. In svm_range_evict_svm_bo_worker 
we're not holding the smvs->lock.

Regards,
   Felix


> + *
> + * Return:
> + *   0 - success with all pages migrated
> + *   negative values - indicate error
> + *   positive values - partial migration, number of pages not migrated
> + */
>   static long
>   svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   		       struct vm_area_struct *vma, uint64_t start, uint64_t end)
> @@ -709,8 +725,6 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   		pdd = svm_range_get_pdd_by_adev(prange, adev);
>   		if (pdd)
>   			WRITE_ONCE(pdd->page_out, pdd->page_out + cpages);
> -
> -		return upages;
>   	}
>   	return r ? r : upages;
>   }
> @@ -759,13 +773,16 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
>   		unsigned long next;
>   
>   		vma = find_vma(mm, addr);
> -		if (!vma || addr < vma->vm_start)
> +		if (!vma || addr < vma->vm_start) {
> +			pr_debug("failed to find vma for prange %p\n", prange);
> +			r = -EFAULT;
>   			break;
> +		}
>   
>   		next = min(vma->vm_end, end);
>   		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next);
>   		if (r < 0) {
> -			pr_debug("failed %ld to migrate\n", r);
> +			pr_debug("failed %ld to migrate prange %p\n", r, prange);
>   			break;
>   		} else {
>   			upages += r;
> @@ -773,7 +790,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
>   		addr = next;
>   	}
>   
> -	if (!upages) {
> +	if (r >= 0 && !upages) {
>   		svm_range_vram_node_free(prange);
>   		prange->actual_loc = 0;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 509d915cbe69..215943424c06 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -3155,6 +3155,7 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
>   	struct svm_range_bo *svm_bo;
>   	struct kfd_process *p;
>   	struct mm_struct *mm;
> +	int r = 0;
>   
>   	svm_bo = container_of(work, struct svm_range_bo, eviction_work);
>   	if (!svm_bo_ref_unless_zero(svm_bo))
> @@ -3170,7 +3171,7 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
>   
>   	mmap_read_lock(mm);
>   	spin_lock(&svm_bo->list_lock);
> -	while (!list_empty(&svm_bo->range_list)) {
> +	while (!list_empty(&svm_bo->range_list) && !r) {
>   		struct svm_range *prange =
>   				list_first_entry(&svm_bo->range_list,
>   						struct svm_range, svm_bo_list);
> @@ -3184,15 +3185,15 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
>   
>   		mutex_lock(&prange->migrate_mutex);
>   		do {
> -			svm_migrate_vram_to_ram(prange,
> +			r = svm_migrate_vram_to_ram(prange,
>   						svm_bo->eviction_fence->mm);
> -		} while (prange->actual_loc && --retries);
> -		WARN(prange->actual_loc, "Migration failed during eviction");
> -
> -		mutex_lock(&prange->lock);
> -		prange->svm_bo = NULL;
> -		mutex_unlock(&prange->lock);
> +		} while (!r && prange->actual_loc && --retries);
>   
> +		if (!prange->actual_loc) {
> +			mutex_lock(&prange->lock);
> +			prange->svm_bo = NULL;
> +			mutex_unlock(&prange->lock);
> +		}
>   		mutex_unlock(&prange->migrate_mutex);
>   
>   		spin_lock(&svm_bo->list_lock);
> @@ -3201,10 +3202,11 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
>   	mmap_read_unlock(mm);
>   
>   	dma_fence_signal(&svm_bo->eviction_fence->base);
> +
>   	/* This is the last reference to svm_bo, after svm_range_vram_node_free
>   	 * has been called in svm_migrate_vram_to_ram
>   	 */
> -	WARN_ONCE(kref_read(&svm_bo->kref) != 1, "This was not the last reference\n");
> +	WARN_ONCE(!r && kref_read(&svm_bo->kref) != 1, "This was not the last reference\n");
>   	svm_range_bo_unref(svm_bo);
>   }
>   
