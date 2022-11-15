Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF25C4332F
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Nov 2022 18:15:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14F6510E134;
	Tue, 15 Nov 2022 18:15:13 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6693210E0C9
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Nov 2022 18:15:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IzlPNA8SR6JTDcm07lotWe9wfTDkT565b8c+E6QW3nbs9EXGplzCcmX/aWzX6p0TUV100J1JUh/BxiYA/v3Q4jWvXnquhRG3kPipgXiF4d0oUrA1rNx9hGkdoDTINN+qe6MBSEFjUmpv8blazraFeLIJBVg6aNg/h9tW5NKx2n357yNe7zbK4rpg9EajfutMx9Iumh1Ejhql4IZ2vJnKxBmgTlL8TBa/5ffjlhOWhkvgoVyYZ+ZCpH6AvU7kFgp7RVgDyLKtC9Mof7rc3JSE2xjuE5c2ew0nAuKkuYgVAWtgwfFOw+TuKgprCBHvNMszigVdT3A/e3SwJA8ud/ISUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rwxm1VO47MFu+ZqLgo+N0tbbQGJIOOQ4HSpKpu+bW94=;
 b=i/OhkisvRHsc+OmrKuHVVfe9rVBYL963e8Z4qy1DYHmztjhMLjsF7PzX1w9M5mSfrnPDkw6yVX98qm57fEtlX22PDCssxaCXNPkzzmAfmtgkja1Na+ruJSqHziey8TD/c5NbmpnHz66qt9wlzoCs2VNcG+CNxBr6BtYcz19qlHRWY7psSCeh62ceMrlhMSOkzepBjPf3pb4PegN1JjDIKJ/qBZq3QfIXmOoCEvP09x4DPD2whqsDzWa+JlV4eDcs/4qQGFsNUufrtiZkR7g1Lhmi86PQfQDBzlijB3ai5qTE13DKYje5fXmJxieaepc1nnREv1v3Pog9DrNuGRGQWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rwxm1VO47MFu+ZqLgo+N0tbbQGJIOOQ4HSpKpu+bW94=;
 b=tgtuv346wzXiWAT3tkqb+d68mbgIjoSe67qXIqeV0tR1XfEWG2JJuQ+b2y6I+habnxKDkqCcjHdxQtVpNEG3hTjx9acXb+ZueiIIxZRH7YLLc85Kl9ssMZolBKrBXw97ZEgsW7lrqMTtXl6Yi6Du73u3lXMZYeNBaBDc730xrrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN9PR12MB5115.namprd12.prod.outlook.com (2603:10b6:408:118::14)
 by CY5PR12MB6597.namprd12.prod.outlook.com (2603:10b6:930:43::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Tue, 15 Nov
 2022 18:15:07 +0000
Received: from BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350]) by BN9PR12MB5115.namprd12.prod.outlook.com
 ([fe80::5d8:f3f2:d940:5350%3]) with mapi id 15.20.5813.017; Tue, 15 Nov 2022
 18:15:07 +0000
Message-ID: <61113d03-aaba-495f-c0e0-908fa6fe0b7f@amd.com>
Date: Tue, 15 Nov 2022 13:15:05 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/4] drm/amdgpu: fix userptr HMM range handling v2
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <ckoenig.leichtzumerken@gmail.com>,
 mikhail.v.gavrilov@gmail.com, amd-gfx@lists.freedesktop.org
References: <20221115133853.7950-1-christian.koenig@amd.com>
 <20221115133853.7950-2-christian.koenig@amd.com>
