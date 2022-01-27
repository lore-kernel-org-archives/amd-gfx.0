Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F6DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Jan 2022 23:29:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 941DF10E467;
	Thu, 27 Jan 2022 23:29:36 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B7C510E467
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Jan 2022 23:29:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOKm9nVB2UZISlWCFXgqlkkrgFT9xOuwlD0gma3EcoU6kGi/POXW6FZbu1XXOp1zX7gjxoweiKEMdA0qDZ+wKqMDWh7+D7BbSiFRDwk+bzlama2mpt8wnZ8TyFYGF8Xxx30emBwRfyQNI00/QIJTgdJP78eLMvkvfJl5Pxbw1E6znCUmUZ96JVA25dgjp3RN7CGG2unrI+49nXhMaP9tqY+I2mTP4ajpbHmhL78ucxeVsqwMKwQkngrWOPWdp6mlsJdqPnQzkFALSKrxb2p20sQOYPRg6FFkwsFkaZRod4W9WAdBZdks9BTEUFxFrNE6VlDbeFS5oVarMTDTTfGuuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/288UF+MgocZYckbp1Hh9DQ/K8QEL4VsiH56BtKnh0g=;
 b=nom04n3NzpWqjqHBQpSnlbP2Oawm/NK5Zl/xiMAhjgvIJvP/tW+atdjQZFx43+JIP4dryMtDcZphM2Q94ICOe5EGNc6h8hFdgIy9/3Vjammaa4LnH2NZqjRJIVRFpeVfhitXgmo1bdDvMUwXth4r56l/hIFA3M4UZXwfIQksDlT5YQvk0KppCMypIRYgm1KwLlsbhNlopua5JIGqRqgjrnuSIc/Q4WVk6phHgDkrdTcpWV2LhAqXUjdotq9pheYaLROQgIK5aAaxMWstP32hB5MQ/ddgfTE0bJ6Xfhvj0HYYcuqpDj31Gd31UzllUAe709381asuFXAnL2DYWTy4rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/288UF+MgocZYckbp1Hh9DQ/K8QEL4VsiH56BtKnh0g=;
 b=WDx/udEt2sW2Lo64O5FmB0CknZ4pqzTmiKbYCZu/u+YBdNYBgDILp7sXD57IaR5SelhLisUujseFB6d1bhYJft9uz00byvdbHfk4RSf7aHWdRAKOsw/0Pc/SY+xFD7Nle4dpesyJc25iXGqBIzjTtTNomXDNEKb51TkMI7/6biU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by DM6PR12MB3948.namprd12.prod.outlook.com (2603:10b6:5:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Thu, 27 Jan
 2022 23:29:29 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::971:531c:e4f4:8a9a%7]) with mapi id 15.20.4930.018; Thu, 27 Jan 2022
 23:29:29 +0000
Message-ID: <3d1012eb-311d-ea9a-5193-3ab6e4b980fe@amd.com>
Date: Thu, 27 Jan 2022 18:29:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 5/8] drm/amdkfd: add migration SMI event
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220120231322.10321-1-Philip.Yang@amd.com>
 <20220120231322.10321-6-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220120231322.10321-6-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT1PR01CA0094.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::33) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9db27d25-5306-4853-a331-08d9e1ecdd12
