Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2508AC433EF
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Dec 2021 00:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2EB386E16D;
	Wed,  1 Dec 2021 00:42:09 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F15EC6E16D
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Dec 2021 00:42:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NTEBPJ5u9CqqTHqzhGzLw75ua0JvJpIzSMp4dsEt0MOa3K9OMveqAtvXebEW+RATQdDwhegoyIO//FfANUx0xJfEL0fwvV6QgOtt6NB+VDvMmHtq44lhyf8lnvGzIWgGJdQOK8pWehJNcKR4xhUG9/qu7h+ecLYBRjqfYr+6FQ0JcMgwRk0DYdp4RkhpL6vCmRucj+Gs6tDul4X71JelmKFxmvTvepRnKce6Ncp51xSz/GBVdkeWiN5SUbrwTvyv/XOF1DZB0FZscDuPvC35HYT6d9L1KNTjn5OCP9jxc6LFVOFP310rvI2jtj6I4nqYIQgez360qokhDCzokZ9s2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gq1Zp5SI3hvoJs4nQ/IW7ES37qH3BGRFISCRehq1JGU=;
 b=B7app0XeQPkeG3bSDbQAwOr43JajGNjbddil6dXjEKVJKsjcz3C/51cvTq9o6qL3nyZwxndu0jX2XFSrAlOt5TdyaitPd2LdSN12ZqAm7nEtW3KGRD7pNTwlvvxwMj5fUqpEx/TcDKmaZtasHmHBJWWmKCE/Z3cmCVveQGvIGVHhhvK5IZMTtGphHu9sUKbAeJyE/DsWk0kcjbHLki2muOPqgJr4IKZ2n1Pf3nCw4BJQBsaGzCnNXVcl6gxVWjoiUYpis2U1a2zbIJaOlnpqGjJKQrBDEJu5NQGgfmkE2sSayRfaT54JjTUuZ3E2k52XmeWW3v3L9rd40CpffYMQlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gq1Zp5SI3hvoJs4nQ/IW7ES37qH3BGRFISCRehq1JGU=;
 b=LRNYUuUqW1JQyEriijU7VDkHVWc977KR6QEyk1slYVU8YX3icxj4w+LoagiflFpZtVioutPYqMhbk5rUq0ho/uVmaaCrJVH/t7X6qyZui6dGnBvEIExUUdtIHxwsl7w6JiKHTi7KkUyk8+YjXB8yi3yED0V43CTs8VGVR9hOjbQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by BN9PR12MB5179.namprd12.prod.outlook.com (2603:10b6:408:11c::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Wed, 1 Dec
 2021 00:42:03 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::9dfe:ccc6:102c:5300%9]) with mapi id 15.20.4734.024; Wed, 1 Dec 2021
 00:42:03 +0000
Subject: Re: [PATCH] drm/amdkfd: fix svm_bo release invalid wait context
 warning
To: Philip Yang <Philip.Yang@amd.com>, amd-gfx@lists.freedesktop.org
References: <20211130201321.22190-1-Philip.Yang@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Message-ID: <f7f454e0-81c3-13f5-7d20-c1fb287c13ee@amd.com>
Date: Tue, 30 Nov 2021 19:42:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20211130201321.22190-1-Philip.Yang@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: YT1PR01CA0084.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2d::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
Received: from [192.168.2.100] (142.127.191.123) by
 YT1PR01CA0084.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:2d::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4755.11 via Frontend Transport; Wed, 1 Dec 2021 00:42:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa63f146-d9c4-4944-6152-08d9b4636487
