Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435E2C77B73
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jun 2023 16:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A40A10E158;
	Tue,  6 Jun 2023 16:16:53 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on20601.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e83::601])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CE3510E158
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Jun 2023 16:16:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajPPXFRUAan93Qk3a7JczeSE7aNP0rz4FEHO/SomWj0HFIOPi9pLM6jLCGe7EGhmrH1AfuFqMeqXkYUsR3sgBL8IZN2nQXytHhpmBLh2pD2gtYPrt0LChyO3wIOLj2zrEgGl0/H0+upG6Nf8X9iSe5JBw41ZMohyP9o4j+B8sTVRlW/EpzHbpQtG1mcqsxV9WHgXqIZ/BEuhUMQ8zUJ5NJzRIkwPQQC+m+0ZOC9IWiOa+P8AS6zeksMDFHhFFers7xSDUAcnBHrczqIbBC0LuWeFANijmhdCYeIEC6abQehtLZ0k0umU16DK7Kp4d8Sg6waacFYhNJAAnf1p+sEfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=db3jrOF7LIJu/d6tLcMqMRd2CrBhdMKbQ8oyE++3myc=;
 b=JE9ips2Zp1OEidURdSP0+pwJ9r1S5KxPA+d+eXyjiZdQWgVjAH1tpdR8MPJbe3c15VJQHh2StskkYvCb89cOEaqZH4magJa9FWzeXvzg5saZ6NuvDrEIIFtU7DeYljmNh0YpFbUYhZODmRFxE0FP6CEWlJC7i0temrKRFDqn242qN//sBQxRdqsk7v5ho01oHBXDjsoycDFHY22XrG4HafwSwai3jT3LiAfbaDicD7eW5o4Uysbm9lClU8d+aS2pDydXB3Cpk0iymxKJ9V5LxhsHvwKr785pnLF1MvDWIh/QhQq7aVWQdygZV9CR7eOC3O5fE1mWRsGW0enu1fPE4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=db3jrOF7LIJu/d6tLcMqMRd2CrBhdMKbQ8oyE++3myc=;
 b=5A8AORRAP8ahTy/AwomEbM43XhYiutnODIvgAMEpK9KHe4wpRBjMhsb88dc+L3prjojZDyADJvWDOoliCVFXvH5F7VxkKfYYd631wGIW6ow8svYkGKNcOpRcd/TL5xInXqZRxJdBoiy52l95jsZYDP6re3ctFBxd/r++zVXRDTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH0PR12MB5138.namprd12.prod.outlook.com (2603:10b6:610:bd::17)
 by SJ1PR12MB6194.namprd12.prod.outlook.com (2603:10b6:a03:458::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 16:16:47 +0000
Received: from CH0PR12MB5138.namprd12.prod.outlook.com
 ([fe80::62a7:7d37:dbc3:55a0]) by CH0PR12MB5138.namprd12.prod.outlook.com
 ([fe80::62a7:7d37:dbc3:55a0%4]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 16:16:47 +0000
Message-ID: <96876525-a363-5458-d3cb-1f741ed9e6f7@amd.com>
Date: Tue, 6 Jun 2023 12:16:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/4] drm/amdkfd: Signal page table fence after KFD flush
 tlb
Content-Language: en-CA
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>, Philip Yang <Philip.Yang@amd.com>,
 amd-gfx@lists.freedesktop.org,
 "Somalapuram, Amaranath" <Amaranath.Somalapuram@amd.com>
References: <20230601193117.13143-1-Philip.Yang@amd.com>
 <20230601193117.13143-3-Philip.Yang@amd.com>
 <90a3ac90-4091-4542-89c2-778230d265a5@amd.com>
 <a521c410-787c-d235-f911-e34a9cd01640@amd.com>
 <4e390c3e-b63a-8fbf-8988-2d8bed0688b8@amd.com>
 <9dfb0942-b731-16f3-6792-a0ae1ac60ce4@amd.com>
 <f467155e-4582-9bd7-bc16-bdb584bcfdc3@amd.com>
 <a0ee77e1-7783-803a-1e66-14dc8c7cd9bd@amd.com>
From: Philip Yang <yangp@amd.com>
In-Reply-To: <a0ee77e1-7783-803a-1e66-14dc8c7cd9bd@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQBPR0101CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c00::25) To CH0PR12MB5138.namprd12.prod.outlook.com
 (2603:10b6:610:bd::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB5138:EE_|SJ1PR12MB6194:EE_
X-MS-Office365-Filtering-Correlation-Id: 92288cc9-17a8-424e-fec2-08db66a96d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C9qOa17lny6WKZgKKbFPuuvk2zYwwU0o5UhyO01DonZnJ9Q0M+/1vVuCMAAg+ha9u6llNwTE7NnW8y/YHPcOcCInZYVSp84os8B4pSCggagRoywoYtCTfPvq0VZI0DqX50J8C2+iByZ2O0d+ypE9GUBiPnrQI6PTPTGxdLDdec2IBfg4NAPUQRUYvXoA/JUBOBWge1gMg7nfAygfj7unqaljXNygqzsBSDrxzndEjghy70xnzwf5JZNYr4fy28TWDfAqfcUBM+vRRl1FQ2Jpn+Qn83+wyU0agIEPEvqhvNBaNMfQBXrg7mEfl83IWUedYZmNJYnx6Ohy53ZRy7epsKj+1wyWZaXKZmELctef+7g0tDMS8tSRpioLvWhc6mndOcRY2ON5ihRfPnRA4dWjMYd9uenekQpqktC4biIiovUE1suZ/A9FHGJ2pSRvP9/qAzSeYGgtZm3OZEeX2giZUYa46dzMrg8scdm+vtLbXn4aVj0oZM/eVdPEpCfaV7Oyb/Y80iIcpRszbbWRJnlyt/mY9RkPD9qTzbEpsSTmm61b//CUeVoYLyGjgSKuTW/7KuhRbzzkmn+el9Tx74nP7Qg65iadufzfuXxfhP9dBHyXuzk5k2ftOtjFOB9vINXIaZ7wFRdmtwoMQG8KGNDXOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB5138.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(451199021)(66574015)(83380400001)(478600001)(8676002)(8936002)(41300700001)(316002)(66556008)(66946007)(66476007)(5660300002)(31696002)(38100700002)(6636002)(36756003)(6486002)(2906002)(110136005)(31686004)(26005)(6506007)(6512007)(53546011)(186003)(2616005)(66899021)(43740500002)(45980500001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NnpoWFU3dUEySnMyVmZKUlJmNzVSZHNUdSs2NVVmSXpQbEE4SnI3UzVyZVFy?=
 =?utf-8?B?MC9sdlp3V295REwvUHlyTzBGeC9OUGZkRXpOckNjOWZhMmh5WW5zbFB4eGxD?=
 =?utf-8?B?UkJmSjhmMjdFSHp0NWthdFE4dzFyMm0xWjhjdFh0RnMvNjY4ajh4OFpwU2t2?=
 =?utf-8?B?VThLaThUaWVkWlNlR2xKU1ZteDlNZ2V4Y09ZWTRFZHVieTFUVVRmc0Q2T0U5?=
 =?utf-8?B?OXdPeUEzMG9RRHFhRkFOazVWQ0RzYmxRK2tsb2MvZUtLZFdQUlJwblhaU0Y1?=
 =?utf-8?B?dGFraGxka2xIaGVxNGRmVW9zZWc2OVRKWXRRQlVTZWlUYTFCeC9wNG4wRE9R?=
 =?utf-8?B?UGJ0cFJ2R2VXNjA3bXNWWGFWakRhUXhiUGJIcDQrMy9YenRUUzhiVldDZGJo?=
 =?utf-8?B?WTkxbFBqdHQrY2d1RlQreXZ3YkkvSWpNeG1ScUllOTQwS2R5bW5COFQzUExn?=
 =?utf-8?B?U2lZODdyS1JrVCtLeDhqRE4yUTE1OVAzL3dDbndXQVlqMVhOS2JGQmgzVmQ5?=
 =?utf-8?B?eVlqRFJ5bkJHWDNQY2V4d2xQMUwzUnNrUjlNemlVeDNXTGJiZ3o4UmxxMHA0?=
 =?utf-8?B?OUVoZVVlMUsxM3dYOTVFbFVvZ1JWSUdPMDNRWU54Y0t6SUI2Z2REdzdiaEpN?=
 =?utf-8?B?SHFkMVVrK0dRNnE4V2RKRnFTdFV5TWc0d0FzYUszOHNrQUEvWDBBWmtRY2VP?=
 =?utf-8?B?bTNUQkQ3YjMvc1BkRFBNUEFucGVXMnpBcm5OcXZUaUs0QVozT3B3aStKcCtz?=
 =?utf-8?B?TVNuSVJqV2ZlMlFacFZVbUhtOHp5ZFJUTkE5S0RDYmpLeEp4cDdkaGlTOWRa?=
 =?utf-8?B?SkRCMHZ5aWZ5WDlVMzZJei9kTDJqeldrdVhES21Sd3FLTVNUTS9LdTlRZVFk?=
 =?utf-8?B?SFBCak8yOGNpcmhTUG9HcmR3bnB1NFdGa2hCTWtWaUxwWWk3T0cyeUhYSVFD?=
 =?utf-8?B?dVJiait5THBRSTdFZmxxYmloZDU5ckkrSDhGU2R6ZldGSTJvZjI4UkE2YkVi?=
 =?utf-8?B?cVR1SE92ajNnNFUwdmxKb0ZVanNBbUIyQjdIRC8yVXY0dzJGd0J6Vk5FbmpM?=
 =?utf-8?B?OUw2TEZheXc1OTRBUE1lWVl5OUFFSHRYWEYyOCtwWThMU21vRDFXTUFqemRT?=
 =?utf-8?B?bUJlZHlKd0FEdUlXUHpSZzdrV2JlUEdTcy9MaEJYOW41dklLMWJnQTEzMmVm?=
 =?utf-8?B?L2pOU0tpWmFqZ1hZRFF6YWJ5UDZSakFSYWJlSk01VXIvNHd1STZLaDltV01q?=
 =?utf-8?B?eVpCU0ZMemxHWUNBeFdKbUVtaW9xNitTTVUyTS9KL0RadEZkcHBlV08wN3hL?=
 =?utf-8?B?MTdURHZRNEs1bFJ1VUJsSVFqOHY3aXBUZFFjYmIvMExsdXpENk9nREZHaklG?=
 =?utf-8?B?VFpYb1pGSWxDbGNvbGk5L29mYk1ZbWpnNjRBUXNRTXdtajVFLzBjeWErRVgx?=
 =?utf-8?B?SlRuQkNvNGpRSlBYcnNKM1VaMTVQdGRCYjNNOElUS1ZaMmt0a2hqc25lKzFM?=
 =?utf-8?B?RGhiMFZiTDdDQlhUbThCWmt2d3ppbk9Jd2UxZDJWWVRlZUYyYW1RVEV3R0hT?=
 =?utf-8?B?ZWRRV0c5dExlUnZleDZKNGtVQW14YVNmYmFUYmppMXhiTlBTNW9nMENia2cr?=
 =?utf-8?B?a3M4TlF1VENiM0N6TmF5VGNNK3RFT3BBbFhEQ2hjTnAvRndNZEVXUThLNmth?=
 =?utf-8?B?bm5ibGEvVXNJYU8zS1FWVDlvVDllZWx0SklRRGxSaG5xaUdFMU1qMHpxUlB3?=
 =?utf-8?B?M0RFUGU1dHBmVm5FdFNZcGtxQ21Dcmora3BxS3JReVJTWXlpbjRmcmF2bUpl?=
 =?utf-8?B?Q21pMHB5TEw0b29ob2RJTXZiejhhejNiZnRWbXgyMms2ajJEaTZvNGxlV0E3?=
 =?utf-8?B?OWREWk9BVm82U0FWWkx1Snp4Tk9Yc3FjWm44Q2pNWmJpd3NoRXJlaHhTbE1p?=
 =?utf-8?B?a0J5NC9rQ2JHVHpxanZJdkJlQlYwV0wxbkFRU0VkN3JWODYvYW85R05ROWR0?=
 =?utf-8?B?V3NBSjdkblgvcjNsSXhIOENsMzd1SzJpRlRtM2p0dEhlKzFYU3lhY3FQZ2VE?=
 =?utf-8?B?d2tycGMvNU5hdWRnTzFTdld2OGJaTkYvT0JRTmExNFNuTnQ0WVJoN00weEtK?=
 =?utf-8?Q?o3hQ=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92288cc9-17a8-424e-fec2-08db66a96d6e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB5138.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2023 16:16:47.6463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cQYi4kwJ+43hsPJkJE7Qwu7MuTx654mHqzDvtjaCa6IaQkDQIqXInt894JGnaI+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6194
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


On 2023-06-05 11:47, Christian König wrote:
> Am 05.06.23 um 17:40 schrieb Shashank Sharma:
>>
>> On 05/06/2023 17:18, Christian König wrote:
>>> Am 05.06.23 um 17:13 schrieb Shashank Sharma:
>>>>
>>>> On 02/06/2023 16:54, Felix Kuehling wrote:
>>>>> Am 2023-06-02 um 07:57 schrieb Christian König:
>>>>>> Am 01.06.23 um 21:31 schrieb Philip Yang:
>>>>>>> To free page table BOs which are freed when updating page table, 
>>>>>>> for
>>>>>>> example PTE BOs when PDE0 used as PTE.
>>>>>>>
>>>>>>> Signed-off-by: Philip Yang <Philip.Yang@amd.com>
>>>>>>> ---
>>>>>>>   drivers/gpu/drm/amd/amdkfd/kfd_process.c | 5 +++++
>>>>>>>   1 file changed, 5 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c 
>>>>>>> b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>> index af0a4b5257cc..0ff007a74d03 100644
>>>>>>> --- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
>>>>>>> @@ -2101,6 +2101,11 @@ void kfd_flush_tlb(struct 
>>>>>>> kfd_process_device *pdd, enum TLB_FLUSH_TYPE type)
>>>>>>>               amdgpu_amdkfd_flush_gpu_tlb_pasid(
>>>>>>>                   dev->adev, pdd->process->pasid, type, xcc);
>>>>>>>       }
>>>>>>> +
>>>>>>> +    /* Signal page table fence to free page table BOs */
>>>>>>> +    dma_fence_signal(vm->pt_fence);
>>>>>>
>>>>>> That's not something you can do here.
>>>>>>
>>>>>> Signaling a fence can never depend on anything except for 
>>>>>> hardware work. In other words dma_fence_signal() is supposed to 
>>>>>> be called only from interrupt context!
>>>>>
>>>>> We are signaling eviction fences from normal user context, too. 
>>>>> There is no practical way to put this into an interrupt handler 
>>>>> when the TLB flush is being done synchronously on a user thread. 
>>>>> We have to do this in such a context for user mode queues.
>>>>
>>>>
>>>> We are currently working on adding a provide a high level kernel 
>>>> API which can be called directly to perform a TLB flush. Internally 
>>>> this API will add a deferred work to use the SDMA engine to perform 
>>>> a GPU TLB flush work (to compensate for a HW bug in Navi Chips). If 
>>>> my understanding is right, by interrupt context Christian means to 
>>>> perform this flush and signal from that differed work, is that so 
>>>> @Christian ?
>>>
>>> Well more or less. Ideally you put the TLB flush in a work item (or 
>>> use the SDMA for the hw bug workaround on Navi 1x).
>>>
>>> The point is that you shouldn't have it in the same execution thread 
>>> as the VM page table updates, because any memory allocation or 
>>> grabbing a lock could potentially depend on the TLB flush as soon as 
>>> you have published the dma_fence (by adding it to the VM page table 
>>> BOs for example).
>>>
>> Would it work for everyone if we add this generic API (say 
>> amdgpu_flush_tlb_async()) to add a TLB flush work and will also send 
>> this dma_fence_signal from within ? KFD can simply consume it from 
>> wherever they want, do you see a race condition if we do like this ?
>
> Yes, that's pretty much the whole idea. amdgpu_flush_tlb() should just 
> return a dma_fence object.
>
> This dma_fence object should either be the SDMA workaround or signaled 
> from a work item.
>
> We can then fence the BOs or just wait for the dma_fence object to 
> signal.

In order to fix the original issue, page table BOs freed and reused 
before tlb is flushed, I will rebase and modify the patch series on new 
API amdgpu_flush_tlb_sync() which works for both KFD and gfx. Is my 
understanding correct?

Regards,

Philip

>
> Regards,
> Christian.
>
>
>>
>> - Shashank
>>
>>> Christian.
>>>
>>>>
>>>> - Shashank
>>>>
>>>>>
>>>>> Regards,
>>>>>   Felix
>>>>>
>>>>>
>>>>>>
>>>>>> What we can to is to put the TLB flushing into an irq worker or 
>>>>>> work item and let the signaling happen from there.
>>>>>>
>>>>>> Amar and Shashank are already working on this, I strongly suggest 
>>>>>> to sync up with them.
>>>>>>
>>>>>> Regards,
>>>>>> Christian.
>>>>>>
>>>>>>> + dma_fence_put(vm->pt_fence);
>>>>>>> +    vm->pt_fence = amdgpu_pt_fence_create();
>>>>>>>   }
>>>>>>>     struct kfd_process_device 
>>>>>>> *kfd_process_device_data_by_id(struct kfd_process *p, uint32_t 
>>>>>>> gpu_id)
>>>>>>
>>>
>
