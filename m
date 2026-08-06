Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0CDFC56205
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Aug 2026 16:19:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F0DA10E33D;
	Thu,  6 Aug 2026 16:19:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V1seckcD";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010071.outbound.protection.outlook.com [52.101.56.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4614310E33D
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Aug 2026 16:19:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MuQlfIav2lQNbjskDBWQOCpwy7VPNv1cbNTvb55C4Z5rQqVgeLavvPZ7ORZUm5JhlPp/q1fn+crX2uoRWunKVXg35q6fgQxSVgpq60nrDoQ6n3oga9ab2L19BVD/UijQVvCy7hc8g+d5XIqqNk3u+6vuD5Rln+5T9qlFhwbuIyn8+/sp6Uk7IGJXkOpKc0+006SOmX+URFhIvHY8zSG7zu+RKJJ+Z7QWso22vW7wyxswp2pomKphk4adetN+tyjlHPlArhNqdheOdDKOq9fbKRIl75HFBav0F3qYEuwlbBOXyRlRh/ksUIYfSOVPbvw18txl2hDhAzB79uH60RRsEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JEKKTIz+vxChcXqIcuyNh+ywJX3ZBYfXcaILmZRfaio=;
 b=w0fZQ+Pz9ePlp+ysYqmZeiTXrP/h/tG8IAehiRoeyGzHY9TzDOTrKHWXhrWgfVRPwaTt+srjsEJbgg97bUPR8zUU5B4CrfM+bTopP19kjmnvjuo6+zC+BO2TWCcSPsxZuaZgL1UjLe74AQa6cawu10iI+XfaXqlfY3afnPZPWoPTrNs52Bnupzaunr/1r7i09v1mmLALDxRhB3Eqvmd4xdJuUwtBzWCM0XuhcPGq/w8oYsofxkgUVu8gB2l/0p2EVCGe19MuplQ582NnWuRZ2gjLFLFNflhhI+j4f9bYQ0zKZOd9YcFwVuCCyVvg47bd7PzZT2I0aZucBg4WVumlUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JEKKTIz+vxChcXqIcuyNh+ywJX3ZBYfXcaILmZRfaio=;
 b=V1seckcDfZZa4tR8uIm/y2YeGM3E97iLeApWEynexAJcw00+hCQ5rBZJVG80zFOvL9qnWNGBpRE+6pcZKSFXLk0j3SrqXhe+kobN64oT/B2d3VJr3Gwz03Qmp5eIPbG5E7io9GN0SgyiN88iDqzcm176YtZjVcyGVksOGtXiaEs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from IA1PR12MB8517.namprd12.prod.outlook.com (2603:10b6:208:449::8)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 16:19:46 +0000
Received: from IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525]) by IA1PR12MB8517.namprd12.prod.outlook.com
 ([fe80::c47e:c884:f06:1525%4]) with mapi id 15.21.0292.019; Thu, 6 Aug 2026
 16:19:45 +0000
Content-Type: multipart/alternative;
 boundary="------------H5PaIqahM8Bh8iLDn2fGsXgj"
Message-ID: <26d0ead7-84ba-494a-b0f0-67a2abf43df3@amd.com>
Date: Thu, 6 Aug 2026 11:19:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdkfd: don't repeat a SVM migration that collected
 no pages
