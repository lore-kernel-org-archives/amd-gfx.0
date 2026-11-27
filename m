Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8542E606A324
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 09:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=MymOYpCP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B4B1112965;
	Fri, 27 Nov 2026 09:57:41 +0000 (UTC)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010004.outbound.protection.outlook.com [52.101.56.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7E5D112945
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 09:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V07smle6gqkpKubQ4SAB/pK3iZYO9hS9nqoSPMomQLPpyXahNXb0w7ar15vhk1lnv+BkDbV2frZ1Hz0Y8nCBDC5zDhaWGlE7rmptgzSsITfPl5//Vi0LuJ0L9KBmYWzStkR+ULgNHLiS/37KYu0eYVlXJEqriQKzyk7nwLsxrX3AbTE2jin0efgVD/OY39qJGIWAzqnmPAQNLv1S7SZjDLNcrIpUKIpR2uJfnrydPgm2UhraHszu0lVgXXVfM38/mny/MRKbrnKWnGS4PYCo/PBeiaxWx+AzdjU49FfRQBXqAsHIsC5lpoHICLVNF4CDLJ/F6FzbqOcj4S5lWwN2qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a50HAkf06oCFP1MZlngLXTHEQTWY6iefBdZe713DvcU=;
 b=M+HYilINYfruz08HCh/mVilVCcoSzt1sQyYfF7dnxB0uYQmrM1sedPBF9M1cRiBCDfSc3Bv9uolxqOc1oOtWlIGce3CC2wgwduHybcQhFb0g0twsh96OLTZ3ouLDM7Et5cWAz6jkphyuzEyo35wRNfhPLeBgGAlUYwv7IUmxADm8sXCFutF/5TV9BeCUPl93N9KtMsriQFTwEXdK/ojeyHtm8HYqKXmf+43IcG5qGQPsV+RMNWKvPZ6r6A4jdccX4Q3/AYKnB1mQn95kO/Jrtj8/rKuUqqv2pC2otB4NaSOwWmnVY20w/qnwP/9rg1fpHdQ/Qju/bhf9/m/OzsrPdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a50HAkf06oCFP1MZlngLXTHEQTWY6iefBdZe713DvcU=;
 b=MymOYpCPqjbleVRuZkuXeAVndtgW26n4NSTXpVKJvQ5kDFrBDcFOEEJU7XINUAmpZz4y+Zh06d2cwQaw4Xo0rLH09HplIf/w7tVosmk8d3E3G9+Q7Q89yw6yo1WuvhBt2dW9TVmpRK/2P6y5OLPUzYYtAVHWBTmXkfrsU8DYFEI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS5PR12MB592442.namprd12.prod.outlook.com (2603:10b6:8:47d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Fri, 27 Nov
 2026 09:57:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 09:57:31 +0000
Message-ID: <1ab8972f-e474-4c9a-b722-a50348113357@amd.com>
Date: Fri, 27 Nov 2026 10:57:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: switch vm->tlb_seq to dma_fence_chain
 handling v2
To: "Li, Chong(Alan)" <Chong.Li@amd.com>,
 "timur.kristof@gmail.com" <timur.kristof@gmail.com>,
 "phasta@kernel.org" <phasta@kernel.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
References: <20261125153036.3278-1-christian.koenig@amd.com>
 <DS7PR12MB5768645271CA503FD33AA2499B412@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <DS7PR12MB5768645271CA503FD33AA2499B412@DS7PR12MB5768.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0393.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cf::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS5PR12MB592442:EE_
X-MS-Office365-Filtering-Correlation-Id: a618a3c2-49b2-4dc7-9719-08df4c6cda49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|10067099003|56012099006|261026121527099003|261026140227099003|261028144727099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|261009221227099003|261009223027099003|22082099003|18002099003|11063799006|4143699003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: O6xTVnZeHq/vAEyfK+3TimFzckEktBOIYi44+7VEgoV/x/IbwV6hO4t+4aONjPUu5nrw/s7nnwlBclRm+CwNrPMv2HLDlmwktsgk9G0n8bfcXtERNexpJJLDaayHxhkCy2Yy3wXj8FM2mXatD6TZqQrJCx7G7Qe77HSWuyadBeriOtwBOO3X53u5NtwJN479SS0utwwD3M19uLv3Ayane8DVY9KNNAJpkaO1u2lBWhhN2NFXA1FrqUglmddV+XGdPJrrn9Wx5oBJe9CjAbuNP/b2rlx0inn5xNXr9rQ2IVWiwxIPuhSuTcYzDo56iSMlUFOjbCNbyDrCykCxdkiMrW0AyFX4jvFhx8a6TY1Eo64i9dzydMYnvnmcVXMxP5R7xs6PWEGpsuQHaH0pKOHRAbfxP7AlWdG49LMLJVUQAgDNBAAjv65ZWEIH1leezT+7dKxelNNPytxuZGR7aY4Nzz/wzTG+wS16TYYUXfrmwg6NmVm10Ko6uiddvgpaxU+OlOSGwYRlnOcd23tSHv9/F1uoNX2rMdM0InKBB+FTV0JSmObvcB8K3D4nyR0fyQAKdauWCWoH8LVlH6LXED18lYHs3Sqe9DS/ryzNY/A7z7L3dOfMJLJCbrmMxXdy0STAtEPmmcoH7n6ynRs+muM9Mhq8QKbcOyuE6mauQD4LAAw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(10067099003)(56012099006)(261026121527099003)(261026140227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009221227099003)(261009223027099003)(22082099003)(18002099003)(11063799006)(4143699003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWN6QjdubnJ4NGRsNllqdmtqWTgzQ0ZRaWljTWU5WER4MWtzNmpuQlErblp6?=
 =?utf-8?B?ZVBpbGlnODBpa0lSN1kwZ1pvME80bmVYZHNnUzJaOWl0RXZPZW5EOWlnZWRu?=
 =?utf-8?B?QmV4bkVaWnpCQVlCSU1GWHFQeXo3bm8rdHlNMGpLcnJsRHBDa0ExS0ROWi9s?=
 =?utf-8?B?R1BHcHkwRVpDZEFENE5nMlVubUh3VGFrMVF0RWtsZGhzK2lyZWw1bWU1Z1VD?=
 =?utf-8?B?ei9nU1lkWU41TmNrY0tkRjQ0dTY0MHR3MWNpaTJCQmNocDIyY0xXWDV4NElx?=
 =?utf-8?B?elY3bHR3RWtldmFyTlRGN3FZYjZrQUV3em1seVB6b21QY1MrTjIzSkZ3TGNT?=
 =?utf-8?B?R3pnT1NjQzN6YVZ5SWZvR1RmblVNcCtDVU83VHpZTGUvRHo5eGpGbG5kK3JR?=
 =?utf-8?B?RXRXMlNMbkxpT05lYmJwQkwwRFZIUmdBN0YvclNSQ1FlcVExMW8yNVE3VEM5?=
 =?utf-8?B?aGhZVTZKQkk3S3JrTGN2UVJBcSthbWY1TllIOS9BdlE2UVhtelVTdXI1SGsr?=
 =?utf-8?B?Y2YxSkJqY0g1NjJWVThvT1huZEo5NkNzVk5XYXFVQ1VmU0V3V2pjc0dWMzRp?=
 =?utf-8?B?bkJaeDZMRlVORmluTlFWbUMvQ1QreWFhS0pMczBjT0lKWlZHMG5ac1QzRmRY?=
 =?utf-8?B?YTV5WUcvdzgvNHR4TVhYVkErL1AyMkUxemZMT1Q2OGVNUVNPdnRIRXNYOUFC?=
 =?utf-8?B?a0JHTG1sd2tWNUIwQXZZb1BDdlIrandKWHRuUXR4MFQxSzJXNm5JY2Y0WHNH?=
 =?utf-8?B?OTRUcXhjYjdETzZFU1Y2bk5yNjJiTHpPT041TlhMNE9uQ21DN09XSk5LekJO?=
 =?utf-8?B?S1o2Nld4cVRZZkpza2JGN2ZDNGN2czQvTkxsamZHVkQ0SngyQzFKWTFjaGxE?=
 =?utf-8?B?NDl3clZUOVdDT1NGSVpiemVTWkJuL1l4OVpVZW1uUDE1c1pVNGFiMXZ2TGk4?=
 =?utf-8?B?WlhEdVJLekJoNXJDWkZ4dWtwMmlORml4emNSRmJSd2xSTzNSS0hCaVFXWDVo?=
 =?utf-8?B?RzQ1Y1Y3d3hUdDkyOUN2VXpVS0ZEbVNwNnkzRURGVHpWM24yY0FVSzFBaSt3?=
 =?utf-8?B?Z3pWaFNGMnhaYUVGMFVVbzlCNzJzZ0FxaGhzRHhUVUs1NW5LMGsrbGsyRXJZ?=
 =?utf-8?B?dWovMldqVEdIWTlEVDRxc29tZnRVMVFJS0xMaWg0bDEwY1ljZmZnWEdrMXll?=
 =?utf-8?B?NTFaTk5FOEpRVndtV3lybythNnFGWWRhUmQ0d2pvZHVsdGdjMTg5ZGY1TWdm?=
 =?utf-8?B?RDJRaENlUjZMRnZwakYrOFJPVVZiQkxqK2s4TWk2ODZON2ExbHc3UWVRUXkw?=
 =?utf-8?B?eUg0eU15SHExQjJBblFKalhMWmthU242RDlIbXQ2U0lwc2d1TW12Yis0enpC?=
 =?utf-8?B?bEpiZzhET3Yxd1dFTFJYOXlvYVFLUHorczNsT3ZXUXFzYUltR01iUkxQSnNE?=
 =?utf-8?B?ZnVxWWhKT3ZEcFZzRTVLMEVpL0loN1lDay9nMjIwNU9IMHIwemV4QWhzN2Js?=
 =?utf-8?B?bnp2Y3hzOFpmeGVuZWJtNVNXMTdCVGhCSkVSeVZINlF1dkV1U09aREp4YklQ?=
 =?utf-8?B?MnY1LzArYU83K0VKNUNhOUVFUjFNUE5VNmVMQXJwNThyZitGODlRV2JlNVV6?=
 =?utf-8?B?L3h5M0gyeW1TeU85YjMvbEN0RysranNZQVBUT2hqemx4STRaYlIrTlVTNlVs?=
 =?utf-8?B?S1BOMEQ4MGlJckN2cmFhRUh5MU9qcnhDNlVPMEF6VktkNnpDSkNuendqWnF2?=
 =?utf-8?B?K0dZUmxSd3lBUnovV1JOWFdNdVVwd1BUaisxT0dlYS81RDQxRlBCbkZaQ3Vr?=
 =?utf-8?B?ZmI0YkxxRVYvdVRtdUhGd0JrMzFnclZFajlzVHNhYTZPUVp1ekRtaWZQckJu?=
 =?utf-8?B?TkpOQUJ2VWtQTnZYVFBxaHpXdEhOK2Yyd1hBSHR6VGlocWs3M29jaXR0UlFR?=
 =?utf-8?B?b0puRlJZUi9neFQ0Wmd4ekRlZk1OYU9WLzBuelR5VDU0b2NlY3dKM2t2NWhr?=
 =?utf-8?B?endoUFB0OW1BWGYwZ0tUUHgwNUhLbWxneVRGQk9sNURUSlpldGxUeVI4NTl2?=
 =?utf-8?B?SThtMGtyc0VkWlhOL3hRY1p6TlZsWm1mZXB2QUZ3RGRmUUJJVS92TzFiaXBr?=
 =?utf-8?B?Mk85SEhML0ppbDdDU1JZZWNzNXBiNU9tcGVjNGFJL3VyczhNU2U1UGF4elhV?=
 =?utf-8?B?YWtzNkxXNjFtR2JOVFR2WmZmbnM1Rjl6N1ZoMVAvbnExWTVJM3c1MldyU1Fx?=
 =?utf-8?B?ZW9CNy9YMi9pOWtPSncvSEVNM095WjQ5eE5HMkhOREl6M3hWdkVVSTRuQm41?=
 =?utf-8?Q?IkXGgoOARk6nE07b3b?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a618a3c2-49b2-4dc7-9719-08df4c6cda49
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 09:57:31.5368 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p0GdTqGBkVPGzOmz0WHk7Vkc++SMXOsyC47dO/N3LXeMDqhpMuCK8RS+xQHtC8cO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PR12MB592442
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

Hi Alan,

On 11/27/26 07:09, Li, Chong(Alan) wrote:
> AMD General
> 
> Hi, Christian.
> 
> 1.
>> +uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
>> +{
>> +     struct dma_fence *fence;
>> +     u64 tlb_seq = 0;
>> +
>> +     rcu_read_lock();
>> +     fence = dma_fence_get_rcu_safe(&vm->last_seq_flush);
>> +     rcu_read_unlock();
>> +
>> +     if (dma_fence_is_signaled(dma_fence_chain_contained(fence))) {
> 
>    amdgpu_vm_tlb_seq() dereferences NULL when the chain is empty.
>    The first job of a new process oopses:
> 
>    BUG: kernel NULL pointer dereference, address: 0000000000000030
>    RIP: 0010:amdgpu_vm_tlb_seq+0x8b/0x230 [amdgpu]
>    Call Trace:
>     amdgpu_vmid_grab+0x4ef/0xc60 [amdgpu]
>     amdgpu_job_prepare_job+0xcb/0x130 [amdgpu]
>     drm_sched_entity_pop_job+0x75/0x420 [gpu_sched]
>     drm_sched_run_job_work+0x6a/0x2e0 [gpu_sched]
> 
>    vm->last_seq_flush is only set in amdgpu_vm_tlb_flush() and is still
>    NULL at the first VMID grab, so
>    dma_fence_is_signaled(dma_fence_chain_contained(fence)) reads
>    fence->flags from a NULL pointer.
>    patch v1 was fine because dma_fence_chain_for_each() accepts NULL.
> 
>    We can check NULL before checking whether fence has signaled:
> 
>     if (!fence)
>         return 0;

Good point.

We usually use an always signaled stub fence for such use cases but I removed setting that in version #1 of the patch because dma_fence_for_each() is NULL save, but we now of course need to bring it back or otherwise run into problems.

> 2.
>> @@ -122,8 +122,7 @@ static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
>>  {
>>       struct amdgpu_device *adev = p->adev;
>>
>> -     if (p->needs_flush)
>> -             atomic64_inc(&p->vm->tlb_seq);
>> +     *fence = dma_fence_get_stub();
> 
>    amdgpu_vm_cpu_commit() writes *fence unconditionally, but
>    amdgpu_vm_handle_fault() passes NULL as fence, so the CPU update
>    path dereferences NULL. The fence which *fence held before is also
>    overwritten without dma_fence_put().
> 
>    We can guard it with `if (fence)` and drop the old reference first:
> 
>     if (fence) {
>         dma_fence_put(*fence);
>         *fence = dma_fence_get_stub();
>     }

Yeah good point as well. We are about to remove that stuff but this patch needs to be able to be backported so it is necessary for old kernels.

Thanks,
Christian.

> 
> 
> 
> Thanks,
> Chong.
> 
> -----Original Message-----
> From: Christian König <ckoenig.leichtzumerken@gmail.com>
> Sent: Wednesday, November 25, 2026 11:31 PM
> To: Li, Chong(Alan) <Chong.Li@amd.com>; timur.kristof@gmail.com; phasta@kernel.org; amd-gfx@lists.freedesktop.org
> Subject: [PATCH] drm/amdgpu: switch vm->tlb_seq to dma_fence_chain handling v2
> 
> The vm->tlb_seq handling for per VMID based TLB invalidation was always rather fragile and relied on grabbing the dma_fence spinlock to make sure that callbacks executed in the right order.
> 
> Alan now pointed out that even this doesn't work correctly because different PTDE/PTE updates might use different locks and their signaling is not necessarily in the same order and on the same GPU.
> 
> Ditch the whole approach, instead use a dma_fence_chain to track all PDE/PTE updates and just iterate over them to get the last completed one when asked.
> Also make sure that PDE updates use the same path as PTE updates for consistency.
> 
> This not only fixes rare GPU page faults in the kernel queues but also potentially issues with the user queues should a PDE update make a TLB invalidation necessary.
> 
> v2: also handle the case where the chain head is already signaled as
>     pointed out by Alan.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Reported-by: Li, Chong(Alan) <Chong.Li@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 173 +++++++++---------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  32 +---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c    |   3 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |   3 -
>  .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  |   2 +-
>  5 files changed, 94 insertions(+), 119 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> index a627a30929903..2e15116e790f4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
> @@ -27,6 +27,7 @@
>   */
> 
>  #include <linux/dma-fence-array.h>
> +#include <linux/dma-fence-chain.h>
>  #include <linux/interval_tree_generic.h>  #include <linux/idr.h>  #include <linux/dma-buf.h> @@ -114,21 +115,6 @@ struct amdgpu_prt_cb {
>         struct dma_fence_cb cb;
>  };
> 
> -/**
> - * struct amdgpu_vm_tlb_seq_struct - Helper to increment the TLB flush sequence
> - */
> -struct amdgpu_vm_tlb_seq_struct {
> -       /**
> -        * @vm: pointer to the amdgpu_vm structure to set the fence sequence on
> -        */
> -       struct amdgpu_vm *vm;
> -
> -       /**
> -        * @cb: callback
> -        */
> -       struct dma_fence_cb cb;
> -};
> -
>  /**
>   * amdgpu_vm_assert_locked - check if VM is correctly locked
>   * @vm: the VM which schould be tested
> @@ -1026,6 +1012,71 @@ uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr)
>         return result;
>  }
> 
> +/**
> + * amdgpu_vm_tlb_seq - return tlb flush sequence number
> + * @vm: the amdgpu_vm structure to query
> + *
> + * Returns the tlb flush sequence number which indicates that the VM
> +TLBs needs
> + * to be invalidated whenever the sequence number change.
> + */
> +uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm) {
> +       struct dma_fence *fence;
> +       u64 tlb_seq = 0;
> +
> +       rcu_read_lock();
> +       fence = dma_fence_get_rcu_safe(&vm->last_seq_flush);
> +       rcu_read_unlock();
> +
> +       if (dma_fence_is_signaled(dma_fence_chain_contained(fence))) {
> +               tlb_seq = fence->seqno;
> +               dma_fence_put(fence);
> +       } else {
> +               do {
> +                       tlb_seq = to_dma_fence_chain(fence)->prev_seqno;
> +                       fence = dma_fence_chain_walk(fence);
> +               } while (fence);
> +       }
> +       return tlb_seq;
> +}
> +
> +/**
> + * amdgpu_vm_tlb_flush - prepare TLB flush
> + *
> + * @params: parameters for update
> + * @chain: dma_fence_chain for the signaling callback
> + * @fence: input fence to sync TLB flush with
> + *
> + * Increments the tlb sequence to make sure that future CS execute a VM flush.
> + */
> +static void
> +amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
> +                   struct dma_fence_chain *chain,
> +                   struct dma_fence *fence)
> +{
> +       struct amdgpu_vm *vm = params->vm;
> +       struct dma_fence *prev;
> +
> +       ++vm->tlb_seq;
> +       prev = rcu_dereference_protected(vm->last_seq_flush,
> +                                        lockdep_is_held(&vm->eviction_lock));
> +       dma_fence_chain_init(chain, prev, dma_fence_get(fence), vm->tlb_seq);
> +       rcu_assign_pointer(vm->last_seq_flush, &chain->base);
> +
> +       /* Prepare a TLB flush fence to be attached to PTs */
> +       /* The check for need_tlb_fence should be dropped once we
> +        * sort out the issues with KIQ/MES TLB invalidation timeouts.
> +        */
> +       if (!params->unlocked && vm->need_tlb_fence) {
> +               amdgpu_vm_tlb_fence_create(params->adev, vm, fence,
> +                                          &vm->last_tlb_inv);
> +
> +               /* Makes sure no PD/PT is freed before the flush */
> +               dma_resv_add_fence(vm->root.bo->tbo.base.resv,
> +                                  vm->last_tlb_inv, DMA_RESV_USAGE_BOOKKEEP);
> +       }
> +}
> +
>  /**
>   * amdgpu_vm_update_pdes - make sure that all directories are valid
>   *
> @@ -1043,6 +1094,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,  {
>         struct amdgpu_vm_update_params params;
>         struct amdgpu_vm_bo_base *entry, *tmp;
> +       struct dma_fence_chain *chain;
>         bool flush_tlb_needed = false;
>         int r, idx;
> 
> @@ -1054,11 +1106,21 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>         if (!drm_dev_enter(adev_to_drm(adev), &idx))
>                 return -ENODEV;
> 
> +       chain = dma_fence_chain_alloc();
> +       if (!chain) {
> +               r = -ENOMEM;
> +               goto error_dev_exit;
> +       }
> +
>         memset(&params, 0, sizeof(params));
>         params.adev = adev;
>         params.vm = vm;
>         params.immediate = immediate;
> 
> +       r = amdgpu_vm_begin_critical(&params);
> +       if (r)
> +               goto error;
> +
>         r = vm->update_funcs->prepare(&params, NULL,
>                                       AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES);
>         if (r)
> @@ -1078,73 +1140,22 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
>                 goto error;
> 
>         if (flush_tlb_needed)
> -               atomic64_inc(&vm->tlb_seq);
> +               amdgpu_vm_tlb_flush(&params, chain, vm->last_update);
> +       else
> +               dma_fence_chain_free(chain);
> 
>         list_for_each_entry_safe(entry, tmp, &vm->kernel.needs_update,
>                                  vm_status)
>                 amdgpu_vm_bo_idle(entry);
> 
>  error:
> +       amdgpu_vm_end_critical(&params);
> +
> +error_dev_exit:
>         drm_dev_exit(idx);
>         return r;
>  }
> 
> -/**
> - * amdgpu_vm_tlb_seq_cb - make sure to increment tlb sequence
> - * @fence: unused
> - * @cb: the callback structure
> - *
> - * Increments the tlb sequence to make sure that future CS execute a VM flush.
> - */
> -static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
> -                                struct dma_fence_cb *cb)
> -{
> -       struct amdgpu_vm_tlb_seq_struct *tlb_cb;
> -
> -       tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
> -       atomic64_inc(&tlb_cb->vm->tlb_seq);
> -       kfree(tlb_cb);
> -}
> -
> -/**
> - * amdgpu_vm_tlb_flush - prepare TLB flush
> - *
> - * @params: parameters for update
> - * @fence: input fence to sync TLB flush with
> - * @tlb_cb: the callback structure
> - *
> - * Increments the tlb sequence to make sure that future CS execute a VM flush.
> - */
> -static void
> -amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
> -                   struct dma_fence *fence,
> -                   struct amdgpu_vm_tlb_seq_struct *tlb_cb)
> -{
> -       struct amdgpu_vm *vm = params->vm;
> -
> -       tlb_cb->vm = vm;
> -       if (fence && !dma_fence_add_callback(fence, &tlb_cb->cb,
> -                                            amdgpu_vm_tlb_seq_cb)) {
> -               dma_fence_put(vm->last_seq_flush);
> -               vm->last_seq_flush = dma_fence_get(fence);
> -       } else {
> -               amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
> -       }
> -
> -       /* Prepare a TLB flush fence to be attached to PTs */
> -       /* The check for need_tlb_fence should be dropped once we
> -        * sort out the issues with KIQ/MES TLB invalidation timeouts.
> -        */
> -       if (!params->unlocked && vm->need_tlb_fence) {
> -               amdgpu_vm_tlb_fence_create(params->adev, vm, fence,
> -                                          &vm->last_tlb_inv);
> -
> -               /* Makes sure no PD/PT is freed before the flush */
> -               dma_resv_add_fence(vm->root.bo->tbo.base.resv,
> -                                  vm->last_tlb_inv, DMA_RESV_USAGE_BOOKKEEP);
> -       }
> -}
> -
>  /**
>   * amdgpu_vm_update_range - update a range in the vm page table
>   *
> @@ -1177,16 +1188,16 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>                            struct ttm_resource *res, dma_addr_t *pages_addr,
>                            struct dma_fence **fence)
>  {
> -       struct amdgpu_vm_tlb_seq_struct *tlb_cb;
>         struct amdgpu_vm_update_params params;
>         struct amdgpu_res_cursor cursor;
> +       struct dma_fence_chain *chain;
>         int r, idx;
> 
>         if (!drm_dev_enter(adev_to_drm(adev), &idx))
>                 return -ENODEV;
> 
> -       tlb_cb = kmalloc_obj(*tlb_cb);
> -       if (!tlb_cb) {
> +       chain = dma_fence_chain_alloc();
> +       if (!chain) {
>                 drm_dev_exit(idx);
>                 return -ENOMEM;
>         }
> @@ -1291,14 +1302,14 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>                 goto error_free;
> 
>         if (params.needs_flush) {
> -               amdgpu_vm_tlb_flush(&params, *fence, tlb_cb);
> -               tlb_cb = NULL;
> +               amdgpu_vm_tlb_flush(&params, chain, *fence);
> +               chain = NULL;
>         }
> 
>         amdgpu_vm_pt_free_list(adev, &params);
> 
>  error_free:
> -       kfree(tlb_cb);
> +       dma_fence_chain_free(chain);
>         amdgpu_vm_end_critical(&params);
>         drm_dev_exit(idx);
>         return r;
> @@ -2685,7 +2696,6 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
> 
>         vm->last_update = dma_fence_get_stub();
>         vm->last_unlocked = dma_fence_get_stub();
> -       vm->last_seq_flush = dma_fence_get_stub();
>         vm->last_tlb_inv = dma_fence_get_stub();
>         vm->generation = amdgpu_vm_generation(adev, NULL);
> 
> @@ -2863,7 +2873,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>         struct amdgpu_bo_va_mapping *mapping, *tmp;
>         bool prt_fini_needed = !!adev->gmc.gmc_funcs->set_prt;
>         struct amdgpu_bo *root;
> -       unsigned long flags;
>         int i;
> 
>         amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm); @@ -2876,10 +2885,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>                                       false, MAX_SCHEDULE_TIMEOUT);
>         dma_fence_wait(vm->last_unlocked, false);
>         dma_fence_put(vm->last_unlocked);
> -       dma_fence_wait(vm->last_seq_flush, false);
> -       /* Make sure that all fence callbacks have completed */
> -       dma_fence_lock_irqsave(vm->last_seq_flush, flags);
> -       dma_fence_unlock_irqrestore(vm->last_seq_flush, flags);
>         dma_fence_put(vm->last_seq_flush);
>         dma_fence_put(vm->last_tlb_inv);
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> index f6285a9d9e989..452409e95a5ea 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
> @@ -329,8 +329,8 @@ struct amdgpu_vm {
>         struct drm_sched_entity delayed;
> 
>         /* Last TLB seq/fence */
> -       atomic64_t              tlb_seq;
> -       struct dma_fence        *last_seq_flush;
> +       u64                     tlb_seq;
> +       struct dma_fence __rcu  *last_seq_flush;
>         atomic64_t              kfd_last_flushed_seq;
>         uint64_t                tlb_fence_context;
>         struct dma_fence        *last_tlb_inv;
> @@ -545,38 +545,12 @@ int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm *vm);
> 
>  bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct amdgpu_bo *bo);
> 
> -/**
> - * amdgpu_vm_tlb_seq - return tlb flush sequence number
> - * @vm: the amdgpu_vm structure to query
> - *
> - * Returns the tlb flush sequence number which indicates that the VM TLBs needs
> - * to be invalidated whenever the sequence number change.
> - */
> -static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm) -{
> -       unsigned long flags;
> -       spinlock_t *lock;
> -
> -       /*
> -        * Workaround to stop racing between the fence signaling and handling
> -        * the cb. The lock is static after initially setting it up, just make
> -        * sure that the dma_fence structure isn't freed up.
> -        */
> -       rcu_read_lock();
> -       lock = dma_fence_spinlock(vm->last_seq_flush);
> -       rcu_read_unlock();
> -
> -       spin_lock_irqsave(lock, flags);
> -       spin_unlock_irqrestore(lock, flags);
> -
> -       return atomic64_read(&vm->tlb_seq);
> -}
> -
>  void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
>                                   unsigned int pasid,
>                                   uint64_t addr,
>                                   uint32_t status,
>                                   unsigned int vmhub);
> +uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm);
>  void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>                                 struct amdgpu_vm *vm,
>                                 struct dma_fence *dep,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> index d03b9bbe20c7c..17a579dbf7b90 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
> @@ -122,8 +122,7 @@ static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,  {
>         struct amdgpu_device *adev = p->adev;
> 
> -       if (p->needs_flush)
> -               atomic64_inc(&p->vm->tlb_seq);
> +       *fence = dma_fence_get_stub();
> 
>         mb();
>         /* A reset flushed the HDP anyway, so that here can be skipped when a reset is ongoing */ diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> index d3a5e8487419e..26af3d54895b1 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
> @@ -117,9 +117,6 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
>         WARN_ON(ib->length_dw == 0);
>         amdgpu_ring_pad_ib(ring, ib);
> 
> -       if (p->needs_flush)
> -               atomic64_inc(&p->vm->tlb_seq);
> -
>         WARN_ON(ib->length_dw > p->num_dw_left);
>         f = amdgpu_job_submit(p->job);
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> index 180e02de73e9b..06e0fe3ee18a9 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
> @@ -112,7 +112,7 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
>         spin_lock_init(&f->lock);
> 
>         dma_fence_init64(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
> -                        vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
> +                        vm->tlb_fence_context, vm->tlb_seq);
> 
>         /* TODO: We probably need a separate wq here */
>         dma_fence_get(&f->base);
> --
> 2.43.0
> 

