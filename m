Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E85C54E49
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Feb 2024 17:37:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C695E10E58A;
	Thu, 29 Feb 2024 17:37:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="XeRDqOkx";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3691910E4EB
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Feb 2024 17:37:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jlHSS54W7fvTcZx6BpO3YQX4MIdkm6gB9XvXEhRDrvNAcGcgsO/9sBG/xF/PickdOMYMVZo+J4BbQ6u8OiOzAod+SSWevHjkPZjmvg6pnYT4yW3St5zy/bypTQVkd+BY7HYRcGKdgmhgxHnhHH35oN4uMT/6q4bLepYex/lJh6ZaRz7hgy3pZpIps0GwChvVCovfS1JXm4K0I7nWVuREorBBrfV5nV/FGSILMEqE4Ivh7vVG6nufraywS2nRxxtiDfER4Vw6qS9BI0b04CN8PRmhM16n14lGC9TEvVh6juiZYXO79lccZ1Lc1rTa/XwgRhylXbb6pfYRX9Xu2VfmTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y5EDi2lVNxOGwsuDjOkNpl51BJuOw+EUmM9psR4TU3E=;
 b=CTYxpII8lCNxG7RgSQdLhICF7hs0MxCrO0XxqmWPUY8WShWCdZpnlI+0YEtpfuL2/3RTj5ruaSCquJgIZHouEmK+7MoIQuM9tJBUS6WcQyywac6ktZxnhgWqmSfy260WkuqTjuHmr8w0MnEzSXqa5oj7RxvBzqAOx3jcpq8f+/HdJVQxNYaLHXAZXtG7+WG7rRa7LecL6haO5t4uQKeB1+CLwH0F1S44Mf+gexMEwZzbP+6ypl8yogGuOjfrOlUft/EUBFObYaclbxpZzfnrjhvqm3uPeLhDtrQBR0+rjH3CxBF2TNajKCU4DDsXAPNWnVqEwNYOgY4UDYZCv2QF6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5EDi2lVNxOGwsuDjOkNpl51BJuOw+EUmM9psR4TU3E=;
 b=XeRDqOkx72BRHt6C0LDLBHWOfv7M935AEETn/4wPzzUQkksEnBYeFXVWsdeXlmt7kayPc5ZivyfLZq5CzBwtche/wUuUGO+Thpw3nmESlGR7ESCnr//o2Xd+ahK6uvB9YZfGKnsgZeZjaaNUqwZAXKXoAyBpsWkQnU1E936TfKw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Thu, 29 Feb
 2024 17:37:44 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::baa0:7590:7bdd:e60]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::baa0:7590:7bdd:e60%2]) with mapi id 15.20.7316.023; Thu, 29 Feb 2024
 17:37:44 +0000
