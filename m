Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB41CD5BB1
	for <amd-gfx@archiver.kernel.org>; Tue, 26 May 2026 11:04:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F29B10E17E;
	Tue, 26 May 2026 11:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1hwYiqzm";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010011.outbound.protection.outlook.com [52.101.56.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DB3E10E17E
 for <amd-gfx@lists.freedesktop.org>; Tue, 26 May 2026 11:04:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHSX32GklpKBDe/qQwXovhUrP0WpC0aKcbdghyZfKQ+kvA1smg9u3cq+U0Bir+Q7gvPiRwSRV8Mtyk5Y17AOCxq9+IaWYNlWRTZe60xYvFhLsVlB3na60vLpafckzgJ6n0DEybUAIBZg5xwX/NC4wLu7jhEyWsrsyZ/YJVGfYGOSOXnKMVbriSv+hmfVL89vqQmJb7grhbA5FnZNv6mZYcuD8oCZvDmCzG1t5cMLxJ1tdFsXbgkfzEuZrlV/VRMvmd0V8jnu+mOq+7Y+3IjFi8DvXr/tIDo/iG++4JEpExUzFasshi2yZIRfEGOh3s/FxWmWnMvZL1lHXhfqFOIYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cBdyPabjw8h6tmCi6NOpZ1l/SbNvJnTOoQ19eMUDWIY=;
 b=GIoFavoJyUaaUj0e/idIVgEymiQEqZlVXASR1eg8z3oLP0mss2aGlrMLpD9ip8r8hcb92Qqm9lcZWSD9GyPt/PfdOA9d1G3Z++pX2KPuCvn3BJddY1DrVmX2xCqYWLIRZGxYNHUSfJIpRH/YdN4GBVZkjiNR3Bq11OOTuCiPjCikn3F9eOg8CG+SH9T7fdIDYEYUcBXa1GFGDoV27l1SaQs9LDaomqPaNIFSljBpe7GqldjtYWva5FTX+VhFDVamGDPmri58WAHmSB7kBwqvdeUx6dkJSEO/uiAVPdVdWgaYtWA323BnJDAvMmxyhlggx844sQ8Ot2To8iH8ICE7Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cBdyPabjw8h6tmCi6NOpZ1l/SbNvJnTOoQ19eMUDWIY=;
 b=1hwYiqzmHTsgYC241b/T2iqeAF5vubktuaxx9KyaXnBnHIbJzEGKE2dCIryD0bShNtuQn4e61efmLp64D+Fy3GJv5pc/bKiaUcYMqx91kvNcDP5BTr2WGbwlb3/ralaBujParrA9WgV7K4k50aq4UjZpCNCbKaRSbepLHfW33KI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS5PPFF8845FFFB.namprd12.prod.outlook.com (2603:10b6:f:fc00::66a)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 26 May
 2026 11:04:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 11:04:17 +0000
Message-ID: <e5b2ce8a-f6a9-468a-b265-b3a79f585804@amd.com>
Date: Tue, 26 May 2026 13:04:12 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: reserve TTM move fences slot for rearming
 eviction fences
