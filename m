Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D322FC88E4D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 16:54:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6413610E414;
	Fri, 11 Sep 2026 16:54:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Vg2S4yld";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012045.outbound.protection.outlook.com [52.101.48.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74E1610E414
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 16:54:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lwg04N89A269ZUOhY1JZ7cApa77zu+knGbbsrApDEV1O51HvWBcNP2r0maKtm5xxeDluHaK4/QLTarusR7Wl3PIeaLi8CIiEr+ndneA3xH7hnhaaQ0duGQyyr2Wxr5tLrhlAjoi0EAnfomUJYwi08meivOLPwBhM+g80WxgkdNw50KbosJ73+H8lU/PT24E5aH1zFGdCBY8ZJ9A8fuje/7XrVt7nVfYnO27+ZF0L+ri0rBvIxeouYxtlaY/IxC2oc8WI7Q/gT+DcRyfKnY3jiMZiLWN5AgY813TGltVgzKaLJmb+qXliyxXUtoDlcGPD3k8LVaqaOuZW8AmY59eAxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jxyjwxdzrfpKlPGvYmMXCHGRhtDwB8kOwvcuZ5A3gjo=;
 b=y0VcgBeOJYoljnsqeD0djaeg2p4qEGQskBMbxmtrvP/r8sKGQ4uwfcMBOe5wzXiFND2QYzWmvE8LpM958ldRQq39h+RBctFw7Zp2iDMl1X2AVq38lAxb7klufOx0So1xpgJzhm+eIBnlvA3ob9w98R3UDPui8Ywxl2rvF30r09KWVuwgtUt2sExKEWmJbCVWs4unKxVCskvx3/UxIt/pKVYtP/GwT6qS17Wn2vZkk9PpzrBdQ3m/UCST1g+U4vcl4lGodnAvYYpSeafNHPCeNH8Hvgma6QzoGyvxT31Otm29t+DZGp1SFrpprSu3LCzISqnTyCD/b+E3Bul+6in+7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jxyjwxdzrfpKlPGvYmMXCHGRhtDwB8kOwvcuZ5A3gjo=;
 b=Vg2S4yldAJhGV+ldHqmD9ULItZ9OZCdMrkEu6rpUxQuvOOjPrdHMnkkCM05me2KPMlaITTel9Y9ts80a+ZEcKlD4inrD/YXZYaQepWHrhS5BYisY1DKpw5BaF1HrMOuPNMEaArhuQuvvqbeON4hTSL3Srhk9cSiTy1DU42DqgZA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CHAPR12MB999226.namprd12.prod.outlook.com (2603:10b6:610:2ff::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 16:54:20 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0406.005; Fri, 11 Sep 2026
 16:54:19 +0000
Message-ID: <04ced8a4-d5c0-4733-bd7b-6bd71f9d7157@amd.com>
Date: Fri, 11 Sep 2026 18:54:06 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/amdgpu: nuke most amdgpu_vm_eviction_(try)lock
 uses
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
To: timur.kristof@gmail.com, natalie.vock@gmx.de, amd-gfx@lists.freedesktop.org
References: <20260911164801.50175-1-christian.koenig@amd.com>
Content-Language: en-US
In-Reply-To: <20260911164801.50175-1-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0142.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CHAPR12MB999226:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ccea799-542e-43a9-b177-08df1025520c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XCAFKyx7JnJSUgVodfMvksoFrCpyzjvdJ5FKOVcvogUJEXIt9nD8y27irqoPkR6GjdlJtfzRGTvaLkccdWUkzQCwSXUVtgOkdCoRjasgSJtxt28NI67qUsVUUkKh/YZ8HoaLKq66BR9hPcgMUFmWxxZlgfMwlsSW+Om6woklRBTJrLMIBgu7CSwehZCuO28Z5XsQP4hPPGzcoFRBIQOsLD7ZTbZKuDL8Bwc7X5agxOz29P3Md2uNPBNE0MvktwJX24hYKOMcjBcN0R7282LS0eVUeP6L9dmzWFvD4Q0pxH0yeigAhXEjlTrF5dMSaZhh5G9yHaGvXCYRqxJJlT4r29zJMfZmrGUTfJpyEP2PwFcMN0+vI4l2KfUqE3DPRUWTduNE3V8d+qvqS53WQk02GeKhBnHt3g38W+yDfOEi6Viz892ztdIQZx3WY5Q1jkKKX0tJVj+IdITccLX4X7/g3FkVzXwFTRtr/nh0OEQODXZMIiBFVP+YqNZEmHRu4rmrHkiIq8Gb4wxHERgzrxhZXAVvWrNJ4AwhkhedHRPNDZUAVuw3gmx9n5WiwFzDhudXg3AdBDGEw34pCLbFmAqqMNh/qWr27+Wqsi8mZqRSZZ6I7rxF1O/njXOVuxqzHCVA3jE1QTuUsbCrOxYJ59hF1YN+WOV3Pxm7J7yIQEJegcc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MEJuZVFYZjl1SERlVndJV0NGZlBqRXJrakJsckFWUnBJZUcrNDBabTFuQy9j?=
 =?utf-8?B?UzliR291a05rQ1dmM2d3NTRLS0E2UXNzSkVCRjNOT2VRaFhNSHpVSlFmYVhD?=
 =?utf-8?B?RWJTd3BDWGZXWDNQdFJ6UzNFcUg3MUpDTm5YM0U5ZGs0Y2RKc1BUSHdMQm5x?=
 =?utf-8?B?YU1vU0pHWFd6NXVablFHSEQybndka1BTdEdFMVdFcXBsdldlWVVOdlR6emN6?=
 =?utf-8?B?eFFkclhkaVNyTlVraVR1cFpoWndaN3JxWE0yMlc2L2dhWkFmRHRMOENUNlVo?=
 =?utf-8?B?MTBtZXJLeE1PTEtHcnA3ZXo2RUhwNzVveXhrTnl4QlhSR1ZiMTQ0N29vdm9h?=
 =?utf-8?B?SGhEZlA3TTBTSVFMdThUelhKcDg5VFAwNlBSdTMwNW5HYVlIanZIOFFrUDNL?=
 =?utf-8?B?dHBqZG1PMFFWMmxEUFowZjdRakhxUHBaV0JKTGVzYVJiUkRYTnpSdjFhVkhO?=
 =?utf-8?B?Y1g4QWtlTFgrZ1BNdVVnYUZCS2hSYUdhSU9iRTNPUVdKMVh5L1pBMkRiMEt5?=
 =?utf-8?B?T3Z3VHlDMlV4QXhqMDZpOWhvdVFmbmlyWm1wR1lzaklkdWUvd0ZjSjhYT255?=
 =?utf-8?B?UnYyS3ZLNmNDSnBYelIycUQ0YTlWaVRPRHRHU0pCM1dmTTM4aElwa0JMNmNZ?=
 =?utf-8?B?eDBib3grcHJYRXdTUzZkZ00rWVNuUnk3QUJsQmZSWmdJbjN5VTY1eUdhcHZw?=
 =?utf-8?B?S1Y0NFJTSWF4ajNvVE91d1dSNjhsRlhIYU9pVnJCMklWYkZqWVcyOC9DYXpL?=
 =?utf-8?B?SFJwb3BxZmlvOE5pYUEzbmFuYjQ4eC9MWis2WVl0MUVnZmtSMjFLeEZjaXl1?=
 =?utf-8?B?WFR1TWUyeldQUXFSblVjdURuY0kwSTVYU05wY0tUV1NJcmwxb0RvZHN0SG42?=
 =?utf-8?B?dE9BVGl3bFBGd3VEUU1xWUIzcFB1MUtOSFk2WUo5OGxSVGl2Z0pCczhLTmFk?=
 =?utf-8?B?WDdGV1Z1V05IZk1wV1ZobGpqVkF1bVBvQiszVHIybk5CcW0xSzMxaUQvTEsy?=
 =?utf-8?B?cmFBc1BMRDB5MFdTdkJMVTdwNjlYWmJ6RDV3TmY1akpmRUpydmJWTzZReGxa?=
 =?utf-8?B?TnJKQTk1bUVza3BtL09WK1hBdDUya0Q3bWkzMHZxZmdtUjRFZkJPQUdSaUpC?=
 =?utf-8?B?Rmg1aXBQZE1kZ2haRUVmbjZYR205U1JoZzRDdm1UcDMzUHdaaEI4VCt5eHJp?=
 =?utf-8?B?cENOb2lIdDJTbW5BREpESEhDYkRDWUczOTBQYkM4cmlwemh5Mk5QSGZvTVhj?=
 =?utf-8?B?Q01QZTZiK2E1dnJCSVNVN1lRV2tUVEFQc1RZWit1SHlmVi9ibnUwV0laa1RY?=
 =?utf-8?B?NWYvdTZrVkFpTzhQTDNJVFVjUEdIb2hyY0dPaGR2bndkWC9OMWszZFRaRXdi?=
 =?utf-8?B?bC9EcHZwaDd0Z2lPUUtraEFhRVJUekx3eHU3Z2MrUTRXME91b2ozd1daSU4w?=
 =?utf-8?B?NGhELytFV0tQV3RYbFVDbUJZY0xzb2tkOUdxVGowc3BiVFdpUmRDaVh0WTVl?=
 =?utf-8?B?MlBob3E1TTFQS0MvTFNRNFdRR2xyd0Y5TUJ2N3B3a0ZmNFU3ZUxGcmhEaWU0?=
 =?utf-8?B?RmFTNHU1VkNWb3lPQ1pzTGZjOHN6bTBDYzEvczQ0T0JmZi9neXAxbDlWZnNV?=
 =?utf-8?B?ODFqdWdpR3Y1c3BmaWZtVjVNTW1MVC9xQXRvUlJaaXJBRVFTN2dZb09IZUg0?=
 =?utf-8?B?NWpmRXF4TmU5b29PMnVwN2FpMTN0ZGo3dC9US2RmbTVDT2ZvTjFtV1E3WUZF?=
 =?utf-8?B?QnUwRUw1NHEybDc3eW9OTmd4bFplUmZhbnFEcCt2SkgySVRtLytPQXc4dk1s?=
 =?utf-8?B?V1VmV3BFak5XaERPLzRiZ2piUFVXM0dUYW4wOGl0dVJKN0U0YStZekU1WHdh?=
 =?utf-8?B?L2hMMVVOQi9uU2U2alg2TmEvbTQyV1l3cG0xQ2x2a002SWF5SG9wVm9EVXZ5?=
 =?utf-8?B?TmV0VDNjNE9FVXJrK003NVpaRUdnU2tqVnoxSHd6KzE1ZWViR2xlTVZvc3lN?=
 =?utf-8?B?NzU1Y0s1bVYxUGVzaUJQUCszZDBIVUF0V3lQaGhKYUhGMTZWbjMzMmx6NzQw?=
 =?utf-8?B?cXQ0SHRYS3hEdVZFL2MzeE94YXBOUTFNNzJ5Y2tCdUsvOExYWjBUYUNobW1P?=
 =?utf-8?B?b1c3NWxBU21CeVA0YWlLL2NxMWR2L0hTMjVTVU9HTHB4SEQ1aEpETWZTdTFH?=
 =?utf-8?B?RE9vNmtKYkltLzJZUElTOHFoekl0L0pDaFRFS1QrQ2R3MWpaVk8yUGZKOGlx?=
 =?utf-8?B?YzhjdUtKRHcvdUsxZnhiN1NGcksrdkc4TjY0a3N2SmZpbkk4UmtlT0k1a24x?=
 =?utf-8?Q?7qq8mOOtWwiWsXjajK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ccea799-542e-43a9-b177-08df1025520c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 16:54:18.9579 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BTNOUTxN+QerJc0ixNQ4JTPrmJ04Umt4MGzV5IblRqCbwH9P4Z6gFDgIszv0jLof
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999226
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
Reply-To: Honglei1.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Hi Honglei,

this is just to unblock your SVM work, the rest of my patch set needs more work than I thought because of the new ualink files.

Regards,
Christian.

On 9/11/26 18:48, Christian König wrote:
> Use scoped_guard/scoped_cond_guard instead.
> 
> Saving and restoring the GFP flags is not necessary in those use case.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 27 +++++++++----------
>  .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |  9 -------
>  2 files changed, 12 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 47cde54594693..7ced26c9c651b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -616,9 +616,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  	 * As soon as all page tables are in place we can start updating them
>  	 * again.
>  	 */
> -	amdgpu_vm_eviction_lock(vm);
> -	vm->evicting = false;
> -	amdgpu_vm_eviction_unlock(vm);
> +	scoped_guard(mutex, &vm->eviction_lock)
> +		vm->evicting = false;
>  
>  	list_for_each_entry_safe(bo_base, tmp, &vm->always_valid.evicted,
>  				 vm_status) {
> @@ -678,9 +677,8 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>  
>  	amdgpu_vm_assert_locked(vm);
>  
> -	amdgpu_vm_eviction_lock(vm);
> -	ret = !vm->evicting;
> -	amdgpu_vm_eviction_unlock(vm);
> +	scoped_guard(mutex, &vm->eviction_lock)
> +		ret = !vm->evicting;
>  
>  	ret &= list_empty(&vm->kernel.evicted);
>  
> @@ -2274,6 +2272,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>  bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
>  {
>  	struct amdgpu_vm_bo_base *bo_base = bo->vm_bo;
> +	struct amdgpu_vm *vm;
>  
>  	/* Page tables of a destroyed VM can go away immediately */
>  	if (!bo_base || !bo_base->vm)
> @@ -2284,17 +2283,15 @@ bool amdgpu_vm_evictable(struct amdgpu_bo *bo)
>  		return false;
>  
>  	/* Try to block ongoing updates */
> -	if (!amdgpu_vm_eviction_trylock(bo_base->vm))
> -		return false;
> +	vm = bo_base->vm;
> +	scoped_cond_guard(mutex_try, return false, &vm->eviction_lock) {
>  
> -	/* Don't evict VM page tables while they are updated */
> -	if (!dma_fence_is_signaled(bo_base->vm->last_unlocked)) {
> -		amdgpu_vm_eviction_unlock(bo_base->vm);
> -		return false;
> -	}
> +		/* Don't evict VM page tables while they are updated */
> +		if (!dma_fence_is_signaled(vm->last_unlocked))
> +			return false;
>  
> -	bo_base->vm->evicting = true;
> -	amdgpu_vm_eviction_unlock(bo_base->vm);
> +		vm->evicting = true;
> +	}
>  	return true;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> index 447195cc45932..ca86eaac75235 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
> @@ -137,15 +137,6 @@ static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
>  	vm->saved_flags = memalloc_noreclaim_save();
>  }
>  
> -static inline bool amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
> -{
> -	if (mutex_trylock(&vm->eviction_lock)) {
> -		vm->saved_flags = memalloc_noreclaim_save();
> -		return true;
> -	}
> -	return false;
> -}
> -
>  static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
>  {
>  	memalloc_noreclaim_restore(vm->saved_flags);

