Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 480F21061B2E
	for <amd-gfx@archiver.kernel.org>; Tue, 31 Mar 2026 11:51:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2AC810EA99;
	Tue, 31 Mar 2026 11:51:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="D2clqAUo";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011057.outbound.protection.outlook.com [52.101.52.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A1A0810EA99
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 11:51:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HeOfJH4Gba+p+1Utibya+fHzZphE6MQR9fasD7nwx0Apej/pubjY+f+qXK6rK6mxzh5j7yBmgn/FtQqdyBjRNbiEtOFrMrtQUE3L2+Wi2FBiTU+wDivw4XHUMS9OzHUxJfnXw15zfAvbqufotuvo0xomjM0HRPccN7KAub0rBx9i3Te1LDPvVZsSow39Fjgq9TyT7gGtZFCpuLrPfphOi6v56iySemPCm4dST8r1E9/NV+KUH7V7P8WSS7wgHXzP4h0ebFvwkMIzEjLIbwebW+4ld4i0cYVTq/1PzBKsrlgLLl6K5bHynwrZC+WTRGI7VisuLsiX9VPULqA1GfJM6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/K1O0AMW8HV0VYNBeIk9wwId9vie/AfR7x5VEH7KAc=;
 b=zKodGMIOADt37BeelFnvSLgPZNbC4H3ViGMXn04HCjJtiSNf5HhJd2gauNGtNaGffOM7qKYiZysSU04IfGFxpkpJuXdmCWUN+DBTNdMyjxP4UN+DGhFgv7V/kHaYJVMyUA+++4eAolfAb1xCztBVBQWZ4hENJeOMfRJrFgePPeyRuEI3uzlViTVK/kut0Mm832xuwtJKN6nEVNxQR2PGpW0HAt9g6lmJ+SZyE3TY11kPQnVAt2/rp9LO74cl2HDeNSPigwxIy0dohWMC7NKqh9lYSe0hYm9tEDIuw+yK+FF5D52hBA9LRcQfIyd+OEYhNP3qKSkGSOoUAs3Ut5Z+Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x/K1O0AMW8HV0VYNBeIk9wwId9vie/AfR7x5VEH7KAc=;
 b=D2clqAUogouJUeHUpZS14WAqyp8a+1K6crMm6dnILfoSJas+aRwjW5xo/f4VGVDCvLJ6dvUvkUPN6peJVhB5x+KxF6A80zb/SqKg8WTHOtM6eadAe+PvpArnbv6mBEZczxwwvAIy7boKdaxv9Eje41TuMf5uL7iGWsV2qsvrXC4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM4PR12MB6182.namprd12.prod.outlook.com (2603:10b6:8:a8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 11:51:06 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 11:51:06 +0000
Message-ID: <4c88cbb1-521c-4cba-8ce0-8a31c3c24f18@amd.com>
Date: Tue, 31 Mar 2026 13:51:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v4 3/4] drm/amdgpu/userq: call dma_resv_wait_timeout
 without test for signalled
To: Sunil Khatri <sunil.khatri@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: amd-gfx@lists.freedesktop.org
References: <20260331074943.2510941-1-sunil.khatri@amd.com>
 <20260331074943.2510941-4-sunil.khatri@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260331074943.2510941-4-sunil.khatri@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:208:32b::27) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM4PR12MB6182:EE_