To: Prike Liang <Prike.Liang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20260526093210.55565-1-Prike.Liang@amd.com>
 <20260526093210.55565-3-Prike.Liang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260526093210.55565-3-Prike.Liang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0391.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::15) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS5PPFF8845FFFB:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a62382b-7b41-4e3f-ee34-08debb1687a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|11063799006|4143699003|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: rtsEqOPIhArcZqArs9DzEYxe9PT8M3F/2ZndwexWgUzXlYxVR+B4jE14ivdKrs+A+LJ8PN6dWoGQK0VQUwGqWYOxqM4rN57gQsIc/wFKXvUDId2qOOLGBfpLtcHe9AFMnsbAPQjB5bo24HMsBKGKcUH084PY4V/BW2l1yiKf18m5z2SrYBrI14jorh0atNsAKbRPz9iGibNQvYbMbejqfHV+b3A/kqf+hW0H6o1HuHaENnzeRQOAysRz9xjW/uZYqN0hh937fAs5hcQYCEgmCe9wEkUd75PU291B5ycj5AjFBV30s8/BwZ5PAOICX837JsZb3ueJz8V0wL021iCRjFII+zANH6hIOnVHlgCxQPiV13zcONEQtq+moo3EOIXKqsO2aIJvog7/hkb74vwNc2ZjGyQZmx+/gc8ux6sNhPIQ2phYxodw6U8Uz6oRd/L1o6aAzZ86Y9vs3eb2RugJR9qbpvgUZMSsSCSvRFFUzN9iXJSrq62GC7xRN1E8TJvjQL8X/KlChwG1Iq1QRtrzRfQd3NbImlyiugnwLmpsLgxxmWelwcbBKDJoNSVbGmxkcaudlnBSR2LKT6z48ZrDcN6ul/rfhfYK4ybSMXb9WLqKUVcbtOVsvHFyvXjrmPdghlKP5hP+ufJLCQpYPeDhmPucoyM57Gwkp65sltPdkU+HTzOaY58faw6ioY2wUJms
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(11063799006)(4143699003)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZThhOUgvWTlJOTBDQ0lWZVpOYW1xK1hvZEZ0Z0NBNlhsaks4RGJ5SUZ0Rzlh?=
 =?utf-8?B?YUhvT2d3UWxqa1ZKUFIyZWZoSWhER3hmTW02d0lYTFB6dVRFdEtCSCtGU0J5?=
 =?utf-8?B?cFpBUVRUbHh0MERzWlZOZUNadkVPRk9iOUh3bllyeXY5K3ltanlJZ0ZVc3Ja?=
 =?utf-8?B?QU5GZXBOMWxEQ2xMRzU1M0lXN3k0WnFLR0lPMm8zT1R4eTZFcGljYlJodVdE?=
 =?utf-8?B?bW5nb0hBcEZ6RUQxWUMvalk2Y2k3MExtd21RMURPclNmODJHcGpjcFB2MDcr?=
 =?utf-8?B?SlRJUmxqaDZ2RGpLTUtHRTJTNzYvUzV2NWdjOVE4YU1DS1UyZmRDS0JsRkxD?=
 =?utf-8?B?U1ZUVlBFWElxUmc4cnplMG1xcUM0T2FlcXBqSFRya05tNTNqeUtNejJiS1Z2?=
 =?utf-8?B?cnhuY2FMaStvMWRiZExpQ2Z6a251R2IxQldma1ZFeVV6NGNqMGRZeE85ZllB?=
 =?utf-8?B?S1pPVUl5MG1IUk1nOCtvV0E4R2tvSzlIbGVKd0trU0hlMERIKzU5TzR2QnFX?=
 =?utf-8?B?ZmpDd1VDcXI5S0h0YWFjZ3hUZG80bnJmUWVLSlhwL1pLaFljWU5pK05kUldv?=
 =?utf-8?B?c041d2V3dVdHMDBQSXBBb1lGenY5dHhDWFdkZzFrL0hCdVQvS0F0d3dPVWNz?=
 =?utf-8?B?WEZuZVJMRVl6MWR0TzJrL1QyVHdCcm0reFNlL1NTVm43aHJHdXJPc0tsRnpR?=
 =?utf-8?B?cDR0YU9ZMjFLakdkaWJWdldIZ2ZpNUE3blJYVUZYekxEeU1GRXlUc3dwY3V5?=
 =?utf-8?B?aXd3ZHdIYU12OHFNaStkTXV4cCswYkdPa1VKdFU3TTlLUFJHWjZ1aXhyaGwx?=
 =?utf-8?B?SjQrZER4QVpabG5tcFZ1V2VkeVRNQzNVMzJ5ME4zK0lPL3JVTjExdWMwVDZQ?=
 =?utf-8?B?TVBBQ0Uwd1RrbThPVStjYnpwTDRzQWZGbkd0MENzZTJvRTZEQzEwOVh5Mlo2?=
 =?utf-8?B?ZmFuSnRwRHd0c1lUVGc4aTIxN0k5T0hXbkc5NzZ2cjY1QmNpQSt1REVoMlN1?=
 =?utf-8?B?YmRaN1pHS3JkNlFjdnNjcEllL0NkQWZWenNpeFF4SWxXcWk1SnBjemdLL2Rx?=
 =?utf-8?B?S25DaDJWR3hta2pBOGt6cjRlLzVYZkFaRVJKelFQOE9aenVqN1NmWnl1UUtK?=
 =?utf-8?B?RW5GN2k3aWpORUZ0UWozREZvRmZPR2dqMGZwQ0ZRanR4djhWL3JSZlRNVUI2?=
 =?utf-8?B?dFd2aSsxWTVxREtCN0RCY1dCUTlqVHZCZVNnT0FVTUhtdVBGMm1jTElFdkxL?=
 =?utf-8?B?SHJ4dERkdXYzWTVLMW5hNE5QcUlNb1RuSitYcCtQQytVcnJPeXNyd25JSmRK?=
 =?utf-8?B?WUZpaGdiWnl1UldCbHowQlFsMHJBTVJzcm9PRjQ1OWNoWUxVVGRBSm9YY29C?=
 =?utf-8?B?SzYwdzBQZVBMYU1YUmdERjJoWjNkNTFnbXVBdDNUcEdld2Npdk5ITmJ3QVkx?=
 =?utf-8?B?cGR6ZmdRZlhMVGY3YjNPdU4xVnZ5WEx2ek42SVA3LzFvWUxBYUg3Z2VEajBV?=
 =?utf-8?B?bFhML0JYczlwUXd3TzBPQWpvc3g4bUFaenA0SUZLUjdrb0RZaG50ODZ5bFZt?=
 =?utf-8?B?M2ZjYXJqY2JaVWZWOHp5STVhdmhZRmR5T1R0RERuNEY4bktPRjNaMUE2aFox?=
 =?utf-8?B?dFBRUnQ4Qjcxc3M3b1RTMjJPc3luQkQwVzRhRWlqMlE4dEQ2WkdIVk1GY3dr?=
 =?utf-8?B?Nllkdjd4TXllMFJnV1MxVmpPVkpod29lUkNsWUhJYk1jaGJJS3p0M2pVMGNL?=
 =?utf-8?B?WlJNRUxWaVhreU5YRGpyYVpUcDhuNnNhZlFpemhncTZ4eWs2QkQ2b0EyU3R6?=
 =?utf-8?B?dkQxSHBCakZnM0NicFpDaVMrWGtCVHRTTUhPaWdQMlE1Y1pHMEZremxmTjFa?=
 =?utf-8?B?RjNqYTMrZlZ2NFNvMElqWFdGSmlIUWNBbFBsdzJRNmxPOTJTZVh3RTdTVGkx?=
 =?utf-8?B?TGx0R20zY1BMK3dOUGVYTG4xMnhYM1c0RzlCUnZWaitOdnNQcW8wT2JjUGx2?=
 =?utf-8?B?cCtIS2piSkFaeUJrNkR6bVdRZXNiU1pxTTJBNkg4UUE2T0pXdktPUkpWTk5o?=
 =?utf-8?B?a0hMdWFlS01RSTJJZW5PcXdhcENWMmxMcG5OMlpNSGpsNTRvK0MwN25vR2JY?=
 =?utf-8?B?aXMwZGlyb2ltbFJNa2krMmlQZWZOVHV6aFB5QzREMkpPOTJSTVo0VVpSckdq?=
 =?utf-8?B?THJsVnBmUWdDYVdIYjhWMGNVN25ZUVlBTEtrNG9jWUxXRkFsbTFhZThkNXlG?=
 =?utf-8?B?cDJDbHBKa1dteE5tSTcwWEU3bHd2U2YydmIxZWIwL0tTbnFncHBTUDBSZmZy?=
 =?utf-8?Q?CQ7bkjvRRFUmgzMNXr?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a62382b-7b41-4e3f-ee34-08debb1687a2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 11:04:17.4311 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+sa4+ro4jh2KgRmjPdghW+0lfoUATWOLLl63a43n0PCvnmskwKVg6QAFBN3KPRf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFF8845FFFB
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

