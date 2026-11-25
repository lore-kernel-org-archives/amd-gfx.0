Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA63606A321
	for <amd-gfx@archiver.kernel.org>; Wed, 25 Nov 2026 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vGV+xBOh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A6EB10FC65;
	Wed, 25 Nov 2026 13:49:24 +0000 (UTC)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43FB710FC65
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 13:49:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V3obEsaugCkgvfMQNLW9SIm+GLCkMWgLy3n6//GP0O+tOYhqUJgdJaUFI0ZCJOpN337wI1R9lHn67w/dXu6v/bIMKV1Hm0dFr5cngZNvDK28hSBzCPC4+6UczquL/znuPlOdkZwWizPS0dtwOA0IV7c094tWXuNSINaGoYgb0DoOl1Le8NWFVwok4y2OG49JtneenSdsXQqJWl+QRE55jozw/UlIIpVMLXqf8NBF/SVSNVAU8iYdly8qI4P1DqPVD19cwuguEYXAnrUlJu0tWsRnL9cM03fqgjOG6I4fRUfoXz7A8WT3srbU9AM+xN7gCJMS9bJVIEai5XZiTzCNow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qu0tAwtNXqmsl+C5jLp4OYkKInOpIL+t/r8V6LQsL8k=;
 b=LM6EpMXNxkAHpelAM73Tr6+5Z74HR/3QCKxXVSZ/4muuy1/51om4mo6h5SqapA8KoIQH+6wMCjNb58/U4Zg7QKYp8TLdNM1IwNP1FwmVThrKJkfhNuQbiVrA4XkTkjHQ6WOX5szCldu2MwFUb3IRtITy/bRkBvl8yZP1jnidiH9W0lHNhmiCG5QK01gx9mDFOSPriqhv+C8A6xKPX5tqf/u/HCPwbVpanWSG5wtVswkEnNHLYsVCBZYxdR4VpXWerGH3pRRwZxAvjwpukDxTplfzk+XZsU53exnYW6yTJBssvO+P7myXvkyQjfThlWn+aixTYDgGIma/N5D4S3cFrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qu0tAwtNXqmsl+C5jLp4OYkKInOpIL+t/r8V6LQsL8k=;
 b=vGV+xBOh7FRb8UjnNaWx4pQoinZ+ydJfBA7fLcfDw0c8XW1MAuCRInJLfGQeFI6qXui1g1ByU9Kns0of1bUNSs9K8W+peuEgqs07KtqvdOjyG2gji4NGD4qtGi/7432p3/nO6W0uhh0YQGVXX+0agbtG/8jhOk6sfN7gg88KGl4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by SA1PR12MB9490.namprd12.prod.outlook.com (2603:10b6:806:45b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Wed, 25 Nov
 2026 13:49:14 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::c3e5:48f8:beb6:ea68%4]) with mapi id 15.21.0662.001; Wed, 25 Nov 2026
 13:49:12 +0000
Message-ID: <64bdf30b-8033-4d74-a928-9d5690aafb24@amd.com>
Date: Wed, 25 Nov 2026 14:49:02 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: unlink userptr bo_vas under the
 notifier_lock
