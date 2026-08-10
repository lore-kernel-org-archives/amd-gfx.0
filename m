Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6595BC5AD55
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2026 14:01:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C449610E0EB;
	Mon, 10 Aug 2026 14:01:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YnNam4I4";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010002.outbound.protection.outlook.com [52.101.61.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B0B110E0EB
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Aug 2026 14:00:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HxHWAFiwvxGauL96ETRk8gIqJzFgr6z1GmrGD5FHfcYaxYK8dMZ8on8fc2pAruacQu3UR9X2XdSb3BfkXSelVM4p8atp9zhkVdcShXmbCjB0itBFYav+wM56dhsuK45SX9heDp8bGkhtH+ITXsPtFHnEjeniLi7UkcdTZjlE+81fZXNZehDYlMmiS6rlCL0+0AWb5y+KbFMmNMrnGYhalDHqsVJYXwlhhfw4Ms6yUTFA1zIWVDYz8OoxqksrhmnnybrBB7q86J61LRakPgKA+i54dIXWi6z8jcDUuCp4Ona6oltT2PggODqNfya2HRMSO8QTt8SqhFVL24dy3G9oZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zkRmS9hRDcbAAt62DJsmf9zmW4VpRxtsojvLNZutpro=;
 b=Ji2wdT20UZaMAUNnrayR4AtRnp/0MzYtsjcj+ytFRLhbYCyrVU7cBmVD+BGi2S0vx8+qJ2uAyR3EWQryevvGgcyF6PPKakUxJHYF/6XMK1m8H06Se/DZQyKM06wd5Ksx3XwstW6ONMzTBk00cGe/ee9THoGL/SRINXWbjl+IMAV6xkHrMQHr8zYA8zbPU0v0gtgv1vrnePfk46VZPr7BE0f0RwgZbEMbeYhi0ua4KrZSbNpNEXLBb3gqgGVjtvftzlQrsLfRHlxhxDERe7VfjxpPcHYLjus9V9rrC0nh268GqKfJJHvfY6YJ1+EL16Tlzt48n01w3nJ0pt6OssVbxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zkRmS9hRDcbAAt62DJsmf9zmW4VpRxtsojvLNZutpro=;
 b=YnNam4I41YqIoDwLr8NSvaW0yLa7e0tjVBQ5cU1vfykKSVZPOR6lsBiwu0oCdY0yve+Lk3DmDglBYZxvNSl04Ja9+CXC91vVNdqLFntTHPu9IicHsSMLNpoa6zwyxRxOuJqY0Pj5FBqD9Kso89NJhGvkcUX6ZKHL3qyCbEFxyEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PPF5EBD457EF.namprd12.prod.outlook.com
 (2603:10b6:61f:fc00::610) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.21; Mon, 10 Aug
 2026 14:00:55 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 14:00:55 +0000
Message-ID: <9c9b6e69-4983-47a5-bd10-fbd4a819f4c6@amd.com>
Date: Mon, 10 Aug 2026 16:00:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: avoid building unused VM update fences
To: Bob Zhou <bobzhou2@amd.com>, amd-gfx@lists.freedesktop.org,
 Alexander.Deucher@amd.com
