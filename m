Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F109F99362
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 10:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2783610F085;
	Thu, 23 Apr 2026 10:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1kAhKOL0";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012044.outbound.protection.outlook.com [40.107.209.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3521510F085
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 10:46:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gnj7NiAkUshEPpjUhDvEQfEEJu/RwcDP7FcXU8fQIS45CMwzyKBAYaTRpq2tPO9aiG4PfRW39uiqrIokzWwT4i5J7Eeeo7eQWeagWn6Sov0y9j4ZLsnhUkfROm6CMbxekS/XFQ+eROHYxmzNFsxaIIzB96/fHwAP60+OB+crQYpQf3gEgwiRpE4O7Y+FvtYaa5uVU3/7fttafAibLQqG/J7qTk8XDROvix62OM4m3/FXH7SBCfSWtz98xhpzo/T4aWreH4OLbG1sqwBpjYMXajgqCisKbX1oyIrfROK1iNUQq7EtaESZfp3EurWzd+fD5/83V8wRvD5RirEjrgo0ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEVX4gvp1mzloCyGJnE2b99g/6AY/k7T3WSD/1EBAB4=;
 b=bglKJNPGeXE6+SsKbwQbch6vIMhAOHTwhDfNHeVfXvCz52VVLk6gOM2PTihFw7zp3bH8z9lP0XsNq5AoWWk0AzmhgmIaFgCQ/ExmZ9LHaO5KEXzW6v68de0d9CvZxNuCVU7fKnENJN8ZSvOYhuYC7w76ePxVNMx/DPR6CDifUubB2twnM5TmdJQ9o7BdUZ6g98bgtUEM3z6mhFemOKvMiHl7ODX3PfECmo7I6mjn/9we6zdMrvoRy5/jJhUm08/nQH3mV9AFniDiRxfCpGXyn7qrx9j7mZdgLBzmULRytJZu+FdXtYJKayqXhU0Vp1iNi1IVusVtomD08K+Def91+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEVX4gvp1mzloCyGJnE2b99g/6AY/k7T3WSD/1EBAB4=;
 b=1kAhKOL0mmA77CW/2U2g/e8khhKuJvBYk2/+aI/wJG+PSDnv/xZEBYCiKTmBUs9jTbqujbHLlt/FPTlUibf8rFqwkPekNmVk+jIuCv9uFTbUKaDZskToBVwea6eyNSVrlRWg0tn9umx0BBweM1cHWz9WcP/mUvoYW4ladqvfoIA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5753.namprd12.prod.outlook.com (2603:10b6:208:390::15)
 by DM6PR12MB4202.namprd12.prod.outlook.com (2603:10b6:5:219::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.21; Thu, 23 Apr
 2026 10:46:52 +0000
Received: from BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2]) by BL1PR12MB5753.namprd12.prod.outlook.com
 ([fe80::81e6:908a:a59b:87e2%6]) with mapi id 15.20.9846.014; Thu, 23 Apr 2026
 10:46:52 +0000
Message-ID: <aab9c7f9-e158-4624-92c6-a20e2270cf76@amd.com>
Date: Thu, 23 Apr 2026 16:16:45 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] drm/amdgpu: restructure VM state machine v2
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 alexander.deucher@amd.com, Prike.Liang@amd.com, amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
References: <20260421125513.4545-1-christian.koenig@amd.com>
 <20260421125513.4545-10-christian.koenig@amd.com>
