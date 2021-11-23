Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D2C1C433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Nov 2021 02:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAD8389C16;
	Tue, 23 Nov 2021 02:29:39 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2088.outbound.protection.outlook.com [40.107.220.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DBFD89C16
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Nov 2021 02:29:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NubTUp9/bPb/I1Y44FYpJSZdzNsCnmyF7X4EBTjTf5YFWGhkUps+4mGlN481c9I0op8q/sgJvIpbYesKDvu26pIDSRQpzENncDarknb/2MiF6bb8AAz1ISDCLKuOybwLvcdc7JYd5pliTIchfZpmEvcmNU2/PooOC+W2y2+jQfcGpZY6oQnZBzCZ1LOSqscCtzvtWcd7x2XB0F5haPQlT4kFaalPk/haPn8IlTeyI8UD9wRYktiUvjdGEhG1+W/79qKSq8/zi+xGUh8xU/ur6y9sKSSofQh7STEIL1a6AAljGhzBpq2izzJ29m12KpNVxyzOvJKv/Dpjs8wyKP7Usg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fJwsfW8QzHNNbAh4rPWWVddeYXw878NPvx5xrvz/dFM=;
 b=Gs9JaW9+/Rw/tnWryIJRd7p+cAx0Vbzk7Ua2oZK0Nk5pJ42Ih7u8AkER43wkPXfTSz53bP2gGNZ1Wf32ravnX5A4bEE0jmTQLyXy0gE+49yC81H5BgMDk9dpjND3BuSwmtgRH2FwyweK6+NVd3uiqfS6k3lVOSkN2FWoZm6QZUBvCHgpj2nElxryCcVA5vDKs9KYbo+A2SB/YPddRlte+U/NNPUQK/LTcdFy0oJ7cAvJ9nfWRMrCPsC/nuO2QKEfhjvxakGw/Cvbgj9lPfSa5bGFxEK6b80+RAz7pw1QNv3ZerZ+TzCk0mM7aqosBIq6vS18qW+KDJd7hUD8B+rO6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fJwsfW8QzHNNbAh4rPWWVddeYXw878NPvx5xrvz/dFM=;
 b=l86XdQDR75+W3RI5+/uHlBH9WOHVMGsOhpZCgt7C4WlcibkJCvfTrn+eRyMFnjZCWxhU7GnKmR4sfMnleu5/v0aV9Pp3LdhHhXzsjIbltXteuErVaTxmNOOx9gFkjntY9i6ycUB4Jnm4tyne72zIkjn3XvYIREwPiNoXb/QwwJE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5177.namprd12.prod.outlook.com (2603:10b6:408:11a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4713.19; Tue, 23 Nov
 2021 02:29:38 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%8]) with mapi id 15.20.4713.025; Tue, 23 Nov 2021
 02:29:37 +0000
