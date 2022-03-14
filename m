Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F080DC433F5
	for <amd-gfx@archiver.kernel.org>; Mon, 14 Mar 2022 19:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A011010E709;
	Mon, 14 Mar 2022 19:58:37 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A350510E709
 for <amd-gfx@lists.freedesktop.org>; Mon, 14 Mar 2022 19:58:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DhaNc9TD7htYv3VSnoOKRFfbWb0xwi0wjHp0yHTpz6Tyu8kUS+BBI01yL4CVcxzjok9uamahyw1CQjgWm5Kv9mRDaIj94EbYc5PcuNZWCiZIAU915/tVuM7Kb3CxeQA3lxBODGpA+dBc35lKreUEBMHqivCoRr5rehk1x/2MtXMflOCDBOreZgN4myMqSIRs95awBy2+ltE4tiINmUkGnQHfY+NGT6oBLOnyrlv9C8Jw6ZB4NYbR0Kj6wyy0qmJsVJmmnihMRh0q6SaNgnQgRSw3iumuvrQVzWR0Z6TOslhZjND8+mPgygi+0HSyChfhTYhpdwwUbO4nQPwrR7d0Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OgN7xfDh4+nNxcKJm9sHzuVpyMF+q4cjAjxQ0w9Ji8=;
 b=gzki1jwxQGhf/+xOcAVoXaxXsPRqfsYWbFTH0Fs+KpQJZkTIrYx2bUZpnyAEyvVmFzSG+AnA7KNLX4ioJ0aGXQCFCRY1I/Md5tIOA6NyI02TxYsYcLSHSeGFjKzHM5I/H/snCY/d5gfYJEkC4u4KkVxcjUrpRkIttBcbTilNekBPirYIE9Ye7oK8h8vLCaJm9QRpUoFpYr/i7u5+VrmeIdjzELgQ6UU+j7fqq0O0VwhRzTXpbYelViFMECafnOkmdgdHK2wpxUmfYlVe7SbS87Lt8T3HV1w/4QVtBVHAGnqaqkIDHW1rLUvvtPbKV8dq6YtBeKKvKDkpATcmF5H28w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OgN7xfDh4+nNxcKJm9sHzuVpyMF+q4cjAjxQ0w9Ji8=;
 b=tM8Bp8N4hH19bEg3ldQHR1prs5M9thnv114EF/nJaDh3n+wU4czMFOQ0RZdg7+ejTT+kabA1Ko/oIt40aC5+J+PgKqRq4R6ioV+a0MLcwHFqH6CGK+CkLSFrckVQBd7kkfh94T+WjfFrLo40fR2raGaV7tqNFGzhcYJRhrqvLuI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by PH7PR12MB5619.namprd12.prod.outlook.com (2603:10b6:510:136::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Mon, 14 Mar
 2022 19:58:32 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%3]) with mapi id 15.20.5061.028; Mon, 14 Mar 2022
 19:58:32 +0000
