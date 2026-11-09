Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1135606EE98
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Nov 2026 14:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MSvnW71y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FA8B10E4A8;
	Mon,  9 Nov 2026 14:08:37 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010052.outbound.protection.outlook.com
 [52.101.193.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A384D10E4A8
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Nov 2026 14:08:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uduyxSGzCZRtKPWxWHNtVvUgMuvKdadKPiUugxV4h3abwfXDwZ39pWZFUVLPRw8wuduPPF6oi2ojsEPq+bNZOv0mI2c4aTZw3H9eiW1PSeEpyweF9frjPg0hnHbWxM6nM19aQVmwUo2hY4C25hh+wMjOo01bhQFUKUsW4KFjp61c7HsVtaRtvSIOMBEqzJYVrheEbHWOoY6nIf6LtUThdvP3ZgTNJZfRtNud3GeI7AqNI+Z5qIDYC/NdfWtssNCl+GlHT7tsIhff/ExTojtwlX4wK/jZBE/K7fOI4igMgPKMGW4+5yZa5RMja5DeaSmurymVgwknFOB3Cq7peUUSgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyO4UrU6kA+/FrAYriNp+b2IQ6udK/pIe1qMa9cuW8o=;
 b=ITSlJktEy327Q+JIOddwDEt9adpsGyCoo/fizt2yhcdSytMOlzbzgBC7NCq48GZlp63kl4sY4u3MAFJaVbDpTU9OuZzS4oA79Wa/G88VTa58Mc6vvAVAX5upURfLsOjWs4M9WDCesX4pSSNwtodEJOJFdKVBzQGrykWZxfgGC02t/j1DA77ItwSIJ1W6UklqeQED307fPY45mVQ7sx0v5LOjxb2pq8fLA4s7LEccYirI0oxlRktg+OiXVBHpSXj04QVifgio715+FERlv4xCbqFciiULybMPMUcOKmxwfaOPoldu+1EAKXNmoh/jm7vijp+gaAeEg217299BGpUeyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyO4UrU6kA+/FrAYriNp+b2IQ6udK/pIe1qMa9cuW8o=;
 b=MSvnW71yiNt46Z3jb1knvwfPQ8uuCiNoPomAJjep9xbTx100T3HDi9CbtpI014Q49dBCdcIdpHX19c3Yq5Rfvw1tCRMGuhYPv+7XmcvpTngi5Fg3h9qcSTs5nMpuo8cek1zABGku4t4JMSwwIv0JPn5H92DghOAMyl99tSLL8sA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7588.namprd12.prod.outlook.com (2603:10b6:930:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 14:08:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 14:08:28 +0000
Message-ID: <bd300bdd-21e7-49e7-bb2c-2d0512c7fc8c@amd.com>
Date: Mon, 9 Nov 2026 15:08:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: fix page fault by not skipping VM flush
 before tlb_seq update
To: chong li <chongli2@amd.com>, amd-gfx@lists.freedesktop.org
References: <20261109140616.2326304-1-chongli2@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261109140616.2326304-1-chongli2@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0504.namprd03.prod.outlook.com
 (2603:10b6:408:130::29) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7588:EE_
X-MS-Office365-Filtering-Correlation-Id: 02b09e72-4070-4262-6c37-08df3e6aed43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|261021123027099003|261021121427099003|261022075727099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|261102123227099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: FDXiOqasgPvr8vQJ+smHIZDOtGVIDTqL0v09htrMI2Sk1jiKrz6ohSu/RGjHj9EWqzPEuYE2PUgYKZWLaIsdA6DdfGASh+9/vl2osQE57qM5pNInayk0GhuetiYJN9ENF+iAutvk4MHsUTWN58czBkt53M464tKnknB615wXVKSvUHdpkkaeirrvWb9L/jwm3kZOazNVOX+V9mrVeShM9kzvSCoYuIuepDZZg8Cp9690+JShXFiw10SzWCU9OxVNWDDQv8MIC8knJqyi39Wze3XzqA/EbPK4wri6Jx9WebiDfIZV0JNquG8hiP7K9uz8eBCPeVvIRBpkkWQyV+r8/3YMBhhyVlsb+Wdif2GHFfPSMqkrVGJM++FliWkpwS5HB4dgmC8knKa5H+b/HWJAhICZp7qNYSKfSykLo9eRkcmzoVxUhHz9y5gfoadDPq4FaCIEa06Ho8HSWi4pG9qV48jQpkJzUYK9tu1OJB0aKBuJDQLn25QyadhlxCjaD+KYlG8tMkB54Gi3wI0fxd9HamVXmuNsYk08HqbifVQYOEGxtRKCcfdPb+qwFM69j9EJhYIA5jt+1B6jJYcOwL08BVw+jaU0fE+yVcrA6CikR7h4wYCkfZTwPpF3EPD4JAvV3YxARaJ+Aat9b0brusUpTxHh3dOOZdJ/9e6TgGHaULA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261022075727099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(261102123227099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEgrQlMwMHdZTW1DSzFDVGFkTUQxL3FWTFlGWm0wTGxoRG5nK1dYRGQvWFM3?=
 =?utf-8?B?Z1BlRzJuY1AvMU01MDJPSkpUSVplNUwwa3lWNEdaTXpkRVBiR1RrSU1YQXZN?=
 =?utf-8?B?bGpZeForVkdwakRxblZRTHBjcGZDeVBQMmUrMzRhQnFkcS90VHhDTW1ZeXYr?=
 =?utf-8?B?TzBwZ0UwNEVpaHZLeEl2Ukc5SHZCcnJyYTdGbWw0aGl2b3ZBZWVKUVhkSkJD?=
 =?utf-8?B?MnpKOGF0N0NyMWhobVlnbHBOY2FXbkNlQ1RFemcxWlFLQ2k0cFdsNVpCTzFp?=
 =?utf-8?B?VCs4UzRTYmtwWFdjaTl0OHZVOUh2UVlNeXdkRWdYSVdFVVhaT0tEVmpFMkhY?=
 =?utf-8?B?NS9ZVjNXSW53WktQZnZGcStiVUZjbjNDRjJiVWV5U3E5cWUzWHNZRm5lZFJi?=
 =?utf-8?B?Z3NXeEZzY04yVW96UjBGczFuRTZibEJmV0Fzd3Rhcy93aTNLQWVNRldJMnBB?=
 =?utf-8?B?RUEvbGIwd2ZvamZ2YmFUbXpQNTlCdzQySy9wdXFVbEx5czlQRTJISEpna1lp?=
 =?utf-8?B?aXVOcHZ5bkZIM1h3T0IxN1BpTWdYbDFaWFV4cmx3MnVLQXAxcklGdVc3RjF5?=
 =?utf-8?B?aUNFaXJwUHhKUWF6NWVrN2p3L0RHemNmQ3dyN1pseDdab1Q0K1VxMmNSa3dS?=
 =?utf-8?B?M0h1TUt4L0xNWTJLK01YTC9xanNBSEpOOTJHSUZKUEJIcitjeG5ZMVlHYnQz?=
 =?utf-8?B?VFMyRVBJQVY0QzVqWVlFRDMrM0FXUkw3eHNobDR1N2h3TW1VRCtIQ2hWMjgx?=
 =?utf-8?B?ekE5NE9Fa3Q0UGVpTmNqR2d0QlFNV3M0b21FdlBzUkRKWk1ONjBXckx6TVkv?=
 =?utf-8?B?amxvd090U0FHWHNjSHJCMFhpelMzdHliZC9MZmk0M1I0RXd3eGlFdmhBditk?=
 =?utf-8?B?TVZhWmpGdks0MTdleU5zcGdVT0k0MzMvL2ZqQm9Oc0FaMDNJeGlybVpydTRn?=
 =?utf-8?B?UE0vcnNzODBKazBCWWl5dlFjVVBPODBUT3dTYUl2NkVHSkhPTHFpbjl2M0Fo?=
 =?utf-8?B?NTEyNy9oVGZuU3JtQnIvVkRNNE9jdDc1VUpIeDZmTnNHcnUzSnVnN1pNZll5?=
 =?utf-8?B?V2NTeFI3OFVJNGZ5RGtiQTdacTZ1R21QR3k0bit0OTVkUkc5dUVoWlVFV2Uw?=
 =?utf-8?B?cEZydFFKTG01UHJjTzVWcThtenMyWHM4T3ZxZFpHdFBocEl4SmR6SGxOQVhG?=
 =?utf-8?B?bVM2dll4UDlWckdyVnN0T0Q0Tnd1c29LZEt1L1NUTEY5OWlxNlFtcEhsT0c3?=
 =?utf-8?B?QVpoampFa1hTOTdFeGJiYkRPZDA1QkE4eG9iWHhJZmJBSk1pODJ6aDZEZFBj?=
 =?utf-8?B?ek1wOWZzZTlQbC8wQ3FRMXVTaHNwQUxJU3l4VVMyKzJkeXlCUy9IYU9rU1ZL?=
 =?utf-8?B?MHdidTRIM2pqSmlLOUtCNi9sZGFZdTJVcmRNQkQvN1d2dFdnYTVVYTVpNU9L?=
 =?utf-8?B?SWdWSEViNmNxc3dyUVg4QVh0RVEyZFV5YlZtbTl2WnJwQk1oTTFKb0RHVnVS?=
 =?utf-8?B?Q3ZpSCtPc0U2dEVZcGowc2F0NnJ4Y1RFaVZFZEJDdXBaNE9pMDdtdlhQL1hk?=
 =?utf-8?B?Yk5pNHVxSXFNUGJadDgyYy9wSTAxQnZyQzEvZTduK25IQlhJSXdiUGVJSWU4?=
 =?utf-8?B?bXpudTRaNFlPVmEyQ2RzRFdhKzQrRjYvdjYrMDFoOEtLODVSRk4zL1IzWkEv?=
 =?utf-8?B?RytraXJuSDdKbW5mVGorZDBtTjNPL3EyQjY3UHNLV0JOaUkrVTQzWU5Dczd6?=
 =?utf-8?B?MGcwQVluWFUwMS8yMXpMa085WWpTZzBPc29qYkx0bHBZSSt1a0JKc0pzN25s?=
 =?utf-8?B?ZVZrUjRrZ0R0by8wTjFkL2t4SnE3MnpGWk15dFk3QUN5RlNEdmRnYTcwbm14?=
 =?utf-8?B?QkJpcVVUZWZNRGhKUjBWeFI1a2x1QzMzd1ZNSVVVQTVXUGR3UEpIckNIMzVI?=
 =?utf-8?B?MFlaUy9pOGdQWXB5OTArNkt3NWVRSDFxNExEU1lBdnFuOVE2RzNTMnhiY1lS?=
 =?utf-8?B?dkFVL1NDemYvTXN0bGd3ZXJaanY1YXdMWnBkbzNMZERRc0hGY0dWZ0dyK0Zx?=
 =?utf-8?B?YmsxamwyNXJISlJ5WGs3VWc3NTVzdlA2VHF5ZkR0WFZhK3RxVUZHWnBTTFYr?=
 =?utf-8?B?bkxPQWxCSjlYUDlnRzlva2EyR1haWnoxb29ScFNUdFZUWnFaMjVXcHA2L1F3?=
 =?utf-8?B?OEF0QVFwQ2lWaEt0bXJHZ1EvV2pQLzlzY1ZOeUlNZjJtdkMrTnZGYyt0MUFU?=
 =?utf-8?B?eWV5SWdocWFTR2hCOWtaRmpnSUVjSVpRRWViMjl0Q1NndStSRzIrejdsdUc3?=
 =?utf-8?Q?WM6g87Gd7P7Uf9I0OR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b09e72-4070-4262-6c37-08df3e6aed43
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 14:08:27.9479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +odb6VsWQQyM0zQJsaHJGskpuDG0el9FgOslzcoIEFYQnBS337o5j2lLusxE0fwl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7588
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

On 11/9/26 15:06, chong li wrote:
> amdgpu_vm_tlb_seq() waits for the tlb_seq callback by taking the lock of
> vm->last_tlb_flush. Newer page table updates replace vm->last_tlb_flush
> immediately, without waiting for older callbacks. A job scheduled after
> an older fence signals but before its callback finishes takes the newer
> fence's lock, while the callback runs under the older fence's own lock.
> The job misses that tlb_seq increment and can reuse a VMID whose TLB was
> last flushed before the older page table update completed, without
> flushing the TLB again.

That's not even remotely correct.

All fences use the same lock, that's why this works correctly.

Regards,
Christian.

> 
> how to fix:
> Count the flush-requiring page table updates whose tlb_seq callback has
> not run yet, and request a VM flush when a job reuses a VMID while this
> count is non-zero.
> 
> Signed-off-by: chong li <chongli2@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 10 ++++++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 12 +++++++++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  | 10 ++++++++++
>  3 files changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index 9c879ac68352..b9e058da162b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -393,7 +393,8 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
>  	unsigned vmhub = ring->vm_hub;
>  	uint64_t fence_context = adev->fence_context + ring->idx;
>  	bool needs_flush = vm->use_cpu_for_update;
> -	uint64_t updates = amdgpu_vm_tlb_seq(vm);
> +	bool tlb_pending;
> +	uint64_t updates = amdgpu_vm_tlb_seq_pending(vm, &tlb_pending);
>  	int r;
>  
>  	*id = vm->reserved_vmid[vmhub];
> @@ -405,6 +406,8 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
>  	     !dma_fence_is_signaled((*id)->last_flush)))
>  		needs_flush = true;
>  
> +	needs_flush |= tlb_pending;
> +
>  	if ((*id)->owner != vm->immediate.fence_context ||
>  	    (!adev->vm_manager.concurrent_flush && needs_flush)) {
>  		struct dma_fence *tmp;
> @@ -456,7 +459,8 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
>  	unsigned vmhub = ring->vm_hub;
>  	struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
>  	uint64_t fence_context = adev->fence_context + ring->idx;
> -	uint64_t updates = amdgpu_vm_tlb_seq(vm);
> +	bool tlb_pending;
> +	uint64_t updates = amdgpu_vm_tlb_seq_pending(vm, &tlb_pending);
>  	int r;
>  
>  	job->vm_needs_flush = vm->use_cpu_for_update;
> @@ -480,6 +484,8 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
>  		if ((*id)->flushed_updates < updates)
>  			needs_flush = true;
>  
> +		needs_flush |= tlb_pending;
> +
>  		if (needs_flush && !adev->vm_manager.concurrent_flush)
>  			continue;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index 2ba33212d507..6d15fd001a42 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -1095,6 +1095,9 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
>  
>  	tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
>  	atomic64_inc(&tlb_cb->vm->tlb_seq);
> +	/* Pairs with atomic_read_acquire() in amdgpu_vm_tlb_seq_pending() */
> +	smp_mb__before_atomic();
> +	atomic_dec(&tlb_cb->vm->tlb_pending);
>  	kfree(tlb_cb);
>  }
>  
> @@ -1281,9 +1284,16 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>  		start = tmp;
>  	}
>  
> +	/* Must be visible before the update fence can signal */
> +	if (params.needs_flush)
> +		atomic_inc(&vm->tlb_pending);
> +
>  	r = vm->update_funcs->commit(&params, fence);
> -	if (r)
> +	if (r) {
> +		if (params.needs_flush)
> +			atomic_dec(&vm->tlb_pending);
>  		goto error_free;
> +	}
>  
>  	if (params.needs_flush) {
>  		amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index d8e17f493f61..312fd0d268ce 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -337,6 +337,8 @@ struct amdgpu_vm {
>  
>  	/* Last finished delayed update */
>  	atomic64_t		tlb_seq;
> +	/* Flush updates whose tlb_seq callback has not run yet */
> +	atomic_t		tlb_pending;
>  	struct dma_fence	*last_tlb_flush;
>  	atomic64_t		kfd_last_flushed_seq;
>  	uint64_t		tlb_fence_context;
> @@ -578,6 +580,14 @@ static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
>  	return atomic64_read(&vm->tlb_seq);
>  }
>  
> +/* Read tlb_pending first; pairs with the barrier in amdgpu_vm_tlb_seq_cb() */
> +static inline uint64_t amdgpu_vm_tlb_seq_pending(struct amdgpu_vm *vm,
> +						 bool *pending)
> +{
> +	*pending = atomic_read_acquire(&vm->tlb_pending) != 0;
> +	return amdgpu_vm_tlb_seq(vm);
> +}
> +
>  void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
>  				  unsigned int pasid,
>  				  uint64_t addr,