Message-ID: <6cad8a76-43ef-e0da-1345-1e61ea19a136@amd.com>
Date: Thu, 29 Feb 2024 18:37:38 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v3 3/3] drm/amdgpu: sync page table freeing with tlb flush
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?Q?Christian_K=c3=b6nig?= <Christian.Koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
References: <20240223134206.899-1-shashank.sharma@amd.com>
 <20240223134206.899-3-shashank.sharma@amd.com>
 <555f7ad2-a3f9-1f79-970f-eba3512d8aff@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <555f7ad2-a3f9-1f79-970f-eba3512d8aff@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BEXP281CA0003.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10::13)
 To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: 832b5997-c4c4-48af-65b8-08dc394d2312
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wV5w2rotZCXdtaKh1sNnEfCHxFOhfp476a+nMd+uc4BIB6dHB2+w3cO5z8OzYas9Lw61H0KBrreJDJSK0dnEYMra2XBdk86Ns5Yzo+8kafeWFflbWpYtRSAB+vl13+H/B+lBfuu2vejbrglzxywVAUWjsO2KlbG+GfmA+xBjwBqCalgFWlimAV2fExjGdO9Hkc2DEqj4/Rpg5qil2soFgIgGCXzMsS2qtySFXZC9vaXY5hLRMtrJzNwlMGMkh/WKC4I1Cc3+CRQMvwzUI2DgeI00rohnIxHITuiXMFVjW8sCxA87nwcUs7KyQFU9J/0VXCUwdZ4HLr2Wj7zJFDF0GYtWkoKNE7bB0Dmv/QziT0Y88vq2iBXvPzHFEBKn1Uaadq8yphxgq9YQ5/AElKIlo22XGWa/mbKviYLYEtpRiPhqKFW7pmPK+ysKFMdHUqwpM5yppsq8p0+n3qk0kL7BQj8F4IlpJr+KhKKTCkHzp9uo4gehuUaKqoBRljAav7pJLmryE+rfCsV6PUz3uKMS+F8NhUs3nIW9U/DgvOHUz8ug39ONL5Hcr4SjXCBRLiBxfro+1sbb6ml6/KgsTsbhAf7QBExmiO6eV02CKEocmmlREJttOJL9epiQ9LAcCeRJLHff19zz6/cp3l7L4C5reg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmtKUFRDODVHZ1k0TXI0NExCS3MzZWNyUkhSMU9BdVpOcE5GeG9JZk9HQWJt?=
 =?utf-8?B?U2FZOWlDblExRGNzOTZ6a011d1BENFpWTmVOU3lEaERmLzZYWW15dUVzbWRV?=
 =?utf-8?B?alVuekpnT2g2TGVNeTBCS0RmMEZ1NkdyZGx6VUl4TGxESThMZmR4NnZvVHRj?=
 =?utf-8?B?YWI5UDgwc29mRVJyUisvazhDVXpwdTRma0RGblBsbEVXMG5NQVlTSWp0SkRm?=
 =?utf-8?B?VWxiQ2loUWxJSmZrVm93ckdaQXBVKzhlRGtTRkd6aktXaFg3b0w5ZWt4Yk45?=
 =?utf-8?B?YWREdytoY1NQUStuTUxqd0ZHdVdoWFdWNGF1cVlPTDk2VlF4N0h5L3ZrWU9I?=
 =?utf-8?B?R0ZMYjQvaWwrczBCRkgrUFJCYXQ3YUZEL2hQQm5IQk9URnVSaUViMzBzazVB?=
 =?utf-8?B?MVgzaHVXcERqTFNUcXM2bm9lc2N1UUVBTmR3RENoelVZYWtuNE1hMzZuMi8z?=
 =?utf-8?B?TFp3bU4xbkh5Sk1kbUlBMjBvc1E1eGFhYzNzMEc3blFzVG84eWhaUWE3UG15?=
 =?utf-8?B?TmE3NENzR1JIWjBOWFZaWlBGL1pmUjlMdUhTK2lsVFA3am5CZGtCOFBmWEUx?=
 =?utf-8?B?eFRxaXhkeFNNNUNHc1Z6ejAvVTB5WWNHdHk5VnpFbmErbE9ITnZlN0FyaEkz?=
 =?utf-8?B?OFdWeHRzdERrc0JjdEdEeGpIenhmSVlEaFAySm1pNHVDQ0tKektCdTkxaTdu?=
 =?utf-8?B?Wkp4UE5jZXhXZUMvTG03RFhYdU04QmZwUzZsVmJkVGU5MHZiaTNRZnVFV2Yw?=
 =?utf-8?B?MnpCYndQcmUrc0xhVUJaNGsyOU9OZVhrdUU1U3I4QnFLRG8wOEZhczZVN0hP?=
 =?utf-8?B?dzB1dXlmOGI4TmVXakRkbVZwd1NNOEdzTHdLd2dnTlN6d3JBbWU2Vy9NNHZD?=
 =?utf-8?B?SUlsY3Y4UTRqYUhOZHNjYzJqdnM3UnN6eWJtcVFBNUcrNDg4ZVhtb2NzOHlP?=
 =?utf-8?B?VDd0ditxcURWSEloejkwSkJvSXM2ZHZxNkl0cTFLcUhXU2VpMlhyUkxxZWRy?=
 =?utf-8?B?THFSTU45b0xHQlZoaFVNaFlpZWVleCtzaXRna2o0ak1EQWFtMEg3U0x0eEpp?=
 =?utf-8?B?UlpNcVovMENhdDZLbjR3UmUzc3d0Snd5aHIzZlc0bWk5UEFVQU9aMEdHd1gy?=
 =?utf-8?B?cWw2MHllV2RESDZPalU3WE5OZTBYMlhpSDNZTzJrK3VmZGVLVUNJelZhR3dU?=
 =?utf-8?B?YW5FT1hGNU0zNWltOWV0S0pmTG9GVGh2blV3NmFJMFRjNGRzb0dBUjg0SXpO?=
 =?utf-8?B?YWUvMjhsNHZQQ0ZML3ZJcVlHMDNVZnhsOWNjdmpDeGMyKzZGYm9DRGhiU3Nm?=
 =?utf-8?B?QW1kT2JkVE5xdFJyMWNEN0JnRmFUTDNocnJJZ1M3ZjdFeG9ZNEJWZTA4YkpD?=
 =?utf-8?B?VUpNRElpVFgwQjZTdGFvNFYxQXlFMzc4aG5tcXdYdFFidHc0blNiNmpQcGRY?=
 =?utf-8?B?RmJlT214c2I2MmlyMDJJWGloL2dWOU9yMC9pN0pUSXhuVnVGSzhnSksxQzZ3?=
 =?utf-8?B?MGx3RG1RY0xyR3U2clFKNjJuZW9ZSWZPLzJuaHpJR1BNQnBGYzdORFB1b2Mx?=
 =?utf-8?B?OHF4bGtRTEpkODR2aXJGUDJIVUtRTTJCWXUwdVZ4cGNGT2xwR2VXN3hSZnFC?=
 =?utf-8?B?U1hhaExwTGZRSGxUWkR4MXFQc0lkWWRsTmFSRGpoVXU4d1pINE1MMUpkQitZ?=
 =?utf-8?B?ZWhhUEQ2TGpVb0FqMVA4YjdmS2lEUmhxc2RyOHZTODBxbTBjMU9UcWZyVGph?=
 =?utf-8?B?SzNZTjlxM2t3OG8ydkozcXJTcTYwTEFscFROTkpEVERpMVN5b1UzTDEzcklX?=
 =?utf-8?B?TStIN0tWMXZVS3Rka3BsaHVZZ3p5KzUwMzY5UkFtajZ6amx0bXY4Q2ZqRHN5?=
 =?utf-8?B?Nkpmalc0YXYzRWhUKzlXWGEybzhaY0VqdmJUVjRwdDNuYVJIbmlCbTVGc0x5?=
 =?utf-8?B?eUVIZHNHMUk3TDlaejQyUWovRUZLc09QSjYxaWd4eERTVExYbXkwVVVTK2R0?=
 =?utf-8?B?OVVWOGRWbG1OQzlRNVZIUFNjSVRDZEpNMm50VGcyd2h2V01EZVlFbFJyRUpW?=
 =?utf-8?B?V2drVWlZMXl1R3JtNEFaZUdBUC9sS1pmbkRnMUhrN3A4WnVCeVM3bkNHN0NX?=
 =?utf-8?Q?GbGnFha7dP7jWcZTSbklO/lZK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 832b5997-c4c4-48af-65b8-08dc394d2312
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 17:37:44.6367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K/3s6nscCn8WO0kT+wGwauyd4o4aRWMymQtb6FoaRRr73QRq6ofGlTSpUNOtUaf7ekcDkThbJpJcJcUDEijo9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256
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