X-MS-TrafficTypeDiagnostic: DM6PR12MB3948:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3948D8742E04B6EDE93B62E792219@DM6PR12MB3948.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vhzoV3M5Jzedn67Kx+/f/rjHR4kNofqTabBpSYuicRh6Q1kjj0UgbK2adYTJvO3gJRxDoTGb4pYzgWz2MtU6CGeXDEZD06kPbUs76Q4aXTRThQLXkEXfIjzznD3CcweBVlzvToUu1ggXPTgq2pfDxfFav9CkctDq428oajohCudsqIpsiVCZhLulwnWcUdi2fT0Z1S6OeN7PXhw4pEBljBKASdHVru4VKD/j+DUmUtSuTeQP5Uij1IsX1pZfZ5FzTGME2mHJmvXxaYt5mMkEy7Tf1aNE32Ndd95s3KkfZFxfPCmFz7Bm7gmw1i67meoZsjJgnq/D/1MU+KZQWFwH6dNLb7LlDDlD6fh3NFZkyIYeT/2MjW2ezf2SDcqZTP5Th6SLHKanhOWTzmTGja7tDTX5M+bqSW35QxbFPpYQuzLO2JmZnEr7+94hW/Op/pwim2/7I66J9XKlwTb6DIsrkhyilUNVgm+JhTWt4PHjHm0vwAMihw9WIjRMVZJ77TssZ7OYKm6mIT9ldrblGVu5DEB4q/wySDB8nb7YySNJ2Np8/gOi/8VaZpgVX2BB1J6NE99KS7xbsH5Ax48AzixIiQFhbw+P6GbcNjBYP0btXP8Z5ZzYheW282ZZdH2sQuxVSCbuWlBWkMTefZ+P9a5R0UP/7aT8YggaDJPx0RcRQNIggOgvAO9Y8QfNmRd04vWHdMi+PD8hyRBvVUX58mRHG/ahrFWldT6FQJhw1IOs+Ck2OS0WIO8dJN09hfSHr2Uy
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(8676002)(8936002)(66476007)(86362001)(66946007)(83380400001)(66556008)(30864003)(38100700002)(44832011)(5660300002)(31696002)(6666004)(186003)(2906002)(36756003)(316002)(2616005)(508600001)(6512007)(31686004)(6486002)(6506007)(26005)(43740500002)(45980500001)(20210929001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cldXSmZjdUJONnljM0FEYzRwYTlLL2dNbmE0MEpMODZ5M1g1bGdoV0JTRWJI?=
 =?utf-8?B?YUtuVlcxbG1OenM3MllTZ2FKRHVyK2E5K0xyS2d2L1N1TFFUWE9mSkloQ3RE?=
 =?utf-8?B?Z2xnMWhicmZabTdZbEkxV1ZkcUxDODg2QnNpcXowRlVJbUZUc2xZWUhJM3Rj?=
 =?utf-8?B?cEM5TXU0WWFoU3BCeTFLMnp2NTQ0Q0hHVkl6Tllpd2ZjRUl3a2tUejdaTExR?=
 =?utf-8?B?bmRROUdWSWQvMTg3S2lGUjRpTkYvTUdvODBCZ3VTMzVwOHdqQ00zeld4R1pa?=
 =?utf-8?B?QytPZjQ3TUlCcVhlUHNlT0RsQU9uOTMwK3JmZ1ZHam9lM2lwV09ZRktNMFE3?=
 =?utf-8?B?SzdpUjN4c3RtUHNHYUxlWU9RQ1Ntb0JiRlQ4ZzkzaEVFcGc5NGE4MElVdGdx?=
 =?utf-8?B?L0g3WW0wcW5uYzdmcGFHMzhKUjlRYWhMbnlhREo3QTQ0a0Y4M1dGckFqamlE?=
 =?utf-8?B?NDFjVnYxVmZHZzFvTno0VGFBem1HTXZ6RGdydFJXTkJkdTZ3R25FMFlmZmMv?=
 =?utf-8?B?Sy83WFZXdjVHUVZidHFPWkE0ak5mR2ptY1g4SmJIQ0N1TkxwM2Z1N2QrQkhk?=
 =?utf-8?B?cVMydmpHeUMwMkx3T1JvZ0hLam1aZ281T2pmcUl2TXhpTHBtLzl0VHBuWjZF?=
 =?utf-8?B?NzJvTWlWZnhzcnhiRTZuc1FoOVRqWlBsSEZsaGpKYXk4Nm1QQVUrRGMyQ0FE?=
 =?utf-8?B?eVlOT0tGZktMdU1NcTBFMXVqOXJoeDhDeE84OWNmZXl6MW5iSGRETE9aV1ho?=
 =?utf-8?B?MnBsaGpwWFZJbEEyWE1VZGlOcG1WeElLWm1oRXNRb250RDFLQUR3U2o2cFh2?=
 =?utf-8?B?NTQ2UWJhTjczeC9XMldNT0tDT0picXFpL04wZHdSaTh0clU0bGJjWnNoQ1Vw?=
 =?utf-8?B?YmxsTStpSUlVcUoyTkFFTlFKSjBtS0VIZFVHVTJETmhJWVVScDExQmd4bVpp?=
 =?utf-8?B?SmcyN2lMSUNaYkZzd1VOVnA4NXp0UFJpczZQZ0d2b043NlZWTEVSR0dNMVVJ?=
 =?utf-8?B?ZTdIM25yZEFtLzV4NFBOVURmbmhTWDc3VG5IaTBYVGFpT3lGckZFWlFEUWpU?=
 =?utf-8?B?WjgxN2VlYXhKQnlicU5GRytTUW9uQURxak9BRmF2alRNbDJxZ3BUbndBQURx?=
 =?utf-8?B?dTVYNHg0b1J4TTJSZ2g5aXBUN2ptUXVaQ2lIbmpJS3M5cG5iMCtOU0Z2RXFy?=
 =?utf-8?B?R2IvTnlENVYzWmcxcktVeEYxaVUyMk04SGlQeWJjN3kxa05ZZm9jYXBjWEtZ?=
 =?utf-8?B?aFhmVDJGcGYxSVdSME54RWw5QXdHUjBUempDTWVvWWxlZWNveDE2dytUOFRy?=
 =?utf-8?B?Y3hiYXN5RGRQZ0IzeFJ4T05tSXJuN0pzZTJjSjB0Wm9pcVpNYW9venFwazlP?=
 =?utf-8?B?U21RNGNjb2tKb1p3ejRLSllnR1llYXNzM1lpMnRqVjAzK2w0M3g1VmR5OGky?=
 =?utf-8?B?S2tERXlmM0xMbjRIWW5rbTQ1N3VMWEcxWG1kZXJmN2hXYThDbFJYbXUrU1RZ?=
 =?utf-8?B?ZkVaUFVzQkVZbXg2WXhrOVdwcUF3WlNOUGsrNC9VdTZ1UFQ0L1FGU1NBWFY0?=
 =?utf-8?B?UE96Zzl0ei82NHZtcExPZ0cxL1JYdko3VE8wSVBHMVBDejVSR2lZWXg0aVAr?=
 =?utf-8?B?K2FUVC84MzlPY3RjVFIrdVRJL0xhYUY0blVCYXJjc1JzNS9xRzVtOHo5UjVT?=
 =?utf-8?B?ZHJsNGJ2YWdERkNXS3BBMEU5SCtmUU1MbUp2RDNOWDNoeG1oZVRTYVBPcXJJ?=
 =?utf-8?B?T1ZsbFNJWEVJNnZQVjgzTE1GS09PeHZLWWFIdG9JMjdSdlBJaUsxN2VTdC8z?=
 =?utf-8?B?L2lrQVF0ZCtqaWprb041UCtYdEhuSy9vSDBiMzA5UTRpNHR1b3dlbWtnVElp?=
 =?utf-8?B?MmNWQzYzdW9EbFNobDFFenNvWUZ1YWNsNENxMHdEOVVmSVV1ZnZENzZiNEdF?=
 =?utf-8?B?ejMxeVFUK0ppbjB6ZVI4MXFSa05XRFNqZXB2VzRaYU85SlJSR1NoV200Y3l1?=
 =?utf-8?B?OUR0bmVNZ3QyTFNVRStkbkh2dmkrY1VROUpPWlF5cmhJeEVINGNVY211aVhX?=
 =?utf-8?B?eGh4d3lqL2ZWS2htRnZ3U21UYS9Md29IcEI1SVdyR2xyRm9xdlFLenJGR2dk?=
 =?utf-8?B?UzFocGZkb1hzNm14Q1VnWVRFUmFLamJSQ0dudjM1cC9PNXJ1ck1PakpUQnd0?=
 =?utf-8?Q?4AfriNPHhAXWozgt26bAfrQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9db27d25-5306-4853-a331-08d9e1ecdd12
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 23:29:28.9028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c/U/O28/cuNjBQ0Eg+7kJpzaKj/cQcH915kkE20s6UVzCoD1fwd32wg53PBOFCU42qQbPqQ1Dwz7M8hrHOJqWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3948
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


Am 2022-01-20 um 18:13 schrieb Philip Yang:
> After migration is finished, output timestamp when migration starts,
> duration of migration, svm range address and size, GPU id of
> migration source and destination and svm range attributes,
>
> Migration trigger could be prefetch, CPU or GPU page fault and TTM
> eviction.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    | 67 ++++++++++++++-------
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.h    |  5 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 29 +++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  5 ++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 16 +++--
>   5 files changed, 91 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 88db82b3d443..06fb888f87aa 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -32,6 +32,7 @@
>   #include "kfd_priv.h"
>   #include "kfd_svm.h"
>   #include "kfd_migrate.h"
> +#include "kfd_smi_events.h"
>   
>   #ifdef dev_fmt
>   #undef dev_fmt
> @@ -402,10 +403,11 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   static long
>   svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   			struct vm_area_struct *vma, uint64_t start,
> -			uint64_t end)
> +			uint64_t end, uint32_t trigger)
>   {
>   	uint64_t npages = (end - start) >> PAGE_SHIFT;
> -	struct kfd_process_device *pdd;
> +	struct kfd_process_device *pdd = NULL;
> +	uint64_t timestamp = ktime_get_boottime_ns();
>   	struct dma_fence *mfence = NULL;
>   	struct migrate_vma migrate;
>   	unsigned long cpages = 0;
> @@ -431,6 +433,10 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   	migrate.dst = migrate.src + npages;
>   	scratch = (dma_addr_t *)(migrate.dst + npages);
>   
> +	pdd = svm_range_get_pdd_by_adev(prange, adev);
> +	if (!pdd)
> +		goto out_free;
> +
>   	r = migrate_vma_setup(&migrate);
>   	if (r) {
>   		dev_err(adev->dev, "vma setup fail %d range [0x%lx 0x%lx]\n", r,
> @@ -459,6 +465,11 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   	svm_migrate_copy_done(adev, mfence);
>   	migrate_vma_finalize(&migrate);
>   
> +	kfd_smi_event_migration(adev->kfd.dev, pdd->process->pasid,

The pasid is only used by kfd_smi_event_migration to determine the PID. 
But you already know the PID here:

	container_of(prange->svms, struct kfd_process, svms)->lead_thread->pid;


> +				start >> PAGE_SHIFT, end >> PAGE_SHIFT,
> +				0, adev->kfd.dev->id, prange->prefetch_loc,
> +				prange->preferred_loc, trigger, timestamp);
> +
>   	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
>   	svm_range_free_dma_mappings(prange);
>   
> @@ -466,10 +477,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   	kvfree(buf);
>   out:
>   	if (!r && cpages) {
> -		pdd = svm_range_get_pdd_by_adev(prange, adev);
> -		if (pdd)
> -			WRITE_ONCE(pdd->page_in, pdd->page_in + cpages);
> -
> +		WRITE_ONCE(pdd->page_in, pdd->page_in + cpages);
>   		return cpages;
>   	}
>   	return r;
> @@ -480,6 +488,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>    * @prange: range structure
>    * @best_loc: the device to migrate to
>    * @mm: the process mm structure
> + * @trigger: reason of migration
>    *
>    * Context: Process context, caller hold mmap read lock, svms lock, prange lock
>    *
> @@ -488,7 +497,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>    */
>   static int
>   svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
> -			struct mm_struct *mm)
> +			struct mm_struct *mm, uint32_t trigger)
>   {
>   	unsigned long addr, start, end;
>   	struct vm_area_struct *vma;
> @@ -525,7 +534,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   			break;
>   
>   		next = min(vma->vm_end, end);
> -		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next);
> +		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next, trigger);
>   		if (r < 0) {
>   			pr_debug("failed %ld to migrate\n", r);
>   			break;
> @@ -641,12 +650,14 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   
>   static long
>   svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
> -		       struct vm_area_struct *vma, uint64_t start, uint64_t end)
> +		       struct vm_area_struct *vma, uint64_t start, uint64_t end,
> +		       uint32_t trigger)
>   {
>   	uint64_t npages = (end - start) >> PAGE_SHIFT;
> +	uint64_t timestamp = ktime_get_boottime_ns();
>   	unsigned long upages = npages;
>   	unsigned long cpages = 0;
> -	struct kfd_process_device *pdd;
> +	struct kfd_process_device *pdd = NULL;
>   	struct dma_fence *mfence = NULL;
>   	struct migrate_vma migrate;
>   	dma_addr_t *scratch;
> @@ -671,6 +682,10 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   	migrate.dst = migrate.src + npages;
>   	scratch = (dma_addr_t *)(migrate.dst + npages);
>   
> +	pdd = svm_range_get_pdd_by_adev(prange, adev);
> +	if (!pdd)
> +		goto out_free;
> +
>   	r = migrate_vma_setup(&migrate);
>   	if (r) {
>   		dev_err(adev->dev, "vma setup fail %d range [0x%lx 0x%lx]\n", r,
> @@ -701,16 +716,19 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   
>   	svm_migrate_copy_done(adev, mfence);
>   	migrate_vma_finalize(&migrate);
> +
> +	kfd_smi_event_migration(adev->kfd.dev, pdd->process->pasid,
> +				start >> PAGE_SHIFT, end >> PAGE_SHIFT,
> +				adev->kfd.dev->id, 0, prange->prefetch_loc,
> +				prange->preferred_loc, trigger, timestamp);
> +
>   	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
>   
>   out_free:
>   	kvfree(buf);
>   out:
>   	if (!r && cpages) {
> -		pdd = svm_range_get_pdd_by_adev(prange, adev);
> -		if (pdd)
> -			WRITE_ONCE(pdd->page_out, pdd->page_out + cpages);
> -
> +		WRITE_ONCE(pdd->page_out, pdd->page_out + cpages);
>   		return upages;
>   	}
>   	return r ? r : upages;
> @@ -720,13 +738,15 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>    * svm_migrate_vram_to_ram - migrate svm range from device to system
>    * @prange: range structure
>    * @mm: process mm, use current->mm if NULL
> + * @trigger: reason of migration
>    *
>    * Context: Process context, caller hold mmap read lock, svms lock, prange lock
>    *
>    * Return:
>    * 0 - OK, otherwise error code
>    */
> -int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
> +int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
> +			    uint32_t trigger)
>   {
>   	struct amdgpu_device *adev;
>   	struct vm_area_struct *vma;
> @@ -764,7 +784,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
>   			break;
>   
>   		next = min(vma->vm_end, end);
> -		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next);
> +		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next, trigger);
>   		if (r < 0) {
>   			pr_debug("failed %ld to migrate\n", r);
>   			break;
> @@ -787,6 +807,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
>    * @prange: range structure
>    * @best_loc: the device to migrate to
>    * @mm: process mm, use current->mm if NULL
> + * @trigger: reason of migration
>    *
>    * Context: Process context, caller hold mmap read lock, svms lock, prange lock
>    *
> @@ -795,7 +816,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
>    */
>   static int
>   svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
> -			 struct mm_struct *mm)
> +			 struct mm_struct *mm, uint32_t trigger)
>   {
>   	int r, retries = 3;
>   
> @@ -807,7 +828,7 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	pr_debug("from gpu 0x%x to gpu 0x%x\n", prange->actual_loc, best_loc);
>   
>   	do {
> -		r = svm_migrate_vram_to_ram(prange, mm);
> +		r = svm_migrate_vram_to_ram(prange, mm, trigger);
>   		if (r)
>   			return r;
>   	} while (prange->actual_loc && --retries);
> @@ -815,17 +836,17 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	if (prange->actual_loc)
>   		return -EDEADLK;
>   
> -	return svm_migrate_ram_to_vram(prange, best_loc, mm);
> +	return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
>   }
>   
>   int
>   svm_migrate_to_vram(struct svm_range *prange, uint32_t best_loc,
> -		    struct mm_struct *mm)
> +		    struct mm_struct *mm, uint32_t trigger)
>   {
>   	if  (!prange->actual_loc)
> -		return svm_migrate_ram_to_vram(prange, best_loc, mm);
> +		return svm_migrate_ram_to_vram(prange, best_loc, mm, trigger);
>   	else
> -		return svm_migrate_vram_to_vram(prange, best_loc, mm);
> +		return svm_migrate_vram_to_vram(prange, best_loc, mm, trigger);
>   
>   }
>   
> @@ -894,7 +915,7 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>   		goto out_unlock_prange;
>   	}
>   
> -	r = svm_migrate_vram_to_ram(prange, mm);
> +	r = svm_migrate_vram_to_ram(prange, mm, MIGRATION_TRIGGER_PAGEFAULT_CPU);
>   	if (r)
>   		pr_debug("failed %d migrate 0x%p [0x%lx 0x%lx] to ram\n", r,
>   			 prange, prange->start, prange->last);
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
> index 2f5b3394c9ed..b3f0754b32fa 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.h
> @@ -41,8 +41,9 @@ enum MIGRATION_COPY_DIR {
>   };
>   
>   int svm_migrate_to_vram(struct svm_range *prange,  uint32_t best_loc,
> -			struct mm_struct *mm);
> -int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm);
> +			struct mm_struct *mm, uint32_t trigger);
> +int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm,
> +			    uint32_t trigger);
>   unsigned long
>   svm_migrate_addr_to_pfn(struct amdgpu_device *adev, unsigned long addr);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> index 080eba0d3be0..97393f4f3549 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -314,6 +314,35 @@ void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
>   			   len);
>   }
>   
> +void kfd_smi_event_migration(struct kfd_dev *dev, uint16_t pasid,
> +			     unsigned long start, unsigned long end,
> +			     uint32_t from, uint32_t to,
> +			     uint32_t prefetch_loc, uint32_t preferred_loc,
> +			     uint32_t trigger, uint64_t ts)
> +{
> +	struct amdgpu_task_info task_info = {0};
> +	char fifo_in[128];
> +	uint64_t duration;
> +	pid_t pid;
> +	int len;
> +
> +	if (!kfd_smi_event_duration(dev, ts, &duration))
> +		return;
> +
> +	amdgpu_vm_get_task_info(dev->adev, pasid, &task_info);
> +	if (!task_info.pid)
> +		return;
> +	pid = task_info.pid;
> +
> +	len = snprintf(fifo_in, sizeof(fifo_in),
> +		       "%x %lld(%lld) -%d @%lx(%lx) %x->%x %x:%x %d\n",
> +		       KFD_SMI_EVENT_MIGRATION, ts, duration, pid, start,
> +		       end - start, from, to, prefetch_loc, preferred_loc,
> +		       trigger);

Would it make sense to have start and end events instead of a duration, 
for consistency with the page fault events?

Regards,
   Felix


> +
> +	add_event_to_kfifo(pid, dev, KFD_SMI_EVENT_MIGRATION, fifo_in, len);
> +}
> +
>   int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
>   {
>   	struct kfd_smi_client *client;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> index 7f70db914d2c..5788728f2879 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> @@ -34,4 +34,9 @@ void kfd_smi_event_page_fault_start(struct kfd_dev *dev, pid_t pid,
>   void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
>   				  unsigned long address, bool migration,
>   				  uint64_t ts);
> +void kfd_smi_event_migration(struct kfd_dev *dev, uint16_t pasid,
> +			     unsigned long start, unsigned long end,
> +			     uint32_t from, uint32_t to,
> +			     uint32_t prefetch_loc, uint32_t preferred_loc,
> +			     uint32_t trigger, uint64_t ts);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 08b21f9759ea..7dbc724364e6 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2791,7 +2791,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	if (prange->actual_loc != best_loc) {
>   		migration = true;
>   		if (best_loc) {
> -			r = svm_migrate_to_vram(prange, best_loc, mm);
> +			r = svm_migrate_to_vram(prange, best_loc, mm,
> +						MIGRATION_TRIGGER_PAGEFAULT);
>   			if (r) {
>   				pr_debug("svm_migrate_to_vram failed (%d) at %llx, falling back to system memory\n",
>   					 r, addr);
> @@ -2799,12 +2800,14 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   				 * VRAM failed
>   				 */
>   				if (prange->actual_loc)
> -					r = svm_migrate_vram_to_ram(prange, mm);
> +					r = svm_migrate_vram_to_ram(prange, mm,
> +						MIGRATION_TRIGGER_PAGEFAULT);
>   				else
>   					r = 0;
>   			}
>   		} else {
> -			r = svm_migrate_vram_to_ram(prange, mm);
> +			r = svm_migrate_vram_to_ram(prange, mm,
> +						    MIGRATION_TRIGGER_PAGEFAULT);
>   		}
>   		if (r) {
>   			pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
> @@ -3126,12 +3129,12 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
>   		return 0;
>   
>   	if (!best_loc) {
> -		r = svm_migrate_vram_to_ram(prange, mm);
> +		r = svm_migrate_vram_to_ram(prange, mm, MIGRATION_TRIGGER_PREFETCH);
>   		*migrated = !r;
>   		return r;
>   	}
>   
> -	r = svm_migrate_to_vram(prange, best_loc, mm);
> +	r = svm_migrate_to_vram(prange, best_loc, mm, MIGRATION_TRIGGER_PREFETCH);
>   	*migrated = !r;
>   
>   	return r;
> @@ -3188,7 +3191,8 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
>   		mutex_lock(&prange->migrate_mutex);
>   		do {
>   			svm_migrate_vram_to_ram(prange,
> -						svm_bo->eviction_fence->mm);
> +						svm_bo->eviction_fence->mm,
> +						MIGRATION_TRIGGER_TTM_EVICTION);
>   		} while (prange->actual_loc && --retries);
>   		WARN(prange->actual_loc, "Migration failed during eviction");
>   
