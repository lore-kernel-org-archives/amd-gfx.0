Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A319C56207
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 14:55:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87A0B10F1EB;
	Thu,  6 Aug 2026 14:55:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LHP4lwhq";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013062.outbound.protection.outlook.com
 [40.93.196.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 216AD10E333
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 14:55:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dvPGrYxtVQ+WlfWO4AJ/kgpAh+avoPgiyce/4Wt76N7Hw2WAbor6/a5EJUys0+n9mSXG+qJIJCwKDIE7DtAxYFdiMq44wrP2UA8kqh3OXX1F7G1tAC6rrmBGR8WPK/VQnFN0I+BgOkGRKzgX/X4AxJmWHs1GphF6vvZUrMlGmOyuQlMrVqxgIzEaK2tev0rlE/sveszbi6MFz753qPABLuUskOytqhMUjxhGSZEpRlmQPK4FgCGli3kGdFqfjEnK1NPCcfB9Yqmkj6krLnWztLmzI3wh21Uf8fB5Nm77evhmB1gPIhPt2/TQtUF/LJUdHdxO+3sw9q9FDICv1MTKEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTwnYrnkxG1ljEop00AMtvpanT3b81Xq17W8AIrJwmc=;
 b=OpqbEj2cCQeneJa64u9ZsvRFm7ihgkUIVfLNPLkcX+AV9kCd7w3+OUlZMZ6d4sCeTJM8yjtco5sJ4PcucwKQbZ34Q+UYdn2pusVOWpPz5Ujt9+T29RpoB+lAWqgPcHY/l6yZ8DF6cZs6K4OD0VrO112IvOWvnIrpHM2q7UPVCC+rCfJKRaQScd1KVH0HnmYqsWl1GLfRDgsKEUX9ty08CrEEJmtUal54L5dd4ENHaewAJ7U8eaBXMzR4guPttAkAl/SiPUu7WoLJbe9PHmWtttM5xitHVXrS063BVuiNllHhZHj/I+jKGr4jjsYJWscQdaGCfhPDu4aklmydJ06Jhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTwnYrnkxG1ljEop00AMtvpanT3b81Xq17W8AIrJwmc=;
 b=LHP4lwhqfeufFH2aWDPtCNu5oFUBkcoFi3ZW7fCeo036O7ugMEatnKOaKpp+rsc6I+JLyLsQP2vXAyToT43uyerZEs2PLoMdtriT3RmMuMksvwC5EwgkZ9iZfDuwHIs0BuPUfJC39ie8BXp7OUoMJg9xiZyvEbmUtao6ec4D5cs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655) by DM4PR12MB5939.namprd12.prod.outlook.com
 (2603:10b6:8:6a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Thu, 6 Aug
 2026 14:54:59 +0000
Received: from DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852]) by DS5PPF78FC67EBA.namprd12.prod.outlook.com
 ([fe80::7111:7e5c:8508:7852%8]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 14:54:59 +0000
Message-ID: <b03e6eba-b392-4f7c-9895-091b96e08564@amd.com>
Date: Thu, 6 Aug 2026 10:54:57 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: don't repeat a SVM migration that collected
 no pages
To: William Palacek <William.Palacek@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Philip.Yang@amd.com, harish.kasiviswanathan@amd.com, Alysa.Liu@amd.com
References: <20260806143154.3020903-1-William.Palacek@amd.com>
Content-Language: en-US
From: "Kuehling, Felix" <felix.kuehling@amd.com>
In-Reply-To: <20260806143154.3020903-1-William.Palacek@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0418.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10b::26) To DS5PPF78FC67EBA.namprd12.prod.outlook.com
 (2603:10b6:f:fc00::655)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS5PPF78FC67EBA:EE_|DM4PR12MB5939:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f12396e-1d11-46eb-713d-08def3caafe7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|6133799003|56012099006|5023799004|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xP0oOy7u2ToKz5dlZalmgWXgmQw9QpZGh/rz7j7DXZ5wwrHbaht5Kc5BffM+79XgAwwOMqh7zIrZQ56gUFg7iTQoJ6olTasaNin8Ig1ucL9mkZuJYOJKweNABCSnXXg5mPnic/VtdPDCyWzqraIqwkr0wW0WUhNiQlM8vHuJFkaEU+K6i01GT1om+DU+VOpeVxNFlGGxmEJilhovSDeCT35ebd6nRljyXjS27iECeUF1exZFIKidPsl2OgpYrHnCJhnzrpxRQYKSvYwAgxfjUqDtVMH8Px86MvDCy+AtS5k4Jnz89j3sf/g0NOtliesOhsJNSzH+eSXIkdq1YhaRjP0AsPXc1dcfzjizDrIHAfjT5IGbdHyAJEJ21I942A+ptOaZqVt4TSYRAXr1T1k8XfA5qEmZMJbmXzmZ1P8p9SxPuj7HNP18clESZqOAuo9yyib6epZu+2yGreG9ih0x2zSumtn8/igE8U1etlgFaIBQQRDTgHUH1CnTCO9K5MRK55duZBPV52EZyK9zOooBFVGn2VR48am8xbbMt1d/lailvW6L5A5qU0cu7ROUzq/cS1pkQDlWHGz+uV5zyJRVfd3yK0IiDSQ6kK27bJi9vufJfMP/3V8RR77i0J+XhBmJxapprjzUr94W5YXf1Cp5yjuT8LQVYq7TIzR9bG+3mpk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS5PPF78FC67EBA.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(6133799003)(56012099006)(5023799004)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEY4a3hkNUwzelZwTkZWa05wa20zTlVabEd2aloycXA5WmdRVHhFZWdmSGdj?=
 =?utf-8?B?a0pvMmFQYkVudnJldDVIb1BXL2hxMENBV0l4cDg2bHdORzNrMnFHU1NPSUVF?=
 =?utf-8?B?dmhDV1Z1Mzd3MlhzZXpxL09tNGdzNW8vRVc3MzBUdElkWEZ1eW12aDRsSlZQ?=
 =?utf-8?B?cDBZaWRaUkpRZm44R2JXOHlOdE90dkRaaDN6WVRYQXAyNXROZ1BDYlM3am5l?=
 =?utf-8?B?b0hrbzUrcncxcWJrMisrSnF3MFhzMWMyN1haVmUyRnFIeGJQdElGRGhQQ0VY?=
 =?utf-8?B?MWZzVitaMmJnRmFzb2tHQmRDVkZRdDhtSDRWUUN5MjRkSWN0N01FQlZIOUZ2?=
 =?utf-8?B?c3laR1hUYXhyZzlWU0Z3bDVjVHd1Sk02ejZ0VHlRMU50a2J3VFZDREhpR2xH?=
 =?utf-8?B?RzVrR0FxSmRCU05POUlCZ0ViN1BFUDhpc0pTVE5XejI5dFlHc1M5V1hQeS80?=
 =?utf-8?B?S2JqaW40ejh6OHNsZ2Fra2hRaFI0aERZSFpHM1l3dXdnOUVyZjVMTlFIM3RV?=
 =?utf-8?B?RnMzejYvZVp5dk54eFc3bmpTazJscUlaTnZ1ODAvcjNFRlVtUS85STZxMi9y?=
 =?utf-8?B?VmxwMjExR2hzSzl0SHk2dC9WbTlCU3dTckJ3L3lSUnlSRGZYSTExWXdmRW1m?=
 =?utf-8?B?bXMrSmh2azNTdDNHc2VXdERrMVRKZjZPYXRHRDFRS3lsNjRweGpRZE9adzdS?=
 =?utf-8?B?VlRLL2E1aGx6M3dhT1paa3hmR3pyUEFqN2tMc1A3MU5BYk9VT3lqNGdrSjR3?=
 =?utf-8?B?TTFEVko0K3lvakFYZ00yUUp2NmNQZS9hOWdmVXZvSWtsZk96YkRNOW5oRWRp?=
 =?utf-8?B?YTRKN2xpTlgvN0JlRXI2QjJrK1RvNVc4YjZpekI2VHFnYmc0eENYWkZZN0Fw?=
 =?utf-8?B?S1JJbk5sclJQcSsycU1GdHhhdzBXbk5IcTVhazdYUm9SN1haazMxTCttZTVZ?=
 =?utf-8?B?Ni9iZU55WUplYU8vWnlaRWZvNVFtcXhibU4yQUZFQWVuY1ZNazJtS0pGcm9z?=
 =?utf-8?B?djlBSkM3MWpKZ0tCZHhaaFYyNm1OdmIzMi9wY3NYdm1XVXpzbGJUYklzVDND?=
 =?utf-8?B?bjZBSWNXZnY2eUdyZUljWUhpVkluUDdMcFV2WTBSSEtKVmZkTW4vZ3R3WG5K?=
 =?utf-8?B?SHZ2cVdoTkt2aTlhYkJBNHR2dXB3TkMxUU8rVjZVMGFQNWU5TzZGSGNuRVZH?=
 =?utf-8?B?Z3ZEUmdLM1VPeHorT0prK2lLUUFOM2FURHlUZmZxWGhBTDhUcVE3c2hhSHNm?=
 =?utf-8?B?dGsyTWZlenRvcm8yNmpFRitUVk5NMGlzcHdpbjFUVjZmZlhjQmVVRUI0c0Nx?=
 =?utf-8?B?TVlDMlk1dnpXcGg2cmdVZkJTejVUWFVpTWFDd05qalpHcllDdCtmN1pVaGFN?=
 =?utf-8?B?V3c5ZjhQd1k0V00zUkxmYUhQZm1KMDdvVkJJb2FwWVc2NWFQUS80WG5RSWk4?=
 =?utf-8?B?aElDc3Q5VjlyQ3FpREJtRGpRS0ZFSG5xRWVBeVNSby9PVUVja1pxaTFSU0tN?=
 =?utf-8?B?ZWIxSnc2eW5NdTdMOU5DTE0yMlZpS0NjZCtUUGlqMlJibGZLbDllcTRqL20w?=
 =?utf-8?B?WElHQmR0MFZsei8wQUJOZHhKV1Y2ZlBGSmVOM2NYTGs1Y1dWcXlTbHpJcmVp?=
 =?utf-8?B?REZhVktUWTIzSjhuY09TY2hzdmthaEUwU0VMQnBqNHU4bDdYY09URDhnaEhh?=
 =?utf-8?B?UGhvTHpiZlpwY2svTWwrbW9oR09sd1lPQ3JWTHhPTHpLU3JuQ1Z3VmNOR2VT?=
 =?utf-8?B?eHNaZzA4MzhCMVp2ZGpLWlE0aVRGVW1WTFNoUnNPcStBelgwc3VnbndWRW1k?=
 =?utf-8?B?M21mVkRTRkp2QmkrZHFhblZWajVQUkV6NndHQ3NITE1qR3V6TStFc0FCT2dJ?=
 =?utf-8?B?Y1d0WVNhY2hsb2xNV3lxTGo5dGozMXFQaVJmMHFvcDNWTHMxcVBFQ1lsR3RW?=
 =?utf-8?B?WWo2NitxYXk0RE1XdFgwVHBmT3R0c1JHcmRRYXFmeVowUnVKMlhtTUdQN0Ex?=
 =?utf-8?B?V3kwUW9kaTMwYk1CcHBYaHAyUVFaUVhxMUxYTTRrYVgrRk9IWGNRcDdIUXZK?=
 =?utf-8?B?TGcyWmdGQmJoVXh0NDJUK0x4R2tzZkw1WEhYcThQT1VRbGtnVHJZKzBRbi9B?=
 =?utf-8?B?WHN6cmxqQ2RhVlRwRW9tMGIramFtTGlHaUZmcVZiZ1lkWDM2eDZCeWZIYXFO?=
 =?utf-8?B?Q0VjdkNzYllyQ0p6WllYKzFPWnREbldrMjliQ3JuMjh0L25zdlhLQ3BIdW96?=
 =?utf-8?B?cHFIbUpKejJPdEVDRnNndnZvM1JBeGpydjdYRGxSc1FoN0lOUWRXSUMxQ0tO?=
 =?utf-8?B?Q0lQdkVZeHkxNXBzTUcwMzA2L3BEU1ZQUVo2THNxRWFNWmZsQVNKdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f12396e-1d11-46eb-713d-08def3caafe7
