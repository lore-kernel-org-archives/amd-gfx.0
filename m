Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BBDC5475B
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Mar 2024 20:17:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8511B10EBCC;
	Fri,  1 Mar 2024 20:17:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uaWiofDu";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2048.outbound.protection.outlook.com [40.107.223.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1301110EBCC
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Mar 2024 20:17:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Di53lQM4rnV4vfL6KZxO7zEA9hYhqPkre6BpF5SrYVw7vdp/I6WDuJyFc1ITCxSY3p0GHhY2xhLiSlgru73JNRVRJ1rZhvdlftaCs5TF3gL/KciXgqmYcHqJnYtR/NzvCsADI8+1LBW+qGPbAMLTaTjvd+TEb1Pncj00nMsKGX+KztV33RkmwwjDQw1HTMInKe6cWTy/U6nO2cuVlLO9v8RaluQx++UB7n6GwLYA82rIJwxXaudQmnXLuYrz6GZy5olm6deKB8HxzhYA6TrulU2/uogqsWbe2rz50t2RwbAvaZ5pACUBRK4Qpg4qojFYduo0SwMj4YKGwIMPwDsViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zpGEKU5xAaB+zFGcuVdVNN6Vjn9MoJohaATjUU44zis=;
 b=JSraBVmHsZApKl1vgBfpKcu/zoMdGYwSgNvdZdCfg/BIQuuiwOsNG8U63e2KZHaM08VT6nDRiNIUaZuzD6y2KE9g5aBYAu5bcOyS7ba6owIoyzgkSXk9tF95vQs66Luyz7+XmBhmNTs6SPCqgWhYIY4l0BJLYD5C7o0Rh4/HOtOAY9xUmG1KylwSUGVqH4A9qsIBqLJXzm19Gmfk/VyI8yLi67ofAoH7YNQ5ezHY3b5p9dGH7Xu4kiy3hSULGlUDwPlUlyyoqLv1avJ4+tfn4D96uCJmjWyFfyzlN8fms9XFgeublWTCXSnxkgNP10CwZQujEqmtDDDOpXI7BF9eOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zpGEKU5xAaB+zFGcuVdVNN6Vjn9MoJohaATjUU44zis=;
 b=uaWiofDuS0RrQnX5wX6rq+ryaG1GCNSviZfCkeEUTKenwS18gHXtzU7XkvCLj5BQ+4F3CKB+11dDfvhXYBzRVHlc6Se4ALUZkKznbq5wdFtZdQQ2+K7zOeL2j7y/aVkx6r00wt1B5M0K7zfSZr1usz5ZZzfSWw4iXTEk/DNb39I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com (2603:10b6:a03:42b::13)
 by DS0PR12MB8504.namprd12.prod.outlook.com (2603:10b6:8:155::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Fri, 1 Mar
 2024 20:17:31 +0000
Received: from SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ff7e:b189:da4c:dab2]) by SJ0PR12MB5673.namprd12.prod.outlook.com
 ([fe80::ff7e:b189:da4c:dab2%6]) with mapi id 15.20.7316.037; Fri, 1 Mar 2024
 20:17:31 +0000
Message-ID: <1d76d001-e018-770e-5315-f174169b68e6@amd.com>
Date: Fri, 1 Mar 2024 21:17:26 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 2/2] drm/amdgpu: sync page table freeing with tlb flush
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 amd-gfx@lists.freedesktop.org
Cc: Philip Yang <yangp@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
References: <20240301110724.947-1-shashank.sharma@amd.com>
 <20240301110724.947-2-shashank.sharma@amd.com>
 <fdc41038-62e8-4aa4-8a7f-86ca09324362@amd.com>
