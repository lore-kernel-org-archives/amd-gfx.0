Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0152CC43458
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jun 2026 08:27:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BE4310E04F;
	Mon, 29 Jun 2026 08:27:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Q5InMF5E";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012002.outbound.protection.outlook.com
 [40.107.200.2])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5E5C10E04F
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jun 2026 08:27:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xc9UdVq5rFHfTtbmpPBLFsb3cHrv185puRfkQ2QSnrU4jeAZcZ7KnkqpN81YqXPSKEp+/6CV+ngzmRRpKTC81vrNhrKEvIoJ6EZauLJEtnL1pAewtJaLRfiYiIBWlB7D99wkD99X4dhKgv3i9a+zXFdUIgOBK0yc7iyTFKAUdJDb70Bw4J+tmKb1b+hu84LXXxubSzQRL39Hh6XbOuGY1yABdJQRkvuA1KzNw02iwJ+Wj0QqSOVPgl+N5wjrvtucwIo/5mjg/9uUIPXIqJXfB17n0Q1EIkdzox9IXQCWha0wN8hYcRjtn9BryU7GSubCAonBVyq25qjZGf10I2kXpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yeh83ZvWCsm4871jSPcKZ/L5zt4E2nOEnJw5iXUzieY=;
 b=a7v3yNx3xa9HBhtW5jX/bviB04wfB9aHoLw3ALTXpIjbULMpZHzsxgs8itUaZQCEGvisSrFY0Y3/jUsaK7dvxRseYvP/Dw+GYQpnq7T7CTR4lQEKutCpqeynhbWYwv0ty5X7C4L72VaRoq2LqdwnCScjQr4P4Pwwd6ipim+FNsaJdaXKM1jC2uX69mmvbQGOTKjGmuGS2kVpX+/pHdP7btE9nrhsa9oQRi4ySUE7DB8LUo17ifQsTcHX+cs3pEyHN/Ao5BJw+32NYiuE0E2IEDV9axzmhOTtSS7XcBgxobmWY8A8Go3/niAM7a/agYsAUVffBe9lb9qwPiZfO6ENKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yeh83ZvWCsm4871jSPcKZ/L5zt4E2nOEnJw5iXUzieY=;
 b=Q5InMF5Er4rFJKO5QjtpXza2/Va7fFSMpuSgs5ugXK6holm3PDfGs/IjEqj8x8qvrqj6s6xM9AaXbG7Eu1j5asmbyi1zD8WWlYWHvkt2epfBCm3sIlZucbm7ZQZEtbLIhMXhqjdKoc/mv0EKAIiIsfhECc8gtvQmM+bA+QZvaNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 08:27:24 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 08:27:23 +0000
