Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4223AC7EE2C
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jun 2023 15:41:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B635510E2E7;
	Mon,  5 Jun 2023 15:41:11 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2076.outbound.protection.outlook.com [40.107.102.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 521CC10E2E7
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jun 2023 15:41:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+RDbauEEc1tWIVi86I2TPQM9ns4HRbtw58zN3eoK4zqOcx5v7GJzpO6N55j9nLP4nYzcAR4Nny33L6L2OH6int98A9lICDkAqxI1I3IRIBkLBAnj+m0V8Z1YQg2EwDCdaneru8+wTt8ELn8t7MTXkjqEeG4ogGRfEE5VWGpQUoHUtvVGZFhrQ64L+uVDC7SxxWduZZHpDMFSqIbiZRNLVEvNY2dhXr0fGq0QYlqZp3L+yYQdqrWXQIW8b6sGKQeAhs1GpnpcFcHB4OzEomAgkcRvBUheW/KAdlYiQmz/EyjPLl0mCSR6MrhLFwipmHg660AihUFtytzvAKu73W/IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHlUeAzbw+eYomEi/sKfimbrXqav//Tdo8y2IWD/lDQ=;
 b=aMqIuSRt4pyZjHr8q6RPC06Cp9wGM6U+MvViKXNzxpqHFuDrQoUy8alsSVfer8++Oj256WmoXXYCYjcou29Jh1IsziJh8cU4xJJ+oGOh8U+kGsXOBKhjgMjulWP7ekNqf10DC/trEkqGeNOCekbUvCq8J69wQsAtIolbjKPHiBRYb+bdHAjmaGsbMLHTsSyELzHKKeAg1iDsCE8SonrNdBg50BeJQG9Bv9g8L7XreSpyXpivp3NpGWNiBSc+mNG6dIDB6hinHXm6kwBSlb4ZwgZrrU03bhXlw56PTTowRXVIx6d4X/ZvQjv3+M/Pt6eZ2EAb+7Ge7RZMSuWT2fQhTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHlUeAzbw+eYomEi/sKfimbrXqav//Tdo8y2IWD/lDQ=;
 b=w2vJYha0MP3ZvnAjE9zcS77awrbK79m+3mZsW0qjLAvaKCX4OYCZ5HEMx9t3xzpKL5B+c3/t7sC8FiAhVwQKa71KntOs9GhtQ1IB4FkYEUtFEqefTF3OnEF/IpjIgWM8RbD3KSgYQQ6sTff0UP6hFldio6SbjwGYia1ge3shWhI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW4PR12MB5667.namprd12.prod.outlook.com (2603:10b6:303:18a::10)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Mon, 5 Jun
 2023 15:41:07 +0000
Received: from MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6]) by MW4PR12MB5667.namprd12.prod.outlook.com
 ([fe80::f0e:7e1f:f3d6:efc6%5]) with mapi id 15.20.6455.030; Mon, 5 Jun 2023
 15:41:07 +0000
Message-ID: <f467155e-4582-9bd7-bc16-bdb584bcfdc3@amd.com>
Date: Mon, 5 Jun 2023 17:40:59 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/4] drm/amdkfd: Signal page table fence after KFD flush
 tlb
Content-Language: en-US
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org,
 "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>
References: <20230601193117.13143-1-Philip.Yang@amd.com>
 <20230601193117.13143-3-Philip.Yang@amd.com>
 <90a3ac90-4091-4542-89c2-778230d265a5@amd.com>
 <a521c410-787c-d235-f911-e34a9cd01640@amd.com>
 <4e390c3e-b63a-8fbf-8988-2d8bed0688b8@amd.com>
 <9dfb0942-b731-16f3-6792-a0ae1ac60ce4@amd.com>
