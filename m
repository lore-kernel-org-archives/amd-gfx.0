Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26A69C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Mar 2022 15:16:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5B2110E23E;
	Tue, 15 Mar 2022 15:16:41 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2066.outbound.protection.outlook.com [40.107.92.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F30C810E23E
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Mar 2022 15:16:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cts5bc3TG+Crr965Aqn/gPBOaVMY4T6KvkWNMO2m3sJkzqtDlH7DrXTrLlrrSkdaJorhKLn2vYGkG4vm/Kyp5JoykRJqheS000OucnsMYX3t9GihQgDfNfekx8+D/MuOUUB9rB/s+2jrExJB/D1qrrlf46Px8G17a38tFdJqsN3zgT7Pux1ikV2hDNeRY4j1pzq9bTWXaOBY07jAHbkzGzD8MnmGwJnuL7Ts5nBlYwyAiVLhOWHz1tJiUPSk3j3Ne/FVMD07zMrnrrje/y/Ag9tuFIs2RsdQeDdkZv9CcyuoJUl0Z9y5rKA3Uubx/wQc4IPDLEvQuLtz03brKmkoFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oBWbcP9b31VlzQfbtTjKcWI4RnGLCDyqzLQPfdc5MjY=;
 b=SoufDALNL1szTfZLQjuwaRdSVm+lNWumTUf3Luq70HuZyyScbNBkiQuiznR07jQ+vNTnstmedVuO5eIVA9/wAbnhF15MAZ/wG7x1/JxnwmpopKluN/WiQvSxbKd7GO7zjy94zjxGyWza3GbMInaZG33mAj6yvnFH16S/JeyqRZUFTC9jVl8k3FYME0BX6Msro+qf7mHJxmJL4rRZJj2/eHiDzRKyfqwaT9RBZVAnL2BV4eFceB7RSQPADX7fvYaXve5FEp0RFizzeoRyO4q0vJd3h8u2Pj16JtOoF9fng4mDm5WCAhOe91eFI5Bv5Nwj4udl5NpxWUVL2dWxDwYuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oBWbcP9b31VlzQfbtTjKcWI4RnGLCDyqzLQPfdc5MjY=;
 b=BpJemUmlFSWXOnkc0pHQbWCuw1aDtLknCsmHOWi47DprxUc6nX/sNIpELfM0Xq0aD4XoQsiR4vXtcFQ4t5GG9fZIvSVM4xyJR32qiajWuAVc00zj8wetP6znUnVbfN13jcE9g2ZlBcqL3/TUoB6yuOUZ8s4IyAxsdWBDv+D63H8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BYAPR12MB2632.namprd12.prod.outlook.com (2603:10b6:a03:6c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.28; Tue, 15 Mar
 2022 15:16:38 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::4839:9431:1040:5cd5%4]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 15:16:38 +0000
Message-ID: <7326674d-8d07-3d44-a6ca-0ddfcbcde6a2@amd.com>
Date: Tue, 15 Mar 2022 11:16:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 1/1] drm/amdkfd: evict svm bo worker handle error
Content-Language: en-US
To: philip yang <yangp@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org
References: <20220314145020.9142-1-Philip.Yang@amd.com>
 <7fe7133a-bf8d-66c2-7fbc-7d49c48454a9@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