On 5/26/26 11:32, Prike Liang wrote:
> The eviction rearming does not cover possible TTM move fences. If TTM
> moves the BO and consumes move fence slots, the later eviction fence
> add can hit the dma_resv_add_fence() BUG.
> 
> Signed-off-by: Prike Liang <Prike.Liang@amd.com>

Good catch, Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c   | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index ea743407dd06..22ec4eb6e17f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -249,7 +249,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
>  
>  	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
>  	drm_exec_until_all_locked(&exec) {
> -		r = drm_exec_prepare_obj(&exec, &abo->tbo.base, 1);
> +		r = drm_exec_prepare_obj(&exec, &abo->tbo.base, TTM_NUM_MOVE_FENCES + 1);
>  		drm_exec_retry_on_contention(&exec);
>  		if (unlikely(r))
>  			goto out_unlock;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index f650d8d0ef53..39b188848927 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -978,7 +978,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
>  		if (unlikely(ret))
>  			goto unlock_all;
>  
> -		ret = amdgpu_vm_lock_individual(vm, &exec, 1);
> +		ret = amdgpu_vm_lock_individual(vm, &exec, TTM_NUM_MOVE_FENCES + 1);
>  		drm_exec_retry_on_contention(&exec);
>  		if (unlikely(ret))
>  			goto unlock_all;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 519352378b9f..51ddd267da63 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -473,7 +473,7 @@ int amdgpu_vm_lock_individual(struct amdgpu_vm *vm, struct drm_exec *exec,
>  			amdgpu_bo_ref(bo);
>  			spin_unlock(&vm->individual_lock);
>  
> -			ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 1);
> +			ret = drm_exec_prepare_obj(exec, &bo->tbo.base, num_fences);
>  			amdgpu_bo_unref(&bo);
>  			if (unlikely(ret))
>  				return ret;