Message-ID: <67a37c1f-e09e-4eac-b100-0702557c2244@amd.com>
Date: Mon, 29 Jun 2026 10:27:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] drm/amdgpu: Simplify amdgpu_vmid_grab?
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com
References: <20260626161002.13908-1-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260626161002.13908-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN9PR03CA0091.namprd03.prod.outlook.com
 (2603:10b6:408:fd::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH3PR12MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: e089839e-4be3-4231-e450-08ded5b83ec0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|5023799004|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 1l+djrlvFOWc4s7lfDfp3PAb+LrBITXMbECGMm0Sto3hfhLHi594DOIOkqCZwSVFuG/BFRk6YJGHTK+fI2EX+M8vZPtgMUqsHubqhxjfr5xXKeGVRXeZRMSuOQOItyM6msJhK/paxUsGLRN5urB6REdlGHAXdypORdhXPVVHxfILk7OtLgeguHzQ83hny7m7n1FAXMiE2l0fRmwpUgDyympf8qFlMdZaiyUD0O5c6DL0nhrIpWoikKlyxecVxmT+y0zIF6afzyYGCNmxNsGiGslUhOFIGOu6JVnOy1+ifvCSOQ6uKUCW7YLyLjxOHrIutXDZ2NyoT+T8wWLRjArXFXAR8YQ+fSkHw5SoH5W+D6E5hFTtnwk/cdcV/zEg1GJXmAODsfQYWBQfUG3E1A2OzdSMSv8/sPRjtWBAKHSC3ME4f2dLMsec9bQ0xfAm4iEt8e6dAzgEGa0XcyxMGVSA5f9qMmZOGVNxfv+Idz3okyTCoHaisx8xlZi6LlVLFLT4ZDFac/LXnS3tvAOoRgtvZTPZfp5pxeXefvTedaXjztDoLz8iDwrmVlAtFDMUo35SS/pqqNPBth2n9hCKF4YUTTG47Av5zl3XLytMk2xr7w0VKDVHw/8QWrRGJb5m6wESwN/1y5vNvG4GZNo9caVQJGmX7ozWJzBwjLuZVbZSwWY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkRwb2xBWmJMKzR5UTJQOG9tcE5OTXdQUWZBUFpyVndhRHV1YzVtbDlTZHpI?=
 =?utf-8?B?aTAxQzFMcmNHM2oyZnVsYXFCOTZ1S2pLMVJXV2F3QTRiMEpnM2dicGc3NThG?=
 =?utf-8?B?bEM4aFZETEU1TWZIcnhidnl5RElHd2xRTkJUNEtDa0hCZ0FESmpjd3dqbEZh?=
 =?utf-8?B?NURTNEFsWll5Y0J2TnZXQjBxbGMzaCtoOWw4TDIzbEhncVZGNHdPc0I0VzhC?=
 =?utf-8?B?Zk9MU3Fqc3dkSmFXZUJOL2FXaTZyUHRhcllWN3Z4KzRPNVpwSU9Obk5KUmZN?=
 =?utf-8?B?cW90QTF5eE1WN3V1VDNPMHFxd1ZVektVcndjdmgwTDY5RUhFUS93WVJDQTh2?=
 =?utf-8?B?QUZrdjQrRE9SemRoNkhBTDlyUThHN1dBb2pmRTRSa2Y4WmRGQUZ5elg0WWhs?=
 =?utf-8?B?TDFTWDRWRFAxenVsM1VjSDlKUUU1NEhwSEZlSHpRMENvcUNkamtPUVNWV3Vh?=
 =?utf-8?B?OVdwYVA5d24xdHZrUXRPMXNaU0t5RHl4SGgrTGhqemRYVkZET0s3NUduRTRO?=
 =?utf-8?B?TWVyaWF2M3VJUENwYmRFNkNJendKR1p0ckNiT1F4ZXNkTGtna0wxdGlwSXVE?=
 =?utf-8?B?VFNHdGNIVnFHSEtFN3VuM3FWcW5hK25TVWxUWFpySUErRk1Qc296aDdmaFFY?=
 =?utf-8?B?NWk2VzRGVFE4ZW9iTHpMR2tkc3VkRDhnRFh1R3BJMmpLL2V0QUorOWZqVUF1?=
 =?utf-8?B?cXpoVWI2cDFNVjRWM1AzVUh1Vi8vWXhMZ1hsMWlxODBQTjZpdUR2VjZFc00y?=
 =?utf-8?B?eTUwQ0dRM0ZodUF0SzBWWXdzZDJuOVF3a0lnYWNxY3lCOVdtcU1mUTU1WldR?=
 =?utf-8?B?NCtJZU9IeFVSd3ZjVStMbWlva05iN09XOG9RUUpjYmpiUU9sMkJNSHZHcGxx?=
 =?utf-8?B?MFdGSzUrZDZRZXJ4akpsV1NCTk1xbXMxV3BlcHM5V0lrTEZzNHFtaGVrVTZj?=
 =?utf-8?B?L2JXMncvQW1PQjV3L0x0dSttOXBzN2pvR1JvZHZXM0JibDBVWVFRTGR3WU91?=
 =?utf-8?B?QzJCbVBxL2JyQVU5aWZLSTRqMDRHc3ZtS0JwZFUxeUxhdkZneEpub25pdnVM?=
 =?utf-8?B?MmkzN1RHWVNJTGRsUktNOWlLWTZEemphTEk1bFJpZy9EZlJPWGZYdHBDYXNu?=
 =?utf-8?B?MWszd0RzYXcrWFNTdDZaMnlSMkpkN0NwQmxZOXJXZUJFRDB6VkkveXAvM1Fj?=
 =?utf-8?B?d05IM0t0V0M2cCt2QitqYldJbDAvTTRjVU55WHF0WnhDbmRaTU5UNTVoMUdM?=
 =?utf-8?B?QXRweDA2ZkF2cW5HdXhPWXJtZ1BXMXgzaGNqMFpBRGgvSS9mMlY0czFOei9z?=
 =?utf-8?B?MktneXE4YmcwZXVPelRRdmFxU2VUclp3YVc0NFVzR29Jc0o3c3E5L0g3Si9B?=
 =?utf-8?B?em43ZnpoakMwZXF1NlYzbnlDcXZkeC9HdmxnNW9ad1Z0MnZ0WkRTME9vdkw4?=
 =?utf-8?B?T01UdjhzYnNzU2pxVEdFV1Z3TFNORDgvSDJpN21yNFp0R2hkYWVPUDIvbWNp?=
 =?utf-8?B?WlpIZG0yM0pURnZ4NkJYa3ZWMkc1MG4vWjlOOWtHWG1vQnA2V1N5Qmg5bmRF?=
 =?utf-8?B?ODk3YkNlNU41WTNoUFlXNTc3QnhEMUw3OFJkSnVmZHJ3MXNRZHYzWVFNbUhh?=
 =?utf-8?B?cTBKNFh0aXVRRXByOFArR3ZDVE84Y0daZXpCWFFuTTQxQXJGOHZnMndFRmds?=
 =?utf-8?B?c1pUbW1WL04ycnBMQlk5NkNERkFLR2Q2KzVFMlVKMktnRWltalJPNktBZUJr?=
 =?utf-8?B?Ukk5dGU1R01QemxXYlVQeTJuRHVhLzRiUHMwK0FIK0tOZXU3STQ2QXNUT0Ir?=
 =?utf-8?B?WjgvVWg2Z0lzWnVEbWYyZmYxV3pkcEUwbzF4TE8zSENhKzNIc1FYSElCZ1pG?=
 =?utf-8?B?WWlMMEcvUWVXL3duRjlsWlREMnpvME93aXQvWHU0bHo4NlNtSzg1TFh5TERF?=
 =?utf-8?B?NzVVMlN1VVducUJBTnNlYUo3YUtnMkNlQ2pFZlhabjlHd1orNGZpcXRlK3Rs?=
 =?utf-8?B?UjhWa25hdC9wakoxaGZKckU5OForQnlCQlMrdklwZ0hTOEFuWWRBTi80VHFS?=
 =?utf-8?B?aEVLd1BUUUpteG9EUGJRelNBNmxSdHVyZzg4QW5RVEtrZ3VmWktQb3Z1OUlk?=
 =?utf-8?B?NUk2aGhvL21LOUMrNkhxUEI0ME9MNGFqU2pYaGkvd2d3UHBEMmY1VlgrVjFq?=
 =?utf-8?B?VjNOQnVlaktxNDBFWlE1cE1CdXhRdXIrWVNYNlBEc1RRajFubE5GaTYrQ2JL?=
 =?utf-8?B?WjVxYWppamxjdXhvVG1KemZuVnpNbDN3YWgwR1dtNjNsRDdYSkVHbVFqWEJr?=
 =?utf-8?Q?3Kkpfoznx7mxQrpW8i?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e089839e-4be3-4231-e450-08ded5b83ec0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 08:27:23.9054 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QJwxXhO0cnqPSfpzykavyUzbVN8p5NkGqgmuOT9fbYYYhvTokBxTuXATNAX99qFC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194
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

On 6/26/26 18:10, Tvrtko Ursulin wrote:
> This is not a proper commit message but a conversation starter:
> 
> I found the flow of amdgpu_vmid_grab a bit confusing and decided to
> butcher it, heavily, to see what will happen. To my surprise, I was able
> to start a dozen of parallel 3d apps and nothing broke.
> 
> In no particular order:
> 
>  - Amdgpu_vmid_grab_idle cannot return an error despite the code claims it
>    can.

Yeah, that's on my cleanup TODO list after I removed the memory allocation from that path.

>  - Also, why it is called before attempting to re-use the previously
>    assigned vmid?

Because of fairness. That's necessary otherwise submission hungry application can starve processes which only submit something here and there.

>  - And why it is called before the reserved vmid path and then not used?


>  - What is the point of ring->vmid_wait? It is never cleared and isn't
>    the same effect achieved by simply waiting on the last LRU entry?

Different rings see different VMIDs busy because of pipelining.

In other words what can happen is that the last LRU entry changes while somebody waits for it to become idle.

So to guarantee fairness we need to make sure that everybody who wants to use this submission ring waits for the same fence.

Regards,
Christian.

> 
> What am I missing and what have I broke? :) Or if nothing, then:
> 
>  3 files changed, 64 insertions(+), 99 deletions(-)
> 
> And:
> 
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-465 (-465)
> Function                                     old     new   delta
> amdgpu_vmid_grab                            2917    2452    -465
> 
> Which is not bad? Not least the clearer flow of amdgpu_vmid_grab(),
> one of the hottest functions in the submit worker after all.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian König <christian.koenig@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c  | 159 +++++++++--------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |   3 -
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   1 -
>  3 files changed, 64 insertions(+), 99 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 124fb38eb465..37405f9ff7e5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -199,48 +199,35 @@ static bool amdgpu_vmid_compatible(struct amdgpu_vmid *id,
>   * amdgpu_vmid_grab_idle - grab idle VMID
>   *
>   * @ring: ring we want to submit job to
> - * @idle: resulting idle VMID
>   * @fence: fence to wait for if no id could be grabbed
>   *
>   * Try to find an idle VMID, if none is idle add a fence to wait to the sync
> - * object. Returns -ENOMEM when we are out of memory.
> + * object.
>   */
> -static int amdgpu_vmid_grab_idle(struct amdgpu_ring *ring,
> -				 struct amdgpu_vmid **idle,
> -				 struct dma_fence **fence)
> +static struct amdgpu_vmid *amdgpu_vmid_grab_idle(struct amdgpu_ring *ring,
> +						 struct dma_fence **fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	unsigned vmhub = ring->vm_hub;
> -	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
> -
> -	/* If anybody is waiting for a VMID let everybody wait for fairness */
> -	if (!dma_fence_is_signaled(ring->vmid_wait)) {
> -		*fence = dma_fence_get(ring->vmid_wait);
> -		return 0;
> -	}
> +	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[ring->vm_hub];
> +	struct amdgpu_vmid *idle;
>  
>  	/* Check if we have an idle VMID */
> -	list_for_each_entry_reverse((*idle), &id_mgr->ids_lru, list) {
> +	list_for_each_entry_reverse(idle, &id_mgr->ids_lru, list) {
>  		/* Don't use per engine and per process VMID at the same time */
>  		struct amdgpu_ring *r = adev->vm_manager.concurrent_flush ?
>  			NULL : ring;
>  
> -		*fence = amdgpu_sync_peek_fence(&(*idle)->active, r);
> +		*fence = amdgpu_sync_peek_fence(&idle->active, r);
>  		if (!(*fence))
> -			return 0;
> +			return idle;
>  	}
>  
>  	/*
>  	 * If we can't find a idle VMID to use, wait on a fence from the least
>  	 * recently used in the hope that it will be available soon.
>  	 */
> -	*idle = NULL;
> -	dma_fence_put(ring->vmid_wait);
> -	ring->vmid_wait = dma_fence_get(*fence);
> -
> -	/* This is the reference we return */
>  	dma_fence_get(*fence);
> -	return 0;
> +	return NULL;
>  }
>  
>  /**
> @@ -249,34 +236,33 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_ring *ring,
>   * @vm: vm to allocate id for
>   * @ring: ring we want to submit job to
>   * @job: job who wants to use the VMID
> - * @id: resulting VMID
>   * @fence: fence to wait for if no id could be grabbed
>   *
>   * Try to assign a reserved VMID.
>   */
> -static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
> -				     struct amdgpu_ring *ring,
> -				     struct amdgpu_job *job,
> -				     struct amdgpu_vmid **id,
> -				     struct dma_fence **fence)
> +static struct amdgpu_vmid *
> +amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
> +			  struct amdgpu_ring *ring,
> +			  struct amdgpu_job *job,
> +			  struct dma_fence **fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	unsigned vmhub = ring->vm_hub;
>  	uint64_t fence_context = adev->fence_context + ring->idx;
>  	bool needs_flush = vm->use_cpu_for_update;
>  	uint64_t updates = amdgpu_vm_tlb_seq(vm);
> +	struct amdgpu_vmid *id;
>  	int r;
>  
> -	*id = vm->reserved_vmid[vmhub];
> -	if ((*id)->owner != vm->immediate.fence_context ||
> -	    !amdgpu_vmid_compatible(*id, job) ||
> -	    (*id)->flushed_updates < updates ||
> -	    !(*id)->last_flush ||
> -	    ((*id)->last_flush->context != fence_context &&
> -	     !dma_fence_is_signaled((*id)->last_flush)))
> +	id = vm->reserved_vmid[ring->vm_hub];
> +	if (id->owner != vm->immediate.fence_context ||
> +	    !amdgpu_vmid_compatible(id, job) ||
> +	    id->flushed_updates < updates ||
> +	    !id->last_flush ||
> +	    (id->last_flush->context != fence_context &&
> +	     !dma_fence_is_signaled(id->last_flush)))
>  		needs_flush = true;
>  
> -	if ((*id)->owner != vm->immediate.fence_context ||
> +	if (id->owner != vm->immediate.fence_context ||
>  	    (!adev->vm_manager.concurrent_flush && needs_flush)) {
>  		struct dma_fence *tmp;
>  
> @@ -287,26 +273,25 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
>  			ring = NULL;
>  
>  		/* to prevent one context starved by another context */
> -		(*id)->pd_gpu_addr = 0;
> -		tmp = amdgpu_sync_peek_fence(&(*id)->active, ring);
> +		id->pd_gpu_addr = 0;
> +		tmp = amdgpu_sync_peek_fence(&id->active, ring);
>  		if (tmp) {
> -			*id = NULL;
>  			*fence = dma_fence_get(tmp);
> -			return 0;
> +			return NULL;
>  		}
>  	}
>  
>  	/* Good we can use this VMID. Remember this submission as
>  	* user of the VMID.
>  	*/
> -	r = amdgpu_sync_fence(&(*id)->active, &job->base.s_fence->finished,
> +	r = amdgpu_sync_fence(&id->active, &job->base.s_fence->finished,
>  			      GFP_ATOMIC);
>  	if (r)
> -		return r;
> +		return ERR_PTR(r);
>  
>  	job->vm_needs_flush = needs_flush;
>  	job->spm_update_needed = true;
> -	return 0;
> +	return id;
>  }
>  
>  /**
> @@ -319,57 +304,46 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
>   *
>   * Try to reuse a VMID for this submission.
>   */
> -static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
> -				 struct amdgpu_ring *ring,
> -				 struct amdgpu_job *job,
> -				 struct amdgpu_vmid **id)
> +static struct amdgpu_vmid *
> +amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
> +		      struct amdgpu_ring *ring,
> +		      struct amdgpu_job *job)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	unsigned vmhub = ring->vm_hub;
> -	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
> +	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[ring->vm_hub];
>  	uint64_t fence_context = adev->fence_context + ring->idx;
>  	uint64_t updates = amdgpu_vm_tlb_seq(vm);
> -	int r;
> +	struct amdgpu_vmid *id;
>  
>  	job->vm_needs_flush = vm->use_cpu_for_update;
>  
>  	/* Check if we can use a VMID already assigned to this VM */
> -	list_for_each_entry_reverse((*id), &id_mgr->ids_lru, list) {
> +	list_for_each_entry_reverse(id, &id_mgr->ids_lru, list) {
>  		bool needs_flush = vm->use_cpu_for_update;
>  
>  		/* Check all the prerequisites to using this VMID */
> -		if ((*id)->owner != vm->immediate.fence_context)
> +		if (id->owner != vm->immediate.fence_context)
>  			continue;
>  
> -		if (!amdgpu_vmid_compatible(*id, job))
> +		if (!amdgpu_vmid_compatible(id, job))
>  			continue;
>  
> -		if (!(*id)->last_flush ||
> -		    ((*id)->last_flush->context != fence_context &&
> -		     !dma_fence_is_signaled((*id)->last_flush)))
> +		if (!id->last_flush ||
> +		    (id->last_flush->context != fence_context &&
> +		     !dma_fence_is_signaled(id->last_flush)))
>  			needs_flush = true;
>  
> -		if ((*id)->flushed_updates < updates)
> +		if (id->flushed_updates < updates)
>  			needs_flush = true;
>  
>  		if (needs_flush && !adev->vm_manager.concurrent_flush)
>  			continue;
>  
> -		/* Good, we can use this VMID. Remember this submission as
> -		 * user of the VMID.
> -		 */
> -		r = amdgpu_sync_fence(&(*id)->active,
> -				      &job->base.s_fence->finished,
> -				      GFP_ATOMIC);
> -		if (r)
> -			return r;
> -
>  		job->vm_needs_flush |= needs_flush;
> -		return 0;
> +		return id;
>  	}
>  
> -	*id = NULL;
> -	return 0;
> +	return NULL;
>  }
>  
>  /**
> @@ -386,39 +360,34 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>  		     struct amdgpu_job *job, struct dma_fence **fence)
>  {
>  	struct amdgpu_device *adev = ring->adev;
> -	unsigned vmhub = ring->vm_hub;
> +	const unsigned vmhub = ring->vm_hub;
>  	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
> -	struct amdgpu_vmid *idle = NULL;
> -	struct amdgpu_vmid *id = NULL;
> +	struct amdgpu_vmid *id;
>  	int r = 0;
>  
>  	mutex_lock(&id_mgr->lock);
> -	r = amdgpu_vmid_grab_idle(ring, &idle, fence);
> -	if (r || !idle)
> -		goto error;
>  
>  	if (amdgpu_vmid_uses_reserved(vm, vmhub)) {
> -		r = amdgpu_vmid_grab_reserved(vm, ring, job, &id, fence);
> -		if (r || !id)
> -			goto error;
> +		id = amdgpu_vmid_grab_reserved(vm, ring, job, fence);
> +		if (IS_ERR_OR_NULL(id)) {
> +			r = PTR_ERR(id);
> +			goto out;
> +		}
>  	} else {
> -		r = amdgpu_vmid_grab_used(vm, ring, job, &id);
> +		id = amdgpu_vmid_grab_used(vm, ring, job);
> +		if (!id)
> +			id = amdgpu_vmid_grab_idle(ring, fence);
> +		if (!id)
> +			goto out;
> +
> +		/* Remember this submission as user of the VMID */
> +		r = amdgpu_sync_fence(&id->active,
> +				      &job->base.s_fence->finished,
> +				      GFP_ATOMIC);
>  		if (r)
> -			goto error;
> +			goto out;
>  
> -		if (!id) {
> -			/* Still no ID to use? Then use the idle one found earlier */
> -			id = idle;
> -
> -			/* Remember this submission as user of the VMID */
> -			r = amdgpu_sync_fence(&id->active,
> -					      &job->base.s_fence->finished,
> -					      GFP_ATOMIC);
> -			if (r)
> -				goto error;
> -
> -			job->vm_needs_flush = true;
> -		}
> +		job->vm_needs_flush = true;
>  
>  		list_move_tail(&id->list, &id_mgr->ids_lru);
>  	}
> @@ -443,7 +412,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
>  
>  	trace_amdgpu_vm_grab_id(vm, ring, job);
>  
> -error:
> +out:
>  	mutex_unlock(&id_mgr->lock);
>  	return r;
>  }
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index 09593fcdb2f7..6614682eaa89 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -254,7 +254,6 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
>  		ring->adev = adev;
>  		ring->num_hw_submission = sched_hw_submission;
>  		ring->sched_score = sched_score;
> -		ring->vmid_wait = dma_fence_get_stub();
>  
>  		ring->idx = adev->num_rings++;
>  		adev->rings[ring->idx] = ring;
> @@ -413,8 +412,6 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
>  	kvfree(ring->ring_backup);
>  	ring->ring_backup = NULL;
>  
> -	dma_fence_put(ring->vmid_wait);
> -	ring->vmid_wait = NULL;
>  	ring->me = 0;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> index 8f28b3bd7010..33dd39dd21cc 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
> @@ -414,7 +414,6 @@ struct amdgpu_ring {
>  	u64			set_q_mode_token;
>  	unsigned		vm_hub;
>  	unsigned		vm_inv_eng;
> -	struct dma_fence	*vmid_wait;
>  	bool			has_compute_vm_bug;
>  	bool			no_scheduler;
>  	bool			no_user_submission;