X-MS-Exchange-CrossTenant-AuthSource: DS5PPF78FC67EBA.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 14:54:59.4484 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D+xJwJEodbRKsHlRPhwRxkDLDnfEMx3AO53FMQ33gDO26o0nwv3oqkFE7QOqtWbxR+HYpmn8pdVOiAriZ7hHZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5939
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


On 2026-08-06 10:31, William Palacek wrote:
> svm_range_restore_pages() migrates the faulting granule to best_loc
> whenever prange->actual_loc or best_loc is set, without checking whether
> that window already lives there.
>
> When it does, MIGRATE_VMA_SELECT_SYSTEM has nothing to collect and
> migrate_vma_setup() returns cpages == 0. By then it has already issued
> MMU_NOTIFY_MIGRATE, which svm_range_cpu_invalidate_pagetables() turns
> into svm_range_unmap_from_gpus() for that window, so the mapping the
> fault needed is torn down to service a migration that moves nothing and
> the fault is re-armed rather than resolved. Under XNACK on an
> oversubscribed range this becomes a loop: svm_range_restore_pages() and
> svm_migrate_to_vram() are entered thousands of times per second,
> svm_migrate_copy_to_vram() is never reached, and the per process
> migration counters stop advancing while the GPU stays busy.

Why doesn't it get to svm_range_validate_and_map and resolve the fault?