Message-ID: <486b326f-8842-5de4-07ad-7ab1f209132e@amd.com>
Date: Mon, 14 Mar 2022 15:58:30 -0400
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
X-ClientProxiedBy: YT3PR01CA0021.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::32) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 345ff061-45d1-4261-d305-08da05f50429
X-MS-TrafficTypeDiagnostic: PH7PR12MB5619:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB561937FACB36206BDB9AA73C920F9@PH7PR12MB5619.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vAWKn7E2Sz4YGsJhnsRuaIOaYplei/N3qYVrNVaK207uUNApur6Zl/i55LYQJDGHlY8i7npPozEqGvSgswjn5tHvaI+Y1SU/0A8jWU+tj7iwLbESEHUf4twK9LYQa98ZMUr5YylJ0MZOGPno4QOrDrkFe2QU0GwSE0gLVqpevCHD3kFhCb6XKed2OmqZ818MgEVXkrH/e5qGy6st9xre5TXnc2N48EY9s/lUFZGxDjnuW0KHlt7FFyKA88EvH8MFXYp8khOdiapPH9NQK6OUxwqrbrnLEi0QNcHUhEUyL5Rms6nceBqkhnuSUv7lka7icrhO+nbiJ0Bg1gfOtILvFCgajS24OqeELvse95sk2g1aPHcqH7PcF1BNJ1LCaf8ELC62dsg4VNQVkYVJE1GRgHFy9NiSaKQqjPkoEcefLd0YHmYdWgkD0zXY1gd3GDPT/doxUqwTUXBOIk068MLhi+xRYj4H1+BhxFENtvk5wTv9VPyre5+6tdZbRaAp2679rXT/ONlE/V7iAWzJnTnjTChPalq/w1tqU/ur07iTmDyuMq2CA6K4m01PvgTYwHz1Y0J905zNpCHIeTlpi98D9sJDtyCCojYn84pmejiR8f83SvYOa/QaGiUZexuVDjwO2R5iaGjEeT2/OUmESgXgRt3x36DlieGdxj4OGMgubsbiP9TTTF9ulEo2noCp04YMJy1wLzk7/2DZ/as0LY+f7eRP3WO6Okoq6P7KFacd0oJOPH3xcArubv+ZKDWhqTrR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(36756003)(86362001)(6486002)(316002)(31686004)(4326008)(66946007)(66476007)(44832011)(6506007)(66556008)(8936002)(38100700002)(186003)(2906002)(2616005)(31696002)(8676002)(26005)(83380400001)(6512007)(5660300002)(508600001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dTJaaTN0bHBXUkVFa2RLRGlkQXNxSmlNRVBCN0UrYWRIY08wdm14UVQvcnRW?=
 =?utf-8?B?aExQNnBrSEt4bzVpL2QrenB5eTdhQUFXdkk1OVpKYzR2cXpNL1lSK1RvUHpK?=
 =?utf-8?B?bk1WWWRUVGx4aWtsd2QwcXVQOFNMeXBoV0hYLzZhdW1WbVJJNllBWVprcEdt?=
 =?utf-8?B?aDJIYi9oV3BHSUx2Tk9rY1NPdmR6elRBSXphUHM1dmtySDFGYTJhOHIydnZP?=
 =?utf-8?B?TWk4bEpXdkt6Nmp5K3F0OVVzUlE2RlVaU2NLeklQN1l2bHVXa2JaTXgxMTlh?=
 =?utf-8?B?N0lPNVJwaEVKL2dPeDdnejdwR1lTVEpCdHBKN2NOcmhNd3JjSHBxZ2RodkJL?=
 =?utf-8?B?SWFTQ0NNYm1PMW9xOU1KREFmVElQWThSWktpeFNoTFlMY3F3dm50cHorSXZ2?=
 =?utf-8?B?K3c2TDRHL3FoWUdjV2xnOUMwUXlXRTQyQmRFYWF3Wkoxdm1qajhJS3RXVnc3?=
 =?utf-8?B?LzFreU01TXYxaUVDQkhvQUZFODM5ZzNmUkJuS2FYQ0hRRmwrcTIxcWwwT1J3?=
 =?utf-8?B?aXlvUDFHeTI5QVY4SjBhM3hiNlZ4QVdBZkIwOUhad0Y3a2sxSDJqU3IyZXRw?=
 =?utf-8?B?dHV1SU91ekVXMFJ5U2tGOE1haVg0Z0lGZ1hGWklSU0RqYXZ1TGRpRGU1bVZy?=
 =?utf-8?B?YkRYbUU4YkQzMXFhQ0dseVowTklJaXFhWlVoZWpLMDdFa0VHQnZFcEQ0L2Nw?=
 =?utf-8?B?djhxckZYT0NncUVrTGpWUUduaUxBdTZzN3ZvUi9YSm9BcWN3Rjd1Q1c5bkFl?=
 =?utf-8?B?Qk9hbnpUeVdPdzJxZTNldG5lS0VsRjJMUG1zcjZnaUhxTmlsT2dUSDRMdWZQ?=
 =?utf-8?B?RVVkemRDY0k2WVdBUFRmL1RRK0tGK2c2d3NhZmc5MDNIdWQyR1Vsa0pSY1pq?=
 =?utf-8?B?ekpFa1FCUFE0aVk3TWxxREw4U3YwaVRxNktIMHdva09Wc3VnckEyS3pXa2hh?=
 =?utf-8?B?M28zbDVBZks2M2RqMzFaSU5meFR5Yk43Y3BGOWE3R3MybCtTOGhLZXQ3VEYr?=
 =?utf-8?B?cTNjWkpLOTV2a2d1cVZhYldyNVJnVkdaemxsRnE3V29sS3ZVODVPbSsrK2N3?=
 =?utf-8?B?QXlTQy9teTRvNWFFRnBzWEF2aHlLNXFxRjN4Uk5iZ1Q4ampuQXpkd0ZOVzUx?=
 =?utf-8?B?QXJwUm5vN1NTRnRSR3hSdU5xelRYY0V1VnVJRmNoZ1JvME1OakZKZzRjdjds?=
 =?utf-8?B?eklZY1IzSXpidHNMOW4wS2t0OE8yYm9FQXAwZEp0QmJsRWxQNW1ScHJ3Rmox?=
 =?utf-8?B?YzQ3U2VPekVwWSt3MmlOMDZFak90bkFob3FGOS9jeGowelRsV2JQVG4yclFL?=
 =?utf-8?B?NjdSa0k0bnVHMWRuQTMwalpiUmVMZDBOZWR3dFAxVEMvMURaSVh5bzVMMkJl?=
 =?utf-8?B?blJCdW5jalVBYzkxZmJTV1hNRE9kcFlabklRZ0xLNER5cG9XM24ydFBINXZ3?=
 =?utf-8?B?Nko2d0UzL0tHNDBsMWRTeUgvZDdxSDlETS9ydTNidGpXVllTY3g1dENtSWxX?=
 =?utf-8?B?QjVSM213aU9OdUNLZjZUSm9qK0Z0TkVaY2tRMXc5NUVZamticm9vLzZrWU5J?=
 =?utf-8?B?QitnaTVmZEw5MDllVHoyL1R0b01vRFBsKzJVOFBCZDJjWHpQZW8zdUtlYUt2?=
 =?utf-8?B?WkFmNjFOd2ZRK1FTMkpVcmQ1SEFtRW92OHpRYTE3d0ZqMVRvRXlVR1h3a042?=
 =?utf-8?B?VVJPODhvQmhzRTMxbVlZMWMxOWNMUGtiYjEzSU5WdjZ6N3NQU2NsMG0zNDBl?=
 =?utf-8?B?ZHFxSC9CZExhZVJzbTFVY2xjSlVBSFBZM0wveThwbXlheVdiVzgweXVUSEJ1?=
 =?utf-8?B?Q2ZNUzFYaVU2U3RJZnk2Mlo4bVBwK05oSkkrR2lxSFpYNFM5RWlTeW1UZ1lU?=
 =?utf-8?B?SFZRcGpLd2UwNk9NeHd5aUppekx0dnR1cm5NVjdJRHdEbXpBUjFFSWdMYlpG?=
 =?utf-8?Q?H2mlShyOq5SwbtdU8eR8ADfZyaRKvFQx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 345ff061-45d1-4261-d305-08da05f50429
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Mar 2022 19:58:32.2728 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1XDWT+FfD/Q0miDXNxmv7aZ7RU7ySVy9rbkqetind+I427srvrOHnxTuwhPB0iKy0RElm49d45G6Pp5peHwIcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5619
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

I think it would still be good to have a WARN here for other cases than 
process termination. Is there a way to distinguish the process 
termination case from the error code? Maybe we could even avoid the 
retry in this case.

Other than that, this patch is a good improvement on the error handling.

Regards,
   Felix


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
