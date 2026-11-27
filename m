Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA68606A32F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 10:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=UBeQni2U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 258E410E707;
	Fri, 27 Nov 2026 10:18:47 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012057.outbound.protection.outlook.com [52.101.53.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74A4710E557
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 10:18:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n/OnqUcWsDrq93Lb+D0+JuZDle8mSW2raZHkbLl5xPVO2yR0RCaGusLNvr9H2kq4zMxgSuDY4kdcNS086WT4HQzyYsF8sYhVRlgio3Rp5ULWVotR5JNBzmASAS/DL6+BRVnfwUfZRpFDYwU12SHeEtFRTnDd3oexGn58BhjOifqlaUc2FLR2gcIhC31Ic9NWLUQ+38ZW0+ZrMoe0F1TI8ikIOgYwZugwigvUgCUt3bQJ8YHH8a28hPKoX8qf0gNvJP9y2qPfKPxffEVxJx0agEzHINQARN63x3uOnVvJ99nadIAIE/2iDSTZjSCbzrJrH7QMvzQ7PoJv82jfhIs51g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKX16+7pVSxEkzkScf2I8I2Y4KvzOYiC3IzXn+F2iT0=;
 b=tcq8YUiF4hghdlp3IUebMgFk6eWnCs/OC13ixZf5o6HZGUW//k5ng2aQaiPxYm/XYYcfYzXCatESDz0aV2PEJGUsxB8G7TNw1f8KyWmEYO5wZ0KNxm7lhgD1Sr+lNSe3WUcwIJPnjwnZghgjwSvoiEFRCpfqA77AAFulqJsyZD9/P5MBJai11/KGeKRO26fD22NV+n4Lw7ruziq9r0DelEn5+aH8eU2HnMaQ7IJFgxeYBhW76KxL3kvjbQhPTe9x1gv4UobqsJYb8A8ZpfmcMxk64EEir89cyiE+88qorXK6DzrgS5BPXmyCsMKKJc0qMmj4ah7vVvvLz4NBjSMvkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKX16+7pVSxEkzkScf2I8I2Y4KvzOYiC3IzXn+F2iT0=;
 b=UBeQni2Utt6EtTR5WnzSmC4bl5wxeiDQV9GHuPFTU495Bl7cmhlHZCrBk29jUR/fU63Q8FAPuCvN2TVRT/g/OFUUCaxqz13VPMTvlSA1SqpguULUD3LVhyA5MM72zAxGUANUm7sJxTFg1R8Ff8ToPvMyIBcXKNNQOp/TUSIYvNo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SN7PR12MB6862.namprd12.prod.outlook.com (2603:10b6:806:265::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 27 Nov
 2026 10:18:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 10:18:37 +0000
Message-ID: <9928f223-e3ac-4d30-8a54-e779637135c5@amd.com>
Date: Fri, 27 Nov 2026 11:18:33 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu: switch vm->tlb_seq to dma_fence_chain
 handling v2
To: phasta@kernel.org, Chong.Li@amd.com, timur.kristof@gmail.com,
 amd-gfx@lists.freedesktop.org
References: <20261125153036.3278-1-christian.koenig@amd.com>
 <771c562b59828c0e18607a905979252d97a543d1.camel@mailbox.org>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <771c562b59828c0e18607a905979252d97a543d1.camel@mailbox.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0324.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SN7PR12MB6862:EE_
X-MS-Office365-Filtering-Correlation-Id: c7fea702-cf88-483b-c71a-08df4c6fccad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|23010399003|56012099006|11063799006|10067099003|261021121427099003|5023799004|261021135927099003|261026140227099003|261021123027099003|261022105027099003|261026121527099003|261022075727099003|261102123227099003|261028144727099003|261009223027099003|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: sImpuNSayX1TsHlxiEd2h7st4IImLs6OdUyZvv6MGI18+WTXxrfZeBYZYDqHIWKYnmU0UxYl6VrLytj/o8hRym/IkzOCU9y+3mJJHEsx5Yo+VlRwBSKUKWucJpIJI8VKvohCUVNYP4+ptDPiYDeqdsY/8DFeDnZLBkvuYB8iUdapS0dr6Td4uDcPrIveCeWy9YtnZoKWmFfjirqkhD3Jy4b1IQ18+HUoln4s0mJa/xqaqrH2jkKYoBTiCMMCKxf19/KTnYVIPzkBRap3D+UIRvALYotVPr+FFgBl+QlXMo0Pxe6Sy+Blkp3DLSDrSv6/J5lii1IQARKDbm/sD9bxLFiV7DffUbqxclouiM2PUONX01XsZwuTSPNyovN7lWEobr+aulwm93LFbhtzcGCMNqtqGF/zDReHG2E5vvx1Fiqkh1eBsgj+p/6HmGh9MAdizxTzDQO5FpQp1NKv48wvQOiUnBDVKjfMQp8c1Zi310FQCREGV0hjRfZExFLCpHc1pHGJAf3PMvFU74xCjDGjwb8wlGJmEKjujP0/Zy4uTVYppQrbRd4KzU/erSLcBiImjpFgqdnzMjeNHyTpJXVWTbhN55GPdiX+q4vjj6pm7PD77dt1UUm8mhgG+ocjhXk1eK1RaJfon/f7LZfd4nVl/6MuiuwYDkRm7mZ5pAe7NSQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(23010399003)(56012099006)(11063799006)(10067099003)(261021121427099003)(5023799004)(261021135927099003)(261026140227099003)(261021123027099003)(261022105027099003)(261026121527099003)(261022075727099003)(261102123227099003)(261028144727099003)(261009223027099003)(18002099003)(22082099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UEtIUGdLUUR3cWlQSkRnUnFRMEYrU3N4RUlpYUtKWGVZcHBPcituOHMxSDZ2?=
 =?utf-8?B?NTV1N01wMlk3c0s5dFR6ZzVJeVhDQ0ZOMzF4cEhHL2lvc293eGkyZTBoY3Rr?=
 =?utf-8?B?YnIyL1hZbzNVdS9HNThMbFFIbWt4WXdmZTdpN3RqT1ZFaVNyOEJsWkx6emNP?=
 =?utf-8?B?YnZRUUswekdTbUpxZGo0MWxwRU1TeDUwa1dHc1VIRHVOVHF0VzJmOFZrR1A4?=
 =?utf-8?B?Sm5xQm9Wd0NiMDNvVWo5NlJ0N0Q0cFdpWTNwVlJ3RlRhaE9VbkozdGxYdHI3?=
 =?utf-8?B?Ynl5NFJJMlI3R2hVWFkrWE1DbHRTVVJBTmRGWlRTQk55ajVVc0crWGJ3N3BN?=
 =?utf-8?B?YTZmeWUvY2J5Z3JUQUFaZWpGREZCNTBBZFJXMFZad1BSaVpNbXZKaGVzNlhR?=
 =?utf-8?B?TkVXa1VsWWJRU0t3SVNIQms5WEsxRkNaakhVUlhVM1RyMVhsL1JNUXJzd0xr?=
 =?utf-8?B?ajJobmNnK0pGdHVlLzZoUzFtT1hMYmt3c0JjMGlPZERRTGxmVGNlYWhJN2ky?=
 =?utf-8?B?MVduSHNTZHovaEhXWm9mWkZ2UVJIOEwrMlU4ZjBuMGdXODNTVHpiVGwySDJG?=
 =?utf-8?B?RnJPL3lnRHlyNTRJMERPZVkrSmR1MTgwd0JieFhZSU9SanNadnF5RHEzVVIz?=
 =?utf-8?B?dTJNQkJ6TXdWOTNhNWZWaEFNWkVrM3E2dnordksydW5SVUNGS1pGMDVKS3J3?=
 =?utf-8?B?dE5pNEhPN2dGZ09xQ0ptb2I4K0h4eWVGTWNCY1UxOVlVWmU1T0o2WE1tSTJr?=
 =?utf-8?B?cDZJT05LdURMZFk4WlJlajRMdnpPdVNtYmZRWmM2dkp5dHhOaUcwWFdZOWVS?=
 =?utf-8?B?TXluRDMyRjJSMGZNRzhGZjNaYlJjY2J2MGpFRjRRa0dWaUc4SU1Bdnc5eFdH?=
 =?utf-8?B?dnZxY3JCY2RSK1R0aXBUTU04SUYvT1FVRWJsL3NUdnhIYUtYc2dHeThMUFFU?=
 =?utf-8?B?blFkS2dubFF2VDdRNE1ZRG4vSTFtOUlIOW5NTHhqbzJOcTFqdm1TcWY0bFE0?=
 =?utf-8?B?NXJZcDUweHg3eHdBVmNqRjFXaWdwcUJvYURsR0liOG5HOWZkQkVMMzhSa2hx?=
 =?utf-8?B?OWxaM1RTVC9FSy9GMXZWU2E0bmdPaXBoaFFWMVY5cFhYcjRQNHNJcStEWjMw?=
 =?utf-8?B?cXp1NGdLOHJaTVk1bFozcXFuTnNIaDNTckptTDI4cFFQU2dHbzZIQlRKeFVE?=
 =?utf-8?B?QWs5dVdiTWRGeW1ucDJuUGcwQmNMem9rUGVxdVhPdzZsWk1WNVRDV0VBVld3?=
 =?utf-8?B?Vzl6RXFkYnZTdjlZM2JvcGdTeUpwK2RkZUtOQ0ppVmJpa2NBd3VVb1h5bVJ4?=
 =?utf-8?B?TiticTFxZU5OemJlRktvL1VaeXRrRDNINWdKM2xyY25acGdCekhSa1F1YkZi?=
 =?utf-8?B?VGxlTFM0bjJISEl2SWkvTXZFVUFaNE1zS2JicUY0Yyt2dU9WZ0JGSHBsMG5E?=
 =?utf-8?B?aVcySFFGS1NQZmVwd2xGWCtuS0RrQVVtTzdDdjIrMy96dkNocWk1TnM5a3Z0?=
 =?utf-8?B?Qld2ajdpaDhpNEloSFMrUS81WjhYRWJFWExCeUo3RldOcml2SGhRSGU2VzV3?=
 =?utf-8?B?djRUZ2lQNTJjbTM5MExsUCs4czRuMnBqSFdrU3N0UVJnc0dPc0dTbWdOc1FK?=
 =?utf-8?B?eExPejlpOHBNWEc0MEJzQlJpa0l3eTFCSVJxWGMzd2V5TDBrdVJDWmhmeFND?=
 =?utf-8?B?NmQxaXlYRWsxMHoyRS8wTkxXQnlJajVyL2FLYkZXNC8rUmFQSGhJallnaTBB?=
 =?utf-8?B?QUdTVnlEa1pzT2FEMFk0Q0NvT2llT1dpcWVQN0loSXR6UWlVdE16T0NUMmgy?=
 =?utf-8?B?L0lNQUNvWlJDZHUwV24zVlR0QUZVVWQwekdWZHlkUXljOWJiNDNkTDd1cXB1?=
 =?utf-8?B?cTBWeE5oOXl4N0grOUprRlZmZFNoMUpkZHRBQ2c4MGl3S09OQ2IyZW5NVjYr?=
 =?utf-8?B?SFAvS3hNQWR3dUJDN2p1elJnNExCczJvTVZ5WkR0YW1GSmNZYUJ0MVZ5dktr?=
 =?utf-8?B?WlUrd1lQeEdCcHVOY1hLa2dKUVVocTBOSHlRTkdSVUFKcHp5SnczQ3pMQ0RH?=
 =?utf-8?B?SmxRT1hlRVVsWjVQMzBQNjd5ZmxUQi9RME1ycUU3WkFVZ0xnTnZmZnlmWjQz?=
 =?utf-8?B?eUtuc3lETCthTHBuSFRzUTRVbnlXODExSXVWNG1taWdxdkFISS85eFdJM1M3?=
 =?utf-8?B?eWZ6NSticXVXeXZHZFA2d3VNMzZ6bWNxNytULysxUHE4UTBaQjVKUkorOFVP?=
 =?utf-8?B?ZEx6ckxEMVliS1YvNVA0QzVXSmR1Q05lVmVHM0ZBY0R1UW4wa202czIzNkhq?=
 =?utf-8?Q?Up1yQjUxKz1vOdAmtf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fea702-cf88-483b-c71a-08df4c6fccad
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 10:18:37.0357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A8z90cLQtt1ZFBtq82tkPvnclhzj/b2JJX3t0oUAMKUawi6KCnipGYJgI4GpglMH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6862
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

On 11/27/26 07:30, Philipp Stanner wrote:
> On Wed, 2026-11-25 at 16:30 +0100, Christian König wrote:
>> This not only fixes rare GPU page faults in the kernel queues but also
>> potentially issues with the user queues should a PDE update make a TLB
>> invalidation necessary.
>>
>> v2: also handle the case where the chain head is already signaled as
>>     pointed out by Alan.
>>
>> Signed-off-by: Christian König <christian.koenig@amd.com>
>> Reported-by: Li, Chong(Alan) <Chong.Li@amd.com>
> 
> You mention "fixes" above and there was a "report". Cc stable?

We usually add that while discussing the patch, but yeah I agree that we need to backport this.

> 
>> ---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 173 +++++++++---------
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  32 +---
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c    |   3 +-
>>  drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |   3 -
>>  .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  |   2 +-
>>  5 files changed, 94 insertions(+), 119 deletions(-)
> 
> Do you think it might be possible to split this rework up into smaller
> commits that are more atomic and, thus, easier to review / understand?

I already tried that and always ended up with something which was broken in between patches.

>>  
>>  	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
>> @@ -2876,10 +2885,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>  				      false, MAX_SCHEDULE_TIMEOUT);
>>  	dma_fence_wait(vm->last_unlocked, false);
>>  	dma_fence_put(vm->last_unlocked);
>> -	dma_fence_wait(vm->last_seq_flush, false);
>> -	/* Make sure that all fence callbacks have completed */
>> -	dma_fence_lock_irqsave(vm->last_seq_flush, flags);
>> -	dma_fence_unlock_irqrestore(vm->last_seq_flush, flags);
> 
> Certainly nice to see, but I can't derive from the commit message why
> it's now ensured that the fence callbacks have ran?

The point is the callback which increases the sequence number after the fences signaled is removed.

So there is no chance that they can race any more. I will update the commit message.

> 
> 
>>  	dma_fence_put(vm->last_seq_flush);
>>  	dma_fence_put(vm->last_tlb_inv);
> 
> […]
> 
>>  
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> index d03b9bbe20c7c..17a579dbf7b90 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
>> @@ -122,8 +122,7 @@ static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
>>  {
>>  	struct amdgpu_device *adev = p->adev;
>>  
>> -	if (p->needs_flush)
>> -		atomic64_inc(&p->vm->tlb_seq);
>> +	*fence = dma_fence_get_stub();
>>  
>>  	mb();
> 
> Hey look, an undocumented mb! ^_^

Yeah the comment directly below explains why it is here. It is just not showing up in this diff and the technical relationship is not so straight forward to understand.

> Would be a good opportunity to document why it exists. Does it order
> against dma_fence_get_stub()? Seems unlikely…

No, most mb() in amdgpu should actually be a dma_wmb() which needs to be used so that the HW sees written values.

It's just that the code is older than the dma_wmb() function and nobody had the time to update all mb() occasions in the driver and test if nothing was missed.

Regards,
Christian.

> 
> 