References: <20260810091803.777940-1-bobzhou2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260810091803.777940-1-bobzhou2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0170.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PPF5EBD457EF:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d7110b9-d096-4b36-d61d-08def6e7cbe2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|11063799006|56012099006|5023799004|10067099003|18002099003|3023799007|22082099003;
X-Microsoft-Antispam-Message-Info: 7KN2Qchnn7WAkx+WewWsXOUfj39IWo5cEk9sFoZpUeM/rMDCuKuuUXWt6vBdd3GsDIhATqpfTe52Rrh5hQPQZgyTBpldzL4Vdic/cZ5Y63/sonQ8hYl8uaFc8TQH/W4+zLbuU8euERhHS5iVqw6TinibGO2nTSecZ5ZWYhDBTLEmNPn+MimAskP/4ZW1E+X+btKmmcbc2+OuXxrIqERNsnzucsoqmp1mHNqPMAWP3eCgqIlxMwnNfEAGjmsVCT8NV1APBJ0q06S0XIFccd3JqgiAFf4tdfeIVKKWFMX7J/mGeNN2MhxGynTW/lbEkRLlHVKmY1NQEiLzKGG1I2O7XK7mGoiMUml6tzJcRnJtLtFKHln7SW60Y8oEcLHLJoaZj5WO5jYoBpJms1Uv41jZB89iMBL8e0fDOVLUJqefeUZv5Oo3qdfGEu4PMqt+fTToCovoZi9krMvB6ijyTYftt1gYJK4JFImVllVYqCpZOL/0hnN9bK3YkzXioj5ys204EMThT2Inr7cTkeBR/wCnklaoow+7KM0K2RdmSzdYNCoPe1XpzI9VNOuJKqjeUV5brUWpPyS27MCN5luZW/o4LDbEnvAv9GtNcLgHypj7UBUa69Zg+grXuaiNckNfDe6Wx9/ZId8VePBmlHtCJCGWO8Dm2lg8oeE1vaOLPphF3R8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(5023799004)(10067099003)(18002099003)(3023799007)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bGpYOUxmWm43NVF3aU5yTjhNUkJsQXpvT2M2dDVLWS9SYjhjQ0dpTFpIOGJC?=
 =?utf-8?B?eG91Y3VNTUYveHpsUURESGlBRTluZy9OVDdjdzRGY00xVjl0bThUa25DK0Rr?=
 =?utf-8?B?a0cxV2NHMjJmYVJOVE5BWVRQRzFMbWdmQ0FxSVFmVWw3VW45WDVieU9LNlUr?=
 =?utf-8?B?VUVuNmhzdmN5eitiWEkyRHJnRG9LK1RwV0FoMmFnS2QwZ0pyTFhIUWFNdHBR?=
 =?utf-8?B?TEF0SXJ2NnZtL09TL3Z0WTF2cGVPYVdwYmRDKzJCVnNtTDJPWUlNOWJIUzlv?=
 =?utf-8?B?ZmRoZklTQk91NFRDbTlNWFFGVmk3R1g0Wmt2aUxzYTFpeHNEb3JOc2M0SUxj?=
 =?utf-8?B?c2xHck4wYzdZczNzVnRZTUNGY3d2akJBRUIxQ20vcVY1RzFIaGRMMXVwaURm?=
 =?utf-8?B?M0hSL1Ezdm92TmE3V1BYQjdyY2FOaFFwVmNMUG90ZVVWeDlDRzYyZnVVTVFR?=
 =?utf-8?B?NnNpNFVYb1pUQ2pWOXFpZVEvY0wwQ0hhcUZlTWlvR25NUkNKK0ZvSFJMUTI5?=
 =?utf-8?B?TlFTRGJwQVBwSVo0NWtuQ2dWWk1uMjZWSHJNandiTDJpTHBMaHdKY3BJN29V?=
 =?utf-8?B?K2lFZmJZcUgwZ3dxOC92SXIyenlDdktnM0EwZk5mVTRCZm9ReWo5REgvdnB6?=
 =?utf-8?B?bHVXRytqbndTMTJZZi8xbHdTRjB6M3dTRjRZS3BiMC82TGo5aDBTSjhIK1BD?=
 =?utf-8?B?WUhPYndJL3MwV0tMTUlXZ3poYXdsZXhnT1lGWDE4aFFPRmRJUGhjcGlUZEJ6?=
 =?utf-8?B?YmNsak9wN1lrRlhVRVhzWlRpVXFhcHh5aElDdkZkZms2QjhDOXpzaTJ3aTBK?=
 =?utf-8?B?U1JPS0lZU05kWURGQWpqNEVmaEFhWEtqenVEY3hEWDhWVy9TUUhMY01lb0sy?=
 =?utf-8?B?SGRkN1g4dmZqNnowcWNtaVI1QkdleU9kcVVSWmJoTGpUVEZ6djRTeDBaaEUz?=
 =?utf-8?B?R1h2MzVHc2ZzQnJPMXdBcUdIMzRmUmZuRmw1cUZvWHcwdmNqZWNCMC93TEVM?=
 =?utf-8?B?SDNLNUpzak9XaDlSbkVENVNBWUplS2tjMzQvYXcvdE1FR21UMkN2a29RejRZ?=
 =?utf-8?B?UGJJUFV0enp5elZmR3JweEVQUW9TaU5qTldKYUVRVlF5ZUphWHZ5S1Q5L1do?=
 =?utf-8?B?aWxFZnI0czRzS0thWW9XVE5uOUoxZnVlTktiWmNXQ005Z0ZYSDJJTDREVC96?=
 =?utf-8?B?VWJlbmt4OVlsWm5uNS9TMFJJb3ZiT2E4TEd2MGxaaGgzanlyVnFMb0J1V1Vl?=
 =?utf-8?B?OW9IYTE3c3R5VnB1RE02c0RHWXNobzMvUTd5WDFnbHljZHBoSEIvd2Mvc2hq?=
 =?utf-8?B?OWE2dXFveVMwT1pBczV0U3RpYXRnbnQ0VndYVnZ4cnd2TVJsYkY3V0dIMjI1?=
 =?utf-8?B?UG9La0RoL2VaVGpwRktYMktYa2YwbHJzMWx5NWRXUW9OSStqWDQ4VXMwYVZD?=
 =?utf-8?B?L2p5YjJacFIrVzFGU0ZmbFRXcmdwdW9UdytXQS83ZlhBZ1JmZzNaYWo1NHNk?=
 =?utf-8?B?a3pDOWs0enI4RWNnRWpRWGtRRXo4eVhUZEc1ZWtDdjJLdENuenhKVURRdVFU?=
 =?utf-8?B?MDdYQ1M1NFR6TGtQeXorTGZxWFMyMVJOeDBZemdJK1VxNytlMElBV3hvdHQy?=
 =?utf-8?B?VVo4M09QUXBjYWttbjVBWitmMXUwS2ltQXcyejdrVXFUQ2l2UDJjMU82QlZB?=
 =?utf-8?B?aGtDS3NQbUh5b21abHpKcWtXajJWNTNFdWNnVWg0Z1B5eG40UkVQbjJwNmpi?=
 =?utf-8?B?SE1PUjlxSlg0TVNQL3dQMStadDVHdGhBK013WjRKNERHa3BTWExhSWtMS01K?=
 =?utf-8?B?Y3VHUVF1b3psZCszWEtJUTlmN2FrNzVRV2hvY1MzdWtTNWJVMXVPWlVPMm1O?=
 =?utf-8?B?ZmVOQmlZZ2ZQeEtSK1VVd3VOdWlMckhnWUl5a09wdWt3eDNWMFgzTldGbWpr?=
 =?utf-8?B?WUNWZy9kcG4xdVEvbW1GenpUWGVWdHJ1UXBadVowMDd6YkFVcTNuRHZGSjdB?=
 =?utf-8?B?bzFUaFBjc1JrRVExb042ait0RzFta2RxSWNiaHY2VkFGT2YrOE5QbVZtWnJV?=
 =?utf-8?B?NkVmOWhWUzZ1MyswdHhnWEI4YlhvRnZjNHU5Y2F1Q0NGa1Jucmc5b2MxUEhS?=
 =?utf-8?B?SWVvdTlMaGltNjkwM2RTeUdpbEM2aVpmUGh5aVZzd3B4V3VaLzNRanZBbnlE?=
 =?utf-8?B?WnA2bFJDWTlTcjRXL1BQOGd6ZkRoL3RKZEw0QUh3ZE5FUzlTTmFCbGwrSHpw?=
 =?utf-8?B?Zm9hMXVNNFNEV0ZFNENHUjlaSjNJd3NSVCtQaU1rYWZLektrYjhjZXpneDZj?=
 =?utf-8?Q?aBr54AMXkcg5isY+Z2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d7110b9-d096-4b36-d61d-08def6e7cbe2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 14:00:55.4764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6bjCXc0+3d+gZVGMlzSioKNn02vREkmd7r/n378ySlSmYRrbvj2y84oKMoFvOnSI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF5EBD457EF
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