X-MS-Office365-Filtering-Correlation-Id: 78674872-1f0c-4409-dd9a-08de8f1bca3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: B0qr3YUWtxzr9zsP6d2MiHMVuJNNigkcSTFz9iXQV8fWy+9gg50ywIZQx/WAjOqSlnzp4FqMVjI4SvOoVEP1OhxUb7WTTroC9WUOxYcmxl4TbFKiosmApMIFZEadWMxOy0L88AqE/31DwZ0uzgakANhWG3juixcQSweoaYkoTlQgtvj173LqXpOO1S6bKEVFxNJU9Asr6r/8K+WYkWwRq5vwwFs1YZhwEa9aswIhMgP6zou6MokhMRgQ0JOqGZ6p5Ii1mp6sWTx2z2E+M3dIG3SoQ7QNIGJQTQQ0pmeDoxiVJL40tbZ2yEgz+a2BT6p6UwmyzchHDg75khmhMqCXO8F1FjIs2PkzULY9DT4z/1w3ZKgr1oz2TyunBPNN3Ed9x9cFcJFtRpTIDsdt4A7hH1MixVxCnF8h5aHGVoBJ8IdczbvP3UbfDz4FDpo5aZqnBeCzVYLj5v2Ak+C/0nuT3yuNRJWPn1YJ9oaJKfTBIjM/EyAI4+epp0aD0jHfZ/0bpsPCj1kbFvDmpJxOqJFq4ajdEI9hgjMkCwdLoc6as/NYk8fzIMa4+81GCegWsrZM6yJN7dkKd8Wxy296TpHgVn1wzdRup5BAfw1WP4BJY+Ci09+9KQAtKNVd9jS5sQGc2PMpBpLTeqvaJ8ikcS8mj2gkN2BiNBw/Jjz7//8e8TEgKLTCcweLSL0QBpQbmTS/WqKB0Wr27267I3I4WmPII36A0CQOP8C6SnlJvoxSlV0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dEcwQWNyOEwwVC9nQmNWRE01YlRINkdVUWtWQWlwNVFvS09PaU9iUzJta2w1?=
 =?utf-8?B?RlFVRDZpV2FQNzVhQTRiaWNxcUlVOGNDWkRlTGdtNTVNV3psY21ZZE1YMm9x?=
 =?utf-8?B?MC90b2RGQzBLUU1mc3BVVGtnUzdGTDVhbGdDVExTcU00Y3ErSFo0a25INFcx?=
 =?utf-8?B?UldWOStSNlM2WjBXYzNKek4wcE1zRy9XS2xOQWI5QlJnd09Md3JPZ2NTMGdI?=
 =?utf-8?B?bHBSd0hZdXBWbDFTU29ROFMvQWRnZWlRSHI1U0pwbVNXL0d2b25CcEQyYXFj?=
 =?utf-8?B?S1JUVkdNNVVST3l4SktzdkhQMGhGM1lGbWNtZFhOK0Ftb3RKN2diL0hWQUh0?=
 =?utf-8?B?ZUIzVk13LzViMFNKanVZdTNzajdFdnozZ2RHb0NBdVJKcnJTZnp0WEdMdWZr?=
 =?utf-8?B?cjVDcmI2blRETk9pYnBNUFBQRGZST2RVSlNLQlVrQlkvb1IycEpKdUxzREdn?=
 =?utf-8?B?ZU9wMmJOK1FROStpZ0FnWHZPTnA0a09UdkR2Tkc3RmgwUFp4OFAvd3EwQldX?=
 =?utf-8?B?c2JGWURhSXdaOHNQekM0TVp3V21DYzRUK25EbmI5TURPOExDdVluTUlPNngr?=
 =?utf-8?B?bXdYOXJrSFp1Tkp3OEt2czNDRnZwODUyM1Y5M2tacldsRjRLaWtCcjFvT3Y4?=
 =?utf-8?B?T21XUnJOeDFyVjc0emswalpWV2U5SXo4Q1RSMkhVSEpVR1Q2SXpmUEV5QytN?=
 =?utf-8?B?SGZxY0xDeHNyNS8zNVhDejRoRjIxWWE1bThVWHBvZUlPZ0FBdUlBa09GWUxa?=
 =?utf-8?B?Nyt3ekppNWZ6cHN4c1pQaTlYWFZrdTBrZGpwdk5iUEVWbThXRFlEQlZCczZE?=
 =?utf-8?B?cGpSOVQwRmJaNVc2c3pGT2Z2TXByUmZmQ0hiTFJJVUpyaWMvdGVWN2QyMmtC?=
 =?utf-8?B?bU5yRUQyeEVSSG44Nk00U2RQRENaMVp3OUJJa0lyQ3ZBZk51U2phSW1yb2M4?=
 =?utf-8?B?VUV1Ry9OQU41SXl1THZXNUlYSC9Naldzb29hLy8waW9ZbU1zeHJud1AvZU9B?=
 =?utf-8?B?b1hXcml1bkZqYWxocUx1czF0OEtrUHhLNWNYaHlPODNIWHNGbi9kOHBHZlFw?=
 =?utf-8?B?TG9kMGlLam1aTVZvUG1OMEtDbURNWEJqSzZOTDdTZGo3OTFROU9ycVFWK2py?=
 =?utf-8?B?d1M5OUp5L0ZOSzNpZU1yTkUzemhuTEhlanBIbUtTZklyYVhyVC8xWUVYVGps?=
 =?utf-8?B?MldDN0ZPTmxDa2d1RmNkeERwSXpadm0rRG9SeW1ZNWRiWXVFYklXS0dMUUZ4?=
 =?utf-8?B?TURJZjV5M0FFaHBrdjhvSHZ5bUJaT2JRaC83cFowd3dlL2hNSEZ0bEhuekRz?=
 =?utf-8?B?REN4aW4yWklPNXAwL3lrYStXR0NIeUgwY1FWNVFsMVgvamo0clFlWEZGZVR4?=
 =?utf-8?B?amkzc3ZTRUhpQVZlRUFnTmxIdWZpUVdnRUd6SmZ1dDVMVGZSVlhCSTVhQ2tP?=
 =?utf-8?B?aFRXdTU3OTdRUC9aT2l6YXpCRmoxUGE4RC9tL3Z3ZXAyUnZtN1ZJazdlT05v?=
 =?utf-8?B?bzBmNkpDTGJXSEpNQU9PYnpneDVLa2pjdGtjQ3VGdG1yaUprSnhpMmNZRHU0?=
 =?utf-8?B?SzhwbFNVNWg1ME0ya2VvM2NZSGJIMi9xMzNSZ05OSVAxZGROQ2RNdjRxYWp0?=
 =?utf-8?B?WW1iVjFUSEtEMEVjTG9oODVRRmg4SXBkUWhpaVQwWFppUDUxcGZHYlIzQ1hv?=
 =?utf-8?B?cXQrelkvdDc4TGU2NXJScmFsOHE0emJCRG1rNGpsaU54cmRKZTdyWFJLT3Ar?=
 =?utf-8?B?Z05aNGhZaWtJSFpzTWYvT2ZKRjcxMHBYWmpaS2VVbEYrQnArMnBFb1lrTmVR?=
 =?utf-8?B?UzZnanU1UGtESU9GUk9RYm1SSi9DcWxaaFdLSTUvc0U5bTlMcDNlMGY0Nkd6?=
 =?utf-8?B?NFVON1FENWUrU3FyT1pkQkVGR0hqSk0ydzFoK05vVlBtbW5TQ1ZSYzEwQ1B6?=
 =?utf-8?B?RHEwT3EwVmFWU2c0bFM3VjR1SnRHaTY1ZlRFUWZrUXJuZkFNUlBLcXRrTFVa?=
 =?utf-8?B?QkZIRkwxdWRodFdYNTRkYjZzcDZ1eDRjQ3Z5MXNpdlMvZWpJV2VSYVN1UDZJ?=
 =?utf-8?B?N1NQbHkzbFBrWnI0MDhKU21oUjFzaXlTem9wMVhMVDhhSTBEd09hdkFUSWVt?=
 =?utf-8?B?WUVHeVJRbmNjQ3lDcC9WUmszZUlwdFF1NTFMTThpUDh5cWdqc0R0dWUrZE1y?=
 =?utf-8?B?NjZhYW1jWlpXQndhVU1ndW5zTjJiOU9pbnFNVlRrQkVPalRldy95R1lCU20z?=
 =?utf-8?B?THRzZ0xnLzMvQWJIdDgrU2Y3QmRxS25iNlJQWm5YeXJzNkNMOFdmQkV6L2py?=
 =?utf-8?Q?96qVCpNEUunbvjdqBG?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78674872-1f0c-4409-dd9a-08de8f1bca3a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 11:51:06.1869 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J/N0BD3pN2Xb8iC2kTsZLcHSfya+L5OGCdClJ4VlRllC8sz5i5w4xxJkE6WV6yCH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6182
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