Regards,
   Felix


>
> The notification cannot be filtered by pgmap owner, as it is what
> invalidates the PTEs for pages that really do move. Avoid starting a
> migration that cannot move anything instead. Per window residency is not
> cheaply available beforehand, so record the window of a migration that
> collected nothing and do not repeat it there until a short backoff
> expires.
>
> Fixes: a546a2768440 ("drm/amdkfd: Use partial migrations/mapping for GPU/CPU page faults in SVM")
> Signed-off-by: William Palacek <William.Palacek@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 23 +++++++++++++++++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  4 ++++
>   2 files changed, 27 insertions(+)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index fa4054d51f60..b946ae95ff12 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -50,6 +50,11 @@
>    * page table is updated.
>    */
>   #define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING	(2UL * NSEC_PER_MSEC)
> +
> +/* Long enough that a retry fault storm cannot re-arm a migration which
> + * has already been found to have nothing to collect.
> + */
> +#define AMDGPU_SVM_RANGE_NOOP_MIGRATE_BACKOFF	(100UL * NSEC_PER_MSEC)
>   #if IS_ENABLED(CONFIG_DYNAMIC_DEBUG)
>   #define dynamic_svm_range_dump(svms) \
>   	_dynamic_func_call_no_desc("svm_range_dump", svm_range_debug_dump, svms)
> @@ -3221,8 +3226,25 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	last = min_t(unsigned long, ALIGN(addr + 1, size) - 1, prange->last);
>   	if (prange->actual_loc != 0 || best_loc != 0) {
>   		if (best_loc) {
> +			uint64_t vram_pages = prange->vram_pages;
> +
> +			/* migrate_vma_setup() unmaps the window before it knows
> +			 * whether it can collect anything, so a migration that
> +			 * collects nothing re-arms this fault instead of
> +			 * resolving it.
> +			 */
> +			if (start == prange->noop_migrate_start &&
> +			    ktime_before(timestamp,
> +					 ktime_add_ns(prange->noop_migrate_timestamp,
> +						      AMDGPU_SVM_RANGE_NOOP_MIGRATE_BACKOFF)))
> +				goto skip_migrate;
> +
>   			r = svm_migrate_to_vram(prange, best_loc, start, last,
>   					mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
> +			if (!r && prange->vram_pages == vram_pages) {
> +				prange->noop_migrate_start = start;
> +				prange->noop_migrate_timestamp = ktime_get_boottime();
> +			}
>   			if (r) {
>   				pr_debug("svm_migrate_to_vram failed (%d) at %llx, falling back to system memory\n",
>   					 r, addr);
> @@ -3248,6 +3270,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   		}
>   	}
>   
> +skip_migrate:
>   	r = svm_range_validate_and_map(mm, start, last, prange, gpuidx, false,
>   				       false, false);
>   	if (r)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index c7d7adae4476..508a086195ac 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -93,6 +93,8 @@ struct svm_work_list_item {
>    * @granularity:migration granularity, log2 num pages
>    * @invalid:    not 0 means cpu page table is invalidated
>    * @validate_timestamp: system timestamp when range is validated
> + * @noop_migrate_start: start of the last migration that collected no pages
> + * @noop_migrate_timestamp: system timestamp of that migration
>    * @notifier:   register mmu interval notifier
>    * @work_item:  deferred work item information
>    * @deferred_list: list header used to add range to deferred list
> @@ -131,6 +133,8 @@ struct svm_range {
>   	uint8_t				granularity;
>   	atomic_t			invalid;
>   	ktime_t				validate_timestamp;
> +	unsigned long			noop_migrate_start;
> +	ktime_t				noop_migrate_timestamp;
>   	struct mmu_interval_notifier	notifier;
>   	struct svm_work_list_item	work_item;
>   	struct list_head		deferred_list;
