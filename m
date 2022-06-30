Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3032C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 14:29:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0AB9E11276C;
	Thu, 30 Jun 2022 14:29:59 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2086.outbound.protection.outlook.com [40.107.220.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A1B01126B7
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 14:29:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IWiMZB/GYuwwx1xSLnThxUPXkW945FSIDNYNh9s3Tv47ZUziJMrrFHBLl+/AV7qPgMy7QXEDGYFgNVIjqLegUtCwhmgzweZYGFfFcGCRhIrMRr9YVzFHdxx4+3q2dICOacdXJMQkh1Uoy6h5MmzcLADSCUox1DQwPv8T3AjxmFqodfU3ef10sz9ooUvZjREqlDAvVgy3uuSaBEpYqXbF8ykYMzuxdDdFq11iOE6fg8z9CUKVgcJ6xpZgaagUTvfPr5DOBM3qSvX+FL4tRWhLPSTkbjHmP0mLR6aL+TOclp/C9WVNCoH5ZNw7ScIiSdaJUQ0QJhZUTD9lvKMf4HrMFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swYDi8+0f0T+vfgt+P/4s7PMjbQUpHG8FbQWFNRfK/A=;
 b=gEPfpRuI6xqdiEaVcMHw9XDqTi5koGXwi+CTDp+qIdi86r//nl6Ex5VlgNmpPFz/stz0Gy3bZomcivaU6DawlWoJunbbsgsbVOFuEKAL6paGjLwoS8KTjsr0AzIQ+rUIcSDeW8PMwL7cUVKDocfbVGCXvX0fIOQQZgNYal/dMrQcYk9nX+6gTRzFixUI7mFURsvuyEFj6gYbx2atvIs1cfJSaSquJRxPbBJzDJDOCj9VGMNQYWJpB7Z16IrxX6OjWVmvK+RBPuBQ+JZegJ3AdsBlMoSRR+33J/CzzKtt0JNYihqoL9H8ARFXRhJo/QBvBmIz0nDvxJxqGqFUTYR25w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swYDi8+0f0T+vfgt+P/4s7PMjbQUpHG8FbQWFNRfK/A=;
 b=DnzCamsm+SFicEpL5nl++3QwKu+vtwLJ/A1WyJsrmgGa7JSDkrkN2D20zE7fY1Px6Z/ObiCf/S7tnisa0W75sEW2nLftzq4um1CyQB/MzqkNHxs1UV3wTMChNFDuvqKZcL3J6D1/YBCX/OM/9UlIv2QdalZdiUR34exgJXBmtLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BL3PR12MB6476.namprd12.prod.outlook.com (2603:10b6:208:3bc::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 14:29:55 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::8d23:cb0f:d4d2:f7fa%6]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 14:29:55 +0000
Message-ID: <ffbb26e7-052b-d3d6-9c00-700c400570f2@amd.com>
Date: Thu, 30 Jun 2022 10:29:52 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH v5 4/11] drm/amdkfd: Add migration SMI event
Content-Language: en-US
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220628145020.26925-1-Philip.Yang@amd.com>
 <20220628145020.26925-5-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <20220628145020.26925-5-Philip.Yang@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT3PR01CA0106.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::17) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e1cda6f-f88f-4799-c2d5-08da5aa500a0