In-Reply-To: <7fe7133a-bf8d-66c2-7fbc-7d49c48454a9@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT1PR01CA0111.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::20) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8826e16d-92e0-4b12-587c-08da0696ccf3
X-MS-TrafficTypeDiagnostic: BYAPR12MB2632:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB26324A988696B3AAACEF7DFB92109@BYAPR12MB2632.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pCHqjeQQB4xVKXvyYRHIxJwP+u6EvBxzn5XPcQGV2rimY3NRnmNGaq9GH+69nP4wiGM64BmUzbwRF9UfJ/0d1vtZA0i1rRFLcRHNHTc1vIai9xFSOTR/rcmxd/cAX7zi5cQpdAMOzJc0ZTgtFoaB7bJTQoeMcWEg8Lw0VCttMaO6PMWRoSTQ+CjN1a8PXUR1bgXgzaNrup8X+bqdX8B7+UyecqlBMvyJGPl8EY2XgrJMkUnVYr7sJfp1Yn6ARP+1WudbB2J9mdKtgTav61ABoZBdAy1DdPSEpxAzHQTuc84iBJHG3ouv6RKJqxeFFuE+o7zLZ1WwY7DwZtVSNIfpmf9DaAvCHl4jT23dVn5jHlFtUOc0E7pF8UEL44v8D8LlqkYYWJ7HFEUMIoYG8Swx7azvNP4Zif9Jy1Qg9/+8jUuEdaXZzepyrCChoTl5qvYTigkGCUhW7PjcOA9yEhHiyJ8nLFE1YhgYRySYGngkIKQo8Bl7PZYKG8xX4qpB5q8uTt1GM0HZjktR1y6g+uxXjoQG2d+nss0DrQGL7DmVrw1vFHdF6OfZjcWXvzgVn4hEZX2w+zATuICuq9yxQX44am47Fz+Sg+tmw10SsMokvHVb9IVTzHhXwKD/w1mSwP95Y46VsYQof3JH8ZzN3fk4QrBcYpTTslo4toOBGORsDrgtDIiKGqMtP199PBPXtBN1xe3uOMlpT7kZCp4TNP7/vALdHuxz1T4q1oFb5KYrpTP/NEydGU/IDNAjiv+FZBse
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(83380400001)(6486002)(2616005)(186003)(36756003)(26005)(66556008)(66476007)(508600001)(66946007)(316002)(6506007)(86362001)(6512007)(2906002)(31696002)(8676002)(4326008)(5660300002)(8936002)(110136005)(38100700002)(44832011)(31686004)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDk3UVN3TGVTVnQzZTZSZkdlWDQrRUFQK3k5V1dmUTBQZnNDSXlyQXZzQ3pa?=
 =?utf-8?B?UFZESmNNNGUvc0lsNXVacWNoekpTbnJXdis5VTBxREZMN2VWWjROQ0kxbktT?=
 =?utf-8?B?d3VFVWJUZWZvai9YVHpwTFpHWCtBNzdVVUN3NlpIYjJJU3RPamg5SDdpblJ6?=
 =?utf-8?B?VE1NakhJUkhCclJTZ0ZBY1dnb1FDTFdlRzBOb0RNaW1FdkxZclFwVGptYklh?=
 =?utf-8?B?alBMaDJNeEJPRTlUVjRROWhYTDRpeUFQYlk3NnBmZkpJNjlDYms0dkx1eUo5?=
 =?utf-8?B?NjRsVWJQQmYrYTdzMkRHUjVMRWc3b1pscGw4aW5vS2RUYWkzeXl0Q2VRV3JV?=
 =?utf-8?B?SjZmQjN1MXlCbUNFaDJBWHcxMUFkTUsxdDBsWG1iNFlFV2lScnMvaFJ5MXpQ?=
 =?utf-8?B?RWN6djBzUE5mREthbU1SYmFsVUdmcnhYZEw2RDFPeE90WGZrM0ZjUmk4ejhF?=
 =?utf-8?B?d2hDV1ZKVGxPZkRHRmpDYUdhQnVwS1NzRXhzeEl5N2ZMaUkxekU5LytTSk9C?=
 =?utf-8?B?NlJzSXhMWmt6TnBNRktlWDZjWFlqYlhXbERzclpyUEErZGhiU1BZUS9MRTJm?=
 =?utf-8?B?amVucDd0azhBbEFmWWdkK0xURzRYSVJoNzdONDE5TVZ1RlpVRWZvQUpDVzdM?=
 =?utf-8?B?TUtKenFicENXbTU0ZmR2QTBTQjEyeTBTRkQrUzJETnQ5MEN3NlltRXY1MWcr?=
 =?utf-8?B?cHJIL0NwTUtFaW1QMWtHaG9TdHZ2WDhRNzFLYWNmSVM0dlV3YWh0Yk1GTlhI?=
 =?utf-8?B?N0lCeDBNQmJ3NngzUUE5bSswdnJzS1lWMW40L2ljRDFxYVFEUVdGbEJMSUsx?=
 =?utf-8?B?dFFiSlhxMVp5TWg0UG5RQ0R2dlM3SE9VK0lDZEVzNzl6WmVnSnFjYW42M3hw?=
 =?utf-8?B?THFTZURJTlVkZXFteCtGNWVUaG1odDJqWXBKdlhlbWpZZmZFT3pCRm0zY2p2?=
 =?utf-8?B?TTRmV1c4VUxnWUQ5ZHI0NkhJOE0zNUNIdDVDMEIzY3hHeXpPVkg3QzkycnRC?=
 =?utf-8?B?VCtFUTMvMXhFQW02Tm1UNGJYOU82RElWcmtER2xtVFV6blFEU3pod0pzaklv?=
 =?utf-8?B?R3J3TENOQjFTMy8xUEI1L3FuM1VvU0tLOXRsZ1RqRkRKR3VhTVVoeUI2bXZY?=
 =?utf-8?B?amdnM3B6d29qQlp2cU5EZkJqbVNZWnJySVowdUtFa0M4Q2ZTK29LbXppdFlv?=
 =?utf-8?B?TWJmenhrQ2luRWNUa2JFK0tmK1pacGFTdUJJOXJLWjkxOUJwR1BHcHM0bFNh?=
 =?utf-8?B?bEE4Q3ZNUU91aG51UXhRYjFXQmFtbUFvU2lvSDdkZ0tUL3pUWXpOT2pveVhz?=
 =?utf-8?B?RkdHbXpSdXp5NldNcmVuaVR1OTJxdFV3UERwNzFobmlaeUhhWExFaHBsRmtw?=
 =?utf-8?B?T29XcXdFdkg0VmRZZ08ra3l1UUFGSTRmdTViRTNQTUNxS0h1ZngzYmx3TTdm?=
 =?utf-8?B?TWJ3eUxDT1NyK2tFRnRpOGRQUWYwQVR5bGhQNjJ0a2lqMVFXR0hUUlNmcjRB?=
 =?utf-8?B?RnpJd0dTYjBhbForVXo5OVZCV09uTVZ2NDBXd2FWWmc1RFpObkoxVi9ERkU4?=
 =?utf-8?B?TGtXNTcrNE5TY0xodDhvOEVQbjFESU9mNWFxa1I1a0FRMXZ0Rk9KeTVVRFpx?=
 =?utf-8?B?RVNucGZNdllkY0NFdUdGNU02Rzl1WjRMYW00SXgvZUE1TE5tWkxmSE9zTCtM?=
 =?utf-8?B?RGI4dDlNQTljL2laaHEwRzJ1RUROQ2hEZ2ZPMUVvVkZlWllLZzZyMTRBeGNJ?=
 =?utf-8?B?QTZ0UjZ0blA0TVpNOGR0K1I3VVdjRXAwZUNXdzVHMjhONHRZbXZaMUZWVjd5?=
 =?utf-8?B?SGRGUGd5dXgwUlp1dU1vUFRNTmJqV3BsaHEzK2pmMmE5QW9zYmxWaXhNSCsy?=
 =?utf-8?B?RW1yMnpBVzRKb3AwRG1vcHJMb3hHelNlRmVCNHVjdEpFaTZ1YXBtM1FWc3lu?=
 =?utf-8?Q?geGpmAst7KGcuVB0VNRrPOdJ3yyBpWEr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8826e16d-92e0-4b12-587c-08da0696ccf3
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 15:16:38.1425 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eFqlqSySp+nwJQht5GAigq1Gk8fTthvl2OfKhQ9mSv/OuCMtxFMVhtTy4XS+GdJJzwDkVg9amhno3RnReGV4Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2632
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