Subject: Re: [PATCH v2 1/3] drm/amdkfd: process exit and retry fault race
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211119222941.18053-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <ecbfca96-8cc6-cbe4-e9ed-26aa62435264@amd.com>
Date: Mon, 22 Nov 2021 21:29:35 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211119222941.18053-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: YT2PR01CA0011.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::16) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT2PR01CA0011.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:38::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4713.19 via Frontend Transport; Tue, 23 Nov 2021 02:29:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3538a8b-0276-49ce-b2dc-08d9ae29186d
X-MS-TrafficTypeDiagnostic: BN9PR12MB5177:
X-Microsoft-Antispam-PRVS: <BN9PR12MB517779EC6458C50F3F260A7892609@BN9PR12MB5177.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VD2Ozd8DnK+MqXZRuq43tcGXI1iKJFxiEhkBDdo/9t+YE17NKC0IwTQ4pf9d9ZDtVmokbfSWfb6+DoiTAmSENgLyyZdm1B+iImHyi+S7d7QGPSbGyMtjZe6taMG4ao/m95T65cA/ldalR24zOiLxuEm0HhBGsYHczYrlFmx2E/jfuZEAz9ggOt9Bbjoqf3XwtlO/1slPl9S18llh0nlCfKTveha4LYeOWrOVBXqy3APYsJwlb3/qPoR4CmXYK1BkI8Tf1M1uUR6kY/L+1mAg6F6GFNLJ+LVPE9OFP8C63cvh5THeMdmaTNxXxR5fdSv2nwhDKKtfFWWukcqNv+A97SojQ+UmNNnREWkhvyelIIgWxe6ICdTQ1N5DZlufb32tWDtD9Kd+16QQuhE9mX2Em7bOMK8WuLcGGF/kO+RD9wmWqYCRqe1Zup0aF/VqdWUE3nS8AxJZqBEFFVr/Tqfi2SLsgIcK44o+jNT2czzQauEq60kPZxmgRUwDsH1QCM9qbMku3ouF+P33akAyAj8E/vKjcINOB/f8LZ20AaV0n1wr7xuNO/3WWjE86HlQ1ySgufAQuDx/cCLSDSabOCT/rlbF/f43DOY/cixpUJSOgN+X/iITEC2QZO06hwwnO40nl8X52LsOtME7EcN2e8+5S/KMbRMWTF1LEKoEn21p00ybjM980hlxOIESbalQYcT3KR/KhvBwjWSOMLrScQv520D2SH0dEF6iT1jlM2CWcGZYWs8y8Uzu+XpEq9QfCmbq
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(956004)(2616005)(508600001)(36756003)(66946007)(66476007)(8676002)(2906002)(66556008)(4001150100001)(31696002)(16576012)(5660300002)(38100700002)(8936002)(6486002)(316002)(86362001)(44832011)(31686004)(186003)(26005)(83380400001)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bk90SVRmcnlNdCtQaXQzUURKSW53c0J0T2xRYU8xVnBXOGpHV2gyUGUwMnJG?=
 =?utf-8?B?R2t6MytXQVh5Nld2R0taZmRtVVJPeDQ5ZDVrY3hhK2V4L2QyRW85NUJBekQ2?=
 =?utf-8?B?VzAyeXlaUFpvRDFMdGQvZTJKMytTLzk5dnhScmtZMUpoaFJ0SXRpbzVHc2pp?=
 =?utf-8?B?UzFvdXhxMHU0QkRkbGtwUWdLSWRsMTFLZ1hxNzI0ZWVLSTRJb1ZOKzRuTUlO?=
 =?utf-8?B?OWkydklqOW1ucDN1aVArdFUzUmtleVFnTmJrRVNqZytwSSsrV3JPTGJDVURi?=
 =?utf-8?B?WGtTUXpLaU8wWWtaYnl6Z3lRaHU4WTVoVE95QkxuWmtaUHlybzN4SDNPdHVa?=
 =?utf-8?B?cWpsS0xKcGo5RTRYUktJT0F4NHRva0ZTVTlxbVpHd2k1WFdCdWZFV2R4a05p?=
 =?utf-8?B?cHZIc2ltWXZQUjZmRk9xTUpzK2ZhVlZhdnhObzdZS1NJeDNNeWVIbnRxdG81?=
 =?utf-8?B?MEtDOGJrSTRRZmt5ZUtMS0Q5dERrM21PdG1mRFR2Y0xTRWgybXRvL012RXQ4?=
 =?utf-8?B?VnNVeUM0Skg5aHhVeDhLR3lnclZtbXBpQW9INVludUwvREVTK055RktZUEgr?=
 =?utf-8?B?VzVqRHdFNmZYbWpjUW9iQzYvRmlzT0xUdSsvc2ZXd3hac0JuT3Vzd1VRdjFn?=
 =?utf-8?B?clprL1o3eGJ3Ni9WZjRSL29DYmJRRE4vYkQzbVV6Ni9VSHFTbmozcGl5REJS?=
 =?utf-8?B?SFZpdVRUTmtKNHVWK1NtMHR3OE00M3V0V0JoWk5zeUJ4TjRIQmp1YTZSWmJZ?=
 =?utf-8?B?TjRrK0ovamxoNjF4b0RaN0swM0M1elhrZ1FIWWlVQngya08yWjVJbk9yVmtX?=
 =?utf-8?B?d2dldzU1M0FjK01QUTRBUDJJb2lpajN3QmpsSTRBbnlWQ3ZBNWdiUFpzOEtH?=
 =?utf-8?B?Q1R4aU5KZ3F0VEEvUGVjOXFLMXdWZ0Q1VVF6cDYwK2NzWTFCenhyZkJsUEZm?=
 =?utf-8?B?Q2dJenUvaDJKdUlyODhncElkZmR4d1NOMCt3YzFlcFNxWDVLMDlLUDEySUhX?=
 =?utf-8?B?amY3dS85NXhXbFY1ZVc3dnhxejZoNHBOOTA5N0g2WjJUU2N5bjVKOHk2K2xi?=
 =?utf-8?B?azBmWHhKRFRlUXNSL1BnK2hJN044TnJqS0xoN1k1dWRITWhHdHNJV1VjczFh?=
 =?utf-8?B?SGkzeU53UklqamIxZjlmamplaU1XYTZXeUlkeEE0ZlhuSmdCY3UvOFVrbURi?=
 =?utf-8?B?eXFkV0hoTEtOREp4ZHZ6SzVSV255Y0UzZkVEeTNKbnIrU1N1RVdvU1ZWVVBn?=
 =?utf-8?B?TGhrS1VrRXdTc1IyOWdpdDlGMHZhU2tYMzJqbGU3Nytxbit5cHdjeStob2t0?=
 =?utf-8?B?cHg2Z211MXprRjFzY1c4Nm1xWGZ5LzNsZ2s1bXB0YThxbTNqL3dIZm1Bd1pQ?=
 =?utf-8?B?cXhjRFhYUG5BYjhnUE9nbDFLQWFEUEtsU1hlUFFObEJhWjArVHM2ZjFFSUFl?=
 =?utf-8?B?dzB5ZHZjUDlnSDM3ekpuQmladmlsMXFwSlJicmgvL09tcXlXV2o3VzRYZTVk?=
 =?utf-8?B?cXBmVktGRk5QNnRCR040cjVQZU9sbmM4SU12OVRYajJEb05odWhMaURvRW1l?=
 =?utf-8?B?cmxwS005VTRHOEJUYlhHZURkUDVEQjRiVklmQ25sSis2dlAvWlo0N20zc0U2?=
 =?utf-8?B?dVIzZzN2RWdQVmhXb3h1TDB1UWF0NWhZQnFxRG5mS3V4ZGozLzkxckwvQllq?=
 =?utf-8?B?L2ZkQmpxcHgzRm5pN3MrR0hnRHBHYWY2Q25samtObmdaZGtNSTRKMVRGdVJT?=
 =?utf-8?B?Y1RQU0FpTmtFekNFT2FZY25tSGZCK2FwR1N4cy9NQVl2UitGZXBJOG1Gb1VM?=
 =?utf-8?B?dGFDQWl3ZlEwUzZ3ZlpkcDFoYllPQlptMXlVb3VGeVgzZGhDZGtuNWNVVTFp?=
 =?utf-8?B?VHFaQ1JWRk9pbE5iOVl4ZktHbTVicWQ2UnNsYjAyRlhkWmYxM1UrOW8wR0xL?=
 =?utf-8?B?OVhqOFJ5UnhBTnllSGZ3bmlkMmFIVW9VYnQyVEpRT3QwRitFNHNxa280V2JF?=
 =?utf-8?B?Y2lWdnRaMUo3SC93ZXlXM01qZXI1V1ptbFhSdFkvemFLTEl2bGNyWFhpV21a?=
 =?utf-8?B?WVBSZzZtSzRkSkp1cjdkUUhvYUE3cEVtKzF4aldTV2hDbkxINmIwWFNiVHg4?=
 =?utf-8?B?d2p1ZDdncnBnRVVyS3JPWVZpcVBTNFdQOGdKS2F0MnhiMTNoU1NqK0lyTXZp?=
 =?utf-8?Q?dAcUB9DqHHvM2PQx0U3Qik0=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3538a8b-0276-49ce-b2dc-08d9ae29186d
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2021 02:29:37.8112 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Old32nz8i1AC4Ssz9/YZKUH5daqLKe4FbRtwTY7p1RoOmNOt0PLW4TF+HcEG7rnice33iSl936GhlYpHs+a5rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5177
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