X-MS-TrafficTypeDiagnostic: BL3PR12MB6476:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Rc/DtAdIDjCrN/F5uo1D9tEbxjYLnr8MFUtGgAb5iMm2TNmhAzX2BlWtcU+sLVJ4RSSRU06eAbVxVPbuTreEHh9QMEIlmvGWkqgp5Qst2j42SMs5ZJADEub0jiLrP+n5Ef7TIoV3XPa0y4YxLhTqSnSJNUvQWqztqxgXvVx9D02w88kJ+rA7H0dqYaTg8mGfMrlZgaFzdnV499Eib2LX93anP6YhvqNzXYXZCu4BF/GrOwGjM7Hy4ZBM6EYvzpAYEBPB0o+ieiAqvnbs6rkiZFOM6OKxMtDgWF02wFwjKXXee64ztNACjl5a/RC6upce1ZHAlMVRqZaZ+yzuCZPuQqruhtqN9ruXFQDrGB+aAXHYpb/qoxMfOqYkveYEm5DO6O/CH7BCfvRLoyvfQeX+PrsjoFzqgS93JNSXp2i14eaXqyW9Jl2OR2Nx4VbWwu2EBxRdrk7OkL2bO7X6s8a0wlHv3pte1HZZdPcKPMj1X/a8NOmeLwC3dfw0s7DIjp2uiJR+Re9Nx93uqPYns+bGeMStyeVVRQovvcTkzT6GfZFMnQAPSkOIxoYSFENMp1bC2Ahn3laztCrs4JoFrv0tdrVHZwHJ4fP1a13v+3IDfJQjP6cWGfKP2b3mjOYHJC0WGjUtgNWhgzopys1fa82j9NgmCynCqysvEj5vUrWIG8TO4lg8lM5JfxSgvkBuOHE2LrVNV5zkMtqLhH1gnggsoQ3SWVs5uSDxzqRMgUF7AlMmBCxCtAuB98pHaH2tqM9Sx/JnLKUZI447vuDZL6xnW2V8QDcgw8wBAFVPzLj41LIrVmvj4ZKxxBp39qt6RjlYmLA+hoXbDKKOGzeRyx0fFeVDbp+l/Jb63OqsizVPn38=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(366004)(396003)(376002)(39860400002)(346002)(316002)(38100700002)(86362001)(8676002)(31696002)(478600001)(6486002)(6666004)(6512007)(66946007)(6506007)(26005)(8936002)(41300700001)(36756003)(5660300002)(186003)(66476007)(44832011)(2906002)(83380400001)(30864003)(31686004)(66556008)(2616005)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RkhWQVQvL0I2WGFYSjFGWXVubzVWMzU3OXhRNkFvMzJCb3FpOVFPK0FaU29v?=
 =?utf-8?B?NVhreE5UejBxVjZWTUxEV3o2Ukx3c1E0d2FNREZ0N1pnVW9kbGpQMjNqYnZL?=
 =?utf-8?B?ZVdiZ3dyc0p6YjNKdnhDejF0ME9uMWhvNldTZ29ESXVBWjRsYldWQlNVV2l1?=
 =?utf-8?B?YlVyQlJEdUZMWTRjbEp1YXBrd2wvRkJseWgySkMxdTU4SE9VajYrVkNPb3l2?=
 =?utf-8?B?VldUQnpCT0dPN2VYTkR2cFFRV0NCQVVkOTl0T2JHaGpIbEpCcndVWGFud2pn?=
 =?utf-8?B?Uk4zQnJEY2lzK3lZUEtuUEVLZ0hxSFJjd2J5TkxuTkcxVzZ1K3U0WXVuQ2JT?=
 =?utf-8?B?Y21INVhXKzBhTG5aaU43TGFMTTkveDJwWkp5UVRWTnBEUzVUQXZRMGR3R0pC?=
 =?utf-8?B?bVhKZkR3Q0xEMFh6ZWRRMEEwUTcrckVZQmlWd3lOMVpBVjlDaEtXaXFuYjZX?=
 =?utf-8?B?VS9nenFrZHV5SGVKSlkwaUpHRTM3QXZxNXFmblJ6aG5vVXJxQTFPTGwzTk1l?=
 =?utf-8?B?WGF4ZFg4RDBhSllTdkdBU2srY0pab05mcTFUQWtsalA3MG9ESTE3a2hTaWFD?=
 =?utf-8?B?c2tISWphYzloNVVRVU41TzRjVXRTdm1PWVlBakpOaHpjUDZRYkZlOGlJZHk5?=
 =?utf-8?B?S1lhQVdiMjlBYk42SDR2OTk0NTlkVHhINTF2TWRVNnhCTi9XaG1TcXQ0QVZq?=
 =?utf-8?B?MCtCeEVYNnI5Ky90R2JHaytPbW56L2JidTJySE5MVTNzMVJlOTVUeWRnenor?=
 =?utf-8?B?WDA3bmZjL0lrdEtkaXVXT21hdzEvcmV3NjlhNTBGa01DUXltbVY3SDM0cXky?=
 =?utf-8?B?bEdDQi9qV2hMMThFMGRxV1QwMVcyU3IxMEVsMVROeGp4am13enpEUXhIdWxE?=
 =?utf-8?B?ZlQ5RDh2SDRoZUN0c0VXT3FVV3FNMXU3bHQvaVcrNkp6RE1jNHV6cnVhQWpr?=
 =?utf-8?B?VERkUFhRVW5GTEJyb01SbE41Yk1pVnZhbXdMbVlsUzBoUG41ODEzSE9zbjR4?=
 =?utf-8?B?L29HYXpuMU1melZvd1VBSGdtMmo3cmpZOE5FWGlzakZWYzh5bTIwQnNQSWFn?=
 =?utf-8?B?N3ZJNVRyNWZCckloTU5pR1cwaG84bnpCY2dxa3JKaG1ZcEswOGVRazFITmF1?=
 =?utf-8?B?RExqZ2s4cHQxZDJOS3dibEx1NGFUc08rS2U3enk5Y3VGcWI3dUNURkhacjFX?=
 =?utf-8?B?WXBmT0x4M3lHaGgxT2N3aGhnWUtEZzNrZ3hjZCswUWhaZDdmcE5hRkZQei81?=
 =?utf-8?B?cC9QQ3NzNkM1eTYvV1BCREFKNWpQWlRBSWZoZ2JQb1lsTlcxaXlubDZYQndL?=
 =?utf-8?B?Q3JKRXNGVWNEeWpGcm5OVnlTb0g4aDZDY2hHbURiQ0pCTytkSVFrM2owSzlR?=
 =?utf-8?B?UWhRUEJybzExWjVjV3lzRzhuS0Fkb0k4QzJ3MGZ1LzVkYTFlVWdkTzR0MmVp?=
 =?utf-8?B?U2hiQnhkNTNVR2Q1NmtZZVJ1clcrUFdhbnV6ODlGYlc1R2pYbm82NW5UWWFh?=
 =?utf-8?B?Rkk2NXdJNFNGdEFOb0V2ZjlCQ2liTkxEZEwxUXkyWVFYbTdrYXdEZ2JST3Vm?=
 =?utf-8?B?YmlCdS9LMzJEaHBEeUFZdFFPVmJTRGlHU3lmN24rSThoaC9HLzlwQ2d0Q2Vq?=
 =?utf-8?B?WkRRSTV4a0JqUEJqZkF1OGVVcFIraDRha2FGQVJEUE1udXVyT1grMk92V3F3?=
 =?utf-8?B?TVVCaEJ1QldqT3ZFZnlJbnV3WFhGNlJWU0NLeE4yOWhYRWJUeFY1UFYxQkpk?=
 =?utf-8?B?RFdqY0dSOWlGRGZ6M1Bmci9HVkxmdnhScVNYb2lQdllTOThCbGRIUW14UFZG?=
 =?utf-8?B?SnJ0NG1BSzIvU1orMU9OYW9vdHlGOWVQY05wTXZuRFVkazd2QUxUNmhqd1ht?=
 =?utf-8?B?SXBWa2Z6OVJiTU1nT0FOaWxZNDZNTnhiSVg4bUV4SEpLb2o4Q25wRjdFZ0NT?=
 =?utf-8?B?ZnJhSDdVaE4vdnV4RlFHbUhYai9CWlhpMVd6eGJzSXBpUUUvUzFDZk9UcVVM?=
 =?utf-8?B?VWs4S3NkRllVTlNxTnJobHlISHVXaklMMHBuWmJ3Q3ViK2psZHgrOTdJQXpM?=
 =?utf-8?B?RFdWOGFsQnAxWlNJN3I2NFRwSnh0WXJNTHNWc0s2eXJKYVlxeVhoWWZSN2Jt?=
 =?utf-8?Q?07RM/i7QRpV08mAAu5fsfnArN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1cda6f-f88f-4799-c2d5-08da5aa500a0
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 14:29:55.4860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4dPN2ULYgsXKTjvWHwjrZMnijS1i4GPE6bJ6omYOk9hlnlBhfO9n8VNSiOdhRjKrrp/xjuIyPbuq/jK9EdbT/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6476
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