From: "Sharma, Shashank" <shashank.sharma@amd.com>
In-Reply-To: <fdc41038-62e8-4aa4-8a7f-86ca09324362@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0149.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:95::20) To SJ0PR12MB5673.namprd12.prod.outlook.com
 (2603:10b6:a03:42b::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5673:EE_|DS0PR12MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ff54d44-0c75-44fb-e6a7-08dc3a2c9f6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dE4232521kgwmaZCirPpliRifQm7u3kmaW7xux6qmZgjnbQnWiFCBzbxaGj3BCVU4jnD5a1dmo8Ta/foviJG/VgCr76u4hgPyPMpDoa3f7rM9FmgDe0vuiEmA4rbZ6tQUGlsn54dY149Tb75Q6a6RY2pwev+UMGIY/B+vVFly/w2RgDqzWKInGAeH/J3qqdY7vgjjrDmzUkq9KWBw45rYxObZ3xta774AmrwWDnB0x4L5B8hqkZc2+14cDEhZwGxjuPnpOsLfXDc8O6Nt/Z+hONobdHz/MKXT/CW6O/4TlSYRB7lAnEjJ6jqLzabPsy8aIZJsExerB1g0KyZuWEl6RnVV7sQlR0SNrDWAuRRJdX3f2JonjsKm8Qffv7c75eAs08Yim2LUaHD0EWFfMwq/PfL2nvbcxx2HyUJPU+L+pUMTt056e/7JePFvUU9IBgrSlR7w5MYVVGxeQkacUbkLEAKP3mpURTd0v3r6y6fIRDeiURr40bp+BGAt/3lh8QYYIjGvYZ+/VL7GN28TnWkXOJNkMIVG8qqmQXHhv5HCmmMkOQKS/o5gqo6dkVT6W4ab4w40g01nf05f+EqNLVsItq0u0XmhXJxQJ5UoSUR1fZiLNz2AARZct5tnAHWjtOL
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5673.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031); DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RDN1dzMvTEcxQVRzaXdMNUcvOE1QL2ZtYi9SNTAvOE50ejc1U3lKVHhIa3Vr?=
 =?utf-8?B?L0tQRlFvRnlzVlVpcWsvMTE3RDNYcHVEM2pXNlNudlQ2TWZqNEdQd3JrSzIy?=
 =?utf-8?B?cG9WeFdMSkk2cVR5YTBHajl1RmRVNE1rU2dSc1ljSThrSFNoOW5jSDI3TGlO?=
 =?utf-8?B?QnNBS2N3dzR4dWczcXQ3Wnk1Smh5N1RiRE5pc2NSYytiUTA2VSs3WS9Wc2FD?=
 =?utf-8?B?VnE4R2xzSDlSeTZXZHpEMWdkNThoOVZ5THJsY2lJbkhDY0xvNG5HVTcrWW1r?=
 =?utf-8?B?STBLN3pzSFpBVVQ5YWJsRm9tZElxZkpPdndWQXpvQ3FxNUlrUnpRRFR3d0c4?=
 =?utf-8?B?bllXeE9ISzZkSzlQMkhRWDhuTllZakxoUmpsSS9CcG5CU2xXc0ZjWkJyOUxE?=
 =?utf-8?B?ZWVrQ0FUTEszQVhVM0M4YklWbC9uUStaMEZiekk4MmxzQlNLdHpEVDR1L0h2?=
 =?utf-8?B?dGRHdDU2SWo3TjZNM0lYOW8vd05HdXhEa0RLRHRQVlAraFp0TVg2bm1GS1M1?=
 =?utf-8?B?bFp2WktJWHRxVk9BS080K1NuTm54YlBNMXIvYXdwSHlRSWs4cVlXRkVHZWtj?=
 =?utf-8?B?WmdjT2NGK3J0eVE0YkVQYVovV0dtb0tBSUZjSkcxYTJMTS9Pa2xObTZzbXZT?=
 =?utf-8?B?V2EyZTZScnh5eEw2TEQwL3lQakkxdTlEQ0U3QmhVeU1XQVQrWkJWVUdvWC8x?=
 =?utf-8?B?MHFpNDRtQkdSSnZkQ3Y0R2NGTHNzWDBCSkpodXhpQzJ2bUpRY0F6SWRUOCtn?=
 =?utf-8?B?R3BjYnRCTWQ2cVR0TTZPM3VReFYweGpsMWhUNC9tWUxQSXk3SzAwSWxNbFdQ?=
 =?utf-8?B?ZUtSRTN2WnJUbjBMWU9UaFE5c1RuaGZuZld1MSs2amhQaHp6dU12U2ZLamFC?=
 =?utf-8?B?UGcvY2RnRERINm52eFZzSWs1aUV4VDZ2eS8xZ2M0WDhqTmxNelgrbi9DVTI0?=
 =?utf-8?B?SFNValpYWXBLUjRSSW5uakd6Q2lCYXU1ekI0ZFB1TlpRUzhvR0gvQ1F5U25s?=
 =?utf-8?B?UzRBRXc3cXA1NCtwMG9iaXpFNDlNTFJ5dytaYVh5QjRsUGVqOWJTZjVkMkJW?=
 =?utf-8?B?bDJTQjMyMTJ0Vk1WN2dVRGN4Ri9WV3VUcUJmRnN6T2dnRG90QWxwVExxYk9X?=
 =?utf-8?B?SWZEbDNNdXJoNXdRTmo1NlJ0d1YyMjRYcE9mN0ZERXB6L2RZUlBxMFFBODdK?=
 =?utf-8?B?MVdjaTRDdnVhMGpLdTFFTTZDNUJYMVR6c3A4YU1IZ3c1cDBBYnVuSW1HQ3B1?=
 =?utf-8?B?c1BpazcrWlMvajZjZGtzdE10a2RyTjMySm52VW8ra0kyWERGNk0zelRnTGZC?=
 =?utf-8?B?c1I2TjRuNFIzTisxZ3NFVXpiblJ3M1BNVFgzYUJPSTlyY1dYaXY3NURTb0FX?=
 =?utf-8?B?VHRkRzcyU0pNc01JYkpNaG0zMnRNYXN4Wm04RDlzZVBGQm1ENUw5b2xiNTM3?=
 =?utf-8?B?alZCekNSdW9aNHByMm8wV3dwSExhSVhFbmhqeEQwbEdBanpUVWVhcTlqb2Jk?=
 =?utf-8?B?TVlwUG1PRmZEcDEvZFM3alNhY2J1R1RlL3BlRXZSUUNSWG9RVnVMQmgrNUIz?=
 =?utf-8?B?UzVSQ2gxaEN2VVJMcFJEdnBpZm9wSUlBZnBNMU9Bb2c3Ky9PRmk1T21uc1V5?=
 =?utf-8?B?QzZEWmozV0ZjNVBaTFBtWk9sb2VIeEptR3Vjdkp3YlZqV2VLQm0rVWJ6emRG?=
 =?utf-8?B?M2RwZExxTEVsZFhYcjBCazExam53ejN1V2duSlI1K3lCcU45MjR5NUhzNzZa?=
 =?utf-8?B?Z2FuajNETWpXNFdLd0FLYWJ6aklENytVTysyVU9yNzNoSkVxWGFIWkdvQlVL?=
 =?utf-8?B?WE8yYjZjdXBZZHhDZEJITnhRNE95eUNKWGs3UWFPc3ZhY1RCTkxBSFdQT0Vx?=
 =?utf-8?B?UWhSTVBuYjNDb0lWVjdlZU4rV2RuSkEvQVRZVlpJVGtCTEVpK3oweithLzIv?=
 =?utf-8?B?RThHYnpJajJVMkFZbGhjV0NTMUhhTkJTNTNtYmkyYVA0dkRVSXl0SFEyNCtU?=
 =?utf-8?B?VlEvdjV4TVo5NDhyOWl2SUNuOGlyL1Jkem5GMmlDT2pmdXdZMnJUbUNTUjVu?=
 =?utf-8?B?ZW9hay8raVpndFY3Q3N3N0hET3g0WThjYk1Qd1dwaXRYajBpcFQ1Z2JIQTdL?=
 =?utf-8?Q?wjYehlj0Go19R1hqGaqxg2Vg9?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ff54d44-0c75-44fb-e6a7-08dc3a2c9f6e
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5673.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Mar 2024 20:17:31.0212 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AysrvTjSYPH5EMzEO7yXtq8kpqpeNvZK0AryFJCKjQzXQLJIuLgeDMeJ1aoWH9uUDh11AfaZXz2rz7JyMdsZQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8504
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


