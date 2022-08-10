Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF577C00140
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Aug 2022 19:20:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D0D3112860;
	Wed, 10 Aug 2022 19:20:13 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D06CB90E74
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Aug 2022 19:20:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vp8LdNoKvoWG+jnAV1jzHZ1skGi/Aekt/DcfgkVX58Z0zZqJGljT5je+EqJs73YeAmN/dFN8wIZQt28UqfiHrPyhB18l35aqfeZEZFzbcijH49IBKQvR3HvBbCOgl01xenfxj3W4vSxXSZFtr12uFjAVV5x0FCUcJlKoZByRwitKpmv5W2ti6bgwdH2uTMRYVHBN9WHNIbf0iLtXQ2csK4LT2FlaJ4wSbrm71pDgIv07a5TTYbfkhDBCt3tIP2fjXaHbORBgApe3knpjv6GsvUcgY8qQEnFFFQKWYRv5xNiuuNoyCa5VNkMuJ8MJdZevGBkTo3w8OQ3z3a5fR/+g0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yxF43PGLN892z1pd+MuVxKT424CsokaK7rV9Z/iJU/s=;
 b=S5rHVgt9Hc22fYb4+ngx0hOnorDFVu+eQckcI/dHprS7Sp+g0nJ7FNhTDf6pIT7l1pnSxdGVc9APkSl0iAWknhNa3B5e0/OKw8wTuas89YiBOye8UpWRKk5DRtT6JKPZU5deLuTKPlp4qDAivpXgzwdH8x6DzT43b3H19KZwCmKPp+SEN8sPRx2ER8oFKGVrvluBOS+K81hPbFtE9UVULaD31ixfVPvne7MdQOC/QbmiN0PmyviIJM1vLi/ZFg0bGfqCFIileKZRF3N9ltarPbevBqDZJxlzlfDWrAce3WmihC6OK/j6uD2U/DPzR+/HJMvJS8Ns1v/5OaFFh14Tvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yxF43PGLN892z1pd+MuVxKT424CsokaK7rV9Z/iJU/s=;
 b=MX9wyyHTCuGRJYjQnaTvAVc9aHHJa+XwWraRgNZyB5B3dlc6v0VkWryrE6uYaFD1roryauBGVcOUz9HD6YkfYwRMcHTvyMISClrKqAJAXVauz2pP9k8Ox1X+QFCYBB5oCi26AALxOoW5yi4kMbcvPEhL8HU/zSDy71mCAryyeoA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5149.namprd12.prod.outlook.com (2603:10b6:5:390::14)
 by PH7PR12MB5783.namprd12.prod.outlook.com (2603:10b6:510:1d2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.20; Wed, 10 Aug
 2022 19:20:00 +0000
Received: from DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::252e:b6db:2d4b:b922]) by DM4PR12MB5149.namprd12.prod.outlook.com
 ([fe80::252e:b6db:2d4b:b922%7]) with mapi id 15.20.5504.021; Wed, 10 Aug 2022
 19:20:00 +0000
