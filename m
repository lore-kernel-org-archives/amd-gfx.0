Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DDB0C48BF6
	for <amd-gfx@archiver.kernel.org>; Mon, 26 Feb 2024 16:58:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0B3310E7DF;
	Mon, 26 Feb 2024 16:58:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YGsKsCem";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 450F610E7EC
 for <amd-gfx@lists.freedesktop.org>; Mon, 26 Feb 2024 16:58:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q946RLxdnAwKSKHXH07EhyD3H8UrBm6SV1VZXSUdpOkeJh3WDvbH3dlTBhIKa4khBqiquTtt9NUdx/vWCi2o5eRiZcuaUfWKlfKbm19ayHEnlS+lWIpsqTnuU1g+8TJRzoPGvL73IQ6ol/UcE9uVBGrIJ0iPK4EBLFTqu5J9SlNa5DgeupAw3CHR0aWlck1HXvHvSU9gWBoDUxWtqx/SnwI3omaj1VGLVgkJva3oCekNwDTdWWBUSZfWibpc0C9flLqK3mbJ8Qyd0PQYuZFvP5bRU6F4uqpfSLc+eVRsAG93njWHy+x2j0mbdBIQBmxk1C5Y3n3zOQ2ZOufNpwKJNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HhwVWG1ABWs1J3YKBp40jKxL6d6N67rTMWu1wy1ixeU=;
 b=NO8e8IFlTEk2MdUV/m/28+sjSLrN6s71cl99j93z7Zd7bGXQTkBt7z3mh82RkCsnV3EY2AMeNTllQNly4psF8ene5vesaJ2fATjeDy6RkSU5W9S+TWm/5BUMonn3kREtIiMY6jJlClxEs4BTp2AcS97TF5rZPybudmJQvp9je3bU/sCgntxEwbN046qSHuN//hzIHvQIKA9kZTT5dIGJm6K6pwDYQ6BU8aCIBiNbEhimiuIsD7K5FmkYGn/JG7Rm0FN2qWT9hdfIB2KVHYzohZ59i5t1fATFQbyeNp/lwFL1uE6LwUPWQtni1OYmNIl6iNsaqmwXVH4E4aKKZvWQaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhwVWG1ABWs1J3YKBp40jKxL6d6N67rTMWu1wy1ixeU=;
 b=YGsKsCem6yBQ9VkfzLLzDhYYaBIaUhlSQRg3ZR396d9c05ywfJLStKnGBNdVC+Gpzl4Wj5hWr/+2dafbkyCeuP5xcs9Q4w46YirtpXvXTgKdl4ZHDArrAwst9J+Nwf0xrWR+NzAOZLMWI+Lqi5I/mxaGR5HmJioB7prn2LYdsyA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8642.namprd12.prod.outlook.com (2603:10b6:806:383::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.33; Mon, 26 Feb
 2024 16:58:10 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::f2b6:1034:76e8:f15a%6]) with mapi id 15.20.7316.031; Mon, 26 Feb 2024
 16:58:10 +0000