From: Felix Kuehling <felix.kuehling@amd.com>
Organization: AMD Inc.
In-Reply-To: <20221115133853.7950-2-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR03CA0018.namprd03.prod.outlook.com
 (2603:10b6:208:23a::23) To BN9PR12MB5115.namprd12.prod.outlook.com
 (2603:10b6:408:118::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN9PR12MB5115:EE_|CY5PR12MB6597:EE_
X-MS-Office365-Filtering-Correlation-Id: b7aa212c-3073-4415-a358-08dac735534a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rwTF1AeQwdz2qvF70/uC++7teAdxWFRfdK8p7RH9d/wMtTpWg8UCpSl8e84D8b6X0wbDjUX/+uJLRj1FWT87LAvrUqrIPbgYer1ZwdzGfprgxSn+/aeCldwp4dJKBg9OH13/xh45YHw7K/5DJBs9fm/3ARTcjqsNJGdzWm5P+K962gVxpx6SPundbns91JyER2wjtowMkeFuZnxVceFGEaXE+k6MASErPTPI8AhYIxRKai36Q3YtJ0ZTE5VmTJg7CZyDz7AWJZmEl9TbZkmFXym2y4080UuUXy2wg3t8NwCPoFKyL6T5PDZd5WScW3V068Jog0Q+fbEmr91zQFdPUCPwconrwCOKqIzXnGIbSLK7Wz6/O7PZCGD4c1XLknzmQ9YwejNhV58BxiQccseSZ2jrclJ41ETc/HM6CkwwszsgOldTeh5ZTzgwmrPdzJ84tmKN+WNwbWB5FH8955jeH2qEee8MithU3W8ZvVk4Y8Gy8qWN40R6B+OIbvVIjLSodHk+f6xwM1FhMeKvkbsMWA2WoQ16JXPjDQgKQh5xCJwCMPAoIIJpz+UIT06cZ9IWvFTUfC9If2cPQVL5OjKWw2HodGgSj5KrQ6UllHnI4mad4VVo+4soBw4jz/mJ0NHQRUK19wbomG6OkiHsHs1S/W/BdhLuA819uZvv6+SjT4RXIn27v6brVg6byDrSnJPQaLaoehRrFOU/1F4jV2DzGXc79VKxjr9R1YD6ft+zLSYiLKqguE2Hbpi77PD8vCXmUpwWnh79uOGQHFRYeF1w+BLGDe/guZuMf8wjdcdwqZE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR12MB5115.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(366004)(346002)(136003)(396003)(39860400002)(451199015)(2906002)(31686004)(41300700001)(66556008)(30864003)(31696002)(53546011)(6512007)(6506007)(86362001)(26005)(44832011)(8676002)(8936002)(66946007)(66476007)(4001150100001)(36756003)(36916002)(6486002)(38100700002)(66574015)(5660300002)(83380400001)(478600001)(316002)(186003)(2616005)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?LzdxMzFnMWVlR0VTRE8vZU9YWUV1ekw0cEJpajhHMmhGZVZuTE9xMlFmTEZ6?=
 =?utf-8?B?Tko5QnJuZVhrU2xWREUwWGJDWlpHMWdKOGJpZkJSbytFaTBOMzhPeDhwd0px?=
 =?utf-8?B?SytxTm5QSC9xeTF0Vmk1VHBHRTk4VTVpdVdhMGM2KzVOK2Z0cU5aZVM4ZDZJ?=
 =?utf-8?B?dVU5MTFza0haZXRUMmhFYk9Hc1RRaHBYYzA3RnRSYzIrMjdQbTJQWmhRd0xV?=
 =?utf-8?B?ai9YY3dERnkydG02QlI3dHBEN2dpaUU2Zkc4TDZiZFdtZVlXWVlzMGRyNzJa?=
 =?utf-8?B?QkU4UjBSTE9RMUlBNmhKVnoxSkhUVUxjWDZwcXRUaG4zKyt2STIzcXVFNmN0?=
 =?utf-8?B?OGFhaThyaGlnd3p4bVowN1ZFOCtaZTZkMnV4dWwrb3QybDJjeWQ1OHEzVG5a?=
 =?utf-8?B?RlQ1VS9VODBDZG9WUWlFUDRFelVzeFh5ZzUyMjArWFVYNzNSckpOVEJtcTFL?=
 =?utf-8?B?akswSmgzam1aZEFqZGVOMEU5WTBuOU9oc1dtd1dUaDJCQld1Z1ZFY3dSVlN6?=
 =?utf-8?B?VjJmZE03eThSRWtESnRJUk5Fc1hVdFprN2NqWnk5VGdpSmxSYmhkd1N5U2lt?=
 =?utf-8?B?NUhqcUhzVlZZTWRoaTMvUDJQakl5bUZZQmVrYno5eUR0Ujk3OW5udjA1bkp3?=
 =?utf-8?B?MHhZWDNxdlBSTy9MUEQvRXJ4NmkyWGRPbzBkSW9uU1FiNWkyNm5YdlhvQzVr?=
 =?utf-8?B?NER5VkV2c01DVlpIN0FTaVdvNld0YkRhL3A5VUdOdkZ5MnRLMlU2WjVnYTZp?=
 =?utf-8?B?ZmpWUnh3dHhrQTVJYzJETW82VmtaRTBXeC83bkNPdmNSTG5GRmU5ZS9qWHUy?=
 =?utf-8?B?U2pZcnltUnFlV0I2dG4xQnM3aVVlNm9EcUZYT0Y3U2FxQ2FqOG1ZUEdxWm8r?=
 =?utf-8?B?aC9KNmdjU29FMGo1U0h5YkZKR0JQbVhKQXBESTN5NjQvUTIzSzFxUEVEN2Rr?=
 =?utf-8?B?L3VJWEZpTmF2SWZSZytZQ3JFV3RxenVCY1BoTGg4RVVBS09BS3FsQ3VjVUxl?=
 =?utf-8?B?b3EraUNjaDJHeTNvSmczWFNEelN6eE83MHgvQjdwWEw2U2hJSkNsczRWNjhL?=
 =?utf-8?B?M2pNTE14anVxaFhIdFlFcVg0YlVIR20xbEhiemhGNWxhRkhkSUtBamJtZldU?=
 =?utf-8?B?Qk5pR2pOcDREdS9wcnovWEkyR2R6K25Xd2wzWFgyMjV2cnI0dHJKWm9JUklL?=
 =?utf-8?B?NmNzS01yOHYycTlsTit0cSsrV1dlZ0ZZYjNwUmxPSlZ5OFZEUTZqS24zRG15?=
 =?utf-8?B?Zzd4WW5QMVRHdy8rY0ZkNlFiT2hOL0NMcW56aks4SFBjQlp4MUN2UnhwN0lr?=
 =?utf-8?B?QUdVNkFMY2lPN0tiSXZsWmIrSXpjRHpubWkwSWpMcFJtODB3d0Q3a2pmSnpK?=
 =?utf-8?B?NEFSTVkvdmNaNGxlSzVyZ1RaazJ1VlRBMHhPU1JWekxHeWJjd2lWVzA1dWFY?=
 =?utf-8?B?am9RMXdIajZMaHA4a3NuSzlERG82b01UUUhmQk5lY1hXZ1JZc2R0ZU5RcVB0?=
 =?utf-8?B?Y2xpWnl5eUJEeGMvWlpXYUlRUzRLMkpqNlhZQ1FvVExsNVRLR2VIaXYvbWdT?=
 =?utf-8?B?M1lKcUJXa1pIM1J1cXhPb2FhTisrMVpZUGJ3Z3dzSlNrS3FKZkhXQVIxQ2NK?=
 =?utf-8?B?Z1hwU1VTYlBIb3BaVmZtamtUWVNLTkozbFVNVVhXTWF6TWNld0NVeEgrSjZQ?=
 =?utf-8?B?OXNiYlR5M2VwN1l1OFJkbCs3aFdOOUNvYVhnV1hVUkJtRmg4VjFLZU00dllq?=
 =?utf-8?B?SlJOcFFPSk1xWHVnSGsrOVFBNkIwenljQW5MejhxaVJneSsrRGdYQVhBNkRO?=
 =?utf-8?B?bm5PNmZoWGNER2JhU1VtcmhZYzI1ajVJZkhoWTRqVU1Lb2VtSVlhUEV3am5j?=
 =?utf-8?B?bDhoZXltTklWRGhzRDd3QXVUaXpzbkFmYU8rR3Y5akNOQnlobkN1ZUd5eWpE?=
 =?utf-8?B?SEt2MXNpajRDTHdzbXhOMmZVU3BQbnhCbjM0QytiZ1JDOUxUYm4xWHpDdGFn?=
 =?utf-8?B?TDJmS2dBeCtrRDVuNnhMcHMvR3FPWVhtNTVhNUJpeGJLcWJpZzJpcVF0Y1Q5?=
 =?utf-8?B?MmU5SFIxMU8rWExBT2RrTFYyV0hYaFdsZWJaYkRDaVM4T3pHZkthZFp1UTJC?=
 =?utf-8?Q?+Na62p9RiG1CS2DUbbxhvEsHg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7aa212c-3073-4415-a358-08dac735534a
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5115.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2022 18:15:07.2347 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: weFxv6vgWG0y0D7IKTIBDMbVVip+TkDHl4BIw3kQeCulaYdVWp6SnJtpe/UfRwwU+kOt7ijV1GscwFQntAKd4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6597
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

On 2022-11-15 08:38, Christian König wrote:
> The basic problem here is that it's not allowed to page fault while
> holding the reservation lock.
>
> So it can happen that multiple processes try to validate an userptr
> at the same time.
>
> Work around that by putting the HMM range object into the mutex
> protected bo list for now.
>
> v2: make sure range is set to NULL in case of an error
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Reviewed-by: Alex Deucher <alexander.deucher@amd.com>

Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>


> CC: stable@vger.kernel.org
> ---
>   .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 12 +++--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c   |  1 +
>   drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h   |  3 ++
>   drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  8 +--
>   drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  6 ++-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 53 ++++++-------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       | 14 +++--
>   7 files changed, 46 insertions(+), 51 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> index c5c9bfa2772e..83659e6419a8 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> @@ -940,6 +940,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>   	struct amdkfd_process_info *process_info = mem->process_info;
>   	struct amdgpu_bo *bo = mem->bo;
>   	struct ttm_operation_ctx ctx = { true, false };
> +	struct hmm_range *range;
>   	int ret = 0;
>   
>   	mutex_lock(&process_info->lock);
> @@ -969,7 +970,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>   		return 0;
>   	}
>   
> -	ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages);
> +	ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages, &range);
>   	if (ret) {
>   		pr_err("%s: Failed to get user pages: %d\n", __func__, ret);
>   		goto unregister_out;
> @@ -987,7 +988,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
>   	amdgpu_bo_unreserve(bo);
>   
>   release_out:
> -	amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
> +	amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, range);
>   unregister_out:
>   	if (ret)
>   		amdgpu_mn_unregister(bo);
> @@ -2319,6 +2320,8 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>   	/* Go through userptr_inval_list and update any invalid user_pages */
>   	list_for_each_entry(mem, &process_info->userptr_inval_list,
>   			    validate_list.head) {
> +		struct hmm_range *range;
> +
>   		invalid = atomic_read(&mem->invalid);
>   		if (!invalid)
>   			/* BO hasn't been invalidated since the last
> @@ -2329,7 +2332,8 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>   		bo = mem->bo;
>   
>   		/* Get updated user pages */
> -		ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages);
> +		ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages,
> +						   &range);
>   		if (ret) {
>   			pr_debug("Failed %d to get user pages\n", ret);
>   
> @@ -2348,7 +2352,7 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
>   			 * FIXME: Cannot ignore the return code, must hold
>   			 * notifier_lock
>   			 */
> -			amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
> +			amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, range);
>   		}
>   
>   		/* Mark the BO as valid unless it was invalidated
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> index 2168163aad2d..252a876b0725 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.c
> @@ -209,6 +209,7 @@ void amdgpu_bo_list_get_list(struct amdgpu_bo_list *list,
>   			list_add_tail(&e->tv.head, &bucket[priority]);
>   
>   		e->user_pages = NULL;
> +		e->range = NULL;
>   	}
>   
>   	/* Connect the sorted buckets in the output list. */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> index 9caea1688fc3..e4d78491bcc7 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
> @@ -26,6 +26,8 @@
>   #include <drm/ttm/ttm_execbuf_util.h>
>   #include <drm/amdgpu_drm.h>
>   
> +struct hmm_range;
> +
>   struct amdgpu_device;
>   struct amdgpu_bo;
>   struct amdgpu_bo_va;
> @@ -36,6 +38,7 @@ struct amdgpu_bo_list_entry {
>   	struct amdgpu_bo_va		*bo_va;
>   	uint32_t			priority;
>   	struct page			**user_pages;
> +	struct hmm_range		*range;
>   	bool				user_invalidated;
>   };
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> index d371000a5727..7f9cedd8e157 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
> @@ -910,7 +910,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   			goto out_free_user_pages;
>   		}
>   
> -		r = amdgpu_ttm_tt_get_user_pages(bo, e->user_pages);
> +		r = amdgpu_ttm_tt_get_user_pages(bo, e->user_pages, &e->range);
>   		if (r) {
>   			kvfree(e->user_pages);
>   			e->user_pages = NULL;
> @@ -988,9 +988,10 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
>   
>   		if (!e->user_pages)
>   			continue;
> -		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
> +		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, e->range);
>   		kvfree(e->user_pages);
>   		e->user_pages = NULL;
> +		e->range = NULL;
>   	}
>   	mutex_unlock(&p->bo_list->bo_list_mutex);
>   	return r;
> @@ -1265,7 +1266,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
>   	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
>   		struct amdgpu_bo *bo = ttm_to_amdgpu_bo(e->tv.bo);
>   
> -		r |= !amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
> +		r |= !amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, e->range);
> +		e->range = NULL;
>   	}
>   	if (r) {
>   		r = -EAGAIN;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 111484ceb47d..91571b1324f2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -378,6 +378,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>   	struct amdgpu_device *adev = drm_to_adev(dev);
>   	struct drm_amdgpu_gem_userptr *args = data;
>   	struct drm_gem_object *gobj;
> +	struct hmm_range *range;
>   	struct amdgpu_bo *bo;
>   	uint32_t handle;
>   	int r;
> @@ -418,7 +419,8 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>   		goto release_object;
>   
>   	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
> -		r = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages);
> +		r = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages,
> +						 &range);
>   		if (r)
>   			goto release_object;
>   
> @@ -441,7 +443,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
>   
>   user_pages_done:
>   	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE)
> -		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm);
> +		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, range);
>   
>   release_object:
>   	drm_gem_object_put(gobj);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 76a8ebfc9e71..29c22a27db80 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -642,9 +642,6 @@ struct amdgpu_ttm_tt {
>   	struct task_struct	*usertask;
>   	uint32_t		userflags;
>   	bool			bound;
> -#if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
> -	struct hmm_range	*range;
> -#endif
>   };
>   
>   #define ttm_to_amdgpu_ttm_tt(ptr)	container_of(ptr, struct amdgpu_ttm_tt, ttm)
> @@ -657,7 +654,8 @@ struct amdgpu_ttm_tt {
>    * Calling function must call amdgpu_ttm_tt_userptr_range_done() once and only
>    * once afterwards to stop HMM tracking
>    */
> -int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
> +int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages,
> +				 struct hmm_range **range)
>   {
>   	struct ttm_tt *ttm = bo->tbo.ttm;
>   	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
> @@ -667,16 +665,15 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>   	bool readonly;
>   	int r = 0;
>   
> +	/* Make sure get_user_pages_done() can cleanup gracefully */
> +	*range = NULL;
> +
>   	mm = bo->notifier.mm;
>   	if (unlikely(!mm)) {
>   		DRM_DEBUG_DRIVER("BO is not registered?\n");
>   		return -EFAULT;
>   	}
>   
> -	/* Another get_user_pages is running at the same time?? */
> -	if (WARN_ON(gtt->range))
> -		return -EFAULT;
> -
>   	if (!mmget_not_zero(mm)) /* Happens during process shutdown */
>   		return -ESRCH;
>   
> @@ -694,7 +691,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>   
>   	readonly = amdgpu_ttm_tt_is_readonly(ttm);
>   	r = amdgpu_hmm_range_get_pages(&bo->notifier, mm, pages, start,
> -				       ttm->num_pages, &gtt->range, readonly,
> +				       ttm->num_pages, range, readonly,
>   				       true, NULL);
>   out_unlock:
>   	mmap_read_unlock(mm);
> @@ -712,30 +709,24 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
>    *
>    * Returns: true if pages are still valid
>    */
> -bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm)
> +bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
> +				       struct hmm_range *range)
>   {
>   	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
> -	bool r = false;
>   
> -	if (!gtt || !gtt->userptr)
> +	if (!gtt || !gtt->userptr || !range)
>   		return false;
>   
>   	DRM_DEBUG_DRIVER("user_pages_done 0x%llx pages 0x%x\n",
>   		gtt->userptr, ttm->num_pages);
>   
> -	WARN_ONCE(!gtt->range || !gtt->range->hmm_pfns,
> -		"No user pages to check\n");
> +	WARN_ONCE(!range->hmm_pfns, "No user pages to check\n");
>   
> -	if (gtt->range) {
> -		/*
> -		 * FIXME: Must always hold notifier_lock for this, and must
> -		 * not ignore the return code.
> -		 */
> -		r = amdgpu_hmm_range_get_pages_done(gtt->range);
> -		gtt->range = NULL;
> -	}
> -
> -	return !r;
> +	/*
> +	 * FIXME: Must always hold notifier_lock for this, and must
> +	 * not ignore the return code.
> +	 */
> +	return !amdgpu_hmm_range_get_pages_done(range);
>   }
>   #endif
>   
> @@ -812,20 +803,6 @@ static void amdgpu_ttm_tt_unpin_userptr(struct ttm_device *bdev,
>   	/* unmap the pages mapped to the device */
>   	dma_unmap_sgtable(adev->dev, ttm->sg, direction, 0);
>   	sg_free_table(ttm->sg);
> -
> -#if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
> -	if (gtt->range) {
> -		unsigned long i;
> -
> -		for (i = 0; i < ttm->num_pages; i++) {
> -			if (ttm->pages[i] !=
> -			    hmm_pfn_to_page(gtt->range->hmm_pfns[i]))
> -				break;
> -		}
> -
> -		WARN((i == ttm->num_pages), "Missing get_user_page_done\n");
> -	}
> -#endif
>   }
>   
>   static void amdgpu_ttm_gart_bind(struct amdgpu_device *adev,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index 6a70818039dd..a37207011a69 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -39,6 +39,8 @@
>   
>   #define AMDGPU_POISON	0xd0bed0be
>   
> +struct hmm_range;
> +
>   struct amdgpu_gtt_mgr {
>   	struct ttm_resource_manager manager;
>   	struct drm_mm mm;
> @@ -149,15 +151,19 @@ void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
>   uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
>   
>   #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
> -int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages);
> -bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm);
> +int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages,
> +				 struct hmm_range **range);
> +bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
> +				       struct hmm_range *range);
>   #else
>   static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
> -					       struct page **pages)
> +					       struct page **pages,
> +					       struct hmm_range **range)
>   {
>   	return -EPERM;
>   }
> -static inline bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm)
> +static inline bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
> +						     struct hmm_range *range)
>   {
>   	return false;
>   }