Message-ID: <2e06b1d4-d5ce-3057-d1c5-4dc708541525@amd.com>
Date: Wed, 10 Aug 2022 15:19:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] drm/amdkfd: Fix mm reference in SVM eviction worker
Content-Language: en-CA
To: Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
References: <20220809003838.684180-1-Felix.Kuehling@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <20220809003838.684180-1-Felix.Kuehling@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR01CA0038.prod.exchangelabs.com (2603:10b6:208:23f::7)
 To DM4PR12MB5149.namprd12.prod.outlook.com
 (2603:10b6:5:390::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: da485306-2d2c-4be7-fe4d-08da7b055183
X-MS-TrafficTypeDiagnostic: PH7PR12MB5783:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8lef4kRr6NQHGiqrPyCmlsWZdVFChmasdsdEnLpXyKPPlHK5iS6d0LoXjCcchBS1Vr73W5x07G9WB0XpMyyNuoFuEaUkTWWAWlpknkstDsLSPuYR2RnoYo+O6UaVcJUV0uIWeTFpNsex3uXapZIBp5vzeo4tXcMvSZifJmViAB1dY+Bhson5N8aAiCMtTL54Zr2rWTavwacAp08kZ5ntmJ5gK/QR/qBiJ4lXOJibRfokTGks/sPT6/ZzZDJKkJclyZhoogMVLcVrtkGoiGA/fwjbTL12ox+69gMZHrwPLJzRhsFqCrmxOX1jZj8A3lsPT8Y1yVh7Xd/AmLW/+jWpsiMQvAFoHo+mpIQR9nvwfuPKww+NbJJ7TEFh1OmTXPPYHudeCpW+hLJ/JOCMN8c4cmiE5I4aCAQifJcHKTT4UCJN8ZsPLs+S9O15SkFcZTJ5oeh+8Bn3wkWtfQjNXfPz+T2I0FkcZATwf/F8HGe37J42cC06LtPtFog8d35b/VUvfbZu41pe9wWLCvGeK0/5mlWv/NEpkN/x31j4gTmPfsY/QTpEQqO/otXcHQjKWBF4FBua8kGh0NzD3pgOuDLArnTPXuKw/5g/jDn7oaCleKr6pkokF3ymNa+LB4cbY9hz6JrBMnsJlba+qmhaSyk6iGhzqB8UWufBGDWKrYuvaovAkz5uTBj3urdv7BAep361r64+sNNa6iJecil7h4XvvTdtmC3+rwCvV9Wt6Sp36wZQuI013M+y5wFTTkK5WtQ63MoWsetnLbINz3lRZxlI1vTUH8s2b4fUqo+aIHZS+1ikWdo37HvGsrSIBHDL7S41lt50PqmLioEkHK6U2Gv3JA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5149.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(376002)(366004)(136003)(346002)(39860400002)(66476007)(8936002)(66556008)(66946007)(36756003)(4326008)(38100700002)(8676002)(5660300002)(478600001)(186003)(31696002)(53546011)(6506007)(41300700001)(26005)(2906002)(316002)(6512007)(83380400001)(6486002)(2616005)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NGFSTjdWaWVOWVVzM3ZYenA1WUdnS04xZmpXYmlxOUZWOWwvaEIvdGR5bERn?=
 =?utf-8?B?czJZNWsxc0JJSjF0N0gzc0kwRlNWakt6UmxrUU1mOGtsT1pIUXh4dk5ZWnBH?=
 =?utf-8?B?YU9kbGszZFdyNzhsSmgzVlBKemFvbUNqYkl0U3BURzU0MnJPd3JST3B0eDFJ?=
 =?utf-8?B?WVpxcllaM093b1dDUEFRQnI0Uml6dmtCSW1RMEtvOU4vL2dmeDBYK25va2Fo?=
 =?utf-8?B?dm1IczludjlvNkNkYjE1VlRhNy9SbDl3cmNaMWp2eUxHckRTQkxWUitBVnBR?=
 =?utf-8?B?dFpGeitHdkQ3M3hjN0VDMXNKbW43dGEwbGZuMFF0UDZ5MWUrZ1ZySHJwTkgv?=
 =?utf-8?B?ZGgxVlVQWnh5eUxMMW1xQVJKcTQrZlFxeDZwempHVzBURzF6dUV1dkErMlR3?=
 =?utf-8?B?Y2Z6aHBEbklqYXZhcjVTUGdrVXJOckQzcTJ5d2c4bjhCbmwwTzNBSUFHdmhG?=
 =?utf-8?B?bCthZWJiSVF3MUlqdXZ2Z2hpUUVPRWd5ZmtTUTVZeldrZTRyM2oxVENqWE53?=
 =?utf-8?B?QURsR0QrSVluR2VLWjR4SUNWSnNSbWl0R0JmeE1zN0RjZlhDMlloSm1TVVpP?=
 =?utf-8?B?cCtQbTVScFJZT2VhTDFnMGJ6aDA5UWI5WU40SlNoZ3B3bE1RbGl4U295VXNK?=
 =?utf-8?B?aUZPRTlJcHNGbU9QNFcwVU1uWVhLM3R0cVFzWVRDMVVRUzlQb1ZuT0pRd1Jh?=
 =?utf-8?B?ZmdSN3Urd1J0ajZ5N3JUQWVWc0t6OXlKaUQxeWVqdXpwQWR3RVk4bmZIc1JQ?=
 =?utf-8?B?am5iRnNLOUZKZ0Q5V0J4K2VNMFJDaXJxK081eTRxRHFEaE5YMHJ1dUxDb08z?=
 =?utf-8?B?SExXMUpHaVJ3bzFZOGtaVDN4TisvYW8ybXgrV0Z6YlZnY2xBOG9sUWdiTTJv?=
 =?utf-8?B?ZXRUMXgydlF4Y0oyTExyczRsWHZ1RnZFTDlYM2UxSjR0djdTL1FIalhXTEIw?=
 =?utf-8?B?dG5tNzIvQTFtWWRKVTV2a0NvTGVmbXlzb3FLcHJHTit1OGdmcmJlTjlPdThy?=
 =?utf-8?B?Z0dRcHpIZ25mNWpVVTZkYUZwazEzZDBKTFVCaThubjdtYkJQclk4YW5zcjFY?=
 =?utf-8?B?ekFpSmVybGlFWTcvMFUza1NrL1J6NXBVMlFocEQrWWF1OTUzWG40UUNCNUxM?=
 =?utf-8?B?bWdNQU5yWEF6c2pWcHBJZnJuV3lYdkJXeGhGaUlZck8rU0drVklFbWFQMERC?=
 =?utf-8?B?Z0NreUVvc1JVdTNVQi9HeUg2czVrUGV2bmdQanVHcHM2Rm9XMmNJZnlJV0po?=
 =?utf-8?B?cVhyUXVhOFRVOHpHV1FVNWYyTzA2YmI5bWRVWUpjaURIaWlmb09DOFFHK2Y2?=
 =?utf-8?B?QWxQeFR2aWw1UFFDQ1FDbkkwRXoraEdxb1FkSER0UkZkRzdiVzArMnhZTG1a?=
 =?utf-8?B?bnNpVkF6NlNxSnpWZkJtd0JVRkdnbVVLNG5NU3RmVnpFL3FnMTVJdkRaZFdQ?=
 =?utf-8?B?NG1oQXh1RHU1NnplTDU4UzJVNVljVzA1Wm5xRmxzQ1ZGZmF4eDdjZjBlcEV0?=
 =?utf-8?B?WWFQTFc2R0xUVFVKNmFtUCtVK0pHZm5pdWxwalA1RFljWUpaWG82eE1RRUxp?=
 =?utf-8?B?ZzNPcnc3VFByUStFSTlzMklsS3A3WGV4bmJaK3BqOUJKWEdNSGRmSEIrVDdC?=
 =?utf-8?B?NjhSOUlHMnFZSDVTOHlZVlV3Y1FJNktlejl3bGFuZmxzbjdta2tBRXc4Y0JM?=
 =?utf-8?B?eW5WbmViQ3BLSTRhRSsrdnBVRFZRaDdCT24wN1h3QS9IRWg5MzJiWXd4bG9R?=
 =?utf-8?B?U1JlMlpScW9TUjE1b1piYk43Tmg0bTFWOHo1UmNscFJiNWJHdXVIN0RPZ1dj?=
 =?utf-8?B?NW1xV1JCb3VhZlNJN3N6WW54Sk9xalZad0J3TkRLV2kzaC9ZdWNzc201RkI2?=
 =?utf-8?B?SWR5Wi9NM1VpbUJKS3VQNUFqcS84cnNiZXpwRkZIQys2NjJHTjFuRzJQaGM2?=
 =?utf-8?B?SXRWY0kvR25SalNwcFdFVWpjRFI1cHlmdUtySTFOK3I2QU4rUzZaRU1ZdkR0?=
 =?utf-8?B?NDI1bWQraEIvM3BsaTA0dFR5SmpMSDRlMUM0ZnNuNUZjMUZXSVY1TnA4WlhK?=
 =?utf-8?B?cjJwRnI1ZDFYM1FSYktnaEs1NGtOVzZNNEo1SHFuM2lVSkZQRUNBMGR6UytX?=
 =?utf-8?Q?YXXadgNTAOzv1CahvgmS0VHb3?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da485306-2d2c-4be7-fe4d-08da7b055183
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5149.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 19:20:00.0253 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3FZJEZ905BTwenqaEJH7DmYKhKI1rHUzWigERPGB+yeoM7Ur/2sKrG6FEvyZKpM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5783
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
Cc: philip.yang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>


On 2022-08-08 20:38, Felix Kuehling wrote:
> Use the mm reference from the fence. This allows removing the
> svm_bo->svms pointer, which was problematic because we cannot assume
> that the struct kfd_process containing the svms is still allocated
> without holding a refcount on the process.
>
> Use mmget_not_zero to ensure the mm is still valid, and drop the svm_bo
> reference if it isn't.
>
> Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Philip Yang <Philip.Yang@amd.com>
> ---
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 17 +++++++----------
>   drivers/gpu/drm/amd/amdkfd/kfd_svm.h |  1 -
>   2 files changed, 7 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> index a67ba8879a56..11074cc8c333 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
> @@ -541,7 +541,6 @@ svm_range_vram_node_new(struct amdgpu_device *adev, struct svm_range *prange,
>   		kfree(svm_bo);
>   		return -ESRCH;
>   	}
> -	svm_bo->svms = prange->svms;
>   	svm_bo->eviction_fence =
>   		amdgpu_amdkfd_fence_create(dma_fence_context_alloc(1),
>   					   mm,
> @@ -3273,7 +3272,6 @@ int svm_range_schedule_evict_svm_bo(struct amdgpu_amdkfd_fence *fence)
>   static void svm_range_evict_svm_bo_worker(struct work_struct *work)
>   {
>   	struct svm_range_bo *svm_bo;
> -	struct kfd_process *p;
>   	struct mm_struct *mm;
>   	int r = 0;
>   
> @@ -3281,13 +3279,12 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
>   	if (!svm_bo_ref_unless_zero(svm_bo))
>   		return; /* svm_bo was freed while eviction was pending */
>   
> -	/* svm_range_bo_release destroys this worker thread. So during
> -	 * the lifetime of this thread, kfd_process and mm will be valid.
> -	 */
> -	p = container_of(svm_bo->svms, struct kfd_process, svms);
> -	mm = p->mm;
> -	if (!mm)
> +	if (mmget_not_zero(svm_bo->eviction_fence->mm)) {
> +		mm = svm_bo->eviction_fence->mm;
> +	} else {
> +		svm_range_bo_unref(svm_bo);
>   		return;
> +	}
>   
>   	mmap_read_lock(mm);
>   	spin_lock(&svm_bo->list_lock);
> @@ -3305,8 +3302,7 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
>   
>   		mutex_lock(&prange->migrate_mutex);
>   		do {
> -			r = svm_migrate_vram_to_ram(prange,
> -						svm_bo->eviction_fence->mm,
> +			r = svm_migrate_vram_to_ram(prange, mm,
>   						KFD_MIGRATE_TRIGGER_TTM_EVICTION);
>   		} while (!r && prange->actual_loc && --retries);
>   
> @@ -3324,6 +3320,7 @@ static void svm_range_evict_svm_bo_worker(struct work_struct *work)
>   	}
>   	spin_unlock(&svm_bo->list_lock);
>   	mmap_read_unlock(mm);
> +	mmput(mm);
>   
>   	dma_fence_signal(&svm_bo->eviction_fence->base);
>   
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> index 9156b041ef17..cfac13ad06ef 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
> @@ -46,7 +46,6 @@ struct svm_range_bo {
>   	spinlock_t			list_lock;
>   	struct amdgpu_amdkfd_fence	*eviction_fence;
>   	struct work_struct		eviction_work;
> -	struct svm_range_list		*svms;
>   	uint32_t			evicting;
>   	struct work_struct		release_work;
>   };