To: Jesse Zhang <Jesse.Zhang@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Alexander.Deucher@amd.com
References: <20261125090415.3345401-1-Jesse.Zhang@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261125090415.3345401-1-Jesse.Zhang@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0118.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::33) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|SA1PR12MB9490:EE_
X-MS-Office365-Filtering-Correlation-Id: 31fb0afd-545a-44de-332b-08df4afae2f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|261102123227099003|261022075727099003|261021121427099003|261021123027099003|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: tOikj1okQq9znfCmXiNhMWjG4uuymp3lWZQKXP0N7uXNANpW6C2IVgnfM+nOCqyjZTzttjb2Y2ZKJsSAvBYh8l65e9bYBTmgN7QVy01/Ut63bDenoB6nVpOmb8sLgmRLO+gaDn+x5ANowmzSJxEBJIc+7qmpgzAiOETAfmqf77tpVBMS5vHbggf/N386VocH+vhnAyKLO0hG4myJVUwF+zs0OtLMDj4TYehWKPQ29rsR89JUqv8utSjvR7XIYmDXKrh/sjOz0m5CAGy3supRd0Fdbf0WqWPm3nvb57Dh1bn4ZdDIv1ELU6q7P3PRCfXGbY9jORzyeZyIW0F+Uhs7weQ5M2ty2j5fM1vtx04XzHR1M5plp7WFpVTVq/UHHky+rD6vsiY2QfcQF/yTX+/HzzjNXDGIw9VRFk+msvT9qkRMbdXKT/yRlHcj71rbVQVuU5I+Jbwk3bW27MF/OoklnOJab9DszctJpBfzl/C92+o+lNqnEb6xDvLiYtgCkBa5Qe3ItScyOj3Xx9K4Mp7qAp5D7g2k/4g9iNEzQ6zmIv7U6Jp8xU1D33dEG00eDHXUBXPo5b6C/t9OUEjxbsoXwbvE6uOLpn5WxCeXxx/KuTxe5HFzeOIds2vJR7Ukr3iKc+4EztPdkrmwN2gW4Hl+Urxim3NlRPIyEHOKkgMrfQ8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(261102123227099003)(261022075727099003)(261021121427099003)(261021123027099003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TjlyT0FOYUFpR3BqRXM2N2g4WDVHOWJTb0Fqek45SEJ3SzBBaGhJQTMrUUx0?=
 =?utf-8?B?ZjRvMUtraEtkY3FidWQyelJlMGx3bDhDK1UvcXlWMXM4eGRpRU5rVStHT3lJ?=
 =?utf-8?B?bWpsYUJHek1OSmhlYWRyMDVpNnVDU2hyKzExbWc5TFFJMFh6Q2tYZXdFTVho?=
 =?utf-8?B?a0lKaEhJdzlEUWJES3ZlQVdORmIwWlBCclF6UkNDK0gyZ29lM1JDRFJxb0c3?=
 =?utf-8?B?aUhMM1MrVGIvVDN3YzhMWlJvQ2taNTJ0L0dPTUhlN3ZjSytVd3FpcTJrTnpY?=
 =?utf-8?B?UDhSc3F4QkR5QXdCUDNMb2s5R0hEN1VuNWdjaitLemNRbXFHWVo1UXJYZFFq?=
 =?utf-8?B?d2Z0czg1MFNNakJyNndteWthbDdWdC9NaTNwRkkrUGlsMmxpMG5KSlZaZFQr?=
 =?utf-8?B?LzRhaDZKakJla0tRaTlQd3kySzZ1Y1Y4OFV1VVA4ZnVWNUJJazlDdlFsdVR4?=
 =?utf-8?B?cnRPb3g5SEZZUVlsUEZoRjhrKzNBRTBUdVE3NUVwWTVITnZ2S3dOcVBidnJM?=
 =?utf-8?B?cU1YeElmQ0lPQlBRYThUeTIyL2VGLzdlakJueHhCVW1xM09oNTdBNFRvc3kz?=
 =?utf-8?B?Wk02b0d2RzVDOERZYzFCdkpibHRUNGVqeEgxTWdtWjNRbDVlNGw1c2hPQTZp?=
 =?utf-8?B?M0J3dXlIYVBzNFplalBIVXI5ZkdTSjRIbFlYTG0xNmNnSlJIYklOeDhuNTdO?=
 =?utf-8?B?VEkyeUYybGNMUDZ3TVl6MHlKdUs3RFZ6RWUrRjQ0UmRSY0pwUkgyQUQ1YWlj?=
 =?utf-8?B?Nko4ZXFHT29PR3VnK2NMZ0FuWEhHUlZZYW1yM1UyWEhpbjY5eFBjdGlXelo3?=
 =?utf-8?B?Ym8xTE9ZcUwycjRWZTR4eEJsVVVmcDRERE5yN0p0YXFoSkUydmFJb3ArN0tq?=
 =?utf-8?B?andEcFNaRW5qQ0x4TStZQm1zZDNmbUI5VWk3aktnbzh1bWlQemRJZlBMS0c4?=
 =?utf-8?B?c0k1dVJMa3ZnUEw5RThJNjAzVU9XcnpDeFpQell0bVl3d3JOK1lZazVHVTZF?=
 =?utf-8?B?MGViUUY0VHlQMnFTRnNxWTZEYmJYWkVkc1FRYyt1MFU2T2J4bHhaUmF1dCsy?=
 =?utf-8?B?bC90T2dSTDZjNklSdGhJRUtSam5UNjVHMEFtVHlRV0tlM2RRbmtPUG9VMjlr?=
 =?utf-8?B?bTVpREpSa0JyUWNpWGFpUmtKUWJXbDdhWmdjVUxNM0htZ0NWY3ZmZ2ZFcFV0?=
 =?utf-8?B?TEtiWE0vTERkRHhueWJmdVhaM0JoV0FzbkVsVUYyMmVheGgxZ2Z4K1JZcWVQ?=
 =?utf-8?B?NXFZU3d1cjFDeWUvMFM4a2pOUlgyaFd2SUpuSjU5aFBQWjZST3FJQzgzbVVL?=
 =?utf-8?B?VjkvWFRnalgwSW83NEtGanpjb3dUeWErTmM2M200cUxHTTU3VjZSOTJWRzZr?=
 =?utf-8?B?WHdIT2Q5WkRZUjVvcHF1RXJyTWhRM3F1Z0VGYmFNVURYS2pJUzJvb3ppbHdw?=
 =?utf-8?B?emtKTTFWdm1ITkIyMkF2OHVmR0hGR0NuakNuekVZZVFKV1JlbFo2dFM1blNt?=
 =?utf-8?B?S1JnQVoyT0RUa3loMGxuYzBENmlZNG9vZlVlK1pDMmttajdUUEZsN3J4Qnhv?=
 =?utf-8?B?TjNzS09YOUo5a2lYSVVIWkhneGFZUVM3eUdHL24vWVdCbHh6cEk4RUtqYU9Z?=
 =?utf-8?B?QjdCUFg2elc5ZGsrcG9UZmpEdjBPN2RlSTRteE0wZm42UVBrWEU5MzNvRmo3?=
 =?utf-8?B?MHhnVk5nVlU3RG9qL1lXNUJONmZPRmZROGp6SHE5b1I4N1VFQzA3YkZFYmF2?=
 =?utf-8?B?Rk1rVUFRVDZ6Q0FPbE5Ib3Z5a0lpaFhORzB5WUpQeEpUNnhBNnhrSmx2MnBU?=
 =?utf-8?B?YkljVFlmSjY2NmVrT3lLZFRCK3JKV2E2TCtRYXFLRWN1M1ZtWnRlUkJRZDdC?=
 =?utf-8?B?MXFKTk12a2N2SUdSNFQ5eXlRZlVkelcrdlF3QmlMczVZM05zc1F5WVBjaWNW?=
 =?utf-8?B?YU45NWRhL0JHWHVxRWlJVUdGMnJrTStwb2NBNTE3cjlSZGF3QmFEdEpXVEg5?=
 =?utf-8?B?MTVEQTlHeGZ0OUh6UWJLcXdrbmNoZktOTHlXM25iOG1WZkVmZGp0S3J1Q05F?=
 =?utf-8?B?eFYybEo4ZU91L2NINmVpSHZWSVFwLzFQQitMNUI5NEJqdGEvK2JZbTVraC9j?=
 =?utf-8?B?Tk1MWnVDeEd5aGJXTms1aFJZUDZBQnFmN1IxQWMvcVB4cFk1UXdoWm1HU2Fo?=
 =?utf-8?B?NkxhaE5MMXA4MHVVOWppK3NYd0xFZGtHY1ZQc1JKYXhuRXlDNW1zZHNuOHhv?=
 =?utf-8?B?V0poeDF5WEZFdnFWaHJWYjdldzc5MjlUUktyd3hVeHMxUjAxdTh5TTdyUFQw?=
 =?utf-8?Q?PWqq/+wNHyN6dD3NFu?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31fb0afd-545a-44de-332b-08df4afae2f7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 13:49:12.5672 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6RxS4lVyXct9FN7fPGcXwHD4U0kMtBMz7L/q5tiB9EiHJApryuCIlUHOvFqFaCS7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9490
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/25/26 10:04, Jesse Zhang wrote:
> The userptr MMU notifier walks bo->vm_bo under notifier_lock, but
> amdgpu_vm_bo_del() removes and frees entries with only the BO and VM
> reservations held. Concurrent invalidation can access a freed bo_va.
> 
> On Navi48, racing userptr BO close with MADV_DONTNEED triggers:
> 
>   BUG: KASAN: slab-use-after-free in amdgpu_vm_bo_needs_update
>    amdgpu_vm_bo_invalidate
>    amdgpu_hmm_invalidate_gfx
>    __mmu_notifier_invalidate_range_start
>    zap_vma_range_batched
>    madvise_vma_behavior
> 
>   Freed by:
>    kfree
>    amdgpu_vm_bo_del
>    amdgpu_gem_object_close
>    drm_gem_close_ioctl
> 
> Take notifier_lock when unlinking userptr bo_vas to serialize with
> the notifier. Test for the task of the userptr rather than its address,
> the GEM ioctl accepts a userptr at address 0 and registers the notifier
> for it as well.
> 
> v2: check amdgpu_ttm_tt_get_usermm() instead of
>     amdgpu_ttm_tt_is_userptr(), which is false for a userptr at
>     address 0 (Sashiko)

That is nonsense and very dangerous. Please use amdgpu_ttm_tt_is_userptr() instead.

Apart from that good catch.

Regards,
Christian.

> 
> Fixes: 1c824497d8ac ("drm/amdgpu: fix calling VM invalidation in amdgpu_hmm_invalidate_gfx")
> Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index ea8672451d98..5f9ed9cb18b5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2279,10 +2279,18 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>  	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
>  
>  	if (bo) {
> +		/*
> +		 * The MMU notifier of a userptr walks bo->vm_bo under the
> +		 * notifier_lock, it can't take the BO reservation.
> +		 */
> +		bool userptr = amdgpu_ttm_tt_get_usermm(bo->tbo.ttm);
> +
>  		dma_resv_assert_held(bo->tbo.base.resv);
>  		if (amdgpu_vm_is_bo_always_valid(vm, bo))
>  			ttm_bo_set_bulk_move(&bo->tbo, NULL);
>  
> +		if (userptr)
> +			mutex_lock(&adev->notifier_lock);
>  		for (base = &bo_va->base.bo->vm_bo; *base;
>  		     base = &(*base)->next) {
>  			if (*base != &bo_va->base)
> @@ -2292,6 +2300,8 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
>  			*base = bo_va->base.next;
>  			break;
>  		}
> +		if (userptr)
> +			mutex_unlock(&adev->notifier_lock);
>  	}
>  
>  	spin_lock(&vm->individual_lock);