On 01/03/2024 14:29, Christian König wrote:
>
>
> Am 01.03.24 um 12:07 schrieb Shashank Sharma:
>> The idea behind this patch is to delay the freeing of PT entry objects
>> until the TLB flush is done.
>>
>> This patch:
>> - Adds a tlb_flush_waitlist which will keep the objects that need to be
>>    freed after tlb_flush
>> - Adds PT entries in this list in amdgpu_vm_pt_free_dfs, instead of 
>> freeing
>>    them immediately.
>> - Exports function amdgpu_vm_pt_free to be called dircetly.
>> - Adds a 'force' input bool to amdgpu_vm_pt_free_dfs to differentiate
>>    between immediate freeing of the BOs (like from
>>    amdgpu_vm_pt_free_root) vs delayed freeing.
>>
>> V2: rebase
>> V4: (Christian)
>>      - add only locked PTEs entries in TLB flush waitlist.
>>      - do not create a separate function for list flush.
>>      - do not create a new lock for TLB flush.
>>      - there is no need to wait on tlb_flush_fence exclusively.
>>
>> Cc: Christian König <Christian.Koenig@amd.com>
>> Cc: Alex Deucher <alexander.deucher@amd.com>
>> Cc: Felix Kuehling <felix.kuehling@amd.com>
>> Cc: Rajneesh Bhardwaj <rajneesh.bhardwaj@amd.com>
>> Signed-off-by: Shashank Sharma <shashank.sharma@amd.com>
>> ---
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 10 ++++++++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  4 ++++
>>   drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 21 ++++++++++++++-------
>>   3 files changed, 28 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> index 310aae6fb49b..94581a1fe34f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
>> @@ -990,11 +990,20 @@ int amdgpu_vm_update_range(struct amdgpu_device 
>> *adev, struct amdgpu_vm *vm,
>>         /* Prepare a TLB flush fence to be attached to PTs */
>>       if (!unlocked && params.needs_flush && vm->is_compute_context) {
>> +        struct amdgpu_vm_bo_base *entry, *next;
>> +
>>           amdgpu_vm_tlb_fence_create(adev, vm, fence);
>>             /* Makes sure no PD/PT is freed before the flush */
>>           dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
>>                      DMA_RESV_USAGE_BOOKKEEP);
>> +
>> +        if (list_empty(&vm->tlb_flush_waitlist))
>> +            goto error_unlock;
>> +
>> +        /* Now actually free the waitlist */
>> +        list_for_each_entry_safe(entry, next, 
>> &vm->tlb_flush_waitlist, vm_status)
>> +            amdgpu_vm_pt_free(entry);
>
> This needs to be outside of the "if". We also need to free the PDs/PTs 
> in non compute VMs.


Noted,

>
>>       }
>>     error_unlock:
>> @@ -2214,6 +2223,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, 
>> struct amdgpu_vm *vm,
>>       INIT_LIST_HEAD(&vm->pt_freed);
>>       INIT_WORK(&vm->pt_free_work, amdgpu_vm_pt_free_work);
>>       INIT_KFIFO(vm->faults);
>> +    INIT_LIST_HEAD(&vm->tlb_flush_waitlist);
>>         r = amdgpu_seq64_alloc(adev, &vm->tlb_seq_va, 
>> &vm->tlb_seq_cpu_addr);
>>       if (r)
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> index 298f604b8e5f..ba374c2c61bd 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
>> @@ -343,6 +343,9 @@ struct amdgpu_vm {
>>       uint64_t        *tlb_seq_cpu_addr;
>>       uint64_t        tlb_fence_context;
>>   +    /* temporary storage of PT BOs until the TLB flush */
>> +    struct list_head    tlb_flush_waitlist;
>> +
>>       atomic64_t        kfd_last_flushed_seq;
>>         /* How many times we had to re-generate the page tables */
>> @@ -545,6 +548,7 @@ int amdgpu_vm_ptes_update(struct 
>> amdgpu_vm_update_params *params,
>>                 uint64_t start, uint64_t end,
>>                 uint64_t dst, uint64_t flags);
>>   void amdgpu_vm_pt_free_work(struct work_struct *work);
>> +void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry);
>>     #if defined(CONFIG_DEBUG_FS)
>>   void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct 
>> seq_file *m);
>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c 
>> b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> index 95dc0afdaffb..cb14e5686c0f 100644
>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
>> @@ -636,7 +636,7 @@ static int amdgpu_vm_pt_alloc(struct 
>> amdgpu_device *adev,
>>    *
>>    * @entry: PDE to free
>>    */
>> -static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>> +void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
>>   {
>>       struct amdgpu_bo *shadow;
>>   @@ -685,13 +685,15 @@ void amdgpu_vm_pt_free_work(struct 
>> work_struct *work)
>>    * @vm: amdgpu vm structure
>>    * @start: optional cursor where to start freeing PDs/PTs
>>    * @unlocked: vm resv unlock status
>> + * @force: force free all PDs/PTs without waiting for TLB flush
>>    *
>>    * Free the page directory or page table level and all sub levels.
>>    */
>>   static void amdgpu_vm_pt_free_dfs(struct amdgpu_device *adev,
>>                     struct amdgpu_vm *vm,
>>                     struct amdgpu_vm_pt_cursor *start,
>> -                  bool unlocked)
>> +                  bool unlocked,
>> +                  bool force)
>>   {
>>       struct amdgpu_vm_pt_cursor cursor;
>>       struct amdgpu_vm_bo_base *entry;
>> @@ -708,11 +710,15 @@ static void amdgpu_vm_pt_free_dfs(struct 
>> amdgpu_device *adev,
>>           return;
>>       }
>>   -    for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>> -        amdgpu_vm_pt_free(entry);
>> +    for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry) {
>> +        if (!force)
>> +            list_move(&entry->vm_status, &vm->tlb_flush_waitlist);
>> +        else
>> +            amdgpu_vm_pt_free(entry);
>> +    }
>>         if (start)
>> -        amdgpu_vm_pt_free(start->entry);
>> +        list_move(&start->entry->vm_status, &vm->tlb_flush_waitlist);
>>   }
>
> The complexity inside amdgpu_vm_pt_free_dfs() really starts to make no 
> sense any more.
>
> First of all ditch the usage in amdgpu_vm_pt_free_root(). Instead just 
> inline the call to for_each_amdgpu_vm_pt_dfs_safe() to free up all of 
> the page tables immediately.