On 26/02/2024 17:52, Philip Yang wrote:
>
>
> On 2024-02-23 08:42, Shashank Sharma wrote:
>> This patch:
>> - adds a new list in amdgou_vm to hold the VM PT entries being freed
>> - waits for the TLB flush using the vm->tlb_flush_fence
>> - actually frees the PT BOs
>>
>> V2: rebase
>> V3: Do not attach the tlb_fence to the entries, rather add the entries
>>      to a list and delay their freeing (Christian)
>>
>> Cc: Christian König<Christian.Koenig@amd.com>
>> Cc: Alex Deucher<alexander.deucher@amd.com>
>> Cc: Felix Kuehling<felix.kuehling@amd.com>
>> Cc: Rajneesh Bhardwaj<rajneesh.bhardwaj@amd.com>
>> Signed-off-by: Shashank Sharma<shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  6 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  6 +++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 51 ++++++++++++++++++++---
>>   3 files changed, 58 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 67c690044b97..eebb73f2c2ef 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -939,6 +939,10 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   		/* Makes sure no PD/PT is freed before the flush */
>>   		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>>   				   DMA_RESV_USAGE_BOOKKEEP);
>> +
>> +		mutex_lock(&vm->tlb_fence_lock);
>> +		vm->tlb_fence_last = *fence;
>> +		mutex_unlock(&vm->tlb_fence_lock);
>>   	}
>>   
>>   	amdgpu_res_first(pages_addr ? NULL : res, offset,
>> @@ -2212,6 +2216,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   	INIT_LIST_HEAD(&vm->freed);
>>   	INIT_LIST_HEAD(&vm->done);
>>   	INIT_LIST_HEAD(&vm->pt_freed);
>> +	INIT_LIST_HEAD(&vm->tlb_flush_waitlist);
>>   	INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>>   	INIT_KFIFO(vm->faults);
>>   
>> @@ -2244,6 +2249,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
>>   	vm->last_unlocked = dma_fence_get_stub();
>>   	vm->generation = 0;
>>   
>> +	mutex_init(&vm->tlb_fence_lock);
>>   	mutex_init(&vm->eviction_lock);
>>   	vm->evicting = false;
>>   	vm->tlb_fence_context = dma_fence_context_alloc(1);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 8e6fd25d07b7..77f10ed80973 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -334,6 +334,10 @@ struct amdgpu_vm {
>>   	uint64_t		*tlb_seq_cpu_addr;
>>   	uint64_t		tlb_fence_context;
>>   
>> +	struct mutex 		tlb_fence_lock;
>> +	struct dma_fence	*tlb_fence_last;
>> +	struct list_head	tlb_flush_waitlist;
>> +
>>   	atomic64_t		kfd_last_flushed_seq;
>>   
>>   	/* How many times we had to re-generate the page tables */
>> @@ -379,6 +383,8 @@ struct amdgpu_vm {
>>   
>>   	/* cached fault info */
>>   	struct amdgpu_vm_fault_info fault_info;
>> +
>> +	int count_bos;
>>   };
>>   
>>   struct amdgpu_vm_manager {
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index 95dc0afdaffb..57ea95c5c085 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -643,13 +643,13 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>>   	if (!entry->bo)
>>   		return;
>>   
>> -	entry->bo->vm_bo = NULL;
>>   	shadow = amdgpu_bo_shadowed(entry->bo);
>>   	if (shadow) {
>>   		ttm_bo_set_bulk_move(&shadow->tbo, NULL);
>>   		amdgpu_bo_unref(&shadow);
>>   	}
>>   	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
>> +	entry->bo->vm_bo = NULL;
>>   
>>   	spin_lock(&entry->vm->status_lock);
>>   	list_del(&entry->vm_status);
>> @@ -657,6 +657,38 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>>   	amdgpu_bo_unref(&entry->bo);
>>   }
>>   
>> +static void amdgpu_vm_pt_flush_waitlist(struct amdgpu_vm *vm)
>> +{
>> +	struct amdgpu_vm_bo_base *entry, *next;
>> +	LIST_HEAD(tlb_flush_waitlist);
>> +
>> +	if (!vm || list_empty(&vm->tlb_flush_waitlist))
>> +		return;
>> +
>> +	/* Wait for pending TLB flush before freeing PT BOs */
>> +	mutex_lock(&vm->tlb_fence_lock);
>> +	if (vm->tlb_fence_last && !dma_fence_is_signaled(vm->tlb_fence_last)) {
>> +		if (dma_fence_wait_timeout(vm->tlb_fence_last, false,
>> +					   MAX_SCHEDULE_TIMEOUT) <= 0) {
>> +			DRM_ERROR("Timedout waiting for TLB flush, not freeing PT BOs\n");
>> +			mutex_unlock(&vm->tlb_fence_lock);
>> +			return;
>> +		}
>> +
>> +		vm->tlb_fence_last = NULL;
>> +	}
>> +
>> +	/* Save the waitlist locally and reset the flushlist */
>> +	list_splice_init(&vm->tlb_flush_waitlist, &tlb_flush_waitlist);
>> +	mutex_unlock(&vm->tlb_fence_lock);
>> +
>> +	/* Now free the entries */
>> +	list_for_each_entry_safe(entry, next, &tlb_flush_waitlist, vm_status) {
>> +		if (entry)
>> +			amdgpu_vm_pt_free(entry);
>> +	}
>> +}
>> +
>>   void amdgpu_vm_pt_free_work(struct work_struct *work)
>>   {
>>   	struct amdgpu_vm_bo_base *entry, *next;
>> @@ -673,7 +705,7 @@ void amdgpu_vm_pt_free_work(struct work_struct *work)
>>   	amdgpu_bo_reserve(vm->root.bo, true);
>>   
>>   	list_for_each_entry_safe(entry, next, &pt_freed, vm_status)
>> -		amdgpu_vm_pt_free(entry);
>> +		list_move(&entry->vm_status, &vm->tlb_flush_waitlist);
>>   
>>   	amdgpu_bo_unreserve(vm->root.bo);
>>   }
>> @@ -708,11 +740,17 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>>   		return;
>>   	}
>>   
>> -	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>> -		amdgpu_vm_pt_free(entry);
>> +	mutex_lock(&vm->tlb_fence_lock);
>> +
>> +	for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry) {
>> +		if (entry)
>> +			list_add(&entry->vm_status, &vm->tlb_flush_waitlist);
>> +	}
>>   
>>   	if (start)
>> -		amdgpu_vm_pt_free(start->entry);
>> +		list_add(&start->entry->vm_status, &vm->tlb_flush_waitlist);
>> +
>> +	mutex_unlock(&vm->tlb_fence_lock);
>
> Because pt bo attached with tlb flush fence already, so 
> amdgpu_vm_pt_free will not free the bo, the tlb flush work will signal 
> the tlb fence, and then the pt bo will be freed.
>
> To add freed pt bo to vm->tlb_flush_waitlist, and then wait for tlb 
> flush fence at end of updating mapping is unnecessary, this patch 
> seems redundant.
>
Thanks for the review Philip, I guess the problem was due to the 
placement of attachment of pt_bo with fence, which I will move to the 
end (in patch 2), which will make this patch valid again.

- Shashank

> Regards,
>
> Philip
>
>>   }
>>   
>>   /**
>> @@ -725,6 +763,7 @@ static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm)
>>   {
>>   	amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>> +	amdgpu_vm_pt_flush_waitlist(vm);
>>   }
>>   
>>   /**
>> @@ -1070,6 +1109,8 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
>>   		}
>>   	}
>>   
>> +	/* Actually free the buffers now */
>> +	amdgpu_vm_pt_flush_waitlist(params->vm);
>>   	return 0;
>>   }
>>   