Am 2021-11-19 um 5:29 p.m. schrieb Philip Yang:
> kfd_process_wq_release drain retry fault to ensure no retry fault comes
> after removing kfd process from the hash table, otherwise svm page fault
> handler will fail to recover the fault and dump GPU vm fault log.
>
> Refactor deferred list work to get_task_mm and take mmap write lock
> to handle all ranges, and avoid mm is gone while inserting mmu notifier.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>

The series is

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 61 ++++++++++++++++------------
>  1 file changed, 35 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index 9e566ec54cf5..5fa540828ed0 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -1979,43 +1979,42 @@ static void svm_range_deferred_list_work(struct work_struct *work)
>  	struct svm_range_list *svms;
>  	struct svm_range *prange;
>  	struct mm_struct *mm;
> +	struct kfd_process *p;
>  
>  	svms = container_of(work, struct svm_range_list, deferred_list_work);
>  	pr_debug("enter svms 0x%p\n", svms);
>  
> +	p = container_of(svms, struct kfd_process, svms);
> +	/* Avoid mm is gone when inserting mmu notifier */
> +	mm = get_task_mm(p->lead_thread);
> +	if (!mm) {
> +		pr_debug("svms 0x%p process mm gone\n", svms);
> +		return;
> +	}
> +retry:
> +	mmap_write_lock(mm);
> +
> +	/* Checking for the need to drain retry faults must be inside
> +	 * mmap write lock to serialize with munmap notifiers.
> +	 */
> +	if (unlikely(READ_ONCE(svms->drain_pagefaults))) {
> +		WRITE_ONCE(svms->drain_pagefaults, false);
> +		mmap_write_unlock(mm);
> +		svm_range_drain_retry_fault(svms);
> +		goto retry;
> +	}
> +
>  	spin_lock(&svms->deferred_list_lock);
>  	while (!list_empty(&svms->deferred_range_list)) {
>  		prange = list_first_entry(&svms->deferred_range_list,
>  					  struct svm_range, deferred_list);
> +		list_del_init(&prange->deferred_list);
>  		spin_unlock(&svms->deferred_list_lock);
> +
>  		pr_debug("prange 0x%p [0x%lx 0x%lx] op %d\n", prange,
>  			 prange->start, prange->last, prange->work_item.op);
>  
> -		mm = prange->work_item.mm;
> -retry:
> -		mmap_write_lock(mm);
>  		mutex_lock(&svms->lock);
> -
> -		/* Checking for the need to drain retry faults must be in
> -		 * mmap write lock to serialize with munmap notifiers.
> -		 *
> -		 * Remove from deferred_list must be inside mmap write lock,
> -		 * otherwise, svm_range_list_lock_and_flush_work may hold mmap
> -		 * write lock, and continue because deferred_list is empty, then
> -		 * deferred_list handle is blocked by mmap write lock.
> -		 */
> -		spin_lock(&svms->deferred_list_lock);
> -		if (unlikely(svms->drain_pagefaults)) {
> -			svms->drain_pagefaults = false;
> -			spin_unlock(&svms->deferred_list_lock);
> -			mutex_unlock(&svms->lock);
> -			mmap_write_unlock(mm);
> -			svm_range_drain_retry_fault(svms);
> -			goto retry;
> -		}
> -		list_del_init(&prange->deferred_list);
> -		spin_unlock(&svms->deferred_list_lock);
> -
>  		mutex_lock(&prange->migrate_mutex);
>  		while (!list_empty(&prange->child_list)) {
>  			struct svm_range *pchild;
> @@ -2031,12 +2030,13 @@ static void svm_range_deferred_list_work(struct work_struct *work)
>  
>  		svm_range_handle_list_op(svms, prange);
>  		mutex_unlock(&svms->lock);
> -		mmap_write_unlock(mm);
>  
>  		spin_lock(&svms->deferred_list_lock);
>  	}
>  	spin_unlock(&svms->deferred_list_lock);
>  
> +	mmap_write_unlock(mm);
> +	mmput(mm);
>  	pr_debug("exit svms 0x%p\n", svms);
>  }
>  
> @@ -2600,10 +2600,12 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
>  
>  	pr_debug("restoring svms 0x%p fault address 0x%llx\n", svms, addr);
>  
> +	/* p->lead_thread is available as kfd_process_wq_release flush the work
> +	 * before releasing task ref.
> +	 */
>  	mm = get_task_mm(p->lead_thread);
>  	if (!mm) {
>  		pr_debug("svms 0x%p failed to get mm\n", svms);
> -		r = -ESRCH;
>  		goto out;
>  	}
>  
> @@ -2730,6 +2732,13 @@ void svm_range_list_fini(struct kfd_process *p)
>  	/* Ensure list work is finished before process is destroyed */
>  	flush_work(&p->svms.deferred_list_work);
>  
> +	/*
> +	 * Ensure no retry fault comes in afterwards, as page fault handler will
> +	 * not find kfd process and take mm lock to recover fault.
> +	 */
> +	svm_range_drain_retry_fault(&p->svms);
> +
> +
>  	list_for_each_entry_safe(prange, next, &p->svms.list, list) {
>  		svm_range_unlink(prange);
>  		svm_range_remove_notifier(prange);