Content-Language: en-US
From: "Khatri, Sunil" <sukhatri@amd.com>
In-Reply-To: <20260421125513.4545-10-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PN2PR01CA0219.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::13) To BL1PR12MB5753.namprd12.prod.outlook.com
 (2603:10b6:208:390::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5753:EE_|DM6PR12MB4202:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e5fdcd-2829-45ad-d0bd-08dea125a0b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|56012099003|22082099003|18096099003;
X-Microsoft-Antispam-Message-Info: sCAzK0+cg0CzztzwmEHEu1O0NTSLPcSFPMCbGtohcHBkfjPyIdfWJM1IChw67hHct7ifYhLA+UaS5emoOvy7a5HxZPsoSY0sV+eXeIyQomLFX3JYmH3iX3K5IN5UY+sewgi3xRHLoJsDa5WvPlL8s78kTdyua5LKaq46/Kt2PeeUmfG98qOi8B9isdosiwDBJpWKEyaCNldRBuQKVTyXK94NN9xKiDpB3Ei5dkNM5qt359Js4gCqUkiwKOIE9KDduJ208InlfSc1gyaXDaazt1ii9aFj/U420RkOoqNbKZJ3KDBU3bjhsAlsOQQM0D6YYua6wzC3tz4DowiHNIPLsk2ekSoIMnDB8Dn/4QkvLydefKGJndXNK6C0fuSymZBUvy3q7XeDtDr8DLCC/9Y44CHtJB6bnkeuOJdBXT5hYdB0/jXoB90VHkk5UHyYMGZ8rjwPvhA7oL9CzcaTVRF1xG/fLRlyxNAr2i3CU5QzwoLcdzTT76TSWaTGxXB/pX9kMbWCj2aI3Q0c38036GASKzJTya+3PwR8e9RnIPRTCvOXGZzYJXG+1p2ihGXeikncAuWKhd+gPMF7OrLMWwuMESr/YFEw8ZhmC1fWSVd1IgFTHeeoh0hKZvs/oHlkVcmYwC4gkbvdfN+njqFuPukT6CIOb6CBbkSQzZcv3KG6pfeHeaYK/Bl6yQ4sIXxCVpNfnz4y4q/qOa6rVHxzgKhnFjO8Yy9avD0jhXXkM18vjY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5753.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(56012099003)(22082099003)(18096099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFdjM3U1M1g1WHlYY1diV3R4YkdyQno1V1QyTkYrYjJ0d2dJZXRVYWVOQVdo?=
 =?utf-8?B?THBwZlJpMXBabGN6N0RBb0pjT0RTU05PZFZGS2hpNnJoMDUzQVNxMW5VV2Za?=
 =?utf-8?B?T3poRmVHMFQ1ZXFlZUpVQW5ZRUdqTVpXNE5wSWR2NkYzYks1ejcyakVvT0Jh?=
 =?utf-8?B?WXRobTVPUTk2RFZTcFNZN1JFTWY1U25TSGV6dkdXOGcrWHcvWXFRZjdRYytn?=
 =?utf-8?B?NWl3THY0M3JNQWdCTk9rVzZYQ3lPbS9sUFZkeUsrcDVEa0dLWXJPWGF3aVhs?=
 =?utf-8?B?TXZyc3hRUXk4YmYxSDF4K1Q1b1NGMnE3MmtOWDBDaU9EanhVMnlwak1XaUQw?=
 =?utf-8?B?M1VhZUVaNkg1dTZuRTZWV0txTVY0c0tUd0lTaE1oR1JmMHlVUlNoWU5TSDUv?=
 =?utf-8?B?LzlNVFlHMXhKaDVlZ0x2M0xkL3lsT1Z6QlVSNjU1RStsQ0lJc1puMEV6TUd2?=
 =?utf-8?B?azFWL2hla3ZnY3pXVjB3ZnlwbjhtdlQ5ZHVCMnJjZmY5dWRPeGFMcEYyQmY4?=
 =?utf-8?B?VmpnZXgxWE9rYnNQeHVQZDRHOUNqODlVY1ZxOWVCTmRLV3VRQ25Wd0xkODFq?=
 =?utf-8?B?NFU4MGVGU1ExTUpJcyszaFFTeEY2dUpoNWlnOGptajNLelBvR2xrTTdWeE5Y?=
 =?utf-8?B?UXZpdFI3T08zSkY5aEZFRXk1M1VGbXNiazhrdVV6U1diQ1FaTnA4aHo2WmdX?=
 =?utf-8?B?QUR5QU5VdUtleUhrS1UxQ3A4M1RXc0toS0ZZK2E2RkZFTXprYnYyMEtCaGlh?=
 =?utf-8?B?citQbHRtZ0Q1V1RITE40cERuZ2pyL2Z3RDVRL0hZUTRkZXpWZkFCVEhVSEZx?=
 =?utf-8?B?K00xM0ZpTStFZkFvTWw2bng0VkFJdE9PSkYzc3JzTTRhSTc5d3hiUjB0Z090?=
 =?utf-8?B?MWJhdG10MFdwSmlGanlwVlEvYjZtL1NiSXRBTjNtak1zbWliMENqWUlZeDA3?=
 =?utf-8?B?VFpYaFJQNy9IeUk1MlRsYmhPUDA3ejJDOWp6VElkb0Y2R3RsUGhaQjBlR1dz?=
 =?utf-8?B?Q3NBUXc2U2pVeEFObmJEa1I3R1psRzQ0emhGSzV1Y2R1QVhjRW5hc1gwMFc4?=
 =?utf-8?B?YnFudzhBdmIvSDFxYURHd1o0TUZ4WFhMZmthdmsrK2R1V3dSMGpOSUpPQ2Rn?=
 =?utf-8?B?bkMwaVVzZ3pIZVZOWjNiMWFBWU01NGMvNW5PTGVGTTBFVVJ1Rnl1S29RYmYz?=
 =?utf-8?B?cHZjOEZLRGJDOVNGMXo3K3NEaUJraUQvV0d3NjRQUVdLYllqNS94T0JsR1g2?=
 =?utf-8?B?MHdYQzRVZWd4c1F6N0w0OFNIZ3FzVWp2aUJsR1ZVUzU1K1FGaVBYSGNHdGp4?=
 =?utf-8?B?a0gybzArZVE1TCtkYWFydmp2cTJic1ZYalMyVHIvZ3dMR29DektZemFOY3cr?=
 =?utf-8?B?Vy9JbVNQa0ZFQjJpeGkxck5sb1ozdWtwSDBHd0hrWTVWRDBhR1lxdmJnV29z?=
 =?utf-8?B?VThDeHF5MmZSTklpcytUelp4UWo5K05qai8zdkh5Z1lxb2NKQXBYeHFPdlVQ?=
 =?utf-8?B?NnZTSzhaS1FERWtKM21lVXNjQzdGa2hIK3hGZm1DZytvZEZac09leXFCSDZU?=
 =?utf-8?B?MGRwMEFQQ3hqc1MwNEI4c1UzSm5WZVJUSVc3aE5sUDg2aG9WeU5xeXo2TUo1?=
 =?utf-8?B?OGlvemp4TVRpTDdYeDBKZ2ZXaGlhUWVJOXdzV2JQa2l0UVdRM2JyWDB0SmFp?=
 =?utf-8?B?RHNMODRtRTRrMlFwV2VnZ2VxVWpZNDBEL3lxck9wT3B1RmVHa20yTk9tTW80?=
 =?utf-8?B?bm5lRmJ3aWg3MFdUVGdMTVJMaVZFRWcxRzhIWVkzQTFibHhPRUI2T2ZBMTVH?=
 =?utf-8?B?TGZ0M1FJK2l5QmFRYVlNay9QOHBmRi9ZVTduOVhVc202alBrRWJHNUFzRXF1?=
 =?utf-8?B?M0o0QnJwM0FVNmRHbFducnhXOGN5WjYvN3c0MjdwZGk2Nnl5VEpqWlpTQkhS?=
 =?utf-8?B?bnhpN05QNWswSU5UbXI0YkRUSW92TUQ1aVNpdWpsMWlZaTVvanhNanl0Zk10?=
 =?utf-8?B?aWphMVUrQS92bXlOT1FzZm1abDg4UWVrWFJNd2FIVWhOekdaY2FBM1paL0NL?=
 =?utf-8?B?MnlQeW52dHhabDFMTXFScWlCRXM3NkpVY1lOc1cwWUU3MnlJZ1VMNGhBV3VC?=
 =?utf-8?B?KzdkRFA4ZUVVZzI1TDRBSWloYmR6NTNmZUxWYVNLNWtEMUNLdnRjNWtqWUFs?=
 =?utf-8?B?bklGR0lsQ1JHRHJDbEo1RHBxZGtacnQvTENJMHIvWDh2V09FOUVuWjd3encv?=
 =?utf-8?B?TlpVRUNEZEFONXhySFpDUStqVFVvMTg1R01mSHpiQzArZGNXK3hlaDZBSk9u?=
 =?utf-8?B?UjNJTzUxZ29lMkdUOHo2OTFIVm5iZVR5c0VXNkxGM2VZcS9TbnBOUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e5fdcd-2829-45ad-d0bd-08dea125a0b0
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5753.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2026 10:46:51.8946 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GQaeHpHjYIOAoS7K6NuFVHs9kLD+NXngyR+sD3footYLmezedx6zQZr1KxPZaVAb6ui/RIgkXGxgQOcG42cFow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4202
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

I think this was already reviewed earlier too with just some additional 
comment.
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>

Regards
Sunil Khatri

On 21-04-2026 06:25 pm, Christian König wrote:
> Instead of coming up with more sophisticated names for states a VM BO
> can be in, group them by the type of BO first and then by the state.
>
> So we end with BO type kernel, always_valid and individual and then states
> evicted, moved and idle.
>
> Not much functional change, except that evicted_user is moved back
> together with the other BOs again which makes the handling in
> amdgpu_vm_validate() a bit more complex.
>
> Also fixes a problem with user queues and amdgpu_vm_ready(). We didn't
> considered the VM ready when user BOs were not ideally placed, harmless
> performance impact for kernel queues but a complete show stopper for
> userqueues.
>
> v2: fix a few typos in comments, rename the BO types to make them more
>      descriptive, fix a couple of bugs found during testing
>
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  22 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 468 ++++++++++------------
>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  64 ++-
>   3 files changed, 252 insertions(+), 302 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 7fc733ba962e..9d01449e1487 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1048,12 +1048,12 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>   	struct amdgpu_bo *bo;
>   	int ret;
>   
> -	spin_lock(&vm->invalidated_lock);
> -	while (!list_empty(&vm->invalidated)) {
> -		bo_va = list_first_entry(&vm->invalidated,
> +	spin_lock(&vm->individual_lock);
> +	while (!list_empty(&vm->always_valid.evicted)) {
> +		bo_va = list_first_entry(&vm->always_valid.evicted,
>   					 struct amdgpu_bo_va,
>   					 base.vm_status);
> -		spin_unlock(&vm->invalidated_lock);
> +		spin_unlock(&vm->individual_lock);
>   
>   		bo = bo_va->base.bo;
>   		ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
> @@ -1065,14 +1065,14 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
>   		if (ret)
>   			return ret;
>   
> -		/* This moves the bo_va to the done list */
> +		/* This moves the bo_va to the idle list */
>   		ret = amdgpu_vm_bo_update(adev, bo_va, false);
>   		if (ret)
>   			return ret;
>   
> -		spin_lock(&vm->invalidated_lock);
> +		spin_lock(&vm->individual_lock);
>   	}
> -	spin_unlock(&vm->invalidated_lock);
> +	spin_unlock(&vm->individual_lock);
>   
>   	return 0;
>   }
> @@ -1104,7 +1104,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>   		if (unlikely(ret))
>   			goto unlock_all;
>   
> -		ret = amdgpu_vm_lock_done_list(vm, &exec, 1);
> +		ret = amdgpu_vm_lock_individual(vm, &exec, 1);
>   		drm_exec_retry_on_contention(&exec);
>   		if (unlikely(ret))
>   			goto unlock_all;
> @@ -1147,7 +1147,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>   
>   	key = 0;
>   	/* Validate User Ptr BOs */
> -	list_for_each_entry(bo_va, &vm->done, base.vm_status) {
> +	list_for_each_entry(bo_va, &vm->always_valid.idle, base.vm_status) {
>   		bo = bo_va->base.bo;
>   		if (!bo)
>   			continue;
> @@ -1197,10 +1197,10 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>   
>   	/*
>   	 * We need to wait for all VM updates to finish before restarting the
> -	 * queues. Using the done list like that is now ok since everything is
> +	 * queues. Using the idle list like that is now ok since everything is
>   	 * locked in place.
>   	 */
> -	list_for_each_entry(bo_va, &vm->done, base.vm_status)
> +	list_for_each_entry(bo_va, &vm->always_valid.idle, base.vm_status)
>   		dma_fence_wait(bo_va->last_pt_update, false);
>   	dma_fence_wait(vm->last_update, false);
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index e2a21a66b28f..118761e2c409 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -138,6 +138,47 @@ static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
>   	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>   }
>   
> +/* Initialize the amdgpu_vm_bo_status object */
> +static void amdgpu_vm_bo_status_init(struct amdgpu_vm_bo_status *lists)
> +{
> +	INIT_LIST_HEAD(&lists->evicted);
> +	INIT_LIST_HEAD(&lists->moved);
> +	INIT_LIST_HEAD(&lists->idle);
> +}
> +
> +/*
> + * Make sure we have the lock to modify the vm_bo status and return the object
> + * with the status lists.
> + */
> +static struct amdgpu_vm_bo_status *
> +amdgpu_vm_bo_lock_lists(struct amdgpu_vm_bo_base *vm_bo)
> +{
> +	struct amdgpu_vm *vm = vm_bo->vm;
> +	struct amdgpu_bo *bo = vm_bo->bo;
> +
> +	if (amdgpu_vm_is_bo_always_valid(vm, bo)) {
> +		/* No extra locking needed, protected by the root PD resv lock */
> +		amdgpu_vm_assert_locked(vm);
> +
> +		if (bo->tbo.type == ttm_bo_type_kernel)
> +			return &vm->kernel;
> +
> +		return &vm->always_valid;
> +	}
> +
> +	spin_lock(&vm_bo->vm->individual_lock);
> +	return &vm->individual;
> +}
> +
> +/* Eventually unlock the status list lock again */
> +static void amdgpu_vm_bo_unlock_lists(struct amdgpu_vm_bo_base *vm_bo)
> +{
> +	if (amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
> +		amdgpu_vm_assert_locked(vm_bo->vm);
> +	else
> +		spin_unlock(&vm_bo->vm->individual_lock);
> +}
> +
>   /**
>    * amdgpu_vm_is_bo_always_valid - check if the BO is VM always valid
>    *
> @@ -157,33 +198,44 @@ bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct amdgpu_bo *bo)
>    *
>    * @vm_bo: vm_bo which is evicted
>    *
> - * State for PDs/PTs and per VM BOs which are not at the location they should
> - * be.
> + * State for vm_bo objects meaning the underlying BO was evicted and need to
> + * move in place again.
>    */
>   static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	struct amdgpu_vm *vm = vm_bo->vm;
> -	struct amdgpu_bo *bo = vm_bo->bo;
> +	struct amdgpu_vm_bo_status *lists;
>   
> +	lists = amdgpu_vm_bo_lock_lists(vm_bo);
>   	vm_bo->moved = true;
> -	amdgpu_vm_assert_locked(vm);
> -	if (bo->tbo.type == ttm_bo_type_kernel)
> -		list_move(&vm_bo->vm_status, &vm->evicted);
> -	else
> -		list_move_tail(&vm_bo->vm_status, &vm->evicted);
> +	list_move(&vm_bo->vm_status, &lists->evicted);
> +	amdgpu_vm_bo_unlock_lists(vm_bo);
>   }
>   /**
>    * amdgpu_vm_bo_moved - vm_bo is moved
>    *
>    * @vm_bo: vm_bo which is moved
>    *
> - * State for per VM BOs which are moved, but that change is not yet reflected
> - * in the page tables.
> + * State for vm_bo objects meaning the underlying BO was moved but the new
> + * location not yet reflected in the page tables.
>    */
>   static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
> +	struct amdgpu_vm_bo_status *lists;
> +	struct amdgpu_bo *bo = vm_bo->bo;
> +
> +	/*
> +	 * The root PD doesn't have a parent PDE and goes directly into the
> +	 * idle state.
> +	 */
> +	lists = amdgpu_vm_bo_lock_lists(vm_bo);
> +	if (bo && bo->tbo.type == ttm_bo_type_kernel && !bo->parent) {
> +		vm_bo->moved = false;
> +		list_move(&vm_bo->vm_status, &lists->idle);
> +	} else {
> +		vm_bo->moved = true;
> +		list_move(&vm_bo->vm_status, &lists->moved);
> +	}
> +	amdgpu_vm_bo_unlock_lists(vm_bo);
>   }
>   
>   /**
> @@ -191,104 +243,36 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
>    *
>    * @vm_bo: vm_bo which is now idle
>    *
> - * State for PDs/PTs and per VM BOs which have gone through the state machine
> - * and are now idle.
> + * State for vm_bo objects meaning we are done with the state machine and no
> + * further action is necessary.
>    */
>   static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
>   {
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
> -	vm_bo->moved = false;
> -}
> -
> -/**
> - * amdgpu_vm_bo_invalidated - vm_bo is invalidated
> - *
> - * @vm_bo: vm_bo which is now invalidated
> - *
> - * State for normal BOs which are invalidated and that change not yet reflected
> - * in the PTs.
> - */
> -static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
> -{
> -	spin_lock(&vm_bo->vm->invalidated_lock);
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
> -	spin_unlock(&vm_bo->vm->invalidated_lock);
> -}
> -
> -/**
> - * amdgpu_vm_bo_evicted_user - vm_bo is evicted
> - *
> - * @vm_bo: vm_bo which is evicted
> - *
> - * State for BOs used by user mode queues which are not at the location they
> - * should be.
> - */
> -static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
> -{
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> -	vm_bo->moved = true;
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
> -}
> +	struct amdgpu_vm_bo_status *lists;
>   
> -/**
> - * amdgpu_vm_bo_relocated - vm_bo is reloacted
> - *
> - * @vm_bo: vm_bo which is relocated
> - *
> - * State for PDs/PTs which needs to update their parent PD.
> - * For the root PD, just move to idle state.
> - */
> -static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
> -{
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> -	if (vm_bo->bo->parent)
> -		list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
> -	else
> -		amdgpu_vm_bo_idle(vm_bo);
> -}
> -
> -/**
> - * amdgpu_vm_bo_done - vm_bo is done
> - *
> - * @vm_bo: vm_bo which is now done
> - *
> - * State for normal BOs which are invalidated and that change has been updated
> - * in the PTs.
> - */
> -static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
> -{
> -	amdgpu_vm_assert_locked(vm_bo->vm);
> -	list_move(&vm_bo->vm_status, &vm_bo->vm->done);
> +	lists = amdgpu_vm_bo_lock_lists(vm_bo);
> +	if (!amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
> +		vm_bo->moved = false;
> +	list_move(&vm_bo->vm_status, &lists->idle);
> +	amdgpu_vm_bo_unlock_lists(vm_bo);
>   }
>   
>   /**
>    * amdgpu_vm_bo_reset_state_machine - reset the vm_bo state machine
>    * @vm: the VM which state machine to reset
>    *
> - * Move all vm_bo object in the VM into a state where they will be updated
> - * again during validation.
> + * Move all vm_bo object in the VM into a state where their location will be
> + * updated in the page tables again.
>    */
>   static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
>   {
> -	struct amdgpu_vm_bo_base *vm_bo, *tmp;
> -
> -	spin_lock(&vm->invalidated_lock);
> -	list_splice_init(&vm->done, &vm->invalidated);
> -	list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
> -		vm_bo->moved = true;
> -	spin_unlock(&vm->invalidated_lock);
> -
>   	amdgpu_vm_assert_locked(vm);
> -	list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
> -		struct amdgpu_bo *bo = vm_bo->bo;
> +	list_splice_init(&vm->kernel.idle, &vm->kernel.moved);
> +	list_splice_init(&vm->always_valid.idle, &vm->always_valid.moved);
>   
> -		vm_bo->moved = true;
> -		if (!bo || bo->tbo.type != ttm_bo_type_kernel)
> -			list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
> -		else if (bo->parent)
> -			list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
> -	}
> +	spin_lock(&vm->individual_lock);
> +	list_splice_init(&vm->individual.idle, &vm->individual.moved);
> +	spin_unlock(&vm->individual_lock);
>   }
>   
>   /**
> @@ -416,8 +400,10 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   	base->next = NULL;
>   	INIT_LIST_HEAD(&base->vm_status);
>   
> +	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>   	if (!bo)
>   		return;
> +
>   	base->next = bo->vm_bo;
>   	bo->vm_bo = base;
>   
> @@ -426,27 +412,22 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
>   	amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
>   	spin_unlock(&vm->stats_lock);
>   
> -	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
> +	if (!amdgpu_vm_is_bo_always_valid(vm, bo)) {
> +		amdgpu_vm_bo_idle(base);
>   		return;
> -
> -	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
> +	}
>   
>   	ttm_bo_set_bulk_move(&bo->tbo, &vm->lru_bulk_move);
> -	if (bo->tbo.type == ttm_bo_type_kernel && bo->parent)
> -		amdgpu_vm_bo_relocated(base);
> -	else
> -		amdgpu_vm_bo_idle(base);
>   
> +	/*
> +	 * When a per VM isn't in the desired domain put it into the evicted
> +	 * state to make sure that it gets validated on the next best occasion.
> +	 */
>   	if (bo->preferred_domains &
>   	    amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type))
> -		return;
> -
> -	/*
> -	 * we checked all the prerequisites, but it looks like this per vm bo
> -	 * is currently evicted. add the bo to the evicted list to make sure it
> -	 * is validated on next vm use to avoid fault.
> -	 * */
> -	amdgpu_vm_bo_evicted(base);
> +		amdgpu_vm_bo_moved(base);
> +	else
> +		amdgpu_vm_bo_evicted(base);
>   }
>   
>   /**
> @@ -467,41 +448,41 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
>   }
>   
>   /**
> - * amdgpu_vm_lock_done_list - lock all BOs on the done list
> + * amdgpu_vm_lock_individual - lock all BOs on the individual idle list
>    * @vm: vm providing the BOs
>    * @exec: drm execution context
>    * @num_fences: number of extra fences to reserve
>    *
> - * Lock the BOs on the done list in the DRM execution context.
> + * Lock the BOs on the individual idle list in the DRM execution context.
>    */
> -int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
> -			     unsigned int num_fences)
> +int amdgpu_vm_lock_individual(struct amdgpu_vm *vm, struct drm_exec *exec,
> +			      unsigned int num_fences)
>   {
> -	struct list_head *prev = &vm->done;
> +	struct list_head *prev = &vm->individual.idle;
>   	struct amdgpu_bo_va *bo_va;
>   	struct amdgpu_bo *bo;
>   	int ret;
>   
>   	/* We can only trust prev->next while holding the lock */
> -	spin_lock(&vm->invalidated_lock);
> -	while (!list_is_head(prev->next, &vm->done)) {
> +	spin_lock(&vm->individual_lock);
> +	while (!list_is_head(prev->next, &vm->individual.idle)) {
>   		bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
>   
>   		bo = bo_va->base.bo;
>   		if (bo) {
>   			amdgpu_bo_ref(bo);
> -			spin_unlock(&vm->invalidated_lock);
> +			spin_unlock(&vm->individual_lock);
>   
>   			ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 1);
>   			amdgpu_bo_unref(&bo);
>   			if (unlikely(ret))
>   				return ret;
>   
> -			spin_lock(&vm->invalidated_lock);
> +			spin_lock(&vm->individual_lock);
>   		}
>   		prev = prev->next;
>   	}
> -	spin_unlock(&vm->invalidated_lock);
> +	spin_unlock(&vm->individual_lock);
>   
>   	return 0;
>   }
> @@ -598,9 +579,9 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   {
>   	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
>   	struct amdgpu_vm_bo_base *bo_base, *tmp;
> -	struct amdgpu_bo *bo;
>   	int r;
>   
> +	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>   	if (vm->generation != new_vm_generation) {
>   		vm->generation = new_vm_generation;
>   		amdgpu_vm_bo_reset_state_machine(vm);
> @@ -610,38 +591,59 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   			return r;
>   	}
>   
> -	list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
> -		bo = bo_base->bo;
> -
> -		r = validate(param, bo);
> +	list_for_each_entry_safe(bo_base, tmp, &vm->kernel.evicted, vm_status) {
> +		r = validate(param, bo_base->bo);
>   		if (r)
>   			return r;
>   
> -		if (bo->tbo.type != ttm_bo_type_kernel) {
> -			amdgpu_vm_bo_moved(bo_base);
> -		} else {
> -			vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
> -			amdgpu_vm_bo_relocated(bo_base);
> -		}
> +		vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base->bo));
> +		amdgpu_vm_bo_moved(bo_base);
>   	}
>   
> -	if (ticket) {
> -		list_for_each_entry_safe(bo_base, tmp, &vm->evicted_user,
> -					 vm_status) {
> -			bo = bo_base->bo;
> -			dma_resv_assert_held(bo->tbo.base.resv);
> +	/*
> +	 * As soon as all page tables are in place we can start updating them
> +	 * again.
> +	 */
> +	amdgpu_vm_eviction_lock(vm);
> +	vm->evicting = false;
> +	amdgpu_vm_eviction_unlock(vm);
>   
> -			r = validate(param, bo);
> -			if (r)
> -				return r;
> +	list_for_each_entry_safe(bo_base, tmp, &vm->always_valid.evicted,
> +				 vm_status) {
> +		r = validate(param, bo_base->bo);
> +		if (r)
> +			return r;
>   
> -			amdgpu_vm_bo_invalidated(bo_base);
> -		}
> +		amdgpu_vm_bo_moved(bo_base);
>   	}
>   
> -	amdgpu_vm_eviction_lock(vm);
> -	vm->evicting = false;
> -	amdgpu_vm_eviction_unlock(vm);
> +	if (!ticket)
> +		return 0;
> +
> +	spin_lock(&vm->individual_lock);
> +restart:
> +	list_for_each_entry(bo_base, &vm->individual.evicted, vm_status) {
> +		struct amdgpu_bo *bo = bo_base->bo;
> +
> +		if (dma_resv_locking_ctx(bo->tbo.base.resv) != ticket)
> +			continue;
> +
> +		spin_unlock(&vm->individual_lock);
> +
> +		r = validate(param, bo);
> +		if (r)
> +			return r;
> +
> +		amdgpu_vm_bo_moved(bo_base);
> +
> +		/* It's a bit inefficient to always jump back to the start, but
> +		 * we would need to re-structure the KFD for properly fixing
> +		 * that.
> +		 */
> +		spin_lock(&vm->individual_lock);
> +		goto restart;
> +	}
> +	spin_unlock(&vm->individual_lock);
>   
>   	return 0;
>   }
> @@ -666,7 +668,7 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
>   	ret = !vm->evicting;
>   	amdgpu_vm_eviction_unlock(vm);
>   
> -	ret &= list_empty(&vm->evicted);
> +	ret &= list_empty(&vm->kernel.evicted);
>   
>   	spin_lock(&vm->immediate.lock);
>   	ret &= !vm->immediate.stopped;
> @@ -966,7 +968,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   
>   	amdgpu_vm_assert_locked(vm);
>   
> -	if (list_empty(&vm->relocated))
> +	if (list_empty(&vm->kernel.moved))
>   		return 0;
>   
>   	if (!drm_dev_enter(adev_to_drm(adev), &idx))
> @@ -982,7 +984,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	if (r)
>   		goto error;
>   
> -	list_for_each_entry(entry, &vm->relocated, vm_status) {
> +	list_for_each_entry(entry, &vm->kernel.moved, vm_status) {
>   		/* vm_flush_needed after updating moved PDEs */
>   		flush_tlb_needed |= entry->moved;
>   
> @@ -998,9 +1000,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>   	if (flush_tlb_needed)
>   		atomic64_inc(&vm->tlb_seq);
>   
> -	list_for_each_entry_safe(entry, tmp, &vm->relocated, vm_status) {
> +	list_for_each_entry_safe(entry, tmp, &vm->kernel.moved, vm_status)
>   		amdgpu_vm_bo_idle(entry);
> -	}
>   
>   error:
>   	drm_dev_exit(idx);
> @@ -1374,7 +1375,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
>   		else
>   			amdgpu_vm_bo_idle(&bo_va->base);
>   	} else {
> -		amdgpu_vm_bo_done(&bo_va->base);
> +		amdgpu_vm_bo_idle(&bo_va->base);
>   	}
>   
>   	list_splice_init(&bo_va->invalids, &bo_va->valids);
> @@ -1602,19 +1603,20 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   	bool clear, unlock;
>   	int r;
>   
> -	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
> +	list_for_each_entry_safe(bo_va, tmp, &vm->always_valid.moved,
> +				 base.vm_status) {
>   		/* Per VM BOs never need to bo cleared in the page tables */
>   		r = amdgpu_vm_bo_update(adev, bo_va, false);
>   		if (r)
>   			return r;
>   	}
>   
> -	spin_lock(&vm->invalidated_lock);
> -	while (!list_empty(&vm->invalidated)) {
> -		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
> -					 base.vm_status);
> +	spin_lock(&vm->individual_lock);
> +	while (!list_empty(&vm->individual.moved)) {
> +		bo_va = list_first_entry(&vm->individual.moved,
> +					 typeof(*bo_va), base.vm_status);
>   		resv = bo_va->base.bo->tbo.base.resv;
> -		spin_unlock(&vm->invalidated_lock);
> +		spin_unlock(&vm->individual_lock);
>   
>   		/* Try to reserve the BO to avoid clearing its ptes */
>   		if (!adev->debug_vm && dma_resv_trylock(resv)) {
> @@ -1644,11 +1646,11 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
>   		    drm_gem_is_imported(&bo_va->base.bo->tbo.base) &&
>   		    (!bo_va->base.bo->tbo.resource ||
>   		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
> -			amdgpu_vm_bo_evicted_user(&bo_va->base);
> +			amdgpu_vm_bo_evicted(&bo_va->base);
>   
> -		spin_lock(&vm->invalidated_lock);
> +		spin_lock(&vm->individual_lock);
>   	}
> -	spin_unlock(&vm->invalidated_lock);
> +	spin_unlock(&vm->individual_lock);
>   
>   	return 0;
>   }
> @@ -2186,9 +2188,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>   		}
>   	}
>   
> -	spin_lock(&vm->invalidated_lock);
> +	spin_lock(&vm->individual_lock);
>   	list_del(&bo_va->base.vm_status);
> -	spin_unlock(&vm->invalidated_lock);
> +	spin_unlock(&vm->individual_lock);
>   
>   	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
>   		list_del(&mapping->list);
> @@ -2268,14 +2270,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
>   
>   		if (bo_base->moved)
>   			continue;
> -		bo_base->moved = true;
> -
> -		if (bo->tbo.type == ttm_bo_type_kernel)
> -			amdgpu_vm_bo_relocated(bo_base);
> -		else if (amdgpu_vm_is_bo_always_valid(vm, bo))
> -			amdgpu_vm_bo_moved(bo_base);
> -		else
> -			amdgpu_vm_bo_invalidated(bo_base);
> +		amdgpu_vm_bo_moved(bo_base);
>   	}
>   }
>   
> @@ -2566,15 +2561,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>   	vm->va = RB_ROOT_CACHED;
>   	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
>   		vm->reserved_vmid[i] = NULL;
> -	INIT_LIST_HEAD(&vm->evicted);
> -	INIT_LIST_HEAD(&vm->evicted_user);
> -	INIT_LIST_HEAD(&vm->relocated);
> -	INIT_LIST_HEAD(&vm->moved);
> -	INIT_LIST_HEAD(&vm->idle);
> -	spin_lock_init(&vm->invalidated_lock);
> -	INIT_LIST_HEAD(&vm->invalidated);
> +
> +	amdgpu_vm_bo_status_init(&vm->kernel);
> +	amdgpu_vm_bo_status_init(&vm->always_valid);
> +	spin_lock_init(&vm->individual_lock);
> +	amdgpu_vm_bo_status_init(&vm->individual);
>   	INIT_LIST_HEAD(&vm->freed);
> -	INIT_LIST_HEAD(&vm->done);
>   	INIT_KFIFO(vm->faults);
>   	spin_lock_init(&vm->stats_lock);
>   
> @@ -3042,100 +3034,62 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
>   }
>   
>   #if defined(CONFIG_DEBUG_FS)
> -/**
> - * amdgpu_debugfs_vm_bo_info  - print BO info for the VM
> - *
> - * @vm: Requested VM for printing BO info
> - * @m: debugfs file
> - *
> - * Print BO information in debugfs file for the VM
> - */
> -void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
> -{
> -	struct amdgpu_bo_va *bo_va, *tmp;
> -	u64 total_idle = 0;
> -	u64 total_evicted = 0;
> -	u64 total_relocated = 0;
> -	u64 total_moved = 0;
> -	u64 total_invalidated = 0;
> -	u64 total_done = 0;
> -	unsigned int total_idle_objs = 0;
> -	unsigned int total_evicted_objs = 0;
> -	unsigned int total_relocated_objs = 0;
> -	unsigned int total_moved_objs = 0;
> -	unsigned int total_invalidated_objs = 0;
> -	unsigned int total_done_objs = 0;
> -	unsigned int id = 0;
>   
> -	amdgpu_vm_assert_locked(vm);
> +/* print the debug info for a specific set of status lists */
> +static void amdgpu_debugfs_vm_bo_status_info(struct seq_file *m,
> +					     struct amdgpu_vm_bo_status *lists)
> +{
> +	struct amdgpu_vm_bo_base *base;
> +	unsigned int id;
>   
> -	seq_puts(m, "\tIdle BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		total_idle += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> -	}
> -	total_idle_objs = id;
>   	id = 0;
> -
>   	seq_puts(m, "\tEvicted BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
> -		if (!bo_va->base.bo)
> +	list_for_each_entry(base, &lists->evicted, vm_status) {
> +		if (!base->bo)
>   			continue;
> -		total_evicted += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> -	}
> -	total_evicted_objs = id;
> -	id = 0;
>   
> -	seq_puts(m, "\tRelocated BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		total_relocated += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> +		amdgpu_bo_print_info(id++, base->bo, m);
>   	}
> -	total_relocated_objs = id;
> -	id = 0;
>   
> +	id = 0;
>   	seq_puts(m, "\tMoved BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
> -		if (!bo_va->base.bo)
> +	list_for_each_entry(base, &lists->moved, vm_status) {
> +		if (!base->bo)
>   			continue;
> -		total_moved += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> +
> +		amdgpu_bo_print_info(id++, base->bo, m);
>   	}
> -	total_moved_objs = id;
> -	id = 0;
>   
> -	seq_puts(m, "\tInvalidated BOs:\n");
> -	spin_lock(&vm->invalidated_lock);
> -	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
> -		if (!bo_va->base.bo)
> +	id = 0;
> +	seq_puts(m, "\tIdle BOs:\n");
> +	list_for_each_entry(base, &lists->moved, vm_status) {
> +		if (!base->bo)
>   			continue;
> -		total_invalidated += amdgpu_bo_print_info(id++,	bo_va->base.bo, m);
> +
> +		amdgpu_bo_print_info(id++, base->bo, m);
>   	}
> -	spin_unlock(&vm->invalidated_lock);
> -	total_invalidated_objs = id;
> -	id = 0;
> +}
>   
> -	seq_puts(m, "\tDone BOs:\n");
> -	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
> -		if (!bo_va->base.bo)
> -			continue;
> -		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
> -	}
> -	total_done_objs = id;
> -
> -	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
> -		   total_idle_objs);
> -	seq_printf(m, "\tTotal evicted size:     %12lld\tobjs:\t%d\n", total_evicted,
> -		   total_evicted_objs);
> -	seq_printf(m, "\tTotal relocated size:   %12lld\tobjs:\t%d\n", total_relocated,
> -		   total_relocated_objs);
> -	seq_printf(m, "\tTotal moved size:       %12lld\tobjs:\t%d\n", total_moved,
> -		   total_moved_objs);
> -	seq_printf(m, "\tTotal invalidated size: %12lld\tobjs:\t%d\n", total_invalidated,
> -		   total_invalidated_objs);
> -	seq_printf(m, "\tTotal done size:        %12lld\tobjs:\t%d\n", total_done,
> -		   total_done_objs);
> +/**
> + * amdgpu_debugfs_vm_bo_info  - print BO info for the VM
> + *
> + * @vm: Requested VM for printing BO info
> + * @m: debugfs file
> + *
> + * Print BO information in debugfs file for the VM
> + */
> +void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
> +{
> +	amdgpu_vm_assert_locked(vm);
> +
> +	seq_puts(m, "\tKernel PT/PDs:\n");
> +	amdgpu_debugfs_vm_bo_status_info(m, &vm->kernel);
> +
> +	seq_puts(m, "\tPer VM BOs:\n");
> +	amdgpu_debugfs_vm_bo_status_info(m, &vm->always_valid);
> +
> +	seq_puts(m, "\tIndividual BOs:\n");
> +	amdgpu_debugfs_vm_bo_status_info(m, &vm->individual);
>   }
>   #endif
>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index b5216bc1292f..cc96a3e6252f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -216,6 +216,23 @@ struct amdgpu_vm_bo_base {
>   	bool				moved;
>   };
>   
> +/*
> + * The following status lists contain amdgpu_vm_bo_base objects for
> + * either PD/PTs, per VM BOs or BOs with individual resv object.
> + *
> + * The state transits are: evicted -> moved -> idle
> + */
> +struct amdgpu_vm_bo_status {
> +	/* BOs evicted which need to move into place again */
> +	struct list_head		evicted;
> +
> +	/* BOs which moved but new location hasn't been updated in the PDs/PTs */
> +	struct list_head		moved;
> +
> +	/* BOs done with the state machine and need no further action */
> +	struct list_head		idle;
> +};
> +
>   /* provided by hw blocks that can write ptes, e.g., sdma */
>   struct amdgpu_vm_pte_funcs {
>   	/* number of dw to reserve per operation */
> @@ -349,46 +366,25 @@ struct amdgpu_vm {
>   	spinlock_t		stats_lock;
>   	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
>   
> +	/* BO's belonging to PD/PT which are internal to the kernel. */
> +	struct amdgpu_vm_bo_status	kernel;
> +
>   	/*
> -	 * The following lists contain amdgpu_vm_bo_base objects for either
> -	 * PDs, PTs or per VM BOs. The state transits are:
> -	 *
> -	 * evicted -> relocated (PDs, PTs) or moved (per VM BOs) -> idle
> -	 *
> -	 * Lists are protected by the root PD dma_resv lock.
> +	 * BOs allocated by userspace where the dma_resv is shared with the
> +	 * root PD
>   	 */
> -
> -	/* Per-VM and PT BOs who needs a validation */
> -	struct list_head	evicted;
> -
> -	/* PT BOs which relocated and their parent need an update */
> -	struct list_head	relocated;
> -
> -	/* per VM BOs moved, but not yet updated in the PT */
> -	struct list_head	moved;
> -
> -	/* All BOs of this VM not currently in the state machine */
> -	struct list_head	idle;
> +	struct amdgpu_vm_bo_status	always_valid;
>   
>   	/*
>   	 * The following lists contain amdgpu_vm_bo_base objects for BOs which
> -	 * have their own dma_resv object and not depend on the root PD. Their
> -	 * state transits are:
> -	 *
> -	 * evicted_user or invalidated -> done
> +	 * have their own dma_resv object and not depend on the root PD.
>   	 *
> -	 * Lists are protected by the invalidated_lock.
> +	 * Lists are protected by the individual_lock.
>   	 */
> -	spinlock_t		invalidated_lock;
> -
> -	/* BOs for user mode queues that need a validation */
> -	struct list_head	evicted_user;
> -
> -	/* regular invalidated BOs, but not yet updated in the PT */
> -	struct list_head	invalidated;
> +	spinlock_t			individual_lock;
>   
> -	/* BOs which are invalidated, has been updated in the PTs */
> -	struct list_head        done;
> +	/* Userspace BOs with individual resv object */
> +	struct amdgpu_vm_bo_status	individual;
>   
>   	/*
>   	 * This list contains amdgpu_bo_va_mapping objects which have been freed
> @@ -510,8 +506,8 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
>   		      unsigned int num_fences);
> -int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
> -			     unsigned int num_fences);
> +int amdgpu_vm_lock_individual(struct amdgpu_vm *vm, struct drm_exec *exec,
> +			      unsigned int num_fences);
>   bool amdgpu_vm_ready(struct amdgpu_vm *vm);
>   uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm);
>   int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