To: amd-gfx@lists.freedesktop.org
References: <20260806143154.3020903-1-William.Palacek@amd.com>
Content-Language: en-US
From: "Chen, Xiaogang" <xiaogang.chen@amd.com>
In-Reply-To: <20260806143154.3020903-1-William.Palacek@amd.com>
X-ClientProxiedBy: CH0P220CA0029.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::17) To IA1PR12MB8517.namprd12.prod.outlook.com
 (2603:10b6:208:449::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB8517:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: e604c81b-cdc6-4ab7-1ccc-08def3d68723
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|5023799004|11063799006|56012099006|18002099003|22082099003|8096899003;
X-Microsoft-Antispam-Message-Info: DGDsryil5GhKuWgaGiX15rsp2orLyXLQyNfHgfCU0DjtMrGXSa47toqhK3yreRj0fUE31DUsdN3Ell+6YM6a2NWcv8UzWBnvGQ75m+BIULrFqw+OXdCWUGwe3Kt9U5ztvB8rZfV29MRS0DfWQJTgw2qrMQReDTJbPdMsfhERBkoG1tDLWwhpc3Skdn3Zwky7M/viegICKm3Gpt36voST1HI35pqGGUWeDi7+DDAetfk34T40y+KOB69/LwtgGAOYF8b8uALaGiAWQsNukyzaWKhgKzp2FWCbHISrK9AuO9x4sD5yi54QSUNjHi/8sbpjLjh5l1l+Ir+zBGN/nf3Rnn+3VSPs/g2YkKF+rsiiqeZ2uliR1tktgL4aGDqJ68THlzxnGjSzLyRbcHu1q+p/ZDroRjEAL/bAg2da+RhPDvVsUdeFt8WczNYlP7lznWe4TZmFfbrtHKkUsBwmCue3u2dIXcR2bf1o+hrIeX30kHV2DJBpsI4Azxivq/soIkQdVSUoTWHHyd+/VzmIFyiUmj23sy7H7gohFX+lYIF/D9jPHnxC5CLtfsYRm7etp3IyPVCp42wLhK6j6fbGZQHjkJsnE9J31ZnjnKeowWCHWcz+FLALa/Tn4HusduYtXpfnpykC0X0eaeWPA+yiYPHThUVnF8Jf26jE7LVHUytmLxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB8517.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(5023799004)(11063799006)(56012099006)(18002099003)(22082099003)(8096899003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OTRBWFZtNWtJVGtKbFNLUDFoSlZWZ0V2WW40N0pyQ1dZblZsWjFwbFJuVHBh?=
 =?utf-8?B?Q3pqbS9ibFNiWDROcDB3bk5OT3ordklUTTczN0ZlYUtxTHFVbEhLMllyNThS?=
 =?utf-8?B?TlcvZGMvak5INTJiVENCaVp0bDdNQzUreGo2WmliTW1RbzYrSTFHTVQreG8w?=
 =?utf-8?B?N0pUR3lzY0xaclpPdC80WkpBQ2RCZW4wU1VuZHFYSmc2TDY2NHptcTMrVWpE?=
 =?utf-8?B?YzE2NkVXU3Zmbk1hRGlHN3c2S1JmVVBGd3pFbStrL3ZyWVFzRlZ4ZG50UlNL?=
 =?utf-8?B?RElTZVIvMkdESm9BaFo0eTlDYzUvSjRON3RnYXV0WVJsZXBoWE5mL0xMK3Q0?=
 =?utf-8?B?Wmhvc04zcVd6N2FsbTQ4aytBZnBHTXFVTVREZkdXdk1QTFQvUzMrUHFTdXZr?=
 =?utf-8?B?Qjl1NjVJRkc5RTF5amdFRVRDV0FLRDd6OVpJMDZ2NnZ5QjIxY1hSb0hScm0v?=
 =?utf-8?B?bTNPUm01RUY3YWpTK1pRN0psVlM1QTR1TDMwNWZnTkphc1VxMjFYYzF4dzJV?=
 =?utf-8?B?UWtTeHVadEVzL0IxbXZUbFhrT25OOWlrY21QWXB1WVhNUlZSMHNUOGtweG9L?=
 =?utf-8?B?WTZNR1R5Zktub2MyT3Z3d0V2dnJuWTFieHdjWnNaTEJnbUhyWE9odUh4dGFX?=
 =?utf-8?B?RU40MnV2UE4wREVyWHpJNG5sTFE1S2FQeXRBMWVGOW5NTStJUk1UTERabUJ0?=
 =?utf-8?B?Q3NyWEVmcmdneDAvRWpOVCtwWXdNRHpjc1lHenZyNWhDOTBTMUhnU2NKWWhG?=
 =?utf-8?B?Y3pHZDI0WndHOGVvUzAyNllWVG5tbTRFTTNWaVBiUXNVa3pOS0dOWm92NWVs?=
 =?utf-8?B?RDF1NW9JWFlsT2pQNHBKZXQrc0twRXpTYVNkNzJPbVVWOEV4S29TVmpHU1Zp?=
 =?utf-8?B?Vk1yRGwyRG9aTGx5Y1FFMzRnNHpJUk56bFlNa0c3Szg4V2lJbFBYNnprZXdt?=
 =?utf-8?B?dHpDOXJnTmlNeDNIY0lkMTZ2U2F0amtjbUJZUDRMb2wxYWFBZ0lJa09lMXFN?=
 =?utf-8?B?c2ZmNiszYklEc29zZTdaQ3hlNU04SWQ2U21jcWQ4RzZIY1ZKbnp5VUlpaFVQ?=
 =?utf-8?B?QkFiT0ZOaktWN3lNWkZNSVViWDlEUnhzalVib0UrUExnTENJU0QzaGRmTERt?=
 =?utf-8?B?K3N6WHd3YjhxQTEzR2M5TFg3RFRwcVNpS2phQytYeUJpRmZUaUlKR2pTVDRI?=
 =?utf-8?B?QWFvbmptaTFhTS9lTDlTVXhDQXJiRk12Nk1veXNDQ0hkMGs2REpRUjhQRUVP?=
 =?utf-8?B?djVJQ1JBaVc4cVk2Q0JUdDNPbTU4cE5TTTRXZFd6ZXFSVUtzNU1mQ0tXSTBY?=
 =?utf-8?B?b2M2bG5ZNCsrQUhSaUJKV0plaklCTWdBTzFld3c3ejNmTUZlRDZNcWZ2RlNa?=
 =?utf-8?B?cFJJcEs5Y2J0UGt6MWNNN3NHYUpkT0JLTU5VMHZnb3N4b1VCdkppYXpWQmRz?=
 =?utf-8?B?cFBXTEsybm9vVjI1K0hVWU9wUG5ackJTWnlWSWJhaENGK3EvbmlXTytCemtq?=
 =?utf-8?B?WFVKT3lOdldxRnBDajY5UE95bDVlSEw3TGRoOVpKVmtXckxUY3gvdFRIMWVU?=
 =?utf-8?B?Qm1WWTNZaGcrN3dVWUg2ejJ5angrRUFWRGZpU3JaZlpiTkw0Sk04VUx4YzVW?=
 =?utf-8?B?UEJVVTZxODF4QzNyNDZCL0lOM2x1VTVlTk40U1BiMEt2b3Qwajh2bXRsNW9X?=
 =?utf-8?B?ZHgvSk1nV1N6TzFVUEovQWw5aHd3WTBRL0gydW9jazV0TkZ4MkRqZ3VXN2Zq?=
 =?utf-8?B?YnBVVGNFaVBwb3doWUp0RFp6OVFrZjkrVHVtbjFWMm1pMVFqTGlWTEhkMVZY?=
 =?utf-8?B?aGN5TVp1Q25FY05MZUpDdUpaR21McjV6UXNxMVY4d0VkbVJHcXhRZzE5a0Ri?=
 =?utf-8?B?bWpsTHBVZmpyMGc4ejYyVEhWbnJKR3BkdXlkVlJ2RE13Ujc4RkJaRVJ5a3lF?=
 =?utf-8?B?bmNOSTNOWmFnUUtjR29KSjVDbU5ZQy9PelgxZmNhbm9pM3hTQ0tuSFUvWXdG?=
 =?utf-8?B?UVVqNEdXQkg5U3I2MWN6SDJFTjZKWEhncXlWU3NWdk9vbVF1b1Y2cmNWbWlJ?=
 =?utf-8?B?Wk9JUmZuM1BITmQ0SzRHNDgwNlNkbXQ2bE4xOXppcCtzSjkrQUUwcXpYWG80?=
 =?utf-8?B?dnhNU3RBZXl3YW5uOVZNL1ZWVDNDZTBhU0dlQUQycHpZVTJSTmdHRks0dW93?=
 =?utf-8?B?Mit2M0N3a2ZmS1pCTytzbGRib2h1enJZam5lM3lFVFg2UXNDUi92Q2NOVlRD?=
 =?utf-8?B?V0xsdi91QnRTcTlDZFBad1RyaDlPSDJPTnRnWkhrY0lQK2lvbFVRNVBTSklD?=
 =?utf-8?Q?p63M4+77Pe4+589CGK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e604c81b-cdc6-4ab7-1ccc-08def3d68723
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB8517.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 16:19:45.3155 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfgSK9wWfF4SNoTKAgAmYNTAQPATimePXAEu7/0efn4zUYdycasdU8snF0salkcr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921
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

--------------H5PaIqahM8Bh8iLDn2fGsXgj
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 8/6/2026 9:31 AM, William Palacek wrote:
> svm_range_restore_pages() migrates the faulting granule to best_loc
> whenever prange->actual_loc or best_loc is set, without checking whether
> that window already lives there.
>
> When it does, MIGRATE_VMA_SELECT_SYSTEM has nothing to collect and
> migrate_vma_setup() returns cpages == 0. By then it has already issued
Can you explain how cpage == 0  after migrate_vma_setup? if 
migrate_vma_setup cannot collect src pages correspondent to vm range, 
have previous code like svm_range_create_unregistered_range or 
vma_lookup already failed?
> MMU_NOTIFY_MIGRATE, which svm_range_cpu_invalidate_pagetables() turns
> into svm_range_unmap_from_gpus() for that window, so the mapping the
Is there gpu mapping at that range if at cpu side there is no page can 
be collected for same range? One case I can think is src pages got 
pinned at cpu side, then cannot be collected,  then app should not 
register the range to svm since the page cannot be migrated to gpu, then 
has no gpu mapping.
> fault needed is torn down to service a migration that moves nothing and
> the fault is re-armed rather than resolved. Under XNACK on an
> oversubscribed range this becomes a loop: svm_range_restore_pages() and
> svm_migrate_to_vram() are entered thousands of times per second,
> svm_migrate_copy_to_vram() is never reached, and the per process
> migration counters stop advancing while the GPU stays busy.

I am not sure if it can cause infinite loop. If there is no page got 
migrated to vram the following amdgpu_hmm_range_get_pages will get sys 
ram for that range, then driver maps the range to sys ram pages unless 
there even no sys ram pages for the range that can be faulted in, then 
amdgpu_hmm_range_get_pages will fail, then this page fault cannot be 
restored.

The main concern is under what situation there is gpu page fault and hmm 
cannot collect sys ram pages at cpu side? If it happens, is it app issue 
or has been detected/handled?

>
> The notification cannot be filtered by pgmap owner, as it is what
> invalidates the PTEs for pages that really do move. Avoid starting a
> migration that cannot move anything instead. Per window residency is not
> cheaply available beforehand, so record the window of a migration that
> collected nothing and do not repeat it there until a short backoff
> expires.
>
> Fixes: a546a2768440 ("drm/amdkfd: Use partial migrations/mapping for GPU/CPU page faults in SVM")

Why it is related to partial migration for page restore? If there is no 
page can be collected at cpu side this issue is more general, not 
related to migration amount.


Regards

Xiaogang


> Signed-off-by: William Palacek<William.Palacek@amd.com>
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
--------------H5PaIqahM8Bh8iLDn2fGsXgj
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 8/6/2026 9:31 AM, William Palacek
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:20260806143154.3020903-1-William.Palacek@amd.com">
      <pre wrap="" class="moz-quote-pre">svm_range_restore_pages() migrates the faulting granule to best_loc
whenever prange-&gt;actual_loc or best_loc is set, without checking whether
that window already lives there.

When it does, MIGRATE_VMA_SELECT_SYSTEM has nothing to collect and
migrate_vma_setup() returns cpages == 0. By then it has already issued</pre>
    </blockquote>
    Can you explain how cpage == 0&nbsp; after migrate_vma_setup? if&nbsp;<span style="white-space: pre-wrap">migrate_vma_setup cannot collect src pages correspondent to vm range, have previous code like svm_range_create_unregistered_range or vma_lookup already failed?</span>
    <blockquote type="cite" cite="mid:20260806143154.3020903-1-William.Palacek@amd.com">
      <pre wrap="" class="moz-quote-pre">
MMU_NOTIFY_MIGRATE, which svm_range_cpu_invalidate_pagetables() turns
into svm_range_unmap_from_gpus() for that window, so the mapping the</pre>
    </blockquote>
    Is there gpu mapping at that range if at cpu side there is no page
    can be collected for same range? One case I can think is src pages
    got pinned at cpu side, then cannot be collected,&nbsp; then app should
    not register the range to svm since the page cannot be migrated to
    gpu, then has no gpu mapping.&nbsp;
    <blockquote type="cite" cite="mid:20260806143154.3020903-1-William.Palacek@amd.com">
      <pre wrap="" class="moz-quote-pre">
fault needed is torn down to service a migration that moves nothing and
the fault is re-armed rather than resolved. Under XNACK on an
oversubscribed range this becomes a loop: svm_range_restore_pages() and
svm_migrate_to_vram() are entered thousands of times per second,
svm_migrate_copy_to_vram() is never reached, and the per process
migration counters stop advancing while the GPU stays busy.</pre>
    </blockquote>
    <p>I am not sure if it can cause infinite loop. If there is no page
      got migrated to vram the following amdgpu_hmm_range_get_pages will
      get sys ram for that range, then driver maps the range to sys ram
      pages unless there even no sys ram pages for the range that can be
      faulted in, then amdgpu_hmm_range_get_pages will fail, then this
      page fault cannot be restored.</p>
    <p>The main concern is under what situation there is gpu page fault
      and hmm cannot collect sys ram pages at cpu side? If it happens,
      is it app issue or has been detected/handled?</p>
    <blockquote type="cite" cite="mid:20260806143154.3020903-1-William.Palacek@amd.com">
      <pre wrap="" class="moz-quote-pre">

The notification cannot be filtered by pgmap owner, as it is what
invalidates the PTEs for pages that really do move. Avoid starting a
migration that cannot move anything instead. Per window residency is not
cheaply available beforehand, so record the window of a migration that
collected nothing and do not repeat it there until a short backoff
expires.

Fixes: a546a2768440 (&quot;drm/amdkfd: Use partial migrations/mapping for GPU/CPU page faults in SVM&quot;)</pre>
    </blockquote>
    <p>Why it is related to partial migration for page restore? If there
      is no page can be collected at cpu side this issue is more
      general, not related to migration amount.</p>
    <p><br>
    </p>
    <p>Regards</p>
    <p>Xiaogang</p>
    <p><br>
    </p>
    <blockquote type="cite" cite="mid:20260806143154.3020903-1-William.Palacek@amd.com">
      <pre wrap="" class="moz-quote-pre">
Signed-off-by: William Palacek <a class="moz-txt-link-rfc2396E" href="mailto:William.Palacek@amd.com">&lt;William.Palacek@amd.com&gt;</a>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 23 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index fa4054d51f60..b946ae95ff12 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -50,6 +50,11 @@
  * page table is updated.
  */
 #define AMDGPU_SVM_RANGE_RETRY_FAULT_PENDING	(2UL * NSEC_PER_MSEC)
+
+/* Long enough that a retry fault storm cannot re-arm a migration which
+ * has already been found to have nothing to collect.
+ */
+#define AMDGPU_SVM_RANGE_NOOP_MIGRATE_BACKOFF	(100UL * NSEC_PER_MSEC)
 #if IS_ENABLED(CONFIG_DYNAMIC_DEBUG)
 #define dynamic_svm_range_dump(svms) \
 	_dynamic_func_call_no_desc(&quot;svm_range_dump&quot;, svm_range_debug_dump, svms)
@@ -3221,8 +3226,25 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 	last = min_t(unsigned long, ALIGN(addr + 1, size) - 1, prange-&gt;last);
 	if (prange-&gt;actual_loc != 0 || best_loc != 0) {
 		if (best_loc) {
+			uint64_t vram_pages = prange-&gt;vram_pages;
+
+			/* migrate_vma_setup() unmaps the window before it knows
+			 * whether it can collect anything, so a migration that
+			 * collects nothing re-arms this fault instead of
+			 * resolving it.
+			 */
+			if (start == prange-&gt;noop_migrate_start &amp;&amp;
+			    ktime_before(timestamp,
+					 ktime_add_ns(prange-&gt;noop_migrate_timestamp,
+						      AMDGPU_SVM_RANGE_NOOP_MIGRATE_BACKOFF)))
+				goto skip_migrate;
+
 			r = svm_migrate_to_vram(prange, best_loc, start, last,
 					mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
+			if (!r &amp;&amp; prange-&gt;vram_pages == vram_pages) {
+				prange-&gt;noop_migrate_start = start;
+				prange-&gt;noop_migrate_timestamp = ktime_get_boottime();
+			}
 			if (r) {
 				pr_debug(&quot;svm_migrate_to_vram failed (%d) at %llx, falling back to system memory\n&quot;,
 					 r, addr);
@@ -3248,6 +3270,7 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		}
 	}
 
+skip_migrate:
 	r = svm_range_validate_and_map(mm, start, last, prange, gpuidx, false,
 				       false, false);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index c7d7adae4476..508a086195ac 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -93,6 +93,8 @@ struct svm_work_list_item {
  * @granularity:migration granularity, log2 num pages
  * @invalid:    not 0 means cpu page table is invalidated
  * @validate_timestamp: system timestamp when range is validated
+ * @noop_migrate_start: start of the last migration that collected no pages
+ * @noop_migrate_timestamp: system timestamp of that migration
  * @notifier:   register mmu interval notifier
  * @work_item:  deferred work item information
  * @deferred_list: list header used to add range to deferred list
@@ -131,6 +133,8 @@ struct svm_range {
 	uint8_t				granularity;
 	atomic_t			invalid;
 	ktime_t				validate_timestamp;
+	unsigned long			noop_migrate_start;
+	ktime_t				noop_migrate_timestamp;
 	struct mmu_interval_notifier	notifier;
 	struct svm_work_list_item	work_item;
 	struct list_head		deferred_list;
</pre>
    </blockquote>
  </body>
</html>

--------------H5PaIqahM8Bh8iLDn2fGsXgj--