X-MS-TrafficTypeDiagnostic: BN9PR12MB5179:
X-Microsoft-Antispam-PRVS: <BN9PR12MB51792FFA14F10EDB3323055E92689@BN9PR12MB5179.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rmFST1QY6cKlXljItZsC28wr9HyojJzKENOO9LOaNG0sekjW8uSy8846CDxHstYROD0247LkFltp4B+jQ8H0h1PcohRUqwI/ahet+kyeXROS5i/Z6Mo9Xp1IR0XzU7cX2AgOYEXxCIyBIDG1oToWTfdhBtILcEw2JE+1iUAyqQ+Zt/tG8AHxNwspVa9sT+PkORX3VgttIBf6mqQ2n53qmQmNGCKwOrDAwqsVZ4nsiFhtASA9jVHbPZKKXxyL9s0lPPDSBRnA54PFjQH4R+P3ysfGbeANNXGkMFLc/6MsNtlRPRsUbXd5l54nQfQqSkK1nqgfQtUQnqusYRJOEVKpqqcvtMi0wbt/D1vLBN6bC3tDUcz60TbOmFnWoC6kN8lwZNYvg0VLRNK2X6ckYZSPOk4SYGXq93wvKAl+DwUbsKleQiWpJIlz12XVYoSqGKoZM1Vo2EZwDlMxFVj0MAREuxl0gXn3L1wopPL0Tz4IZGHNcqppkFY8oyAiuco7MknuU2Rdy5RUS9LNsLlaYDMgYEwU+e2TnYVSq6w6P7EY3rl1F6QKAPabJ3lFql4w895bJwneZQpiLJwsyQg6PB3k9Zmdg9nhHdVwDVvkAnbKVNxlbikvHMvInBabauwilY0IzemvBn2C/W/kgDE6z+PA4F9tYbJ+GAyDk6B1qU1ISWjN1JwJms+HFQt5whrHShzmhQ2QDnT9aCE2fPl/0xXM0nRdfKEeoDKrJ8yC07vZqY8zNf9aaxi7OGnMdMrpspYC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(956004)(2616005)(38100700002)(4326008)(8936002)(316002)(36756003)(31686004)(8676002)(6486002)(5660300002)(44832011)(86362001)(508600001)(2906002)(66946007)(26005)(83380400001)(16576012)(66476007)(4001150100001)(66556008)(186003)(31696002)(45980500001)(43740500002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGNHcEJKaC9DYjBkU3kxUDZXNDdsS3VlTm5rV096bFZMb1pwTWZXbnR5WEpn?=
 =?utf-8?B?YXlCYmI5L1JsVGh5ZncrNk04V1oxZWU5WE5kSTJJOFlRMURrNkl5SGFrVDlH?=
 =?utf-8?B?VWNOK2E0SHZXQjhJdnE3THJNSkRwK0V1RFYvdnR4end0c09Qd2MwY3ZOVFh2?=
 =?utf-8?B?T3lZTEVUeE1Za1gxMmk4OU5vR0lDRWRKQzVhanFIczJuK2ZmWVNOQUc4bmpk?=
 =?utf-8?B?NUgxSWVjTmttQ3NPNzBrSWRGWDF6MHYrSlVaLzBlOGhoYmdLekdCMENZbXpr?=
 =?utf-8?B?MG5zeTJwN0hGZVExWTZTU1dGKzhBWXI0Q3VLbnFINldiYVlSVW5jY0ZBYW9w?=
 =?utf-8?B?YVhmVGRzTVVJRzBsdG1MY3A4K1k4QmdJaW1aRTJtUGVYazdMVzhTWERwMlYr?=
 =?utf-8?B?TlpJcTUwOFkvMDBNNU41d1ZCNUdQdEVUSnBkYnpGamZyUUpQVjFCVWY4UGZZ?=
 =?utf-8?B?MUNFbnUrN05PaUVmcnBabG1BRFBFNGZ0TDFaRG8xa1UxMDloaWp5clBuT1pS?=
 =?utf-8?B?b1RxNGZNQ25yY0pTZkVFRmlXdGRIMjNRdWd0a2x1blVJUVpKOWpKWWR3TkRI?=
 =?utf-8?B?TlI0dHZWQVhuamczRkFzZWlIeUhDT2gxUVU1QXNNeTN3bU9VTTQvTFBuVlAz?=
 =?utf-8?B?OUtlR29BMCt1RzNRRmI0SVpuNElTNEUyRkxDTFgzemUwTGVJY2V6ZlQ2VEQ2?=
 =?utf-8?B?S1ZGeFg5TzBEQ1NSK1FxSytjNG9UNmx6Nmg5ODFyd04vOVpKbzhtWEcvU1Vz?=
 =?utf-8?B?UHUwYzJxTEQvVkpuV0FwZHh1VmdqUncrSnBBVVRQY2VWNnBFU3Fjd1daK01R?=
 =?utf-8?B?aWR3QnhBcDRyYWROVUlYdzc3MlNwTjQ3QWwyK2FhYitIcTZBdCsrS1dRVlNN?=
 =?utf-8?B?bVByYnBGd0x3Slg2TDBRanl3Uk5PZDBhR2dMZEU0VFVjd0lTQm8xc2ZobCt4?=
 =?utf-8?B?NXp5cTlTZUxtSTJHVmxQcjNoLzZXNncrV05wNVplbG1qcjJGNklhVWtVRGJ2?=
 =?utf-8?B?K3RHR3E0TDZVb3RIMUFSbHplOENlNjM1UUxFTFB0ek5rWUI4TUZmSllNVmla?=
 =?utf-8?B?cm5odDZWaVN3Ky82MFlHRW1IMzZuU1o5TUs4U1ZQV013aW5NRXhQWURFbkVJ?=
 =?utf-8?B?YjBFMVJ6a3lka0YzVVR2NmxmSTRsNHFpSDdoaVMxUnFiY0hDV0lFOU5hV1g2?=
 =?utf-8?B?djB4d2ZnSkozYk8xdG01T0k2K2JrbmQ0d0JORlozK2o1cVk2RUVaMTlpcjhh?=
 =?utf-8?B?K2RjNmwxZVNQR1BjNXhFV0JXc3YrcTQ5d2VmR2VrU2xsUVIrVkdwTjhJdFBj?=
 =?utf-8?B?QXRxbitxbUM2bTMxaVVUMzdsTXFNWkhrck5ScHpLc3hjNktPNnFsbVR5Vmtm?=
 =?utf-8?B?MGo1RzhXU2F6RkpYQVlSQXFScEQ3dUpyeEt6Z0pCNFRSZlozN2taQUVZa21k?=
 =?utf-8?B?TElIWk5zeWZ3ZzBSdXFvajhXdDJuNVVjaVJ0OFR2dk5NbFUxN01tSUFJOWxq?=
 =?utf-8?B?UmJFWTBReEdUcHErVHprdnZ1Ymd5SHlLOWhCZWsrSk1pR3hpT0hMQ1NEcUJ6?=
 =?utf-8?B?Y2svbUNMQkpXNHdITEtQNjRaTlFiMUpRTGRjQmFYbFUzMGtzQkdVNEIxR00v?=
 =?utf-8?B?RkRaVVBGYkpMZzhabU9XczdzTnNLYzFzaWpla1ZQNWNlNG5DMDlaYXp3YVR0?=
 =?utf-8?B?SzZYWnFDT1hjQkE3VGxVSkVVeml2ZHF5Yk90WlRLM1JwMGQwemVWWU9jREJz?=
 =?utf-8?B?REgxT2FRUDBLaitqR3lhVFQzYm4ySHdEejdMSUhKN0hGeFk1VUkyL3Q1VlUv?=
 =?utf-8?B?akNJYUlrMHlWSlNxdWswLzRnVzVvem11RDZwTE9ZQyt3bVQvS1lEZ2RBQXA4?=
 =?utf-8?B?SW9YYUcxdHMveklKVVV6MHpZWk1JTlpIQ3p2djJKamxaVkRHaS9DY3U1cElj?=
 =?utf-8?B?MHRqOWZqZVVmYURGQ0h6aVJvY00zMUlOT2tCRHhNdDFvQmg1a054WXUxd3F4?=
 =?utf-8?B?TDQ4LzIxQ3pjZ0V2NzNuUVdjTDZSRnpUUUs4cnQxUkVLN0tOTXExNUZ2c0Zt?=
 =?utf-8?B?RDlpQlNRdVdqZy9jVmtWUmlnOEszZXRtODB2V3kxMGw5Z3p0eExHY0pSMGda?=
 =?utf-8?B?ekF4SXJlOWpSMGhiUmp1eUpVRjYyUXBVdWNmNE9YZzlPTnFySWhSV3VOTFND?=
 =?utf-8?Q?GtQ4b9euYdaCA4UsD5sd4FE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa63f146-d9c4-4944-6152-08d9b4636487
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2021 00:42:03.2027 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bZVdJ023IMxWL4CTBlS0dtPQ6N//1dyR4uklbKtEECzHrEGKaYzwD9+2wUkWPLBd5OZkCytQcjzdQ1pMzQZN7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5179
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

Am 2021-11-30 um 3:13 p.m. schrieb Philip Yang:
> svm_range_bo_release could be called from __do_munmap put_page
> atomic context if process release work has finished to free pranges of
> the svm_bo. Schedule release_work to wait for svm_bo eviction work done
> and then free svm_bo.
>
> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 36 +++++++++++++++++++---------
>  drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 +
>  2 files changed, 26 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index f2db49c7a8fd..8af87a662a0d 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -327,11 +327,33 @@ static bool svm_bo_ref_unless_zero(struct svm_range_bo *svm_bo)
>  	return true;
>  }
>  
> +static void svm_range_bo_wq_release(struct work_struct *work)
> +{
> +	struct svm_range_bo *svm_bo;
> +
> +	svm_bo = container_of(work, struct svm_range_bo, release_work);
> +	pr_debug("svm_bo 0x%p\n", svm_bo);
> +
> +	if (!dma_fence_is_signaled(&svm_bo->eviction_fence->base)) {
> +		/* We're not in the eviction worker.
> +		 * Signal the fence and synchronize with any
> +		 * pending eviction work.
> +		 */

Now that this is its own worker, it's definitely never in the eviction
worker. So this doesn't need to be conditional here.

I'm thinking, in the eviction case, the extra scheduling is not actually
needed and only adds latency and overhead. The eviction already runs in
a worker thread and the svm_range_bo_unref there is definitely not in an
atomic context.

So I wonder if we should have a two versions of
svm_range_bo_unref_sync/async and svm_range_bo_release_sync/async. The
synchronous version doesn't schedule a worker and is used when we're
sure were not in atomic context. The asynchronous version we can use in
places that may be in atomic context.

Regards,
  Felix


> +		dma_fence_signal(&svm_bo->eviction_fence->base);
> +		cancel_work_sync(&svm_bo->eviction_work);
> +	}
> +	dma_fence_put(&svm_bo->eviction_fence->base);
> +	amdgpu_bo_unref(&svm_bo->bo);
> +	kfree(svm_bo);
> +}
> +
>  static void svm_range_bo_release(struct kref *kref)
>  {
>  	struct svm_range_bo *svm_bo;
>  
>  	svm_bo = container_of(kref, struct svm_range_bo, kref);
> +	pr_debug("svm_bo 0x%p\n", svm_bo);
> +
>  	spin_lock(&svm_bo->list_lock);
>  	while (!list_empty(&svm_bo->range_list)) {
>  		struct svm_range *prange =
> @@ -352,17 +374,9 @@ static void svm_range_bo_release(struct kref *kref)
>  		spin_lock(&svm_bo->list_lock);
>  	}
>  	spin_unlock(&svm_bo->list_lock);
> -	if (!dma_fence_is_signaled(&svm_bo->eviction_fence->base)) {
> -		/* We're not in the eviction worker.
> -		 * Signal the fence and synchronize with any
> -		 * pending eviction work.
> -		 */
> -		dma_fence_signal(&svm_bo->eviction_fence->base);
> -		cancel_work_sync(&svm_bo->eviction_work);
> -	}
> -	dma_fence_put(&svm_bo->eviction_fence->base);
> -	amdgpu_bo_unref(&svm_bo->bo);
> -	kfree(svm_bo);
> +
> +	INIT_WORK(&svm_bo->release_work, svm_range_bo_wq_release);
> +	schedule_work(&svm_bo->release_work);
>  }
>  
>  void svm_range_bo_unref(struct svm_range_bo *svm_bo)
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 6dc91c33e80f..23478ae7a7d9 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -48,6 +48,7 @@ struct svm_range_bo {
>  	struct work_struct		eviction_work;
>  	struct svm_range_list		*svms;
>  	uint32_t			evicting;
> +	struct work_struct		release_work;
>  };
>  
>  enum svm_work_list_ops {