Message-ID: <d1c239e6-482e-4851-a61b-23727abf6b65@amd.com>
Date: Mon, 26 Feb 2024 17:58:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/amdgpu: sync page table freeing with tlb flush
Content-Language: en-US
To: Philip Yang <yangp@amd.com>, Shashank Sharma <shashank.sharma@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
References: <20240223134206.899-1-shashank.sharma@amd.com>
 <20240223134206.899-3-shashank.sharma@amd.com>
 <555f7ad2-a3f9-1f79-970f-eba3512d8aff@amd.com>
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <555f7ad2-a3f9-1f79-970f-eba3512d8aff@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0160.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b3::14) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8642:EE_
X-MS-Office365-Filtering-Correlation-Id: f760f179-9af9-420a-8f64-08dc36ec1cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EHp6AWg2uXBx+cu6G0o7VYb8jdXhaZEmnmIWZ3CH39NJJlmtiNlvPAUOooAolo2VirKw5wimQcWBWDPWSRbR1TCBFkAR+dVCI0LfQqqu5TfkGO3Ejv7ppSZyEmDi4Zg2aqrQ1ogmchHflf6rcT06zDqyHXF+QPj9dv6p+Mg0tAhgb7BA8WkplBvJw4QAzQjrEV9L+RQ8fgmFHs3eBuqhf0vZ8oAukwNX3T9EGA6w1O0UgUneAZQJ8/NDsQ6ob/ywcAppGgvOR4DEPX/94CEBhW+bzs6y7ehPVYBt4O+coo4MpPNWMUEz2n2Ic77Ya9ZzkRO34Y1LSNBjSOzXoT16dbeIMMD4GfMgJeH5TA7Owc+7b4lcSHlhfNQ4FvtPAK3g115U+aIIFHlsy2cbHdi2M/pffhyq/rI9lriGcH+yG33pIEs+Aay8h2ubaLW0cXZ73NSO91tZVnzuoXhRsM8orTYfONW9Km6fgUJqyVoiN/PbRZJQLVtvc+rCO/mt2Q3Qv0lJN6HjIRplhYN8dWuFWb0aLYfGAiGArjSm0ItEK9MTnOwbjW5MePw7LfOoX9c0XjAroOGn2wYq4erq/zHnWRrXj+0Ovk7UM6BQhhSTktPMSNN+cpFvva7LjSlZ5GBxlEHZh9SNq933nOYcPgEeqw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YVRqT2tWbG10MkVjVTgvcVkwQTlBWjRwaitWbmZoY3JTYzNPMlAySGRsbFBZ?=
 =?utf-8?B?b0trUHJOdGQ2UDBJRDNIVThaTEJGQXMxMnpuWDl4QzVOSlNkUXhaR2hjUTFI?=
 =?utf-8?B?R0k0VWZTb0hHSUVGLzM3MUpqZTNNUEFsUStXOVFjUm9HYjloSnVValRlNThC?=
 =?utf-8?B?U05ldE51M3ZYdHNJUmtBOWpleTlJelZaTitsSjIwVG5VSVRYZzRmQkNyNm5a?=
 =?utf-8?B?dUxONVNnbkdKVzVPOTN1bGM5Z044eDFtZTdxTEF2RjFDYlQvRHYzcnlmYkRY?=
 =?utf-8?B?TjVScUcxR2p0eGZYV2xqbWhIc0wrUm1naTliSFN0SmZJUEJaTTloT1RCOE1u?=
 =?utf-8?B?L0FpLzg2SnpjaTRLOHFzbFBFUnA3dkFTd0ptZkc0L3VhMkpZdUtoNFRsTHdz?=
 =?utf-8?B?d2lWcGpUODM2cW5SZzRNYThWZittOEpBSnMzM2Uva1lCeGd4RUdpNmZ1TG5K?=
 =?utf-8?B?d04xalJKb2p4RjJiRWZra1B3MExOcWQ0bEdvd3NXL01jcnAwN3g2VWcvV3Yy?=
 =?utf-8?B?YTFqbi9rTHo2YkZXbEpWOVJMWWxHb0F3cGp0a3YxL1VFVCtOM0xLYzIySEZN?=
 =?utf-8?B?V2VKSU1lM1o0THU1ekEwQjJOUUFPbFZSOXZ4Q3ZGWjd2NHFoL3M0Tjg3dFhS?=
 =?utf-8?B?Zi9Xb0dubEdYbFBsZlpSZ1BuUzR0R0lQWmNZcEM4MWlyTEpVWHpiN21ZK0k4?=
 =?utf-8?B?cDRvMncxZUQ0R2pVaEQ0VzNZaTNBM1J1U0ovUVQ3QlMxcTk3b3JQQlI4NCtm?=
 =?utf-8?B?VlhoSXBuUC93YjlqQlN6YXFzWlZrUlVJVXZBM0hiK3NsNGtPcHNkcUpqd3VD?=
 =?utf-8?B?S011b1ZpbVc2eEhqT0dlWE9JQmhFY3RMWGpPa2wwaFJ6TU9pbEwzNCt2OStU?=
 =?utf-8?B?Y2RabzJqZ05XYkRSaDltL0NNTmZpNmZiSmM2czZBOTFsN2ZMZHBsWFBvMkYx?=
 =?utf-8?B?cDlEUUZRV3JkeUVSY0FkektUazF5T05CTHU1S05zem5QOWUwemR3elpTOUR2?=
 =?utf-8?B?WVJYQ2FDdmpYcWMwckRuOVUyQW0rOFM4OHhmVGNWd3RWZ2RVWFRuVlg1TzRp?=
 =?utf-8?B?ZkxuT2kzOG4wYTA0YVhuT1prVG9nblF3YXhCNXNORlpiTGhLcU1jaTdmU0VI?=
 =?utf-8?B?MXBma1RtWnVJRThoNGJCYU40OW9qdllwSXBwL3BNUTg0eHVYcVhuUUJiMDFK?=
 =?utf-8?B?WXlwUXFJQTNoRmRXUHhtOGJCSjZaWGVWOXFKTm9rTzlydElGS21mNWp2djVi?=
 =?utf-8?B?ZnZ4UWZONytLQUFIYVEwUWoyOS9TS0hUQVh4M1ZzZUFvMEZYQ3dGdTdSSXJM?=
 =?utf-8?B?Q2d2M215M3doWHRZUmtoUzN3b1FlY1ZpcVN4NWhoK2N5dTBaK2Z2b0lWSXdQ?=
 =?utf-8?B?QzB4cUpHYWRtVjVRL3BhS21ONUhkeFpIVGtLMkR4anRtZVAwOGRPZEF6NUwx?=
 =?utf-8?B?cU5OV254UlFFRllhNUk5NVlmTzRnc2g4UlFuTGRjSHlteHNwN3prangrSDM1?=
 =?utf-8?B?RU85cXNUNjUzVzFHWUd6WjNSUUM4Y1ovZ1JyVnVTeis2M3J1dDBrNGpvcyta?=
 =?utf-8?B?dCtSN0ZNVnY2U3pNeVdGbkdFRkdBT0xWSnVUSGI4VXB3N0lBWEtIOVV5N3Z3?=
 =?utf-8?B?eGhzaWgxTGF6SEdRNE8xUzFqUkcxS1ZjV1ROamtjTHd4WFJlWEhESjJNMEdK?=
 =?utf-8?B?ZGlpR2ZuMUtpVTBJL0trL1RqYVg4TTJ2aEQ1QXpyWnFtOXJUWEZoRFNUejF6?=
 =?utf-8?B?ZmdMQTBLS2VxMWFRNDRJcEdWd2tUZG14RndGZWJ4QnNKMUZ4VHhXb2RObmRp?=
 =?utf-8?B?akI1ZWkvSjR4cmRQNWxHL21wNGIyN3pyVFp1UkFaK3lqaElYcVpDTCsrVFBm?=
 =?utf-8?B?R050UTRYK3BhTERjWXdOT1Q1cWtibWVpVTN6OFV5U1EzaE5aQ3BoMkYyOWFy?=
 =?utf-8?B?Yk9OaElENGcvY3ZQV2oySVIxWWFpaERlZnArdld3eExzM2kyU1lVT2gvT3JT?=
 =?utf-8?B?L0YvY0Z4WVdhdXFvR0N1VFA5WE1XWmd4N2FUYTFtR3dvelk1djFCMzIwZkUr?=
 =?utf-8?B?V1FwWTYvakdFd2FGQ1Zvc2R3cmdleGR5Z1dJNS9FNjZrc0V1WDh4VkpBdlg4?=
 =?utf-8?Q?zrp7VrWi9ds4rD7gpvdGM5U+1?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f760f179-9af9-420a-8f64-08dc36ec1cf4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 16:58:10.7169 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5LmAR78+BAJSinnhw6ejtS4WVa+wVNhElOGCVlk8ubJtMj7OuJufO0gbs6fo3/nS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8642
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

Am 26.02.24 um 17:52 schrieb Philip Yang:
>
> On 2024-02-23 08:42, Shashank Sharma wrote:
>
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
> Because pt bo attached with tlb flush fence already,
>

The problem is that we attach the TLB flush fence only after that here 
is called.

But I agree that this is not the right approach, instead we should 
change the call to amdgpu_vm_pt_free_dfs in amdgpu_vm_ptes_update.

Basically put all the freed BOs into a list in the parameter structure 
and then call amdgpu_vm_pt_free_dfs() after adding the TLB flush fence.

Regards,
Christian.

> so amdgpu_vm_pt_free will not free the bo, the tlb flush work will 
> signal the tlb fence, and then the pt bo will be freed.
>
> To add freed pt bo to vm->tlb_flush_waitlist, and then wait for tlb 
> flush fence at end of updating mapping is unnecessary, this patch 
> seems redundant.
>
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