Noted,

>
> Then the other use case in amdgpu_vm_ptes_update():
>
> /* Make sure previous mapping is freed */
> if (cursor.entry->bo) {
>     params->table_freed = true;
>     amdgpu_vm_pt_free_dfs(adev, params->vm, &cursor, params->unlocked);
> }
>
> We should basically change params->table_freed into a list_head and 
> put all to be freed entries on there. Something like that:
>
> spin_lock(&vm->status_lock);
> for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)
>     list_move(&entry->vm_status, &params->table_freed);
> spin_unlock(&vm->status_lock);
>
> And then finally in amdgpu_vm_update_range() we should call 
> amdgpu_vm_pt_free_dfs() to really free up all PDs/PTs (probably rename 
> the function while at it).

- in amdgpu_vm_pt_free_dfs, there are two different lists for locked and 
unlocked PT entries

   unlocked is saved in vm->pt_freed

   locked is freed immediately, which we now want to add into another 
list  (params->table_freed in your suggestion) and free after tlb_flush

  which means we have to do something like this:

in amdgpu_vm_ptes_update {

  /* Make sure previous mapping is freed */
if (cursor.entry->bo) {

     for_each_amdgpu_vm_pt_dfs_safe(adev, vm, start, cursor, entry)

     if (unlocked) {

         list_move(&entry->vm_status, &vm->pt_free);

     else
         list_move(&entry->vm_status, &params->table_freed);

}

}

and then we have to change the amdgpu_vm_pt_free_dfs() implementation to 
simply free BOs, not searching anything like:

if (unlocked) {

     schedule_work(pt_free_work)

} else {

    list_for_each(params->table_freed)

     amdgpu_vm_pt_free(entry)

}

and then we would be able to call amdgpu_vm_pt_free_dfs() from 
amdgpu_vm_update_range().

Does that sound good to you ?

- Shashank


> Regards,
> Christian.
>
>>     /**
>> @@ -724,7 +730,7 @@ static void amdgpu_vm_pt_free_dfs(struct 
>> amdgpu_device *adev,
>>    */
>>   void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct 
>> amdgpu_vm *vm)
>>   {
>> -    amdgpu_vm_pt_free_dfs(adev, vm, NULL, false);
>> +    amdgpu_vm_pt_free_dfs(adev, vm, NULL, false, true);
>>   }
>>     /**
>> @@ -1059,7 +1065,8 @@ int amdgpu_vm_ptes_update(struct 
>> amdgpu_vm_update_params *params,
>>                       params->needs_flush = true;
>>                       amdgpu_vm_pt_free_dfs(adev, params->vm,
>>                                     &cursor,
>> -                                  params->unlocked);
>> +                                  params->unlocked,
>> +                                  false);
>>                   }
>>                   amdgpu_vm_pt_next(adev, &cursor);
>>               }
>