From: Shashank Sharma <shashank.sharma@amd.com>
In-Reply-To: <9dfb0942-b731-16f3-6792-a0ae1ac60ce4@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM6P191CA0034.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:209:8b::47) To MW4PR12MB5667.namprd12.prod.outlook.com
 (2603:10b6:303:18a::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB5667:EE_|MW3PR12MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: 22342df3-95e8-4656-1c25-08db65db475a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IkDaYVOwwiyWGM/GSB8JpYC2esMWNGpjCvF+G9nNrbmpbSwkKEC5mrotFFQo491NEitnC+uQk43UFfeh+HgGd9vjxz/2Fl3zMFJkJaPTcvdk9eMzXVpRDWzTecSY+5h8JjcwbIVXVvi1U5pSigf7F3PfVwf5BtxtnWNDSKKomJxQ2Z0c660TNGrvK2Bt5MpiAzhHhPPHppMF6ePjGtvDDTVe8GgEHL8K/Vd9umQXZBY3ON1hDt+yAiJFxH9hhg0m108dbonoiMzU68BFFZNobJ//xPlkMZEDAhW5gcWBC+93hZSch0sf7XKg0VBLBDxEf3kcWa8K5E9ZOjUJxD5bWkwiH8Q+LLHcI3fXVuyhiS+6z9XCu8/yh4Id+VcHK2oz9pv961EMfczqB2c5vWQs+r5aoRW3zVL+iuTWib51Snw26UPos3BThh0mWsPj+Gp5ppuyfsXKfe5N/RWRDKGS4itRiOI1a/kvxXmDJ+i3H3b4RxstKcTrc7W5eKk7LxYxYo+2yrO0VYdNolfImYvT1ozSp+7iGsRzG+b1TSr1LWJQmer4QxFviE1oKDsoIEM2s0dmUgg7jfbCRNuqIpA2ICVRg0UhaCvoZYWYQ8jqsnH8d3Y2cpYZ1sbVJ/nWybfPp2sRmNUBb6VCoEIoNRGfNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB5667.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(136003)(376002)(366004)(346002)(39860400002)(451199021)(2906002)(44832011)(36756003)(66899021)(38100700002)(86362001)(31696002)(110136005)(6486002)(6666004)(478600001)(8936002)(8676002)(66556008)(66476007)(66946007)(41300700001)(316002)(66574015)(83380400001)(2616005)(6636002)(53546011)(6506007)(26005)(186003)(6512007)(5660300002)(31686004)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b1MxcWovYU0ya2dJdnBDRUNvT0l2VG84bmRrMy9PVUVudXRSZFhzVTF5bHdU?=
 =?utf-8?B?eU11RXhWWlVrOWtCdFFLa01JMmFad0oxMndGbjE1NjI4aHJQTGZSajBkbXpU?=
 =?utf-8?B?WUJlemVJbGU1cjNTSUJXNnA2bTVBTGJGNXVicG1QNmtIdGRyVkJzaXhlenly?=
 =?utf-8?B?SWZtL2JoR3pmYmJRbmhwa1kxa3lxWWxJS1Jvb1paQVlZeUlIN0FXbTNidjdK?=
 =?utf-8?B?aFlvcXZ0SUJhbEJSYmo0UU9RNGNadHBUUGU0dS8xRjFpN3dORk9hWTNtY0Fl?=
 =?utf-8?B?bFdEcUxtSHYzbTdabFYyTTdhUFFOMlhrSUowQjhoN0RZQnFIVklXVkxVdWNL?=
 =?utf-8?B?eHNlOTdCSVNSTHpSMjVhRU1wbjdTOS9rNkhzV1BCOEptMlFpajdXUDNOZjl1?=
 =?utf-8?B?SHB2Um44RjZqOWU3YXdZWTk2c1Q3MDJFTFhQU0dEaFBMSy80MTNqMWZVSzV3?=
 =?utf-8?B?N0wwaHhjbDlaMlMxOXlTdTIrNmFiaU9OV29BSjVkdDYzMXYyQlF0ZWUweWFO?=
 =?utf-8?B?Yk9hY2RGamtOVmFiZDZNTEV0TVVHcFoxRUVVK2wvODRiTmtJcFVEMkEzWmtw?=
 =?utf-8?B?djdGM1BsbDRPT1BOSHBCVUhmVXdhN3hKYXpnVDAyLzlSMHFjNGxRMlU4TmVx?=
 =?utf-8?B?Q3U3RUI0TWRsUklwaUVFN013dFBBVm1VSkRzOGRZdUhDTFNON3ZPNDZvK3lL?=
 =?utf-8?B?Vm1lN01xRC9CKzZsSmw1bGc5c1k3andqdTd5ZHIyWUNNRm9ZVkhBV0JHQzRT?=
 =?utf-8?B?eWNNRWY2WHVDL1J0TTFHRkNUclB2ZE5ONE40eGEyUGUwdE1DSDhBYlc0czU1?=
 =?utf-8?B?SStjNXAvakpLM0tEemVabDFwSG1PUldKQmcxYm5pazZUSXlidXlQQ2hJaW1I?=
 =?utf-8?B?LzFVTGNjdjZWWnFEbmRTVEpBYVNZbUxXSG1jQmNXS3cvOTAzWHhOYWUrSkdx?=
 =?utf-8?B?aW1yVkJRQnY5a1hNR3BQWWVuNnE4U2tkblNHb3REcHovc2lxZW4zT1R4SDdD?=
 =?utf-8?B?VUlMMkJqbE5NemdrL09PWXR1MVMyWE85R3MyV25rTjhlazdlOXRadHozV1Fq?=
 =?utf-8?B?elhZeXJMcGNHckdISnU0MHYrU3JjWEVlU1R6US9aMU9MU25VV0lXemQyQ3h1?=
 =?utf-8?B?RFNSekczamJFTW53UWJJdkx0WEdMekw5TVA2c0xpUGZMR1VKTjdFRzJ2cFZx?=
 =?utf-8?B?citKbFYyVHVjMjUwMWpmbnJlQU5KTHM1a0syNGtsOVhvRU1qNFhCSnJ6M0Zu?=
 =?utf-8?B?azlYVldBdURmTzFVNmRodjZ0VVJkN0VVU1dQVnFWam1zYlRJV1UzZVJ0THF6?=
 =?utf-8?B?dnlDVDNtYTBTaFhtV1BWaEp4L2NVTVg1aENzWGovRGNwWEN4NW9VQzBWY0Uz?=
 =?utf-8?B?VWRYSGFwalVtNmNPY054QjhVMHozcW1sOUFhcVhlN2xQckRGaGhJL215WitL?=
 =?utf-8?B?KzY3a0VnUGpQUmpzSEFqYTBIUUIyRnNWaTJVUFZ5eDgybmlWT2xvSHhJWnB0?=
 =?utf-8?B?WUFVWllwOERuVzJCZ3BLQ1R3Q28veE5XUXVJR2hqRGlKSW4xWnI5Ulh4K1A1?=
 =?utf-8?B?VlY1WUZKaFVMR2xwWENJOWFvSnFoYnMzeUtWM2NOaUVDUTlHNFhYVWxkNUJj?=
 =?utf-8?B?Z1owQjVLMEJCK0t3QTh5WFRyU0ZkQTRjMlRLZzN3S1RCR2RibWxkcVZwUkpL?=
 =?utf-8?B?RVNVNEFLMEJkeTFlQjZGaTR3ejA4UjdHVlMvL05uUkpKSTdDdGtuNzZ0TW5F?=
 =?utf-8?B?bUFVM2JiN2xxTEs4U2lzTm9BbXdRQ1V4SDRFTjBXMy9aZmpja1ZhMUFYbGhh?=
 =?utf-8?B?REVQKzhwNnU5QnJyUjdvZnQ3d3pIdUkwZlBPSE8xOGxPbXpyOFp1NDc4TEpn?=
 =?utf-8?B?bkMrdFZ4RlNSNURwaXhxQzU2RkVvc0svY2pJVWg5QTlHYmZiK2YrU1ZpU2w3?=
 =?utf-8?B?RUJQa1U3UFFyM2w3YmJuOVNidTZKS0JNWmdydnRzelBrOEtMM2JncURFT2lW?=
 =?utf-8?B?b1VlMWRWWEpQM0NRM01NN045UTRNc2orak5acytHa2pnU1pGWitNZHNpcXhZ?=
 =?utf-8?B?NTJQOTZDWWVEckwzWDRXc3RYOUltTGo2eDN3R2Vaa2FHSnFXOGlNNGx0YXMy?=
 =?utf-8?Q?dpInfIk8hXNBl3MtxIHb9KkJx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22342df3-95e8-4656-1c25-08db65db475a
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB5667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 15:41:07.4986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcZL//8tLPtkmNyEQN1eTdqyVv3irup3ug8ExlEqRoIFK5sAy/ZpoEe65mMHFG7Dg2ZZ6h9hGyZMz2ulLFCCtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395
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


On 05/06/2023 17:18, Christian König wrote:
> Am 05.06.23 um 17:13 schrieb Shashank Sharma:
>>
>> On 02/06/2023 16:54, Felix Kuehling wrote:
>>> Am 2023-06-02 um 07:57 schrieb Christian König:
>>>> Am 01.06.23 um 21:31 schrieb Philip Yang:
>>>>> To free page table BOs which are freed when updating page table, for
>>>>> example PTE BOs when PDE0 used as PTE.
>>>>>
>>>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>>>> ---
>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 5 +++++
>>>>>   1 file changed, 5 insertions(+)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> index af0a4b5257cc..0ff007a74d03 100644
>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>> @@ -2101,6 +2101,11 @@ void kfd_flush_tlb(struct 
>>>>> kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
>>>>>               amdgpu_amdkfd_flush_gpu_tlb_pasid(
>>>>>                   dev->adev, pdd->process->pasid, type, xcc);
>>>>>       }
>>>>> +
>>>>> +    /* Signal page table fence to free page table BOs */
>>>>> +    dma_fence_signal(vm->pt_fence);
>>>>
>>>> That's not something you can do here.
>>>>
>>>> Signaling a fence can never depend on anything except for hardware 
>>>> work. In other words dma_fence_signal() is supposed to be called 
>>>> only from interrupt context!
>>>
>>> We are signaling eviction fences from normal user context, too. 
>>> There is no practical way to put this into an interrupt handler when 
>>> the TLB flush is being done synchronously on a user thread. We have 
>>> to do this in such a context for user mode queues.
>>
>>
>> We are currently working on adding a provide a high level kernel API 
>> which can be called directly to perform a TLB flush. Internally this 
>> API will add a deferred work to use the SDMA engine to perform a GPU 
>> TLB flush work (to compensate for a HW bug in Navi Chips). If my 
>> understanding is right, by interrupt context Christian means to 
>> perform this flush and signal from that differed work, is that so 
>> @Christian ?
>
> Well more or less. Ideally you put the TLB flush in a work item (or 
> use the SDMA for the hw bug workaround on Navi 1x).
>
> The point is that you shouldn't have it in the same execution thread 
> as the VM page table updates, because any memory allocation or 
> grabbing a lock could potentially depend on the TLB flush as soon as 
> you have published the dma_fence (by adding it to the VM page table 
> BOs for example).
>
Would it work for everyone if we add this generic API (say 
amdgpu_flush_tlb_async()) to add a TLB flush work and will also send 
this dma_fence_signal from within ? KFD can simply consume it from 
wherever they want, do you see a race condition if we do like this ?

- Shashank

> Christian.
>
>>
>> - Shashank
>>
>>>
>>> Regards,
>>>   Felix
>>>
>>>
>>>>
>>>> What we can to is to put the TLB flushing into an irq worker or 
>>>> work item and let the signaling happen from there.
>>>>
>>>> Amar and Shashank are already working on this, I strongly suggest 
>>>> to sync up with them.
>>>>
>>>> Regards,
>>>> Christian.
>>>>
>>>>> +    dma_fence_put(vm->pt_fence);
>>>>> +    vm->pt_fence = amdgpu_pt_fence_create();
>>>>>   }
>>>>>     struct kfd_process_device 
>>>>> *kfd_process_device_data_by_id(struct kfd_process *p, uint32_t 
>>>>> gpu_id)
>>>>
>