On 3/31/26 09:49, Sunil Khatri wrote:
> In function amdgpu_userq_gem_va_unmap_validate call
> dma_resv_wait_timeout directly.
> 
> Suggested-by: Christian König <christian.koenig@amd.com>
> Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 11 ++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  4 ++--
>  2 files changed, 4 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index c85a4f4eefcf..0ef829065403 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -1480,7 +1480,6 @@ int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>  	u32 ip_mask = amdgpu_userq_get_supported_ip_mask(adev);
>  	struct amdgpu_bo_va *bo_va = mapping->bo_va;
>  	struct dma_resv *resv = bo_va->base.bo->tbo.base.resv;
> -	int ret = 0;
>  
>  	if (!ip_mask)
>  		return 0;
> @@ -1494,14 +1493,8 @@ int amdgpu_userq_gem_va_unmap_validate(struct amdgpu_device *adev,
>  	 * unmap is only for one kind of userq VAs, so at this point suppose
>  	 * the eviction fence is always unsignaled.
>  	 */
> -	if (!dma_resv_test_signaled(resv, DMA_RESV_USAGE_BOOKKEEP)) {
> -		ret = dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP, true,
> -					    MAX_SCHEDULE_TIMEOUT);
> -		if (ret <= 0)
> -			return -EBUSY;
> -	}
> -
> -	return 0;
> +	return dma_resv_wait_timeout(resv, DMA_RESV_USAGE_BOOKKEEP,
> +				     true, MAX_SCHEDULE_TIMEOUT);

That wait can never fail and so never return an error.

Just return 0 here or even better drop the return value.

Regards,
Christian.

>  }
>  
>  void amdgpu_userq_pre_reset(struct amdgpu_device *adev)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 937a6dd3a4b5..43a7cb2d5db9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -2005,9 +2005,9 @@ int amdgpu_vm_bo_unmap(struct amdgpu_device *adev,
>  	 */
>  	if (unlikely(atomic_read(&bo_va->userq_va_mapped) > 0)) {
>  		r = amdgpu_userq_gem_va_unmap_validate(adev, mapping, saddr);
> -		if (unlikely(r == -EBUSY))
> +		if (r <= 0 && r != -ERESTARTSYS)
>  			dev_warn_once(adev->dev,
> -				      "Attempt to unmap an active userq buffer\n");
> +				      "Attempt to unmap an active userq buffer ret=%d\n", r);
>  	}
>  
>  	list_del(&mapping->list);