Am 2022-06-28 um 10:50 schrieb Philip Yang:
> For migration start and end event, output timestamp when migration
> starts, ends, svm range address and size, GPU id of migration source and
> destination and svm range attributes,
>
> Migration trigger could be prefetch, CPU or GPU page fault and TTM
> eviction.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c    | 53 ++++++++++++++++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.h    |  5 +-
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c | 22 +++++++++
>   drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h |  8 ++++
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c        | 16 ++++---
>   5 files changed, 83 insertions(+), 21 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index fb8a94e52656..9667015a6cbc 100644
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
> @@ -402,8 +403,9 @@ svm_migrate_copy_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   static long
>   svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   			struct vm_area_struct *vma, uint64_t start,
> -			uint64_t end)
> +			uint64_t end, uint32_t trigger)
>   {
> +	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
>   	uint64_t npages = (end - start) >> PAGE_SHIFT;
>   	struct kfd_process_device *pdd;
>   	struct dma_fence *mfence = NULL;
> @@ -430,6 +432,11 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   	migrate.dst = migrate.src + npages;
>   	scratch = (dma_addr_t *)(migrate.dst + npages);
>   
> +	kfd_smi_event_migration_start(adev->kfd.dev, p->lead_thread->pid,
> +				      start >> PAGE_SHIFT, end >> PAGE_SHIFT,
> +				      0, adev->kfd.dev->id, prange->prefetch_loc,
> +				      prange->preferred_loc, trigger);
> +
>   	r = migrate_vma_setup(&migrate);
>   	if (r) {
>   		dev_err(adev->dev, "%s: vma setup fail %d range [0x%lx 0x%lx]\n",
> @@ -458,6 +465,10 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>   	svm_migrate_copy_done(adev, mfence);
>   	migrate_vma_finalize(&migrate);
>   
> +	kfd_smi_event_migration_end(adev->kfd.dev, p->lead_thread->pid,
> +				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
> +				    0, adev->kfd.dev->id, trigger);
> +
>   	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
>   	svm_range_free_dma_mappings(prange);
>   
> @@ -479,6 +490,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>    * @prange: range structure
>    * @best_loc: the device to migrate to
>    * @mm: the process mm structure
> + * @trigger: reason of migration
>    *
>    * Context: Process context, caller hold mmap read lock, svms lock, prange lock
>    *
> @@ -487,7 +499,7 @@ svm_migrate_vma_to_vram(struct amdgpu_device *adev, struct svm_range *prange,
>    */
>   static int
>   svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
> -			struct mm_struct *mm)
> +			struct mm_struct *mm, uint32_t trigger)
>   {
>   	unsigned long addr, start, end;
>   	struct vm_area_struct *vma;
> @@ -524,7 +536,7 @@ svm_migrate_ram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   			break;
>   
>   		next = min(vma->vm_end, end);
> -		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next);
> +		r = svm_migrate_vma_to_vram(adev, prange, vma, addr, next, trigger);
>   		if (r < 0) {
>   			pr_debug("failed %ld to migrate\n", r);
>   			break;
> @@ -655,8 +667,10 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>    */
>   static long
>   svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
> -		       struct vm_area_struct *vma, uint64_t start, uint64_t end)
> +		       struct vm_area_struct *vma, uint64_t start, uint64_t end,
> +		       uint32_t trigger)
>   {
> +	struct kfd_process *p = container_of(prange->svms, struct kfd_process, svms);
>   	uint64_t npages = (end - start) >> PAGE_SHIFT;
>   	unsigned long upages = npages;
>   	unsigned long cpages = 0;
> @@ -685,6 +699,11 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   	migrate.dst = migrate.src + npages;
>   	scratch = (dma_addr_t *)(migrate.dst + npages);
>   
> +	kfd_smi_event_migration_start(adev->kfd.dev, p->lead_thread->pid,
> +				      start >> PAGE_SHIFT, end >> PAGE_SHIFT,
> +				      adev->kfd.dev->id, 0, prange->prefetch_loc,
> +				      prange->preferred_loc, trigger);
> +
>   	r = migrate_vma_setup(&migrate);
>   	if (r) {
>   		dev_err(adev->dev, "%s: vma setup fail %d range [0x%lx 0x%lx]\n",
> @@ -715,6 +734,11 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   
>   	svm_migrate_copy_done(adev, mfence);
>   	migrate_vma_finalize(&migrate);
> +
> +	kfd_smi_event_migration_end(adev->kfd.dev, p->lead_thread->pid,
> +				    start >> PAGE_SHIFT, end >> PAGE_SHIFT,
> +				    adev->kfd.dev->id, 0, trigger);
> +
>   	svm_range_dma_unmap(adev->dev, scratch, 0, npages);
>   
>   out_free:
> @@ -732,13 +756,15 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>    * svm_migrate_vram_to_ram - migrate svm range from device to system
>    * @prange: range structure
>    * @mm: process mm, use current->mm if NULL
> + * @trigger: reason of migration
>    *
>    * Context: Process context, caller hold mmap read lock, prange->migrate_mutex
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
> @@ -779,7 +805,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
>   		}
>   
>   		next = min(vma->vm_end, end);
> -		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next);
> +		r = svm_migrate_vma_to_ram(adev, prange, vma, addr, next, trigger);
>   		if (r < 0) {
>   			pr_debug("failed %ld to migrate prange %p\n", r, prange);
>   			break;
> @@ -802,6 +828,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
>    * @prange: range structure
>    * @best_loc: the device to migrate to
>    * @mm: process mm, use current->mm if NULL
> + * @trigger: reason of migration
>    *
>    * Context: Process context, caller hold mmap read lock, svms lock, prange lock
>    *
> @@ -810,7 +837,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
>    */
>   static int
>   svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
> -			 struct mm_struct *mm)
> +			 struct mm_struct *mm, uint32_t trigger)
>   {
>   	int r, retries = 3;
>   
> @@ -822,7 +849,7 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
>   	pr_debug("from gpu 0x%x to gpu 0x%x\n", prange->actual_loc, best_loc);
>   
>   	do {
> -		r = svm_migrate_vram_to_ram(prange, mm);
> +		r = svm_migrate_vram_to_ram(prange, mm, trigger);
>   		if (r)
>   			return r;
>   	} while (prange->actual_loc && --retries);
> @@ -830,17 +857,17 @@ svm_migrate_vram_to_vram(struct svm_range *prange, uint32_t best_loc,
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
> @@ -909,7 +936,7 @@ static vm_fault_t svm_migrate_to_ram(struct vm_fault *vmf)
>   		goto out_unlock_prange;
>   	}
>   
> -	r = svm_migrate_vram_to_ram(prange, mm);
> +	r = svm_migrate_vram_to_ram(prange, mm, KFD_MIGRATE_TRIGGER_PAGEFAULT_CPU);
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
> index b7e68283925f..ec4d278c2a47 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.c
> @@ -261,6 +261,28 @@ void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
>   			  pid, address, dev->id, migration ? 'M' : 'U');
>   }
>   
> +void kfd_smi_event_migration_start(struct kfd_dev *dev, pid_t pid,
> +				   unsigned long start, unsigned long end,
> +				   uint32_t from, uint32_t to,
> +				   uint32_t prefetch_loc, uint32_t preferred_loc,
> +				   uint32_t trigger)
> +{
> +	kfd_smi_event_add(pid, dev, KFD_SMI_EVENT_MIGRATE_START,
> +			  "%lld -%d @%lx(%lx) %x->%x %x:%x %d\n",
> +			  ktime_get_boottime_ns(), pid, start, end - start,
> +			  from, to, prefetch_loc, preferred_loc, trigger);
> +}
> +
> +void kfd_smi_event_migration_end(struct kfd_dev *dev, pid_t pid,
> +				 unsigned long start, unsigned long end,
> +				 uint32_t from, uint32_t to, uint32_t trigger)
> +{
> +	kfd_smi_event_add(pid, dev, KFD_SMI_EVENT_MIGRATE_END,
> +			  "%lld -%d @%lx(%lx) %x->%x %d\n",
> +			  ktime_get_boottime_ns(), pid, start, end - start,
> +			  from, to, trigger);
> +}
> +
>   int kfd_smi_event_open(struct kfd_dev *dev, uint32_t *fd)
>   {
>   	struct kfd_smi_client *client;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> index 7903718cd9eb..ec5d74a2fef4 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_smi_events.h
> @@ -34,4 +34,12 @@ void kfd_smi_event_page_fault_start(struct kfd_dev *dev, pid_t pid,
>   				    ktime_t ts);
>   void kfd_smi_event_page_fault_end(struct kfd_dev *dev, pid_t pid,
>   				  unsigned long address, bool migration);
> +void kfd_smi_event_migration_start(struct kfd_dev *dev, pid_t pid,
> +			     unsigned long start, unsigned long end,
> +			     uint32_t from, uint32_t to,
> +			     uint32_t prefetch_loc, uint32_t preferred_loc,
> +			     uint32_t trigger);
> +void kfd_smi_event_migration_end(struct kfd_dev *dev, pid_t pid,
> +			     unsigned long start, unsigned long end,
> +			     uint32_t from, uint32_t to, uint32_t trigger);
>   #endif
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 2ad08a1f38dd..5cead2a0e819 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -2821,7 +2821,8 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   	if (prange->actual_loc != best_loc) {
>   		migration = true;
>   		if (best_loc) {
> -			r = svm_migrate_to_vram(prange, best_loc, mm);
> +			r = svm_migrate_to_vram(prange, best_loc, mm,
> +					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
>   			if (r) {
>   				pr_debug("svm_migrate_to_vram failed (%d) at %llx, falling back to system memory\n",
>   					 r, addr);
> @@ -2829,12 +2830,14 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>   				 * VRAM failed
>   				 */
>   				if (prange->actual_loc)
> -					r = svm_migrate_vram_to_ram(prange, mm);
> +					r = svm_migrate_vram_to_ram(prange, mm,
> +					   KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
>   				else
>   					r = 0;
>   			}
>   		} else {
> -			r = svm_migrate_vram_to_ram(prange, mm);
> +			r = svm_migrate_vram_to_ram(prange, mm,
> +					KFD_MIGRATE_TRIGGER_PAGEFAULT_GPU);
>   		}
>   		if (r) {
>   			pr_debug("failed %d to migrate svms %p [0x%lx 0x%lx]\n",
> @@ -3157,12 +3160,12 @@ svm_range_trigger_migration(struct mm_struct *mm, struct svm_range *prange,
>   		return 0;
>   
>   	if (!best_loc) {
> -		r = svm_migrate_vram_to_ram(prange, mm);
> +		r = svm_migrate_vram_to_ram(prange, mm, KFD_MIGRATE_TRIGGER_PREFETCH);
>   		*migrated = !r;
>   		return r;
>   	}
>   
> -	r = svm_migrate_to_vram(prange, best_loc, mm);
> +	r = svm_migrate_to_vram(prange, best_loc, mm, KFD_MIGRATE_TRIGGER_PREFETCH);
>   	*migrated = !r;
>   
>   	return r;
> @@ -3220,7 +3223,8 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
>   		mutex_lock(&prange->migrate_mutex);
>   		do {
>   			r = svm_migrate_vram_to_ram(prange,
> -						svm_bo->eviction_fence->mm);
> +						svm_bo->eviction_fence->mm,
> +						KFD_MIGRATE_TRIGGER_TTM_EVICTION);
>   		} while (!r && prange->actual_loc && --retries);
>   
>   		if (!r && prange->actual_loc)