On 8/10/26 11:18, Bob Zhou wrote:
> amdgpu_gem_va_update_vm() returns a fence for every immediate VA
> update, but the ioctl caller only consumes that fence when userspace
> requests a VM timeline syncobj. Without a timeline syncobj, the helper
> may take fence references or allocate a merged fence that is
> immediately released.
> 
> Pass the timeline syncobj into the helper and skip fence construction
> when no output fence is requested. Preserve the existing stub,
> merged-fence and error behavior for callers that do request a timeline
> update.

That just massively complicates the handling without any gain at all.

Why the heck should we do that?

Regards,
Christian.

> 
> Signed-off-by: Bob Zhou <bobzhou2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index f754a4a3a1c22..2837553e4f58a 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -754,6 +754,7 @@ int amdgpu_gem_metadata_ioctl(struct drm_device *dev, void *data,
>   * @vm: vm to update
>   * @bo_va: bo_va to update
>   * @operation: map, unmap or clear
> + * @timeline_syncobj: VM timeline syncobj the fence gets attached to, or NULL
>   *
>   * Update the bo_va directly after setting its address. Errors are not
>   * vital here, so they are not reported back to userspace.
> @@ -765,15 +766,15 @@ static struct dma_fence *
>  amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  			struct amdgpu_vm *vm,
>  			struct amdgpu_bo_va *bo_va,
> -			uint32_t operation)
> +			uint32_t operation,
> +			struct drm_syncobj *timeline_syncobj)
>  {
>  	struct dma_fence *fence;
>  	int r = 0;
>  
>  	/* If the VM is not ready return only a stub. */
>  	if (!amdgpu_vm_ready(vm))
> -		return dma_fence_get_stub();
> -
> +		return timeline_syncobj ? dma_fence_get_stub() : NULL;
>  
>  	/*
>  	 * First clean up any freed mappings in the VM.
> @@ -799,6 +800,14 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  	if (r)
>  		goto error;
>  
> +	/*
> +	 * The VM update work above is already committed. If the caller does
> +	 * not need a fence (no VM timeline syncobj was requested) skip building
> +	 * the otherwise-unused merged/last-update fence.
> +	 */
> +	if (!timeline_syncobj)
> +		return NULL;
> +
>  	if ((operation == AMDGPU_VA_OP_MAP ||
>  	     operation == AMDGPU_VA_OP_REPLACE) &&
>  	    !amdgpu_vm_is_bo_always_valid(vm, bo_va->base.bo)) {
> @@ -826,7 +835,7 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
>  	if (r && r != -ERESTARTSYS)
>  		DRM_ERROR("Couldn't update BO_VA (%d)\n", r);
>  
> -	return dma_fence_get(vm->last_update);
> +	return timeline_syncobj ? dma_fence_get(vm->last_update) : NULL;
>  }
>  
>  int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
> @@ -996,7 +1005,8 @@ int amdgpu_gem_va_ioctl(struct drm_device *dev, void *data,
>  		struct dma_fence *fence;
>  
>  		fence = amdgpu_gem_va_update_vm(adev, &fpriv->vm, bo_va,
> -						args->operation);
> +						args->operation,
> +						timeline_syncobj);
>  		if (timeline_syncobj) {
>  			if (!args->vm_timeline_point) {
>  				/* Replace the existing fence when no point is given. */