Am 2022-03-15 um 11:05 schrieb philip yang:
> Migrate vram to ram may fail to find the vma if process is exiting
> and vma is removed, evict svm bo worker sets prange->svm_bo to NULL
> and warn svm_bo ref count != 1 only if migrating vram to ram
> successfully.
>
> Signed-off-by: Philip Yang<Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_migrate.c | 28 +++++++++++++++++++-----
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c     | 21 +++++++++++-------
>   2 files changed, 36 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> index 7f689094be5a..7187417273f9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_migrate.c
> @@ -638,6 +638,23 @@ svm_migrate_copy_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
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
> + * Context: Process context, caller hold mmap read lock, svms lock except calling
> + *          from svm_range_evict_svm_bo_worker, prange->migrate_mutex

This doesn't make a lot of sense to me. This function either requires 
that svms->lock is held, or it doesn't. If svm_range_evict_svm_bo_worker 
functions without holding that lock, it means this function doesn't 
depend on it. I'd just remove the "svms lock ..." from the comment. Also 
remove it from the comment above svm_migrate_vram_to_ram for consistency.

With that fixed, the patch is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> + *
> + * Return:
> + *   0 - success with all pages migrated
> + *   negative values - indicate error
> + *   positive values - partial migration, number of pages not migrated
> + */
>   static long
>   svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   		       struct vm_area_struct *vma, uint64_t start, uint64_t end)
> @@ -709,8 +726,6 @@ svm_migrate_vma_to_ram(struct amdgpu_device *adev, struct svm_range *prange,
>   		pdd = svm_range_get_pdd_by_adev(prange, adev);
>   		if (pdd)
>   			WRITE_ONCE(pdd->page_out, pdd->page_out + cpages);
> -
> -		return upages;
>   	}
>   	return r ? r : upages;
>   }
> @@ -759,13 +774,16 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
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
> @@ -773,7 +791,7 @@ int svm_migrate_vram_to_ram(struct svm_range *prange, struct mm_struct *mm)
>   		addr = next;
>   	}
>   
> -	if (!upages) {
> +	if (r >= 0 && !upages) {
>   		svm_range_vram_node_free(prange);
>   		prange->actual_loc = 0;
>   	}
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 509d915cbe69..3b8856b4cece 100644
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
> @@ -3184,15 +3185,18 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
>   
>   		mutex_lock(&prange->migrate_mutex);
>   		do {
> -			svm_migrate_vram_to_ram(prange,
> +			r = svm_migrate_vram_to_ram(prange,
>   						svm_bo->eviction_fence->mm);
> -		} while (prange->actual_loc && --retries);
> -		WARN(prange->actual_loc, "Migration failed during eviction");
> +		} while (!r && prange->actual_loc && --retries);
>   
> -		mutex_lock(&prange->lock);
> -		prange->svm_bo = NULL;
> -		mutex_unlock(&prange->lock);
> +		if (!r && prange->actual_loc)
> +			pr_info_once("Migration failed during eviction");
>   
> +		if (!prange->actual_loc) {
> +			mutex_lock(&prange->lock);
> +			prange->svm_bo = NULL;
> +			mutex_unlock(&prange->lock);
> +		}
>   		mutex_unlock(&prange->migrate_mutex);
>   
>   		spin_lock(&svm_bo->list_lock);
> @@ -3201,10 +3205,11 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
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
> -- 2.35.1
